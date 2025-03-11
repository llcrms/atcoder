read cnt
read last
i=1
while :; do
    read today
    n=$((${today} - ${last}))
    if [[ ${n} -eq 0 ]]; then
        echo stay
    elif [[ ${n} -gt 0 ]]; then
        echo up ${n}
    else
        echo down $((${n} * -1))
    fi
    i=$((${i} + 1))
    if [[ ${i} -eq ${cnt} ]]; then
        break
    fi
    last=${today}
done
