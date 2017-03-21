#! /bin/bash
# Commande synchro
# Réaliser une commande (synchro) en shell Bourne, effectuant la synchronisation d'une
# arborescence source vers une arborescence destination.
# Cette commande permettra, selon les résultats de l'analyse, de faire :
# $ synchro rep1 rep2
# ou
# $ synchro rep2 rep1
# sachant que la source sera le premier paramètre et la destination le second.
# Cette commande devra être interactive et demander, dans les cas échéants, si il y a remplacement du
# fichier ou du répertoire.
# 

sorter()
{
	echo "ERREUR : $1">&2 
	echo "Utilisation $0 nom_repertoire nom_repertoire2">&2 
    exit # on quitte l'execution du script
}
# On regarde si on as bien 2 paramètres donnés en arguments
[ $# -ne 2 ] && sorter "Il faut deux parametres et seulement deux !"

# On valide les paramètres
# On regarde si il existe et si ce sont bien des dossiers

[ ! -d "$1" ] && sorter "$1 n'est pas un repertoire"
[ ! -d "$2" ] && sorter "$2 n'est pas un repertoire"
rep1=$1
rep2=$2

# On va maintenant parcourir le premier repertoire
# on modifie la variabel IFS
IFS='
'
Confirm()
{
	while [ 1 -eq 1 ]; do
		echo "copier $1 dans $2 (O ou N ) ?:"
		read rep
		if [ -d $1 ] ; then
			[ "$rep" = "O" ] && cp -r "$1" "$2"
			[ "$rep" = "N" ] && break
		else
			[ "$rep" = "O" ] && cp "$1" "$2"
			[ "$rep" = "N" ] && break
		fi
		echo "Seuls O (oui) ou N (non) sont acceptes !"
	done
}

exist()
{
    # cette fonction prend 4 paramètres : exist {chemin_source} {type}  {dossier source} {dossier destination}
    # et elle regarde si ce fichier/repertoire ce trouve dans {dossier destination}
    chemin=$1
    type=$2

    # on attribue les bonnes variables pour le sens de comparaison
    source=$3
    destination=$4

    # on re-écrit le chemin pour qu'il pointe vers rep2
    chemin2=${chemin/$source/$destination} # on replace le chemin du fichier source avec le chemin dans le dossier de destination

    # on regarde si le fichier existe dans le rep2
    if [ ! -$type $chemin2 ]; then
        echo "$chemin ne se trouve pas dans $4"
    	! Confirm $chemin $4 && exit 5
    fi
}


parc()
{
    # Cette fonction permet de parcourir les fichiers/dossier d'un $1=dossier donner
    # On regarde que c'est bien un repertoire
    [ ! -d "$1" ] && sorter "$1 n'est pas un repertoire"

    for i in `ls $1`; do
    
        # on regarde si c'est un repertoire
        if [ -d "$1/$i" ]; then
            # c'est un repertoire on va donc le re-parcourir
            exist $1/$i "d" $1 $2 # on lance la commande qui regarde dans le $2 (oui cela va vérifier si le dossier existe)
            parc $1/$i $2 # on relance la fonction
            
        
        # on regarde si c'est un fichier
        elif [ -f "$1/$i" ]; then
            exist $1/$i "f" $1 $2 # on lance la commande qui regarde dans le $2
        fi
    done
}

parc $1 $2 # utile pour la comparaison
