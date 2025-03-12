read nuser count

head -n${count} | (
declare -a aryuser=(
    `seq $(( ${nuser} * ${nuser} ))`
)

ary_index=
function ary_offset () {
    ary_index=$(( ($1 - 1) * ${nuser} + ($2 - 1)));
}

YES="Y"
NO="N"

function follow() {
    export aryuser
    local lu=${1}
    local li=${2}
    ary_offset ${lu} ${li}
    # echo $ary_index
    aryuser[$ary_index]=${YES}
}

function follow_back() {
    local u=$1
    for i in $(eval echo {1..${nuser}}); do
        if [[ ${u} -eq ${i} ]]; then
            continue
        fi
        ary_offset ${i} ${u}
        if [[ ${aryuser[$ary_index]} = ${YES} ]]; then
            follow ${u} ${i}
        fi
    done
}

function follow_follow() {
    local u=$1
    local i=0
    local f=${nuser}
    for i in `for ii in $(eval echo {1..${nuser}}); do
        ary_offset ${u} ${ii}
        if [[ ${aryuser[$ary_index]} = ${YES} ]]; then
            echo ${ii}
        fi
    done` ; do
        for j in $(eval echo {1..${nuser}}); do
            ary_offset ${i} ${j}
            if [[ ${aryuser[$ary_index]} = ${YES} ]]; then
                follow ${u} ${j}
            fi
        done
    done

}

function answer () {
    # echo ${aryuser[*]}
    # echo ${aryuser[*]} | sed -e 's/ *[0-9]* */'${NO}'/g' -e 's/ //g'
    echo ${aryuser[*]} | sed -e 's/[0-9][0-9]*/'${NO}'/g' -e 's/ //g' | fold -w ${nuser}
}


i=0
while read op u m; do
    # echo $op $u $m
    case ${op} in
    1) follow ${u} ${m} ;;
    2) follow_back ${u} ;;
    3) follow_follow ${u} ;;
    *) ;;
    esac
done
answer;
)
