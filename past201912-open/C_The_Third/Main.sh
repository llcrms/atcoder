read a b c d e f
(
    echo $a
    echo $b
    echo $c
    echo $d
    echo $e
    echo $f
) | sort -n | head -4 | tail -1
