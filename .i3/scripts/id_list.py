import json
import subprocess


"""
Execute the given command and return the
output as a list of lines
"""
def command_output(cmd):
    output = []
    if (cmd):
        p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, \
                                 stderr=subprocess.STDOUT)
        for line in p.stdout.readlines():
            output.append(line.rstrip())
    return output


def output_to_dict(output_list):
    output_string = ""
    for line in output_list:
        output_string += line
    return json.loads(output_string)


def find_windows(tree_dict, window_list):
    if (tree_dict.has_key("nodes") and len(tree_dict["nodes"]) > 0):
        for node in tree_dict["nodes"]:
            find_windows(node, window_list)
    else:
        if (tree_dict["layout"] != "dockarea" and not tree_dict["name"].startswith("i3bar for output") and not tree_dict["window"] == None):
            window_list.append(tree_dict)

    return window_list


def main():
    output = command_output("i3-msg -t get_tree")
    tree = output_to_dict(output)
    window_list = find_windows(tree, [])

    next_index = -1
    for i in range(len(window_list)):
        if (window_list[i]["focused"] == True):
            next_index = i+1
            break

#    next_index = len(window_list)
#    for i in range(len(window_list)-1, -1, -1):
#        if (window_list[i]["focused"] == True):
#            next_index = i-1
#            break

    next_id = 0;
    if next_index == -1 or next_index == len(window_list):
        next_id = window_list[0]["window"]
    else:
        next_id = window_list[next_index]["window"]

    print next_id

main()
