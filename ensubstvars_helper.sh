#!/bin/sh
#USE: cat listofenvvars | ensubstvars_helper.sh template.file target.file

ensubstvars=""
while read p; do
  ensubstvars="$ensubstvars \${$p} "
done

envsubst "$ensubstvars" < $1 > $2
