// Plik readme dla XVM, tłumaczenie na język polski - Nikodemsky


Zawartość:
  1. Informacje ogólne
  2. Instalacja
  3. Aktualizacja
  4. Dodatkowe informacje o pliku konfiguracyjnym

-----------------------------------------------------------
1. INFORMACJE OGÓLNE
-----------------------------------------------------------

  Modyfikacja posiada wiele funkcji, takich jak:
    * Edytowalne znaczniki pojazdów
    * Wyłączenie panelu pośmiertnego
    * Kontrola odbicia ikon pojazdów
    * Kontrola panelu gracza (szerokość, przezroczystość, zawartość)
    * Zegar w czasie ładowania bitwy
    * Ikony dla graczów i klanów
    * Różne zestawy ikon dla różnych paneli.
    * Statystyki graczy (tylko i wyłącznie z xvm-stat)
    * Szczegółowe informacje w panelu przejmowania bazy
    * Edytowalna minimapka
    * Wyświetlanie rozszerzonych informacji w panelu plutonu/kompanii
    * Pokazywanie informacji o pojeździe w panelu plutonu
    * Informacje o odkrytych wrogach(jako rozszerzenie do hitloga)
    * Autoładowanie załogi
    * Wyświetlanie pinga w garażu i przy logowaniu
    * Własna ikona szóstego zmysłu(+ opcjonalnie dźwięk)
    * Karuzela dla listy pojazdów

  Strona projektu:  http://www.modxvm.com/

  Wsparcie(EN):      http://www.koreanrandom.com/forum/forum/57-xvm-english-support-and-discussions/
  Wsparcie(PL):      http://forum.worldoftanks.eu/index.php?/topic/114684-pomoc-xvm-mod-temat-zbiorczy/
  FAQ:               http://www.modxvm.com/en/faq/
  Konfiguracje:      http://www.koreanrandom.com/forum/forum/50-custom-configurations

-----------------------------------------------------------
2. INSTALACJA
-----------------------------------------------------------

  1. Wypakuj paczkę do głównego katalogu gry:
     Prawy klik na paczkę -> "Wypakuj wszystko..." -> wybierz folder gry -> "Wypakuj"

  2. Standardowo nie musisz niczego zmieniać.

    Jeśli chcesz używać innej konfiguracji, to musisz zmienić nazwę w pliku startowym:
      \res_mods\xvm\xvm.xc.sample do xvm.xc
    Instrukcje znajdują sie w środku pliku.

    Wszystkie możliwe opcje konfiguracji możesz znaleźć w:
      \res_mods\xvm\configs\@Default\
    lub możesz użyć edytora: http://www.koreanrandom.com/forum/topic/1422-/#entry11316

    WAŻNE: Jeśli konfigurujesz manualnie, używaj programów typu notatnik(czy innego edytora, który nie modyfikuje kodowania pliku - przykładowo notepad++), NIGDY nie używaj edytorów typu Word/Wordpad.

  3. Jeśli XVM nie wykrywa prawidłowo języka gry,
   to w pliku konfiguracji (standardowo\res_mods\xvm\configs\@default\@xvm.xc)
    zmień wartość "language" z "auto" na kod języka(np. pl).

  4. Jest też możliwość instalacji tzw. "Nightly builds"(wersje testowe).
    Możesz je pobrać na http://nightly.modxvm.com/
    
    *** UWAGA! Statystyki oraz szanse na wygraną należy włączyć na stronie XVM:
    a) Klikamy na "Sign UP",
    b) Wybieramy "Activate Statistics",
    c) W "Settings" wybieramy odpowiednie opcje.

-----------------------------------------------------------
3. AKTUALIZACJA
-----------------------------------------------------------

  1. Wypakuj paczkę do głównego katalogu gry:
     Prawy klik na paczkę -> "Wypakuj wszystko..." -> wybierz folder gry -> "Wypakuj"

  2. Nie rób nic innego

-----------------------------------------------------------
4. DODATKOWE INFORMACJE O PLIKU KONFIGURACYJNYM
-----------------------------------------------------------

  Pliki konfiguracyjne modyfikacji:
    \res_mods\xvm\configs\@Default\
  * Możesz wybrać gotowy plik konfiguracji z katalogu \res_mods\xvm\configs\user configs\ 
  * Możesz utworzyć nową konfigurację lub edytować istniejącą w:
    http://www.koreanrandom.com/forum/topic/1422-/#entry11316

  Wszystkie możliwe opcje konfiguracji znajdziesz tutaj:
    \res_mods\xvm\configs\@Default\


  Wspierane tagi html:
    http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText

    Dostępne makra:
    W panelu gracza(players panel), na ekranie ładowania bitwy oraz na tabeli statystyk(TAB):
      {{nick}}        - Nick gracza z nazwą klanu
      {{name}}        - Nick gracza bez nazwy klanu
      {{clan}}        - Nazwa klanu z nawiasami (puste, jeśli nie ma klanu)
      {{clannb}}      - Nazwa klanu bez nawiasów
      {{squad}}       - wartość 'sq' dla własnego plutonu, pusty wpis dla innych
      {{squad-num}}   - numer plutonu, bez plutonu pokazywany jest pusty wpis
      {{vehicle}}     - Nazwa pojazdu
      {{vehiclename}} - Wewnętrzna nazwa pojazdu (usa-M24_Chaffee)
      {{vtype}}       - Typ pojazdu
      {{level}}       - Poziom pojazdu (cyfry arabskie)
      {{rlevel}}      - Poziom pojazdu (cyfry rzymskie)
      {{hp}}          - Aktualne punkty wytrzymałości
      {{hp-ratio}}    - Współczynnik(ratio) aktualnych punktów wytrzymałości (bez znaku '%')
      {{hp-max}}      - Maksymalne punkty wytrzymałości
      {{c:hp}}        - Kolor zależny od aktualnych punktów wytrzymałości (tylko w znacznikach pojazdów)
      {{c:hp-ratio}}  - Kolor zależny od współczynnika(ratio) aktualnych punktów wytrzymałości (tylko w znacznikach pojazdów)     
      {{c:vtype}}     - Kolor zależny od typu pojazdu
      {{c:system}}    - Kolor systemowy (wyłacza nadpisanie koloru)
      {{a:hp}}        - Przezroczystość zależna od aktualnych punktów wytrzymałości (tylko w znacznikach pojazdów)
      {{a:hp-ratio}}  - Przezroczystość zależna od współczynnika(ratio) aktualnych punktów wytrzymałości (tylko w znacznikach pojazdów)
      {{l10n:blownUp}} - Przetłumaczony tekst "Blown-up!"(wybuch pojazdu), tylko w znaczniku "blowupMessage"
      {{battletier}}  - Przypuszczalny aktualny battle tier
      + makra na statystykach (poniżej)

    W panelu gracza, ekranie ładowania bitwy i statystykach:
      {{frags}}       - aktualna ilość zdobytych fragów
      {{alive}}       - 'alive' dla sprawnego, '' dla zniszczonego    
      
    W znacznikach pojazdów:
      {{turret}}      - wskaźnik seryjnej(stockowej) kopułki:
                         symbol "*"  - seryjna kopułka, nie można zamontować najlepszego działa
                         symbol "'"  - seryjna kopułka, można zamontować najlepsze działo
                         puste       - najlepsza kopułka
      {{dmg}}         - Obrażenia
      {{dmg-ratio}}   - Współczynnik obrażeń (bez '%')
      {{dmg-kind}}    - Typ obrażeń (zwykły atak, podpalenie, taranowanie, ...)
      {{c:dmg}}       - Kolor zależny od źródła obrażeń
      {{c:dmg-kind}}  - Kolor zależny od typu obrażeń
      
    W hitlogu:
      {{n}}           - Ogólna liczba trafień
      {{n-player}}    - Liczba trafień dla każdego gracza
      {{dmg}}         - Wartość obrażeń dla ostatniego trafienia
      {{dmg-total}}   - Całkowita wartość zadanych obrażeń
      {{dmg-avg}}     - Średnie obrażenia
      {{dmg-player}}  - Suma trafień dla gracza
      {{dead}}        - Wskaźnik dla zniszczonego pojazdu
      {{nick}}        - Nick gracza z nazwą klanu
      {{name}}        - Nick gracza bez nazwy klanu
      {{clan}}        - Nazwa klanu z nawiasami (puste, jeśli nie ma klanu)
      {{clannb}}      - Nazwa klanu bez nawiasów
      {{vehicle}}     - Nazwa pojazdu
      {{vehiclename}} - Wewnętrzna nazwa pojazdu (usa-M24_Chaffee)
      {{vtype}}       - Typ pojazdu
      {{level}}       - Poziom(tier) pojazdu (Cyfry arabskie)
      {{rlevel}}      - Poziom(tier) pojazdu (Cyfry rzymskie)
      {{dmg-kind}}    - Typ obrażeń (zwykły atak, podpalenie, taranowanie, ...)
      {{c:dmg-kind}}  - Kolor zależny od typu obrażeń
      {{c:vtype}}     - Kolor zależny od typu pojazdu
      {{l10n:Hits}}   - Przetłumaczony tekst "Hits"
      {{l10n:Total}}  - Przetłumaczony tekst "Total"
      {{l10n:Last}}   - Przetłumaczony tekst "Last"

    W pozostałych punktach wytrzymałości(HP Left):
      {{nick}}        - Nick gracza z nazwą klanu
      {{name}}        - Nick gracza bez nazwy klanu
      {{clan}}        - Nazwa klanu z nawiasami (puste, jeśli nie ma klanu)
      {{clannb}}      - Nazwa klanu bez nawiasów
      {{vehicle}}     - Nazwa pojazdu
      {{vehiclename}} - Wewnętrzna nazwa pojazdu (usa-M24_Chaffee)
      {{vtype}}       - Typ pojazdu
      {{level}}       - Poziom(tier) pojazdu (Cyfry arabskie)
      {{rlevel}}      - Poziom(tier) pojazdu (Cyfry rzymskie)
      {{hp}}          - Aktualne punkty wytrzymałości
      {{hp-ratio}}    - Aktualny współczynnik punktów wytrzymałości (bez '%')
      {{hp-max}}      - Maksymalne punkty wytrzymałości
      {{c:vtype}}     - Kolor zależny od typu pojazdu
      {{c:hp}}        - Kolor zależny od aktualnych punktów wytrzymałości
      {{c:hp-ratio}}  - Kolor zależny od współczynnika punktów wytrzymałości
      {{l10n:hpLeftTitle}}  - Przetłumaczony tekst "Hitpoints left:", tylko w "header"(nagłówek)

    W panelu przejmowania bazy:
      {{points}}      - Aktualne punkty przejęcia bazy
      {{extra}}       - Dodatkowe miejsce na tekst; pokazuje pozostały czas i ilość pojazdów przejmujących bazę
      {{tanks}}       - Ilość przejmujących bazę; nie może pokazać więcej niż 3; można zmienić format tego tekstu/przenieść tylko w sekcji dodatkowego miejsca na tekst
      {{time}}        - Czas pozostały do przejęcia bazy; minuty i sekundy;  można zmienić format tego tekstu/przenieść tylko w sekcji dodatkowego miejsca na tekst
      {{time-sec}}    - Czas pozostały do całkowitego przejęcia; tylko sekundy; można zmienić format tego tekstu/przenieść tylko w sekcji dodatkowego miejsca na tekst
      {{speed}}       - szybkość przejmowania bazy na sekundę; można zmienić format tego tekstu/przenieść tylko w sekcji dodatkowego miejsca na tekst
      {{l10n:enemyBaseCapture}}     - Przetłumaczony tekst "Enemy base capture!"
      {{l10n:enemyBaseCaptured}}    - Przetłumaczony tekst "Enemy base captured!"
      {{l10n:allyBaseCapture}}      - Przetłumaczony tekst "Ally base capture!"
      {{l10n:allyBaseCaptured}}     - Przetłumaczony tekst "Ally base captured!"
      {{l10n:Timeleft}}             - Przetłumaczony tekst "Timeleft"
      {{l10n:Capturers}}            - Przetłumaczony tekst "Capturers"

    W minimapie:
      {{level}}          - Poziom(tier)
      {{vehicle}}        - Pełna nazwa pojazdu
      {{vehicle-class}}  - Specjalny symbol zależny od typu pojazdu
      {{cellsize}}       - Wielkość kwadratu na minimapie
      {{vehiclename}}    - Nazwa wewnętrzna pojazdu - usa-M24_Chaffee
      
    W plutonie:
      {{level}}          - Poziom pojazdu (cyfry arabskie)
      {{rlevel}}         - Poziom pojazdu (cyfry rzymskie)
      {{vtype}}          - klasa pojazdu (zamiennik tekstowy z pliku konfiguracyjnego)
      {{vtype-l}}        - klasa pojazdu (zamiennik tekstowy z pliku językowego)
      {{battletier-min}} - minimalny battle tier pojazdu  
      {{battletier-max}} - maksymalny battle tier pojazdu  

    Makra dla statystyk ('showPlayersStatistics' musi być włączone):
      {{avglvl}}      - Przeciętny poziom(tier) pojazdów
      {{eff}}         - Wartość "efficiency" gracza: http://wot-news.com/index.php/stat/calc/en/
      {{eff:4}}       - Zaokrąglona wartość "efficiency" gracza
      {{teff}}, {{e}} - Wartość "efficiency" gracza dla danego pojazdu: http://www.koreanrandom.com/forum/topic/1643-
      {{wn6}}         - WN6 : http://www.koreanrandom.com/forum/topic/2575-
      {{wn8}}         - WN8 : http://www.koreanrandom.com/forum/topic/2575-
      {{xeff}}        - Skala XVM dla "efficiency" (wartości 00-99)
      {{xwn6}}        - Skala XVM dla WN6 (wartości 00-99)
      {{xwn8}}        - Skala XVM dla WN8 (wartości 00-99)
      {{winrate}}     - GWR (Global Win Ratio)
      {{rating:3}}    - GWR zaokrąglone do 3 liczb z lewej
      {{battles}}     - Całkowita liczba bitw
      {{wins}}        - Całkowita liczba wygranych bitw
      {{kb}}          - Kilo-bitwy (Ogólna liczba bitw podzielona przez 1000).
      {{kb:3}}        - Kilo-bitwy zaokrąglone do trzech liczb z lewej
      {{t-rating}}    - Wartość wygranych dla danego pojazdu
      {{t-rating:3}}  - Wartość wygranych dla danego pojazdu zaokrąglona do 3 liczb z lewej
      {{t-battles}}   - Ogólna liczba bitw dla danego pojazdu
      {{t-battles:4}} - Zaokrąglona całkowita liczba bitw dla danego pojazdu(do 4 liczb z lewej)
      {{t-wins}}      - Całkowita liczba bitw dla danego pojazdu
      {{t-kb}}        - Liczba kilo-bitw dla danego pojazdu
      {{t-kb-0}}      - Liczba kilo-bitw dla danego pojazdu poprzedzona zerem
      {{t-kb:4}}      - Zaokrąglona liczba kilo-bitw dla danego pojazdu(do 4 liczb z lewej)
      {{t-hb}}        - Liczba hekto-bitw dla danego pojazdu (hekto = 100)
      {{t-hb:3}}      - Liczba hekto-bitw dla danego pojazdu zaokrąglona do 3 liczb z lewej
      {{tdb}}, {{tdb:4}} - Przeciętne obrażenia dla danego pojazdu - obrażenia/bitwy
      {{tdv}} - Średnia wydajność obrażeń dla danego pojazdu - obrażenia/(bitwy*maxHP)
      {{tfb}} - Średnia ilość fragów dla danego pojazdu
      {{tsb}} - Średnia ilość wykrytych pojazdów dla danego czołgu na bitwę
      {{c:tdb}}, {{c:tdv}}, {{c:tfb}}, {{c:tsb}} - dynamiczne kolory dla podanych makr
      {{c:eff}}       - Kolor zależny od wartości "efficiency" gracza
      {{c:e}}         - Kolor zależny od wartości "efficiency" dla danego pojazdu gracza
      {{c:wn6}}       - Kolor zależny od WN6 
      {{c:wn8}}       - Kolor zależny od WN8 
      {{c:xeff}}      - Kolor zależny od skali XVM dla "efficiency"
      {{c:xwn6}}      - Kolor zależny od skali XVM dla WN6
      {{c:xwn8}}      - Kolor zależny od skali XVM dla WN8    
      {{c:winrate}}   - Kolor zależny od GWR
      {{c:kb}}        - Kolor zależny od kilo-bitw
      {{c:avglvl}}    - Kolor zależny od przeciętnego poziomu pojazdów  
      {{c:t-rating}}  - Kolor zależny od aktualnej wartości wygranych
      {{c:t-battles}} - Kolor zależny od aktualnej liczby bitw pojazdu
      Każdy kolor możesz zmienić na makro przezroczystości ({{a: tdb}}).

    Zasady formatowania rozszerzonych makr:
        {{name[:norm][%[flag][width][.prec]type][~suf][?rep][|def]}}
        name  - nazwa makro

        :norm - normalizacja wartości, przykładowo {{hp-ratio:300}} zwraca wartość w przedziale 0..300

        flag  - "-" dla usadowienia z lewej strony lub ewentualnie z prawej
                "0" do zapełnienia z przodującymi zerami
        width - minimalna szerokość
        prec  - maksymalna szerokość dla linii lub cyfr po przecinku w liczbach dziesiętnych/setnych itd. 
        type  - typ (s - ciąg, d - liczby dziesiętne, f - usadowienie, ...)

        suf   - przyrostek dodany na końcu  
        rep   - wartość zamienna, wprowadzona zamiar wartości domyślnej 
        def   - wartość domnyślna, ustaw jeśli brakuje wartości:

    Szczegóły: http://en.wikipedia.org/wiki/Printf
    Przykładowo:
      {{name%-16.16s}}      - Przycina nazwy posiadające więcej, niż 10 znaków i wypełnia nazwy posiadające mniej niż 10 znaków usadowione z lewej strony  
      {{kb%4.01f~k|----}}   - szerokość na 4 znaki, dokładnie na 1 znak po kropce, usadowienie z prawej strony 
                              if kb==null, display "----"
        
    Używanie makr tłumaczenia języka - {{l10n:localizationKey}}
      Makra to po prostu odnośniki do wartości w plikach językowych res_mods/xvm/l10n/XX.xc file (XX oznacza kod języka).
      Jeśli nie znaleziono języka, to zostaje wyświetlony komunikat: "localizationKey".

      Przykład na panelu przejmowania bazy
        /l10n/en.xc
          "enemyBaseCaptured": "Przejmujemy bazę wroga!"
        captureBar.xc
          "captureDoneFormat":    "<font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>"
         formated: "<font size='17' color='#FFCC66'>Przejmujemy bazę wroga!</font>"

      Więcej na temat tłumaczenia: https://code.google.com/p/wot-xvm/wiki/LocalizingXVM

  Przykłady formatów:
    1. Pokaż liczbę kilo-bitw, "efficiency" i GWR bez zmiany koloru:
      "{{kb}} {{xwn}} {{winrate}}"
    2. To samo, tylko z przypisanymi kolorami według typu:
      "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:winrate}}'>{{winrate}}</font>"
    3. To samo co numer 2, tylko z przypisanymi kolumnami:
      "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:winrate}}'>{{rating:3}}</font></font>"
    4. Pokaż kolor GWR według XVM:
      "<font color='{{c:xwn}}'>{{winrate}}</font>"

  Przykłady koloru i przezroczystości:
    "color": "{{c:xwn}}" - kolor zależny od xvm
    "alpha": "{{a:hp}}"  - przezroczystość zależ

  Klan i ikony gracza.
  Parametr konfiguracji battles/clanIconsFolder ustalony w głównym katalogu.

  Wszystkie ikony są ładowane z folderu oznaczonego regionem (RU/EU/US/...).

  Jeśli chcesz dodać ikonę dla gracza/klanu, skopiuj ikonę do:
    \res_mods\xvm\res\clanicons\[REGION]\clan\ (dla klanu)
    \res_mods\xvm\res\clanicons\[REGION]\nick\ (dla pojedynczego gracza)
  Możesz utworzyć także standardowe ikony dla graczy/klanów:
    \res_mods\xvm\res\clanicons\[REGION]\clan\default.png (dla klanu)
    \res_mods\xvm\res\clanicons\[REGION]\nick\default.png (dla gracza)
  Kolejność wyszukiwania:
    nick/<player>.png -> clan/<clan>.png -> clan/default.png -> nick/default.png
  150 najlepszych klanów jest dodane standardowo.
  Pełne archiwum ze wszystkimi klanami może być pobrane oddzielnie:
    http://code.google.com/p/wot-xvm/downloads/list
    Files: clanicons-full-ru-XXX.zip (RU), clanicons-full-eu-XXX.zip (EU),
    clanicons-full-us-XXX.zip (US), clanicons-full-sea-XXX.zip (SEA)

  Ikona szóstego zmysłu.
  Aby zmienić ikonę szóstego zmysłu przekopiuj obrazek do:
   \res_mods\xvm\res\SixthSense.png.

  Hit Log.
  Współczynniki x, y pozwalają ustalić ułożenie panelu, w zależności od rozdzielczości.

  Zegar w bitwie oraz na ekranie ładowania bitwy.
  Format: Data PHP: http://php.net/date
  Np:
  "clockFormat": "H:i"          => 01:23
  "clockFormat": "Y.m.d H:i:s"  => 2013.05.20 01:23:45

_______________________________________________________________
  
  Wartości Efficiency per-pojazd {{teff}}, {{e}}.
  
    TEFF       E
    0..299     1 - bardzo słaby gracz
    300..499   2 - słaby gracz
    500..699   3 - słabo
    700..899   4 - poniżej przeciętnej
    900..1099  5 - przeciętny
    1100..1299 6 - powyżej przeciętnej
    1300..1549 7 - dobry
    1550..1799 8 - doskonały
    1800..1999 9 - mistrz
    2000+      E - Expert (top-100 graczy na danym pojeździe)
    
  Wartości Efficiency {{eff}}.
    0..549     1 - bardzo słaby gracz
    550..629   2 - słaby gracz
    630..859   3 - poniżej przeciętnej
    860..1139  4 - powyżej przeciętnej
    1140..1459 5 - dobry
    1460..1549 6 - bardzo dobry
    1550..1734 7 - doskonały
    1735..1899 8 - unikalny(unicum)
    1900+      9 - super unikalny(super unicum)

  Wartości WN6 {{wn6}}.
    0..424     1 - słaby gracz
    425..794   2 - poniżej przeciętnej
    795..1174  3 - przeciętny gracz
    1175..1569 4 - dobry gracz
    1570..1884 5 - bardzo dobry gracz
    1885+      6 - unikalny(unicum)
    
  Wartości WN8 {{wn8}}.
    0..299     1 - bardzo słaby gracz
    300..599   2 - słaby gracz
    600..899   3 - poniżej przeciętnej
    900..1199  4 - powyżej przeciętnej
    1200..1499 5 - dobry
    1500..1749 6 - bardzo dobry
    1750..2299 7 - doskonały
    2300..2899 8 - unikalny(unicum)
    2900+      9 - super unikalny(super unicum) 

_______________________________________________________________