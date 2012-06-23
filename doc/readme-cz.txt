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
    * Statistiku hráčů v průběhu bitvy (jen pro plnou verzi XVM- xvm-full package)
  
  Stránky projektu:  http://code.google.com/p/wot-xvm/
  Podpora:           http://forum.bulychev.net/viewforum.php?f=7
  FAQ (Russian):     http://www.koreanrandom.com/forum/topic/1381-faq-otveti-na-chastie-voprosi-po-xvm/
  Různá nastavení:   http://www.koreanrandom.com/forum/topic/1384-xvm-configurations/
  Online editor:     https://sites.google.com/site/sirmaxwiki/xvm-editor
  
  
-----------------------------------------------------------
2. Instalace
-----------------------------------------------------------

  1.  Hra musí být nainstalována na disku s NTFS souborovým systémem (výchozí Windows nastavení)
  
  2.  Pro běh aplikace je nutné mít nainstalovaný Microsoft .NET Framework 2.0
        Můžete si ověřit vaši verzi pomocí tohoto nástroje:
        http://www.tmgdevelopment.co.uk/versioncheck.htm
  
  3.  Nainstalujte Dokan knihovnu ze stránky http://dokan-dev.net/en/download/#dokan
  
  4.  Rozbalte archiv do složky s hrou:
        Kliknout pravým tlačítkem myši na soubor, zvolit možnost "Extrahovat vše..."
        -> najít adresář se hrou (výchozí C:\Games\World of Tanks) -> "Extrahovat"
       
  5.  Nemusíte nic nastavovat.
        Pokud chcete nějaké jiné, než výchozí nastavení, je nutné vytvořit soubor s nastavením:
        "\res_mods\[VERZE HRY]\gui\flash\XVM.xvmconf" v adresáři hry
        
        Můžete použít některé z připravených souborů s nastavením:
        "\xvm-doc\samples\" v adresáři hry
        
        Můžete použít online editor:
        https://sites.google.com/site/sirmaxwiki/xvm-editor
        
        Starší soubory s nastavením (OTMData.xml) jsou také podporovány,
        můžete je použít, pokud nechcete využít nových funkcí.
        
        Všechna možná nastavení můžete najít v tomto adresáři:
        "\xvm-doc\samples\Full config EN\XVM.xvmconf"
        
        !!!Poznámka!!!:
        ---------------
        Pokud budete ručně měnit soubor nastavení, použijte Poznámkový blok,
        NEPOUŽÍVEJTE Word, WordPad ani další (WYSIWYG) editory
        
  6.  Pokud nechcete používat statistiky, zapněte hru běžným způsobem.
      
      Pokud chcete používat statistiky, spusťte hru pomocí souboru "wot-xvm-proxy.exe"
      (hra se zapne automaticky). Mějte na paměti, že ve výchozím nastavení jsou
      statistiky zakázané, je nutné je povolit v souboru s nastavením.      
        
      Pokud chcete používat statistiky a spouštěč hry (WOTLauncher.exe), je nutné
      vytvořit zástupce na soubor "wot-xvm-proxy.exe" a spouštět ho s parametrem
      "/launcher" (vložit bez uvozovek na konec adresy v poli "Cíl:" ve vlastnostech zástupce)
      
  7.  Pokud používáte Skype, je nutné v něm vypnout alternativní porty 80 a 443.
      Nástroje -> Nastavení... -> Rozšířené -> Spojení
      -> Odškrtnout "Používat porty 80 a 443 jako alternativní pro příchozí spojení"
      
  8.  Pokud chcete poslat upozornění na chybu, spusťte soubor "wot-xvm-proxy.exe"
      s parametrem "/debug" (vložit bez uvozovek na konec adresy v poli "Cíl:"ve vlastnostech zástupce)
      
      
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
      
      
      V panelu hráčů:
        
        {{nick}}        - jméno hráče
        {{vehicle}}     - název vozidla
        
      
      V ikonách nad vozidly:
        
        {{hp}}          - aktuální počet životů
        {{hp-ratio}}    - aktuální počet životů v % (zobrazeno bez jednotky %)
        {{hp-max}}      - maximální počet životů
        {{nick}}        - jméno hráče
        {{vehicle}}     - název vozidla
        {{level}}       - úroveň (tier) vozidla
        {{dmg}}         - počet ubraných životů 
        {{dmg-ratio}}   - počet ubraných životů v % (zobrazeno bez jednotky %)
        
      
      Statistická makra:
      
        Musí být v souboru nastavení (XMV.xvmconf) povoleno "rating/showPlayersStatistics"
      
        {{rating}}      - celkový poměr výher
        {{eff}}         - efektivita hráče (http://wot-news.com/index.php/stat/calc/en/)
        {{kb}}          - celkový počet bitev v tisících
        {{battles}}     - celkový počet bitev 
        {{wins}}        - celkový počet výher
        {{rating:3}}    - poměr výher zaokrouhlený na 3 místa zleva 
        {{eff:4}}       - efektivita hráče zaokrouhlená na 4 místa zleva
        {{kb:3}}        - celkový počet bitev v tisících zaokrouhlený na 3 místa zleva
        {{t-kb}}        - počet bitev v tisících na daném vozidle
        {{t-battles}}   - celkový počet bitev na daném vozidle
        {{t-wins}}      - celkový počet výher na daném vozidle
        {{t-rating:3}}  - celkový poměr výher na daném vozidle zaokrouhlený na 3 místa zleva 
        {{t-kb:4}}      - celkový počet bitev v tisících na daném vozidle zaokrouhlený na 3 místa zleva
        {{t-battles:4}} - počet bitev na daném vozidle zaokrouhlený na 4 místa zleva
        {{t-kb-0}}      - počet bitev v tisících na daném vozidle s "0" na začátku
        {{t-hb}}        - počet bitev ve stovkách na daném vozidle
        {{t-hb:3}}      - počet bitev ve stovkách na daném vozidle zaokrouhlený na 3 místa zleva
      
      
      Makra pro dynamickou změnu barvy:
      
        {{c:hp}}        - barva závislá na aktuálním počtu životů (pouze v ikoně nad vozidlem)
        {{c:hp-ratio}}  - barva závislá na aktuálním počtu životů v % (pouze v ikoně nad vozidlem)
        {{c:eff}}       - barva závislá na efektivitě hráče
        {{c:rating}}    - barva závislá na celkovém poměru výher
        {{c:kb}}        - barva závislá na celkovém počtu bitev v tisicích
        {{c:t-rating}}  - barva závislá na poměru výher daného vozidla
        {{c:t-kb}}      - barva závislá na počtu bitev daného vozidla v tisicích
        {{c:t-battles}} - barva závislá na počtu bitev daného vozidla
        
      
      Makra pro dynamickou změnu průhlednosti:
        
        {{a:hp}}        - průhlednost závislá na aktuálním počtu životů (pouze v ikoně nad vozidlem)
        {{a:hp-ratio}}  - průhlednost závislá na aktuálním počtu životů v % (pouze v ikoně nad vozidlem)
        
      
  3.  Příklady:
      ---------
      
      a.  Zobrazení počtu bitev v tisících, efektivity hráče a celkového poměru
          výher bez změny barev
          "{{kb}} {{eff}} {{rating}}"
      
      b.  To samé co příklad a, ale s různou barvou textu podle hodnoty
          "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>"
          
      c.  To samé co příklad b., ale se zaokrouhlenými hodnotami
          "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:eff}}'>{{eff:4}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>"
          
      d.  Zobrazení celkového poměru výher s barvou textu závislou na efektivitě hráče:
          "<font color='{{c:eff}}'>{{rating}}</font>"
          
      
      Příklad použítí dynamické změny barvy a průhlednosti v souboru s nastavením XVM.xvmconf:
      
        "color": "{{c:eff}}" - barva závislá na efektivitě hráče
        "alpha": "{{a:hp}}" - průhlednost závislá na aktuálním počtu životů