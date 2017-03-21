# projet-bash-bourne-decembre-2016
Voir pdf pour + d'infos

Voici l'arborescence du dossier
```
..
|-- README.md
|-- data
|   |-- rep1
|   |   |-- f0.txt
|   |   |-- f1.txt
|   |   |-- fichier\ avec\ espace\ dans\ le\ nom.txt
|   |   |-- subrep
|   |   |   `-- abc.rtf
|   |   |-- texte.sh
|   |   `-- vide.vide
|   `-- rep2
|       |-- f0.txt
|       |-- f1.txt
|       `-- f3.txt
`-- scripts
    |-- compare.sh
    `-- synchro.sh
```

# compare
## Utilisation
`./compare.sh ../data/rep1 ../data/rep2`
ou
`bash ./compare.sh ../data/rep1 ../data/rep2`

## Exemple de sortie 
``` bash
root@1d51fc8db9ad:/projet/scripts# bash ./compare.sh ../data/rep1 ../data/rep2
../data/rep1:
   |- ../data/rep1/sub.dos ne se trouve pas dans ../data/rep2
   |- ../data/rep1/sub.dos/sf0.txt ne se trouve pas dans ../data/rep2
   |- ../data/rep1/sub.dos/sf1.txt ne se trouve pas dans ../data/rep2
   |- ../data/rep1/texte.sh ne se trouve pas dans ../data/rep2
   |- ../data/rep1/vide.vide ne se trouve pas dans ../data/rep2
../data/rep2:
   |- ../data/rep2/f3.txt ne se trouve pas dans ../data/rep1
```