# Open terminals: new colours over OSC escapes, and herdr clients redrawn
seq=$(printf '\033]10;#%s\033\\\033]11;#%s\033\\' "$fg" "$bg")
i=0
for c in $regular0 $regular1 $regular2 $regular3 $regular4 $regular5 $regular6 $regular7 \
         $bright0 $bright1 $bright2 $bright3 $bright4 $bright5 $bright6 $bright7; do
    seq+=$(printf '\033]4;%d;#%s\033\\' "$i" "$c")
    i=$((i + 1))
done
for pts in /dev/pts/[0-9]*; do
    [ -O "$pts" ] || continue
    timeout 1 sh -c 'printf "%s" "$1" > "$2"' sh "$seq" "$pts" 2>/dev/null &
done
wait
sleep 0.3
ps -C herdr -o pid=,tty=,args= | awk '$2 != "?" && $0 !~ /server/ { print $1 }' | xargs -r kill -WINCH 2>/dev/null || true
