read count;
declare -a ary=($(seq 0 ${count}));
ary[0]="";
dup=""

readarray -n ${count} -t lines

for n in ${lines[*]}; do
    if [[ ${ary[${n}]} = "" ]]; then
        dup=${n}
    else
        ary[${n}]="";
    fi
done
if [[ ${dup} -eq 0 ]]; then
    echo Correct;
else
    echo ${dup} ${ary[*]};
fi
exit 0;
