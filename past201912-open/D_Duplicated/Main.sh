read count;
x=1
before=0
no_num=0
dbl_num=0

for n in `sort -n`; do
    if [[ ${n} -eq ${before} ]]; then
        dbl_num=${n}
    elif [[ ${n} -eq $(($before + 2)) ]]; then
        no_num=$(($before + 1))
    fi
    if [[ ${no_num} -ne 0 ]] && [[ ${dbl_num} -ne 0 ]]; then
        break;
    fi
    x=$(($x + 1))
    before=${n}
done
if [[ ${no_num} -eq 0 ]] && [[ ${dbl_num} -eq 0 ]]; then
    echo Correct;
elif [[ ${no_num} -eq 0 ]]; then
    echo ${dbl_num} ${count}
else
    echo ${dbl_num} ${no_num}
fi
