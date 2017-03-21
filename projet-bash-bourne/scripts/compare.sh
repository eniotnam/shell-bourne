#! /bin/bash
# Commande compare
# Réaliser une commande (compare) en shell Bourne, effectuant la comparaison des deux
# arborescences dont les sommets sont les deux répertoires.
# Le compte rendu doit être assez détaillé pour se rendre compte des modifications, mais pas trop
# verbeux pour rester efficace.
# Le résultat de cette commande non interactive servira de support pour analyser l'étape suivante, la
# synchronisation.
# 
# 
#Consigne en cas d'erreur
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

    # on regarde si le fichier/dossier existe dans le rep2
    if [ ! -$type $chemin2 ]; then
        echo "$chemin ne se trouve pas dans $chemin2"
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

# echo "$1:"
parc $1 $2 # utile pour la comparaison
# echo "$2:"
parc $2 $1 # de meme
