read nuser count

IN_NUSER=$(seq -s' ' ${nuser})
ARY_MAX=$(( ${nuser} * ${nuser} ))
YES="Y"
NO="N"

declare -a aryuser=(
    # $( eval echo {1..$(( ${nuser} * ${nuser} ))} )
    # $(seq $(( ${nuser} * ${nuser} )) )
    $( seq ${ARY_MAX} | sed -e 's/[0-9]*/N/g' )
)

ary_index=0

function ary_offset () {
    ary_index=$(( ($1 - 1) * ${nuser} + $2 - 1 ));
}

function follow () {
    ary_offset ${1} ${2}
    aryuser[$ary_index]=${YES}
}

function follow_back () {
    local u=$1
    for i in ${IN_NUSER}; do
        if [[ ${u} = ${i} ]]; then
            continue
        fi
        ary_offset ${i} ${u}
        if [[ ${aryuser[$ary_index]} = ${YES} ]]; then
            follow ${u} ${i}
        fi
    done
}

function follow_follow () {
    local u=$1
    local i=0
    local u_index=$(( ( ${u} - 1 ) * ${nuser} )) 
    for i in $(for ii in ${IN_NUSER}; do
                # ary_offset ${u} ${ii};
                if [[ ${aryuser[$u_index]} = ${YES} ]]; then
                    echo ${ii};
                fi
                u_index=$(( ${u_index} + 1 ))
            done) ; do
        for j in ${IN_NUSER}; do
            if [[ ${u} = ${j} ]]; then
                continue
            fi
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
    echo ${aryuser[*]} | sed -e 's/ //g' | fold -w ${nuser}
    # echo ${aryuser[*]} | sed -e 's/[0-9][0-9]*/'${NO}'/g' -e 's/ //g' | fold -w ${nuser}
}

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
