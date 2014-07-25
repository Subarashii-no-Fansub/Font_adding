#!/bin/bash
# paramètre 1 : video $1
# paramètre 2 et suivants : police

set -e

if [ "$2" = "" ] ; then
    echo "need args"
    exit 1
fi

name="$1"
shift

chmod 644 "$name"

cmd="mkvpropedit '$name'"

for ((i=0 ; $# ; i++))
do
	if [ ! -f "$1" ]; then
	    echo "lost $1" ; shift ; continue
	fi
	filename="$(basename "$1")"
	attachemine="$(file --brief --mime-type "$1")"

	cmd="$cmd --attachment-name '$filename' --attachment-mime-type '$attachemine' --add-attachment '$1'"
	shift
done

echo $(eval "$cmd")

echo "FINI !"
