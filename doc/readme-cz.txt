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
    * Statistika hráčů v průběhu bitvy (jen pro plnou verzi XVM módu- xvm-full package)

  Stránky projektu:  			http://code.google.com/p/wot-xvm/
  Podpora:           			http://forum.bulychev.net/viewforum.php?f=7
  Nejčastější dotazy (Rusky):		http://www.koreanrandom.com/forum/topic/1381-faq-otveti-na-chastie-voprosi-po-xvm/
  Různá již připravená nastavení:  	http://www.koreanrandom.com/forum/topic/1384-xvm-configurations/
  Online editor:     			https://sites.google.com/site/sirmaxwiki/xvm-editor


-----------------------------------------------------------
2. Instalace
-----------------------------------------------------------

  1.  Hra musí být nainstalována na disku s NTFS souborovým systémem (výchozí Windows nastavení).

  2.  Pro běh aplikace je nutné mít nainstalovaný Microsoft .NET Framework 2.0
        Verzi Vašeho .NET Frameworku si můžete ověřit pomocí aplikace z odkazu níže:
        http://www.tmgdevelopment.co.uk/versioncheck.htm

  3.  Nainstalujte Dokan knihovnu ze stránky http://dokan-dev.net/en/download/#dokan

  4.  Rozbalte archiv do složky s hrou:
        Kliknout pravým tlačítkem myši na soubor, zvolit možnost "Extrahovat vše..."
        -> najít adresář se hrou (výchozí C:\Games\World of Tanks) -> "Extrahovat".

  5.  Nemusíte nic nastavovat.
        Pokud chcete nějaké jiné, než výchozí nastavení, je nutné vytvořit soubor s nastavením:
        "\res_mods\[VERZE HRY]\gui\flash\XVM.xvmconf" v adresáři hry.

        Můžete použít některé z připravených souborů s nastavením ve složce "\xvm-doc\samples\" v adresáři hry.

        Můžete použít online editor:
        http://www.koreanrandom.com/forum/topic/1422-/#entry11316

        Starší soubory s nastavením (OTMData.xml) jsou také podporovány,
        můžete je použít, pokud nechcete využít nových funkcí.

        Všechna možná nastavení můžete najít v tomto souboru:
        "\xvm-doc\samples\Full config EN\XVM.xvmconf"

        !!!Poznámka!!!:
        ---------------
        Pokud budete ručně měnit soubor nastavení, použijte Poznámkový blok,
        NEPOUŽÍVEJTE Word, WordPad ani další podobné editory.

  6.  Pokud nechcete používat statistiky, zapněte hru běžným způsobem.

      Pokud chcete používat statistiky, spusťte hru pomocí souboru "wot-xvm-proxy.exe"
      (hra se zapne automaticky). Mějte na paměti, že ve výchozím nastavení jsou
      statistiky zakazane, je nutne je povolit v souboru s nastavenim.

      Pokud chcete používat statistiky a zároveň spouštěč hry (WOTLauncher.exe), je nutné
      vytvořit zástupce na soubor "wot-xvm-proxy.exe" a spouštět ho s parametrem
      "/launcher" (vložit bez uvozovek na konec adresy v poli "Cíl:" ve vlastnostech zástupce).

  7.  Pokud používáte Skype, je nutné v něm vypnout alternativní porty 80 a 443.
      Nástroje -> Nastavení... -> Rozšířené -> Spojení
      -> Odškrtnout "Používat porty 80 a 443 jako alternativní pro příchozí spojení".

  8.  Pokud chcete poslat upozornění na chybu, spusťte soubor "wot-xvm-proxy.exe"
      s parametrem "/debug" (vložit bez uvozovek na konec adresy v poli "Cíl:"ve vlastnostech zástupce).


-----------------------------------------------------------
3. Aktualizace
-----------------------------------------------------------

  1.  Rozbalte archiv do složky s hrou:
      Kliknout pravým tlačítkem myši na soubor, zvolit možnost "Extrahovat vše..."
        -> najít adresář se hrou (výchozí C:\Games\World of Tanks) -> "Extrahovat"

  2.  Pokud došlo k aktualizaci hry, přeneste Váš soubor s nastavením "XVM.xvmconf"
      Ze složky "res_mods/[STARÁ VERZE]/gui/flash/"
      Do složky "res_mods/[NOVÁ VERZE]/gui/flash/"

  3.  NEDĚLEJTE nic dalšího.


-----------------------------------------------------------
4. Informace o rozšířeném nastavení
-----------------------------------------------------------

  1.  Složka souboru s nastavením:
        "\res_mods\[GAME VERSION]\gui\flash\XVM.xvmconf"

      Můžete použít některé z připravených souborů s nastavením:
        "\xvm-doc\samples\" v adresáři hry

      Můžete si vytvořit vlastní nastavení v online editoru:
        https://sites.google.com/site/sirmaxwiki/xvm-editor

      Všechny možnosti nastavení můžete vidět v tomto souboru:
        "\xvm-doc\samples\Full config EN\XVM.xvmconf"


  2.  Dostupná makra:
      ---------------


      V panelu hráčů, obrazovce během načítání bitvy a statistice:

        {{nick}}        - jméno hráče
        {{vehicle}}     - název vozidla


      V ikonách nad vozidly:

        {{hp}}          - aktuální počet životů
        {{hp-ratio}}    - aktuální počet životů v % (zobrazeno bez '%')
        {{hp-max}}      - maximální počet životů
        {{nick}}        - jméno hráče
        {{vehicle}}     - název vozidla
        {{level}}       - úroveň (tier) vozidla (arabskými číslicemi)
        {{rlevel}}      - úroveň (tier) vozidla (římskými číslicemi)
        {{dmg}}         - pocet ubraných zivotu
        {{dmg-ratio}}   - počet ubraných životů v % (zobrazeno bez '%')
      	{{turret}}	    - ikona základní věže- symbol '*' znamená, že tank nemůže mít nejlepší dělo, symbol '-' znamená, že tank může mít namontované nejlepší dělo


      Statistická makra:

        V souboru nastavení (XMV.xvmconf) musí být povoleno "rating/showPlayersStatistics".

        {{rating}}      - celkový poměr výher k celkovému počtu bitev
        {{eff}}         - efektivita hráče (http://wot-news.com/index.php/stat/calc/en/)
        {{kb}}          - celkový počet bitev v tisících
        {{battles}}     - celkovy pocet bitev
        {{wins}}        - celkový počet výher
        {{rating:3}}    - celkový poměr výher k celkovému počtu bitev zaokrouhlený na 3 místa zleva
        {{eff:4}}       - efektivita hráče zaokrouhlená na 4 místa zleva
        {{kb:3}}        - celkový počet bitev v tisících zaokrouhlený na 3 místa zleva
	      {{t-rating}}	  - poměr výher na daném vozidle k celkovému počtu bitev s daným vozidlem
        {{t-kb}}        - počet bitev v tisících na daném vozidle
        {{t-battles}}   - celkový počet bitev na daném vozidle
        {{t-wins}}      - celkový počet výher na daném vozidle
        {{t-rating:3}}  - poměr výher na daném vozidle k celkovému počtu bitev s daným vozidlem zaokrouhlený na 3 místa zleva
        {{t-kb:4}}      - celkový počet bitev v tisících na daném vozidle zaokrouhlený na 4 místa zleva
        {{t-battles:4}} - počet bitev na daném vozidle zaokrouhlený na 4 místa zleva
        {{t-kb-0}}      - počet bitev v tisících na daném vozidle s "0" na začátku
        {{t-hb}}        - počet bitev ve stovkách na daném vozidle
        {{t-hb:3}}      - počet bitev ve stovkách na daném vozidle zaokrouhlený na 3 místa zleva


      Makra pro dynamickou změnu barvy:

        {{c:hp}}        - barva závislá na aktuálním počtu životů (pouze v ikoně nad vozidlem)
        {{c:hp-ratio}}  - barva závislá na poměru aktuálního počtu životů k celkovému počtu životů- v % (pouze v ikoně nad vozidlem)
	{{c:vtype}}	- barva závislá na typu vozidla (pouze v ikoně nad vozidlem)
        {{c:eff}}       - barva závislá na efektivitě hráče
        {{c:rating}}    - barva závislá na poměru celkového počtu výher k celkovému počtu bitev
        {{c:kb}}        - barva závislá na celkovém počtu bitev v tisicích
        {{c:t-rating}}  - barva závislá na poměru výher daného vozidla
        {{c:t-battles}} - barva závislá na počtu bitev daného vozidla


      Makra pro dynamickou změnu průhlednosti:

        {{a:hp}}        - průhlednost závislá na aktuálním počtu životů (pouze v ikoně nad vozidlem)
        {{a:hp-ratio}}  - průhlednost závislá na poměru aktuálního počtu životů k celkovému počtu životů- v % (pouze v ikoně nad vozidlem)


  3.  Příklady:
      ---------

      a.  Zobrazení počtu bitev v tisících, efektivity hráče a celkového poměru výher bez změny barev:
          "{{kb}} {{eff}} {{rating}}"

      b.  To samé co příklad 'a', ale s různou barvou textu podle hodnoty:
          "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>"

      c.  To samé co příklad 'b', ale se zaokrouhlenými hodnotami:
          "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:eff}}'>{{eff:4}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>"

      d.  Zobrazení poměru celkového počtu výher k celkovému počtu bitev s barvou textu závislou na efektivitě hráče:
          "<font color='{{c:eff}}'>{{rating}}</font>"


      Příklad použítí dynamické změny barvy a průhlednosti v souboru s nastavením "XVM.xvmconf":

        "color": "{{c:eff}}" - barva závislá na efektivitě hráče
        "alpha": "{{a:hp}}" - průhlednost závislá na aktuálním počtu životů
        
      
      Ikony hráčů a klanů:
      
        V nastavení je nutné v parametru "battle/clanIconsFolder" nastavit cestu do kořenového adresáře s ikonami klanů.
        
        Všechny ikony se automaticky načtou ze složky příslušného regionu (RU/EN/US...).
        
        Pro zobrazení své vlastní ikony ve hře stačí vložit vlastní ikonu do příslušné složky:
          "clanicons/[REGION]/clan/" pro klanovou ikonu nebo "clanicons/[REGION]/nick/" pro ikonu hráče
        
        Můžete vytvořit výchozí ikonu klanu/hráče:
          "clanicons/[REGION]/clan/default.png" (výchozí ikona klanů)
          "clanicons/[REGION]/nick/default.png" (výchozí ikona hráčů)
        
        Ikony se přiřazují dle následujících priorit:
          přezdívka -> klan -> výchozí ikona klanů -> výchozí ikonu hráčů
          (nick/<player>.png -> clan/<clan>.png -> clan/default.png -> nick/default.png)
          
        Ikony nejlepších 100 klanů jsou součástí balíčku.
        
        Archivy se všemi ikonami klanů je možné stáhnout zvlášť:
          Ruský server:     http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-ru.zip
          Evropský server:  http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-eu.zip
          Americký server:  http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-us.zip
          
          
Přeložil: Shortik
Kontakt:  vapokrleo@seznam.cz