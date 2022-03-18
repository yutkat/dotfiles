#!/usr/bin/env python3

import os
import sys
import socket
import selectors
import threading
from argparse import ArgumentParser
import i3ipc

SOCKET_FILE = "/tmp/i3_focus_last"
MAX_WIN_HISTORY = 15
UPDATE_DELAY = 0.5

#  def createDaemon():
#    try:
#      pid = os.fork()
#
#      if pid > 0:
#        os._exit(0)
#
#    except OSError:
#      exit("Could not create a child process")


def daemonize():
    def fork():
        if os.fork():
            sys.exit()

    def throw_away_io():
        stdin = open(os.devnull, "rb")
        stdout = open(os.devnull, "ab+")
        stderr = open(os.devnull, "ab+", 0)

        for (null_io, std_io) in zip(
            (stdin, stdout, stderr), (sys.stdin, sys.stdout, sys.stderr)
        ):
            os.dup2(null_io.fileno(), std_io.fileno())

    fork()
    os.setsid()
    fork()
    throw_away_io()


class FocusWatcher:
    def __init__(self):
        self.i3 = i3ipc.Connection(auto_reconnect=True)
        self.i3.on("window::focus", self.on_window_focus)
        self.listening_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.listening_socket.settimeout(None)
        if os.path.exists(SOCKET_FILE):
            os.remove(SOCKET_FILE)
        self.listening_socket.bind(SOCKET_FILE)
        self.listening_socket.listen(1)
        self.window_list = []
        self.window_list_lock = threading.RLock()
        self.focus_timer = None

    def update_windowlist(self, window_id):
        with self.window_list_lock:
            if window_id in self.window_list:
                self.window_list.remove(window_id)
            self.window_list.insert(0, window_id)
            if len(self.window_list) > MAX_WIN_HISTORY:
                del self.window_list[MAX_WIN_HISTORY:]

    def on_window_focus(self, i3conn, event):
        with self.window_list_lock:
            if UPDATE_DELAY != 0.0:
                if self.focus_timer is not None:
                    self.focus_timer.cancel()
                self.focus_timer = threading.Timer(
                    UPDATE_DELAY, self.update_windowlist, [event.container.id]
                )
                self.focus_timer.start()
            else:
                self.update_windowlist(event.container.id)

    def launch_i3(self):
        self.i3.main()

    def launch_server(self):
        selector = selectors.DefaultSelector()

        def accept(sock):
            conn, addr = sock.accept()
            selector.register(conn, selectors.EVENT_READ, read)

        def read(conn):
            data = conn.recv(1024)
            if data == b"switch":
                with self.window_list_lock:
                    tree = self.i3.get_tree()
                    # don't recovery from BrokenPipe
                    #  try:
                    #      tree = self.i3.get_tree()
                    #  except BrokenPipeError:
                    #      self.i3 = i3ipc.Connection()
                    #      tree = self.i3.get_tree()
                    windows = set(w.id for w in tree.leaves())
                    for window_id in self.window_list[1:]:
                        if window_id not in windows:
                            self.window_list.remove(window_id)
                        else:
                            self.i3.command("[con_id=%s] focus" % window_id)
                            break
            elif not data:
                selector.unregister(conn)
                conn.close()

        selector.register(self.listening_socket, selectors.EVENT_READ, accept)

        while True:
            for key, event in selector.select():
                callback = key.data
                callback(key.fileobj)

    def run(self):
        t_i3 = threading.Thread(target=self.launch_i3)
        t_server = threading.Thread(target=self.launch_server)
        for t in (t_i3, t_server):
            t.start()


if __name__ == "__main__":
    parser = ArgumentParser(
        prog="focus-last.py",
        description="""
        Focus last focused window.

        This script should be launch from the .xsessionrc without argument.

        Then you can bind this script with the `--switch` option to one of your
        i3 keybinding.
        """,
    )
    parser.add_argument(
        "--switch",
        dest="switch",
        action="store_true",
        help="Switch to the previous window",
        default=False,
    )
    args = parser.parse_args()

    if not args.switch:
        #  daemonize()
        focus_watcher = FocusWatcher()
        focus_watcher.run()
    else:
        client_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        client_socket.connect(SOCKET_FILE)
        client_socket.send(b"switch")
        client_socket.close()
