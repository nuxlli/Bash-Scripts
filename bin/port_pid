#!/bin/sh

# Map LISTENing TCP ports to their PIDs using lsof

LSOF=/usr/sbin/lsof

# e.g. netstat -an
# 127.0.0.1.25               *.*                0      0 49152      0 LISTEN
#       *.22                 *.*                0      0 49152      0 LISTEN

# e.g. lsof -i
# sshd    5097    root    5u  IPv4 0x30863fb1b58      0t0  TCP *:ssh (LISTEN)

printf "%-6s %-10s %-6s %-8s\n" "Port" "Command" "PID" "User"
printf "%-6s %-10s %-6s %-8s\n" "----" "-------" "---" "----"

for PORT in `netstat -an -f inet | grep -i listen | awk '{ print $4 }' | sed -e :a -e 's/.*\.//'`; do
   $LSOF -i :${PORT} 2>/dev/null | grep LISTEN | tail -1 | while read line; do
      set $line
      COMMAND=$1
      PID=$2
      LSOF_USER=$3
      printf "%-6d %-10s %-6d %-8s\n" "$PORT" "$COMMAND" "$PID" "$LSOF_USER"
   done
done
