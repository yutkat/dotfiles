#!/bin/bash

id=`python ~/.i3/scripts/id_list.py`
i3-msg [id="$id"] focus > /dev/null
