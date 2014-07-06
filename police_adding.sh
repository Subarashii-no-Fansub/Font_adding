#!/bin/bash
# paramètre 1 : video $1
# paramètre 2 et suivants : police

set -e


#change this please :-)
crc_calc="crc32"
fansub_name="SnF"

chmod 644 "$1"

mkvmerge -i "$1"
read -p "Numéro de la vidéo : " var_idvid
read -p "Numéro du son : " var_idson
read -p "Numéro des sous-titres : " var_idss

fullfilename=$(basename "$1")
filename="${fullfilename%.*}"

command='"'

nombrearg="$#"

for ((i=2 ; $nombrearg-$i ; i++))
do
  fullfilename=$(basename "$i")
  filename="${fullfilename%.*}"
  command="$command --attachment-mime-type file --brief --mime $i --attachment-name $filename --attach-file $i"
done

mkvmerge -o "$filename" --default-track var_idvid:yes --forced-track $var_idvid:no --language $var_idson:jpn --default-track $var_idson:yes --forced-track $var_idson:no --language $var_idss:fre --default-track $var_idss:yes --forced-track $var_idss:no --video-tracks $var_idvid --audio-tracks $var_idson --subtitle-tracks $var_idss --no-track-tags --no-global-tags "$1" $command

echo "FINI !"
