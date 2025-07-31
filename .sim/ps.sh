#! /bin/bash

watch -n 2 "ps -eo pid,ppid,uid,cmd --sort=-%mem | grep '^ *[0-9].* /usr/bin/bash'"