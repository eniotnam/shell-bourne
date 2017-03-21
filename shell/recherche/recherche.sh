#! /bin/sh

sorter()
{
echo "ERREUR : $1">&2
echo "Utilisation $0 nom_repertoire nom_repertoire2">&2
exit $2
}

[ $# -ne 2 ] && sorter "Il faut deux parametres et seulement deux !"
[ ! -d "$1" ] && sorter "$1 n'est pas un repertoire !"
[ ! -d "$2" ] && sorter "$2 n'est pas un repertoire !"

IFS='
'
echo " $1diff$2 "
exit 2
