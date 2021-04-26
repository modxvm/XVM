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

  Stránky projektu:                    https://modxvm.com/

  Podpora (EN):                        https://koreanrandom.com/forum/topic/1383-xvm
  Nejčastější dotazy (EN):             https://modxvm.com/en/faq/
  Různá již připravená nastavení (RU): https://koreanrandom.com/forum/forum/50-/


-----------------------------------------------------------
2. Instalace
-----------------------------------------------------------

  1. Rozbalte archiv do složky s hrou:
    Kliknout pravým tlačítkem myši na soubor, zvolit možnost "Extrahovat vše..."
    -> najít adresář se hrou (výchozí C:\Games\World of Tanks) -> "Extrahovat".

  2. Nemusíte nic nastavovat.
    Pokud chcete nějaké jiné, než výchozí nastavení, musíte přejmenovat výchozí soubor s nastavením
    "\res_mods\configs\xvm\xvm.xc.sample" na "xvm.xc" v adresáři hry.

    Všechna možná nastavení můžete najít v souborech ve složce:
      "\res_mods\configs\xvm\default\"

    !!! Varování !!!:
    ---------------
    Pokud budete ručně měnit soubor nastavení, použijte Poznámkový blok,
    NEPOUŽÍVEJTE Word, WordPad ani další podobné editory.

  3. Pokud XVM nerozpozná jazyk vašeho herního klienta,
    můžete pomocí konfiguračního souboru (by default \res_mods\configs\xvm\default\@xvm.xc),
    změnit hodnotu "language" z "auto" na jazykový kód.
    Jazykový kód se musí shodovat s názvem souboru ve složce res_mods\mods\shared_resources\xvm\l10n\ (for example, "en").

  4. Je tu možnost používání "nočních" verzí XVM.
    Tyto verze jsou vytvořeny automaticky z aktuálního zdrojového kódu, nemusí být testovány a mohou obsahovat chyby!
    Stahovat je můžete ze stránek https://nightly.modxvm.com/

-----------------------------------------------------------
3. Aktualizace
-----------------------------------------------------------

  1. Rozbalte archiv do složky s hrou:
    Kliknout pravým tlačítkem myši na soubor, zvolit možnost "Extrahovat vše..."
      -> najít adresář se hrou (výchozí C:\Games\World of Tanks) -> "Extrahovat"

  2. NEDĚLEJTE nic dalšího.

-----------------------------------------------------------
4. Informace o rozšířeném nastavení
-----------------------------------------------------------

  Soubory s nastavením:
    "\res_mods\configs\xvm\default\"

  Můžete použít některé z připravených souborů s nastavením ze složky:
    "\res_mods\configs\xvm\user configs\"

  Všechny možnosti nastavení můžete vidět ve složce:
    "\res_mods\configs\xvm\default\"

  Podporované HTML tagy:
    https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText

  Obrázek šestého smyslu:
    Chcete-li změnit ikonu šestého smyslu, uložte svůj obrázek takto:
      \res_mods\mods\shared_resources\xvm\res\SixthSense.png

  Hit Log.
    Záporné hodnoty x, y umístí text k pravé dolní hranici

  Hodiny v bitvě a při načítání bitvy.
    Formát: PHP Date: http://php.net/date
    Příklady:
      "clockFormat": "H:i"          => 01:23
      "clockFormat": "Y.m.d H:i:s"  => 2013.05.20 01:23:45

Přeložil: Shortik (vapokrleo@seznam.cz) a Assassik
