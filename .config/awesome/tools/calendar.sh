gcalcli --nocolor agenda --nostarted --details location --details end today tomorrow | head -2 | tail -n 1 | sed -r 's/[a-zA-Z.]{3,4} [a-zA-Z.]{3,4} [0-9]{2}//' | awk '{$1=$1};1'
