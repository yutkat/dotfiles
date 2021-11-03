#!/usr/bin/env python

import json
import subprocess


def command_output(cmd):
    if cmd:
        p = subprocess.run(
            cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT
        )
    return json.loads(p.stdout)


def find_windows(tree_dict, window_list):
    if "nodes" in tree_dict and len(tree_dict["nodes"]) > 0:
        for node in tree_dict["nodes"]:
            find_windows(node, window_list)
    else:
        if (
            tree_dict["layout"] != "dockarea"
            and not tree_dict["name"].startswith("i3bar for output")
            and not tree_dict["window"] is None
        ):
            window_list.append(tree_dict)

    return window_list


def main():
    tree = command_output("i3-msg -t get_tree")
    window_list = find_windows(tree, [])

    next_index = -1
    for i in range(len(window_list)):
        if window_list[i]["focused"]:
            next_index = i + 1
            break

    next_id = 0
    if next_index == -1 or next_index == len(window_list):
        next_id = window_list[0]["window"]
    else:
        next_id = window_list[next_index]["window"]

    print(next_id)


main()
