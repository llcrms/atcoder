read nuser count
declare -a auser=()

YES="Y"
NO="N"

function follow() {
    local u=$1
    local flw=$2

    # echo -n $u
    # echo ,${auser[@]}
    auser[${u}]=${auser[${u}]:0:$(($flw - 1))}${YES}${auser[${u}]:${flw}}
    # echo ">" ${auser[@]}
}

function follow_back() {
    local u=$1
    local i=0
    while [[ $i -lt $nuser ]]; do
        if [[ ${u} -eq ${i} ]]; then
            continue
        fi
        i=$(($i + 1))
        fb=${auser[${i}]:$(($u - 1)):1}
        if [[ ${fb} = ${YES} ]]; then
            auser[${u}]=${auser[${u}]:0:$(($i - 1))}${YES}${auser[${u}]:${i}:$(($nuser - $i))}
        fi
    done
}

function follow_follow() {
    local u=$1
    local i=0
    local f=${auser[${u}]}
    for i in $(eval echo {1..${#f}}); do
        f1=${f:$((${i} - 1)):1}
        if [[ ${f1} != ${YES} ]]; then
            continue;
        fi
        ff=${auser[${i}]}
        for j in $(eval echo {1..${#ff}}); do
            f2=${ff:$((${j} - 1)):1}
            if [[ ${f2} != ${YES} ]]; then
                continue;
            fi
            follow ${u} ${j}
        done
    done
}

x=""
for z in $(seq ${nuser}); do
    x+=${NO}
done
for z in $(seq ${nuser}); do
    auser[${z}]=$x
done
for z in $(seq ${count}); do
    read op u m
    # echo $op $u $m
    case ${op} in
    1) follow ${u} ${m} ;;
    2) follow_back ${u} ;;
    3) follow_follow ${u} ;;
    *) ;;
    esac
done
echo ${auser[@]} | sed -e 's/ /\n/g'
