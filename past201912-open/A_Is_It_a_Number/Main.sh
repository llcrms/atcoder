read x
if [ $(expr match "${x}" '^[0-9][0-9][0-9]$') -eq 3 ]; then
    expr 2 \* $x
else
    echo error
fi
exit 0
