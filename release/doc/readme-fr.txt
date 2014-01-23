Contenu :
  1. Présentation
  2. Installation
  3. Mise à jour
  4. Informations supplémentaires pour la configuration

-----------------------------------------------------------
1. PRESENTATION
-----------------------------------------------------------

  Ce mod propose de nombreuses fonctionnalités, comme :
    * Des marqueurs au-dessus des tanks personnalisables
    * La possibilité de désactiver les panneaux postmortem
    * Le contrôle de l'orientation des icônes des tanks
    * La personnalisation complète des panneaux des joueurs (largeur, 
      transparence, contenu, ...)
    * Une horloge sur l'écran de chargement
    * Les icônes des clans en bataille
    * Des packs d'icônes différents en bataille, sur l'écran de chargement, etc.
    * Les statistiques des joueurs en partie
    * Des informations additionnelles sur la barre de capture
    * La possibilité de personnaliser la minimap
    * L'affichage de statistiques supplémentaires en compagnie de chars ou dans 
      les rapports de service
    * Des infos sur les tanks dans la fenêtre de peloton
    * L'affichage des ennemis détectés ou non dans le panneau sur le côté droit
    * La possibilité de charger directement l'équipage dans un char
    * L'affichage du ping avant de se connecter au serveur ou avant de lancer 
      une partie

  Site officiel :     http://www.modxvm.com/fr/

  Support :           http://www.koreanrandom.com/forum/topic/1383-xvm (en anglais)
  FAQ :               http://www.modxvm.com/fr/faq/
  Configurations :    http://www.koreanrandom.com/forum/forum/50-custom-configurations (en anglais)
  Editeur de config : http://www.koreanrandom.com/forum/topic/1422-/#entry11316


-----------------------------------------------------------
2. INSTALLATION
-----------------------------------------------------------

  1. Extraire l'archive dans le dossier du jeu :
    Clic droit sur l'archive -> "Extraire tout..." -> sélectionner le dossier du
    jeu -> "Extraire".

  2. Vous n'avez rien à faire de plus pour que le mod fonctionne.

    Si vous voulez personnaliser votre configuration, vous devez renommer le 
    fichier de démarrage de la config :
      \res_mods\xvm\xvm.xc.sample en xvm.xc
    Les consignes pour modifier les paramêtres sont à l'intérieur.

    Toutes les options de configuration sont localisées dans
      \res_mods\xvm\configs\@Default\
    Mais vous pouvez également utiliser l'éditeur en ligne : 
      http://www.koreanrandom.com/forum/topic/1422-/#entry11316

    Note : Si vous voulez modifier la configuration manuellement, utilisez le 
    Bloc-notes Windows ou Notepad++, mais n'utilisez PAS de logiciels de 
    traitement de texte comme MS Word ou WordPad.

  3. Si XVM n'arrive pas à détecter la langue du client de jeu, alors allez dans
    le fichier de configuration (par défaut \res_mods\xvm\configs\@Default\@xvm.xc),
    changez la valeur de la variable "language" de "auto" à votre code de langue,
    par exemple "fr" pour le français. Le code de langue doit correspondre au
    nom du fichier dans \res_mods\xvm\l10n\.

  4. Vous pouvez installer des versions journalières de développement d'XVM.
    Vous pouvez télécharger ces versions spéciales ici :
      http://wargaming.by-reservation.com/xvm/ (en anglais)

-----------------------------------------------------------
3. MISE A JOUR
-----------------------------------------------------------

  1. Extraire l'archive dans le dossier de jeu :
    Clic droit sur l'archive -> "Extraire tout..." -> sélectionner le dossier du
    jeu -> "Extraire".

  2. Ne rien faire d'autre.
    Notez néanmoins que les modifications effectuées dans le dossier 
    configs\@Default seront effacées.

-----------------------------------------------------------
4. INFORMATIONS SUPPLEMENTAIRES POUR LA CONFIGURATION
-----------------------------------------------------------

  Fichiers de configuration par défaut :
    \res_mods\xvm\configs\@Default\
  Vous pouvez utiliser des configurations toutes faites dans le dossier
    \res_mods\xvm\configs\user configs\
  Vous pouvez créer une nouvelle configuration ou en éditer une déjà existante à
  l'aide de l'éditeur en ligne :
    http://www.koreanrandom.com/forum/topic/1422-/#entry11316


  Balises HTML supportées :
    http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText (en anglais)

  Macros disponibles :
    Dans les panneaux des joueurs, l'écran de chargement et quand vous faites TAB :
      {{nick}}        - pseudo du joueur avec tag du clan
      {{name}}        - pseudo du joueur sans tag du clan
      {{clan}}        - tag du clan avec crochets (vide si pas de clan)
      {{clannb}}      - tag du clan sans crochets
      {{vehicle}}     - nom du tank
      {{vehiclename}} - nom du tank interne (usa-M24_Chaffee)
      {{vtype}}       - type de tank
      {{c:vtype}}     - couleur en fonction du type de tank
      + macros statistiques (cf. ci-dessous)

    Dans les marqueurs au-dessus des tanks :
      {{nick}}        - pseudo du joueur avec tag du clan
      {{name}}        - pseudo du joueur sans tag du clan
      {{clan}}        - tag du clan avec crochets (vide si pas de clan)
      {{clannb}}      - tag du clan sans crochets
      {{squad}}       - valeur '1' pour son propre peloton, vide pour les autres
      {{vehicle}}     - nom du tank
      {{vehiclename}} - nom du tank interne (usa-M24_Chaffee)
      {{vtype}}       - type de tank
      {{level}}       - tier du tank
      {{rlevel}}      - tier du tank (numérotation romaine)
      {{turret}}      - marqueur de tourelle stock :
                          symbole "*" - tourelle stock, ne peut pas monter le meilleur canon
                          symbole "'" - tourelle stock, peut monter le meilleur canon
                          vide - meilleure tourelle
      {{hp}}          - points de vie actuels
      {{hp-ratio}}    - % de vie actuel (sans le signe '%')
      {{hp-max}}      - points de vie maximum
      {{dmg}}         - points de dégâts
      {{dmg-ratio}}   - % de dégâts (sans le signe '%')
      {{dmg-kind}}    - type de dégât (attaque normale, feu, collision, ...)
      {{c:hp}}        - couleur en fonction des points de vie actuels
      {{c:hp-ratio}}  - couleur en fonction du % de vie actuel
      {{c:dmg}}       - couleur en fonction de la source de dégât
      {{c:dmg-kind}}  - couleur en fonction du type de dégât
      {{c:vtype}}     - couleur en fonction du type de tank
      {{c:system}}    - couleur du système (désactive la couleur de remplacement)
      {{a:hp}}        - transparence en fonction des points de vie actuels
      {{a:hp-ratio}}  - transparence en fonction du % de points de vie actuel
      {{l10n:blownUp}} - texte traduit pour "Blown-up!" (ammorack), uniquement dans "blowupMessage"
      + macro statistiques (cf. ci-dessous)

    Dans le journal des coups reçus :
      {{n}}           - nombre total de tirs
      {{n-player}}    - nom de tirs pour chaque joueur
      {{dmg}}         - dégâts du dernier tir
      {{dmg-total}}   - somme totale des tirs
      {{dmg-avg}}     - moyenne de dégâts durant la bataille
      {{dmg-player}}  - somme des tirs pour chaque joueur
      {{dead}}        - marqueur de destruction du tank
      {{nick}}        - pseudo du joueur avec tag du clan
      {{name}}        - pseudo du joueur sans tag du clan
      {{clan}}        - tag du clan avec crochets (vide si pas de clan)
      {{clannb}}      - tag du clan sans crochets
      {{vehicle}}     - nom du tank
      {{vehiclename}} - nom du tank interne (usa-M24_Chaffee)
      {{vtype}}       - type de tank
      {{level}}       - tier du tank
      {{rlevel}}      - tier du tank (numérotation romaine)
      {{dmg-kind}}    - type de dégât (attaque normale, feu, collision, ...)
      {{c:dmg-kind}}  - couleur en fonction du type de dégât
      {{c:vtype}}     - couleur en fonction du type de tank
      {{l10n:Hits}}   - traduction pour "Hits" (tirs)
      {{l10n:Total}}  - traduction pour "Total" 
      {{l10n:Last}}   - traduction pour "Last" (dernier)

    Dans 'PV restants' :
      {{nick}}        - pseudo du joueur avec tag du clan
      {{name}}        - pseudo du joueur sans tag du clan
      {{clan}}        - tag du clan avec crochets (vide si pas de clan)
      {{clannb}}      - tag du clan sans crochets
      {{vehicle}}     - nom du tank
      {{vehiclename}} - nom du tank interne (usa-M24_Chaffee)
      {{vtype}}       - type de tank
      {{level}}       - tier du tank
      {{rlevel}}      - tier du tank (numérotation romaine)
      {{hp}}          - points de vie actuels
      {{hp-ratio}}    - % de vie actuel (sans le signe '%')
      {{hp-max}}      - points de vie maximum
      {{c:vtype}}     - couleur en fonction du type de tank
      {{c:hp}}        - couleur en fonction des points de vie actuels
      {{c:hp-ratio}}  - couleur en fonction du % de vie actuel
      {{l10n:hpLeftTitle}} - traduction pour "Hitpoints left:" (PV restants), seulement dans "header"
      
    Dans la barre de capture :
      {{points}}      - points de capture actuels
      {{extra}}       - texte supplémentaire; s'affiche uniquement quand le temps restantet le nombre de capeurs a bien été calculé
      {{tanks}}       - nombre de capeurs; ne peut pas être défini si plus de 3;      ne peut être placé dans {{extra}} uniquement
      {{time}}        - temps restant avant la capture complète; minutes et secondes; ne peut être placé dans {{extra}} uniquement
      {{time-sec}}    - temps restant avant la capture complète; secondes seulement;  ne peut être placé dans {{extra}} uniquement
      {{speed}}       - vitesse de capture en points/seconde;                         ne peut être placé dans {{extra}} uniquement
      {{l10n:enemyBaseCapture}}     - traduction pour "Base capture by allies!" (base en cours de capture par les alliés)
      {{l10n:enemyBaseCaptured}}    - traduction pour "Base captured by allies!" (base capturée par les alliés)
      {{l10n:allyBaseCapture}}      - traduction pour "Base capture by enemies!" (base en cours de capture par les ennemis)
      {{l10n:allyBaseCaptured}}     - traduction pour "Base captured by enemies!" (base capturée par les ennemis)
      {{l10n:Timeleft}}             - traduction pour "Timeleft" (temps restant)
      {{l10n:Capturers}}            - traduction pour "Capturers" (capeurs/nb. de tanks dans le rond de capture)

    Dans la minimap :
      {{level}}        - tier du tank
      {{short-nick}}   - pseudo raccourci du joueur
      {{vehicle}}      - nom complet du tank
      {{vehicle-type}}  - nom complet du type de tank
      {{vehicle-class}} - symbole spécial en fonction du type de tank
      {{cellsize}}     - taille d'une cellule de la minimap
      {{vehicle-name}} - retourne le nom interne du tank - usa-M24_Chaffee
      {{vehiclename}}  - retourne le nom interne du tank - usa-M24_Chaffee
      {{vehicle-short}}  - nom du tank raccourci

    Macros statistiques ('rating/showPlayersStatistics' doit être activé) :
      {{avglvl}}      - tier moyen des tanks joués
      {{eff}}         - ER du joueur : http://wot-news.com/index.php/stat/calc/en/ 
      {{eff:4}}       - ER du joueur aligné à gauche sur 4 caractères
      {{teff}}, {{e}} - ER du véhicule : http://www.koreanrandom.com/forum/topic/1643-
      {{wn6}}         - classement WN6 : http://www.koreanrandom.com/forum/topic/2575-
      {{wn8}}         - classement WN8 : http://www.koreanrandom.com/forum/topic/2575-   
      {{wn}}          - classement WN8 : http://www.koreanrandom.com/forum/topic/2575-
      {{xeff}}        - XVM Scale pour l'ER (de 00 à 99, XX pour les tops serveur)
      {{xwn}}         - XVM Scale pour le WN8 (de 00 à 99, XX pour les tops serveur)
      {{rating}}      - GWR (Global Win Ratio) = % de victoire global du joueur
      {{rating:3}}    - GWR aligné à gauche sur 3 caractères
      {{battles}}     - nombre total de batailles
      {{wins}}        - nombre total de victoires
      {{kb}}          - nombre de kilo-batailles (nb. total de batailles divisé par 1000)
      {{kb:3}}        - nombre de kilo-batailles aligné à gauche sur 3 caractères
      {{t-rating}}    - % de victoire du tank
      {{t-rating:3}}  - % de victoire du tank aligné à gauche sur 3 caractères
      {{t-battles}}   - nombre total de batailles pour le tank actuel
      {{t-battles:4}} - nombre de batailles pour le tank actuel aligné à gauche sur 4 caractères
      {{t-wins}}      - nombre total de victoires pour le tank actuel
      {{t-kb}}        - nombre de kilo-batailles pour le tank actuel
      {{t-kb-0}}      - nombre de kilo-batailles pour le tank actuel avec zéro initial
      {{t-kb:4}}      - nombre de kilo-batailles pour le tank actuel aligné à gauche sur 4 caractères
      {{t-hb}}        - nombre de hecto-batailles pour le tank actuel (hecto = 100)
      {{t-hb:3}}      - nombre de hecto-batailles pour le tank actuel aligné à gauche sur 3 caractères
      {{tdb}}, {{tdb:4}} - dégâts moyens pour le tank actuel (dégâts/parties)
      {{tdv}} - efficacité des dégâts moyens du tank - dégâts/(batailles*maxPV)
      {{tfb}} - nombre de détruits moyen par bataille pour le tank actuel
      {{tsb}} - nombre de détectés moyens par bataille pour le tank actuel
      {{c:tdb}}, {{c:tdv}}, {{c:tfb}}, {{c:tsb}} - couleurs dynamiques pour ces macros
      {{c:eff}}       - couleur en fonction de l'ER du joueur
      {{c:e}}         - couleur en fonction de l'ER du tank
      {{c:wn6}}       - couleur en fonction du classement WN6
      {{c:wn8}}       - couleur en fonction du classement WN8
      {{c:wn}}        - couleur en fonction du classement WN8
      {{c:xeff}}      - couleur en fonction de l'XVM Scale pour l'ER
      {{c:xwn}}       - couleur en fonction de l'XVM Scale pour le WN8
      {{c:rating}}    - couleur en fonction du GWR
      {{c:kb}}        - couleur en fonction du nombre de kilo-batailles
      {{c:avglvl}}    - couleur en fonction du tier moyen des tanks joués
      {{c:t-rating}}  - couleur en fonction du % de victoire du tank actuel
      {{c:t-battles}} - couleur en fonction du nombre de batailles du tank actuel

      Vous pouvez changer n'importe quelle macro de couleur en macro de transparence.
      Exemple : {{a:tdb}}

    Utilisation des macros traduites : {{l10n:localizationKey}}
      Les macros sont juste des liens vers des traductions présentes dans le 
      fichier res_mods/xvm/l10n/XX.xc (XX est le code de langue).
      Si la traduction n'est pas trouvée, "localizationKey" sera affiché.

      Exemple pour la barre de capture
        /l10n/en.xc
          "enemyBaseCaptured": "Base capturée par les alliés !"
        captureBar.xc
          "captureDoneFormat":    "<font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>"

        formaté : "<font size='17' color='#FFCC66'>Base capturée par les alliés !</font>"

      Plus d'infos sur les traductions dans le wiki : 
        https://code.google.com/p/wot-xvm/wiki/LocalizingXVM (en anglais)

  Exemple du champ "format" :
    1. Affiche le nombre de kilo-batailles, l'échelle WN6/7 et le % de victoires sans couleurs :
      "{{kb}} {{xwn}} {{rating}}"
    2. La même chose avec chaque valeur et sa couleur correspondante :
      "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating}}</font>"
    3. Encore la même chose, mais avec des colonnes alignées :
      "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>"
    4. Affiche le % de victoires colorisé par le xwn:
      "<font color='{{c:xwn}}'>{{rating}}</font>"

  Exemple d'utilisation des couleurs dynamiques et de la transparence :
    "color": "{{c:xwn}}" - couleur dépendant de la macro xwn
    "alpha": "{{a:hp}}" - transparence dépendant des PV actuels

  Icônes des clans et des joueurs.
  Le paramêtre de configuration battle/clanIconsFolder définit le chemin vers
  le dossier racine contenant les icônes.

  Toutes les icônes sont chargées automatiquement depuis le sous-dossier 
  correspondant à votre région du jeu (RU/EU/US/...).

  Pour ajouter votre icône de clan ou de joueur, copiez simplement votre image dans :
    \res_mods\xvm\res\clanicons\[REGION]\clan\ (pour un clan)
    \res_mods\xvm\res\clanicons\[REGION]\nick\ (pour un joueur)
  Par ailleurs, vous pouvez également créer des icônes par défaut :
    \res_mods\xvm\res\clanicons\[REGION]\clan\default.png (pour les clans)
    \res_mods\xvm\res\clanicons\[REGION]\nick\default.png (pour les joueurs)
  L'ordre de recherche est le suivant :
    nick/<player>.png -> clan/<clan>.png -> clan/default.png -> nick/default.png
  Les 150 meilleurs clans sont inclus dans l'archive du mod par défaut.
  Une archive avec TOUS les clans peut être téléchargée séparément :
    http://code.google.com/p/wot-xvm/downloads/list
    Fichiers : clanicons-full-ru-XXX.zip (RU), clanicons-full-eu-XXX.zip (EU), clanicons-full-na-XXX.zip (NA),
    clanicons-full-sea-XXX.zip (SEA), clanicons-full-kr-XXX.zip (KR), clanicons-full-vn-XXX.zip (VN)

  L'image Sixième Sens.
  Pour changer l'image de l'indicateur Sixième Sens, placez votre image PNG 
  alternative dans \res_mods\xvm\res\SixthSense.png.

  Journal des coups reçus.
  Des valeurs X ou Y négatives vous autorise à afficher le texte à droite ou en 
  bas de l'écran pour avoir le même affichage sur différentes résolutions d'écran.

  Horloge en bataille et sur l'écran de chargement.
  Format : Date PHP : http://php.net/date
  Par exemple:
      "clockFormat": "H:i"          => 01:23
      "clockFormat": "Y.m.d H:i:s"  => 2013.05.20 01:23:45

  Rangs d'efficacité pour {{teff}}, {{e}}.
    TEFF       E
    0..299     1 - très mauvais joueur
    300..499   2 - mauvais joueur
    500..699   3 - joueur médiocre
    700..899   4 - joueur en dessous de la moyenne
    900..1099  5 - joueur moyen
    1100..1299 6 - joueur au-dessus de la moyenne
    1300..1549 7 - bon joueur
    1550..1799 8 - excellent joueur
    1800..1999 9 - maître
    2000+      E - Expert (joueur présent dans le top-100 pour ce véhicule)
