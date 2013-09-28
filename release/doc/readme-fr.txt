Contenu :
  1. Présentation
  2. Installation
  3. Mise à jour
  4. Informations supplémentaires pour la configuration

-----------------------------------------------------------
1. PRESENTATION
-----------------------------------------------------------

  Ce mod propose de nombreuses fonctionnalités, comme :
    * Des marqueurs au dessus des tanks personnalisables
    * La possibilité de désactiver les panneaux postmortem
    * Le contrôle de l'orientation des icônes des tanks
    * La personnalisation complète des panneaux des joueurs (largeur, 
      transparence, contenu, ...)
    * Une horloge sur l'écran de chargement
    * Les icônes des clans en bataille
    * Des packs d'icônes différents en bataille, sur l'écran de chargement, etc.
    * Les statistiques des joueur en partie
    * Des informations additionnelles sur la barre de capture
    * La possibilité de personnaliser la minimap
    * L'affichage de statistiques supplémentaires en compagnie de chars ou dans 
      les rapports de service
    * Des infos sur les tanks dans la fenêtre de peloton
    * L'affichage des enemis détectés ou non dans le panneau sur le côté droit
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
    le fichier de configuration (par défaut \res_mods\xvm\configs\@default\@xvm.xc),
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
    Dans les panneaux des joueurs, l'écran de chargement quand vous faites TAB :
      {{nick}}        - player nickname with clan name
      {{name}}        - player nickname without clan name
      {{clan}}        - clan name with brackets (empty if no clan)
      {{clannb}}      - clan name without brackets
      {{vehicle}}     - vehicle name
      {{vehiclename}} - internal vehicle name (usa-M24_Chaffee)
      {{vtype}}       - vehicle type
      {{c:vtype}}     - color depended from vehicle type
      + statistics macros (see below)

    Dans les marqueurs au dessus des tanks :
      {{nick}}        - player nickname with clan name
      {{name}}        - player nickname without clan name
      {{clan}}        - clan name with brackets (empty if no clan)
      {{clannb}}      - clan name without brackets
      {{squad}}       - value '1' for own squad, empty for others
      {{vehicle}}     - vehicle name
      {{vehiclename}} - internal vehicle name (usa-M24_Chaffee)
      {{vtype}}       - vehicle type
      {{level}}       - vehicle level (Arabic numerals)
      {{rlevel}}      - vehicle level (Roman numerals)
      {{turret}}      - stock turret marker:
                          "*" symbol - stock turret, cannot mount top gun
                          "'" symbol - stock turret, top gun is possible
                          empty - top turret
      {{hp}}          - current health points
      {{hp-ratio}}    - current health ratio (without '%' sign)
      {{hp-max}}      - maximum health points
      {{dmg}}         - damage health points
      {{dmg-ratio}}   - damage health ratio (without '%' sign)
      {{dmg-kind}}    - damage kind (attack, fire, ramming, ...)
      {{c:hp}}        - color depended from current health points (only in vehicle markers)
      {{c:hp-ratio}}  - color depended from current health ratio (only in vehicle markers)
      {{c:dmg}}       - color depended from damage source
      {{c:dmg-kind}}  - color depended from damage kind
      {{c:vtype}}     - color depended from vehicle type
      {{c:system}}    - system color (disable override color)
      {{a:hp}}        - transparency depended from current health points (only in vehicle markers)
      {{a:hp-ratio}}  - transparency depended from current health ratio (only in vehicle markers)
      {{l10n:blownUp}}  - localizated text "Blown-up!", only in "blowupMessage"
      + statistics macros (see below)

    Dans le journal des coups reçus :
      {{n}}           - total number of hits
      {{n-player}}    - number of hits for each player
      {{dmg}}         - last hit value
      {{dmg-total}}   - total sum of hits
      {{dmg-avg}}     - average damage during the battle
      {{dmg-player}}  - sum of hits for each player
      {{dead}}        - tank's death marker
      {{nick}}        - player nickname with clan name
      {{name}}        - player nickname without clan name
      {{clan}}        - clan name with brackets (empty if no clan)
      {{clannb}}      - clan name without brackets
      {{vehicle}}     - vehicle name
      {{vehiclename}} - internal vehicle name (usa-M24_Chaffee)
      {{vtype}}       - vehicle type
      {{level}}       - vehicle level (Arabic numerals)
      {{rlevel}}      - vehicle level (Roman numerals)
      {{dmg-kind}}    - damage kind (attack, fire, ramming, ...)
      {{c:dmg-kind}}  - color depended from damage kind
      {{c:vtype}}     - color depended from vehicle type
      {{l10n:Hits}}   - localizated text "Hits"
      {{l10n:Total}}  - localizated text "Total"
      {{l10n:Last}}   - localizated text "Last"

    Dans 'PV restants' :
      {{nick}}        - player nickname with clan name
      {{name}}        - player nickname without clan name
      {{clan}}        - clan name with brackets (empty if no clan)
      {{clannb}}      - clan name without brackets
      {{vehicle}}     - vehicle name
      {{vehiclename}} - internal vehicle name (usa-M24_Chaffee)
      {{vtype}}       - vehicle type
      {{level}}       - vehicle level (Arabic numerals)
      {{rlevel}}      - vehicle level (Roman numerals)
      {{hp}}          - current health points
      {{hp-ratio}}    - current health ratio (without '%' sign)
      {{hp-max}}      - maximum health points
      {{c:vtype}}     - color depended from vehicle type
      {{c:hp}}        - color depended from current health points
      {{c:hp-ratio}}  - color depended from current health ratio
      {{l10n:hpLeftTitle}}  - localizated text "Hitpoints left:", only in "header"

    Dans la barre de capture :
      {{points}}      - points already capture
      {{extra}}       - extra text section; is shows only when timeleft and number of capturers was calculated successfully
      {{tanks}}       - number of capturers; cant define if more than 3; can be placed only inside extra section
      {{time}}        - time left to full capture; minutes and seconds;  can be placed only inside extra section
      {{time-sec}}    - time left to full capture; seconds only;         can be placed only inside extra section
      {{speed}}       - capture speed in points per second;              can be placed only inside extra section
      {{l10n:enemyBaseCapture}}     - localizated text "Base capture by allies!"
      {{l10n:enemyBaseCaptured}}    - localizated text "Base captured by allies!"
      {{l10n:allyBaseCapture}}      - localizated text "Base capture by enemies!"
      {{l10n:allyBaseCaptured}}     - localizated text "Base captured by enemies!"
      {{l10n:Timeleft}}             - localizated text "Timeleft"
      {{l10n:Capturers}}            - localizated text "Capturers"

    Dans la minimap :
      {{level}}        - subject level
      {{short-nick}}   - subject shortened nickname
      {{vehicle}}      - subject full vehicle type
      {{vehicle-type}}  - subject full vehicle type
      {{vehicle-class}} - places special symbol depending on subject vehicle class
      {{cellsize}}     - minimap cell side size
      {{vehicle-name}} - returns vehicle system name - usa-M24_Chaffee
      {{vehiclename}}  - returns vehicle system name - usa-M24_Chaffee
      {{vehicle-short}}  - shortened vehicle name

    Macros statistiques ('rating/showPlayersStatistics' doit être activé) :
      {{avglvl}}      - average level (tier) of tanks
      {{eff}}         - player efficiency: http://wot-news.com/index.php/stat/calc/en/
      {{eff:4}}       - player efficiency aligned from left to 4 chars
      {{teff}}, {{e}} - player per-vehicle efficiency: http://www.koreanrandom.com/forum/topic/1643-
      {{wn}}          - WN6 rating: http://www.koreanrandom.com/forum/topic/2575-
      {{xeff}}        - XVM Scale for efficiency (values 00-99, XX for Tops)
      {{xwn}}         - XVM Scale for WN6 (values 00-99, XX for Tops)
      {{rating}}      - GWR (Global Win Ratio)
      {{rating:3}}    - GWR aligned from left to 3 chars
      {{battles}}     - total battles count
      {{wins}}        - total wins count
      {{kb}}          - number of kilo-battles (total battles count divided by 1000).
      {{kb:3}}        - number of kilo-battles aligned from left to 3 chars
      {{t-rating}}    - vehicle win ratio
      {{t-rating:3}}  - vehicle win ratio aligned from left to 3 chars
      {{t-battles}}   - total battles count for current vehicle
      {{t-battles:4}} - number of battles for current vehicle aligned from left to 4 chars
      {{t-wins}}      - total wins count for current vehicle
      {{t-kb}}        - number of kilo-battles for current vehicle
      {{t-kb-0}}      - number of kilo-battles for current vehicle with leading zero
      {{t-kb:4}}      - number of kilo-battles for current vehicle aligned from left to 4 chars
      {{t-hb}}        - number of hecto-battles for current vehicle (hecto = 100)
      {{t-hb:3}}      - number of hecto-battles for current vehicle aligned from left to 3 chars
      {{tdb}}, {{tdb:4}} - average damage for current tank - damage/battles
      {{tdv}} - average damage efficiency for tank - damage/(battles*maxHP)
      {{tfb}} - average frags per battle for current tank
      {{tsb}} - average number of spotted enemies per battle for current tank
      {{c:tdb}}, {{c:tdv}}, {{c:tfb}}, {{c:tsb}} - dynamic colors for this macros
      {{c:eff}}       - color depended from player efficiency
      {{c:e}}         - color depended from player per-vehicle efficiency
      {{c:wn}}        - color depended from WN6 rating
      {{c:xeff}}      - color depended from XVM Scale for efficiency
      {{c:xwn}}       - color depended from XVM Scale for WN6
      {{c:rating}}    - color depended from GWR
      {{c:kb}}        - color depended from kilo-battles
      {{c:avglvl}}    - color depended from average level of tanks
      {{c:t-rating}}  - color depended from current vehicle win ratio
      {{c:t-battles}} - color depended from current vehicle battles
      Any color macro you can change to transparency macro ({{a: tdb}}).

    Utilisation des macros traduites : {{l10n:localizationKey}}
      Les macros sont juste des liens vers des traductions présentes dans le 
      fichier res_mods/xvm/l10n/XX.xc (XX est le code de langue).
      Si la traduction n'est pas trouvée, "localizationKey" sera affiché.

      Exemple pour la barre de capture
        /l10n/en.xc
          "enemyBaseCaptured": "Base capturée par les alliés !"
        captureBar.xc
          "captureDoneFormat":    "<font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>"

        formated: "<font size='17' color='#FFCC66'>Base capturée par les alliés !</font>"

      Plus d'infos sur les traductions dans le wiki : 
        https://code.google.com/p/wot-xvm/wiki/LocalizingXVM

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
  Une archive avec TOUS les clans peut être téléchargée séparemment :
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
    1100..1299 6 - joueur au dessus de la moyenne
    1300..1549 7 - bon joueur
    1550..1799 8 - excellent joueur
    1800..1999 9 - maître
    2000+      E - Expert (joueur présent dans le top-100 pour ce véhicule)
