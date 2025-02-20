read nuser count
declare -a auser=()

YES="Y"
NO="N"

function follow() {
    u=$1
    follow=$2
    # echo -n $u
    # echo ,${auser[@]}
    auser[${u}]=${auser[${u}]:0:$(($follow - 1))}${YES}${auser[${u}]:${follow}}
    # echo ">" ${auser[@]}
}

function follow_back() {
    u=$1
    i=0
    while [[ $i < $nuser ]]; do
        if [[ ${u} -eq ${i} ]]; then
            continue
        fi
        i=$(($i + 1))
        fb=${auser[${i}]:$((u - 1)):1}
        if [[ ${fb} = ${YES} ]]; then
            auser[${u}]=${auser[${u}]:0:$(($i - 1))}${YES}${auser[${u}]:${i}:$(($nuser - $i))}
        fi
    done
}

function follow_follow() {
    u=$1
    i=0
    f=${auser[${u}]}
    # echo follow_follow: ${u} ${f}
    for i in $(eval echo {1..${#f}}); do
        f1=${f:$((${i} - 1)):1}
        if [[ ${f1} != ${YES} ]]; then
            continue;
        fi
        ff=${auser[${i}]}
        # echo ,$i ${f1},${ff}
        for j in $(eval echo {1..${#ff}}); do
            f2=${ff:$((${j} - 1)):1}
            if [[ ${f2} != ${YES} ]]; then
                continue;
            fi
            follow ${u} ${j}
        done
    done
    # while [[ $i < $nuser ]]; do
    # done
}

i=0
x=""
while [[ $i < $nuser ]]; do
    x+=${NO}
    i=$(($i + 1))
done
i=0
while [[ $i < $nuser ]]; do
    i=$(($i + 1))
    auser[${i}]=$x
done
i=0
while [[ $i < $count ]]; do
    i=$(($i + 1))
    read op u m
    # echo $op $u $m
    case ${op} in
    1) follow ${u} ${m} ;;
    2) follow_back ${u} ;;
    3) follow_follow ${u} ;;
    *) ;;
    esac
    # echo ${i} ${op} ${user} ${member}
done
echo ${auser[@]} | sed -e 's/ /\n/g'
