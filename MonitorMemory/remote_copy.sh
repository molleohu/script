#!/usr/bin/expect
#


spawn scp <username>@<ip>:<path>/output.txt .

expect "*password:"
send "pass...\r"

interact

