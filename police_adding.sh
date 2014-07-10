#!/bin/bash
# paramètre 1 : video $1
# paramètre 2 et suivants : police

set -e

chmod 644 "$1"

mkvmerge -i "$1"
read -p "Numéro de la vidéo : " var_idvid
read -p "Numéro du son : " var_idson
read -p "Numéro des sous-titres : " var_idss

nombrearg="$#"

commande=""

for ((i=2 ; $nombrearg+1-$i ; i++))
do
	fullfilename=$(basename "${!i}")
	attachemine=$(file --brief --mime-type "${!i}")
	commande=$(printf "%s --attachment-name \"%s\"  --attachment-mime-type \"%s\" --add-attachment \"%s\"" "$commande" "$fullfilename" "$attachemine" "${!i}")
done

fullfilename=$(basename "$1")

echo $commande

mkvpropedit "$1" $($commande)

echo "FINI !"
