gcalcli --nocolor agenda --nostarted --details location --details end today tomorrow | head -2 | tail -n 1 | sed -r 's/[a-z]{3}. [a-z]{4}. [0-9]{2}//' | awk '{$1=$1};1'
