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
      http://nightly.modxvm.com/ (en anglais)

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

  Balises HTML supportées :
    http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText (en anglais)

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
