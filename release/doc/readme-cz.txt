Obsah:
  1. Základní informace
  2. Instalace
  3. Aktualizace
  4. Informace o rozšířeném nastavení


-----------------------------------------------------------
1. Základní informace
-----------------------------------------------------------

  Tento mód má množství funkcí, jako např.:
    * Značky vozidel (dřívější OverTargetMarkers)
    * Deaktivace módu „postmortem"- mód zašednutí obrazu apod. po zničení vozidla
    * Nastavení zrcadlení ikon vozidel
    * Nastavení seznamu hráčů (šířka, průhlednost, obsah)
    * Hodiny na obrazovce při načítání bitvy
    * Ikona hráčů/klanů
    * Nastavení ikon vozidel
    * Statistika hráčů v průběhu bitvy (jen pro plnou verzi XVM módu- xvm-stat package)
    * Stav obsazování základy - podrobnější informace
    * Přizpůsobitelná minimapa
    * Rozšířené statistiky v okně Rot a Služebním záznamu
    * Informace o tanku v okně Čety
    * Stav nasvětlení nepřátelských vozidel v pravém postranním panelu
    * Automatické osazení posádky
    * Ping na servery na přihlašovací obrazovce, v hangáru a před bitvou


  Stránky projektu:             http://www.modxvm.com/
  
  Podpora (EN):                 http://www.koreanrandom.com/forum/topic/1383-xvm
  Nejčastější dotazy (EN):      http://www.modxvm.com/en/faq/
  Různá již připravená nastavení (RU): http://www.koreanrandom.com/forum/forum/50-custom-configurations
  Online editor (EN):           http://www.koreanrandom.com/forum/topic/1422-/#entry11316


-----------------------------------------------------------
2. Instalace
-----------------------------------------------------------

  1.  Rozbalte archiv do složky s hrou:
    Kliknout pravým tlačítkem myši na soubor, zvolit možnost "Extrahovat vše..."
    -> najít adresář se hrou (výchozí C:\Games\World of Tanks) -> "Extrahovat".

  2.  Nemusíte nic nastavovat.
    Pokud chcete nějaké jiné, než výchozí nastavení, musíte přejmenovat výchozí soubor s nastavením
    "\res_mods\xvm\xvm.xc.sample" na "xvm.xc" v adresáři hry.

    Můžete použít online editor:
      http://www.koreanrandom.com/forum/topic/1422-/#entry11316

    Všechna možná nastavení můžete najít v souborech ve složce:
      "\res_mods\xvm\configs\@Default\"

    !!! Varování !!!:
    ---------------
    Pokud budete ručně měnit soubor nastavení, použijte Poznámkový blok,
    NEPOUŽÍVEJTE Word, WordPad ani další podobné editory.


-----------------------------------------------------------
3. Aktualizace
-----------------------------------------------------------

  1.  Rozbalte archiv do složky s hrou:
    Kliknout pravým tlačítkem myši na soubor, zvolit možnost "Extrahovat vše..."
      -> najít adresář se hrou (výchozí C:\Games\World of Tanks) -> "Extrahovat"

  2.  NEDĚLEJTE nic dalšího.


-----------------------------------------------------------
4. Informace o rozšířeném nastavení
-----------------------------------------------------------

  Soubory s nastavením:
    "\res_mods\xvm\configs\@Default\"
    
  Můžete použít některé z připravených souborů s nastavením ze složky:
    "\res_mods\xvm\configs\user configs\"
    
  Můžete si vytvořit vlastní nastavení v online editoru:
    http://www.koreanrandom.com/forum/topic/1422-/#entry11316

  Všechny možnosti nastavení můžete vidět ve složce:
    "\res_mods\xvm\configs\@Default\"

  Podporované HTML tagy:
    http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText


  Dostupná makra:

    V panelu hráčů, obrazovce během načítání bitvy a statistice:
      {{nick}}        - jméno hráče s tagem klanu
      {{name}}        - jméno hráče bez tagu klanu
      {{clan}}        - název klanu s tagem (prázdné, pokud není)
      {{clannb}}      - název klanu bez tagu
      {{vehicle}}     - název vozidla
      {{vehiclename}} - interní název vozidla (usa-M24_Chaffee)
      {{vtype}}       - typ vozidla
      {{c:vtype}}     - barva závislá na typu vozidla
      + makra statistik (více informací níže)


    V ikonách nad vozidly:
      {{nick}}        - jméno hráče s tagem klanu
      {{name}}        - jméno hráče bez tagu klanu
      {{clan}}        - název klanu s tagem (prázdné, pokud není)
      {{clannb}}      - název klanu bez tagu
      {{squad}}       - hodnota '1' pro vlastní četu, prázdné pro ostatní
      {{vehicle}}     - název vozidla
      {{vehiclename}} - interní název vozidla (usa-M24_Chaffee)
      {{vtype}}       - typ vozidla
      {{level}}       - úroveň (tier) vozidla (arabskými číslicemi)
      {{rlevel}}      - úroveň (tier) vozidla (římskými číslicemi)
      {{turret}}      - ikona základní věže:
                        "*" symbol - základní věž, nemůže mít namontovanou nejlepší zbraň
                        "'" symbol - základní věž, může mít namontovanou nejlepší zbraň
                        prázdné - vozidlo má nejlepší věž
      {{hp}}          - aktuální počet životů
      {{hp-ratio}}    - aktuální počet životů v % (zobrazeno bez '%')
      {{hp-max}}      - maximální počet životů
      {{dmg}}         - počet ubraných životů
      {{dmg-ratio}}   - počet ubraných životů v % (zobrazeno bez '%')
      {{dmg-kind}}    - typ poškození (útok, oheň, náraz, ...)
      {{c:hp}}        - barva závislá na aktuálním počtu životů (pouze v ikoně nad vozidlem)
      {{c:hp-ratio}}  - barva závislá na poměru aktuálního počtu životů k celkovému počtu životů- v % (pouze v ikoně nad vozidlem)
      {{c:dmg-kind}}  - barva závislá na typu poškození
      {{c:vtype}}	- barva závislá na typu vozidla (pouze v ikoně nad vozidlem)
      {{c:system}}    - systémová barva (zakáže změnu barvy)
      {{a:hp}}        - průhlednost závislá na aktuálním počtu životů (pouze v ikonách tanků)
      {{a:hp-ratio}}  - průhlednost závislá na poměru počtu aktuálního počtu životů k celkovému počtu životů (pouze v ikonách tanků)
      + makra statistik (více informací níže)

    Záznam zásahů:
      {{n}}           - celkový počet zásahů
      {{n-player}}    - počet zásahů pro každého hráče
      {{dmg}}         - velikost posledního zásahu
      {{dmg-total}}   - součet všech zásahů
      {{dmg-avg}}     - průměrné poškození za bitvu
      {{dmg-player}}  - součet všech zásahů pro každého hráče
      {{dead}}        - značka zničeného vozidla
      {{nick}}        - jméno hráče s tagu klanu
      {{name}}        - jméno hráče bez tagu klanu
      {{clan}}        - název klanu s tagem (prázdné, pokud není)
      {{clannb}}      - název klanu bez tagu
      {{vehicle}}     - název vozidla
      {{vehiclename}} - interní název vozidla (usa-M24_Chaffee)
      {{vtype}}       - typ vozidla
      {{level}}       - úroveň (tier) vozidla (arabskými číslicemi)
      {{rlevel}}      - úroveň (tier) vozidla (římskými číslicemi)
      {{dmg-kind}}    - typ poškození (útok, oheň, náraz, ...)
      {{c:dmg-kind}}  - barva závislá na typu poškození
      {{c:vtype}}     - barva závislá na typu vozidla (pouze v ikoně nad vozidlem)

    Panel obsazování základny:
      {{points}}      - obsazené body
      {{extra}}       - zvláštní sekce; zobrazuje se tehdy, pokud byl spočítán zbývající čas a počet obsazujících
      {{tanks}}       - počet obsazujících; nelze určit více jak 3;	 může být použito pouze v sekci extra
      {{time}}        - zbývající čas do obsazení; minuty a sekundy;     může být použito pouze v sekci extra
      {{time-sec}}    - zbývající čas do obsazení; v sekundách;          může být použito pouze v sekci extra
      {{speed}}       - rychlost obsazování v bodech za sekundu;         může být použito pouze v sekci extra

    Minimapa:
      {{level}}         - úroveň (tier) vozidla
      {{short-nick}}    - zkrácené jméno hráče
      {{vehicle}}       - název vozidla
      {{vehicle-type}}  - název vozidla
      {{vehicle-class}} - umístí zvláštní symbol podle typu vozidla
      {{cellsize}}      - délka strany buňky (např. A1) na minimapě 
      {{vehicle-name}}  - vrátí systémoví název vozidla - usa-M24_Chaffee
      {{vehiclename}}   - vrátí systémoví název vozidla - usa-M24_Chaffee
    
    Statistická makra:
      V souboru s nastavení (\res_mods\xvm\configs\@Default\rating.xc) musí být povoleno "rating/showPlayersStatistics".
    
      {{avglvl}}      - průměrná úroveň (tier) vozidel
      {{eff}}         - efektivita hráče: http://wot-news.com/index.php/stat/calc/en/
      {{eff:4}}       - efektivita hráče, zaokrouhlená na 4 místa zleva
      {{teff}}, {{e}} - efektivita hráče, dle vozidel: http://www.koreanrandom.com/forum/topic/1643-
      {{twr}}         - TWR (T-Calc): http://www.koreanrandom.com/forum/topic/2389-
      {{wn}}          - WN6 hodnocení: http://www.koreanrandom.com/forum/topic/2575-
      {{xeff}}        - XVM rozsah pro efektivitu (hodnoty 00-99, XX pro nejlepší)
      {{xwn}}         - XVM rozsah pro WN6 (hodnoty 00-99, XX pro nejlepší)
      {{rating}}      - celkový poměr výher k celkovému počtu bitev
      {{rating:3}}    - celkový poměr výher k celkovému počtu bitev, zaokrouhlený na 3 místa zleva
      {{battles}}     - celkový počet bitev
      {{wins}}        - celkový počet výher
      {{kb}}          - celkový počet bitev v tisících
      {{kb:3}}        - celkový počet bitev v tisících zaokrouhlený na 3 místa zleva
      {{t-rating}     - poměr výher na daném vozidle k celkovému počtu bitev s daným vozidlem
      {{t-rating:3}}  - poměr výher na daném vozidle k celkovému počtu bitev s daným vozidlem, zaokrouhlený na 3 místa zleva
      {{t-battles}}   - počet bitev na daném vozidle
      {{t-battles:4}} - počet bitev na daném vozidle, zaokrouhlený na 4 místa zleva
      {{t-wins}}      - počet výher na daném vozidle
      {{t-kb}}        - počet bitev v tisících na daném vozidle
      {{t-kb-0}}      - počet bitev v tisících na daném vozidle, s nulou na začátku
      {{t-kb:4}}      - počet bitev v tisících na daném vozidle, zaokrouhlený na 4 místa zleva
      {{t-hb}}        - počet bitev ve stovkách na daném vozidle
      {{t-hb:3}}      - počet bitev ve stovkách na daném vozidle, zaokrouhlený na 3 místa zleva
      {{tdb}}, {{tdb:4}} - průměrné poškození způsobené daným vozidlem - poškození/bitev
      {{tdv}}         - průměrný potenciál škod na daném vozidle - poškození/(bitev * max. HP vozidla)
      {{tfb}}         - průměrný počet zničených nepřátel na bitvu s daným vozidlem
      {{tsb}}         - průměrný počet nasvícených nepřátel na bitvu s daným vozidlem
      {{c:tdb}}, {{c:tdv}}, {{c:tfb}}, {{c:tsb}} - dynamické barvy pro makra
      {{c:eff}}       - barva závislá na efektivitě hráče
      {{c:e}}         - barva závislá na efektivitě hráče, dle vozidel
      {{c:twr}}       - barva závislá na TWR (T-Calc)
      {{c:wn}}        - barva závislá na WN6 hodnocení
      {{c:xeff}}      - barva závislá na XVM rozsah pro efektivitu
      {{c:xwn}}       - barva závislá na XVM rozsah pro WN6
      {{c:rating}}    - barva závislá na poměru celkového počtu výher k celkovému počtu bitev
      {{c:kb}}        - barva závislá na celkovém počtu bitev v tisících
      {{c:t-rating}}  - barva závislá na poměru výher daného vozidla
      {{c:t-battles}} - barva závislá na počtu bitev daného vozidla
      Jakékoli barevné makro můžete změnit na makro průhlednosti (př. {{a: tdb}} ).

  Příklady:

    a.  Zobrazení počtu bitev v tisících, efektivity hráče a celkového poměru výher bez změny barev:
        "{{kb}} {{xvm}} {{rating}}"

    b.  To samé co příklad 'a', ale s různou barvou textu podle hodnoty:
        "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating}}</font>"

    c.  To samé co příklad 'b', ale se zaokrouhlenými hodnotami:
        "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>"

    d.  Zobrazení poměru celkového počtu výher k celkovému počtu bitev s barvou textu závislou na xwn:
        "<font color='{{c:xwn}}'>{{rating}}</font>"

    Příklad použití dynamické změny barvy a průhlednosti:
        "color": "{{c:xwn}}" - barva závislá na xwn
        "alpha": "{{a:hp}}" - průhlednost závislá na aktuálním počtu životů

    Ikony hráčů a klanů:

      V nastavení je nutné v parametru "battle/clanIconsFolder" nastavit cestu do kořenového adresáře s ikonami klanů.

      Všechny ikony se automaticky načtou ze složky příslušného regionu (RU/EN/US...).

      Pro zobrazení své vlastní ikony ve hře stačí vložit vlastní ikonu do příslušné složky:
        \res_mods\xvm\res\clanicons\[REGION]\clan\ (pro klanovou ikonu) 
          
        \res_mods\xvm\res\clanicons\[REGION]\nick\ (pro ikonu hráče)

      Můžete vytvořit výchozí ikonu klanu/hráče:
        \res_mods\xvm\res\clanicons\[REGION]\clan\default.png (výchozí ikona klanů)
        \res_mods\xvm\res\clanicons\[REGION]\nick\default.png (výchozí ikona hráčů)

      Ikony se přiřazují dle následujících priorit:
        přezdívka -> klan -> výchozí ikona klanů -> výchozí ikonu hráčů
        (nick/<player>.png -> clan/<clan>.png -> clan/default.png -> nick/default.png)

      Ikony nejlepších 150 klanů jsou součástí balíčku.

      Archivy se všemi ikonami klanů je možné stáhnout zvlášť:
        http://code.google.com/p/wot-xvm/downloads/list
        Soubory: clanicons-full-ru-XXX.zip (RU), clanicons-full-eu-XXX.zip (EU),
          clanicons-full-us-XXX.zip (US), clanicons-full-sea-XXX.zip (SEA)

  Obrázek šestého smyslu:
    Chcete-li změnit ikonu šestého smyslu, uložte svůj obrázek takto:
      \res_mods\xvm\res\SixthSense.png

  Hit Log.
    Záporné hodnoty x, y umístí text k pravé dolní hranici
    
  Hodiny v bitvě a při načítání bitvy.
    Formát: Y:rok, M:měsích, D:den, H:hodina, N:minuta, S:sekunda. "" - odstraní hodiny.
    Příklady:
      "clockFormat": "H:N"          => 01:23
      "clockFormat": "Y.M.D H:N:S"  => 2013.05.20 01:23:45
    Je možné použít HTML pro hodiny v bitvě.

  Rozsahy pro efektivitu {{teff}}, {{e}}.
    TEFF       E
    0..299     1 - velmi špatný
    300..499   2 - špatný
    500..699   3 - slabý
    700..899   4 - podprůměrný
    900..1099  5 - průměrný
    1100..1299 6 - nadprůměrný
    1300..1549 7 - dobrý
    1550..1799 8 - výborný
    1800..1999 9 - mistr
    2000+      E - Expert (top-100 hráčů na tomto vozidle)

Přeložil: Shortik (vapokrleo@seznam.cz) a Assassik