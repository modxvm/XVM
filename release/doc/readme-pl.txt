// Plik readme dla XVM/STAT, tłumaczenie dla wersji 4.1.1/1.6.1
// Tłumaczenie na język polski - Nikodemsky


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

  Strona projektu:  http://www.modxvm.com/

  Wsparcie:      http://www.koreanrandom.com/forum/topic/1383-xvm
  Wsparcie na polskim oficjalnym polskim forum WoT:   http://forum.worldoftanks.eu/index.php?/topic/114684-pomoc-xvm-mod-temat-zbiorczy/

  FAQ:           http://www.modxvm.com/en/faq/
  Konfiguracje:  http://www.koreanrandom.com/forum/forum/50-custom-configurations
  Edytor wizualny: http://www.koreanrandom.com/forum/topic/1422-/#entry11316



-----------------------------------------------------------
2. INSTALACJA
-----------------------------------------------------------

 * Przed instalacją są wymagane dwie rzeczy:
 - Biblioteki Dokan(http://dokan-dev.net/wp-content/uploads/DokanInstall_0.6.0.exe)
 - NET Framework w wersji 3.5 lub wyższe


  1. Wypakuj paczkę do głównego katalogu gry:
     Prawy klik na paczkę -> "Wypakuj wszystko..." -> wybierz folder gry -> "Wypakuj"

  2. Standardowo nie musisz niczego zmieniać.

    Jeśli chcesz zmienić konfiguracje, to musisz zmienić nazwę w pliku startowym:
      \res_mods\xvm\xvm.xc.sample do xvm.xc
    Instrukcje znajdują sie w środku pliku.

    Wszystkie możliwe opcje konfiguracji możesz znaleźć w:
      \res_mods\xvm\configs\@Default\
    lub możesz użyć edytora: http://www.koreanrandom.com/forum/topic/1422-/#entry11316

    WAŻNE: Jeśli konfigurujesz manualnie, używaj programów typu notatnik, NIGDY nie używaj edytorów typu Word/Wordpad. Opcjonalnie możesz również użyć edytora XCPad(podświetla on tagi xvm): http://www.koreanrandom.com/forum/index.php?app=core&module=attach&section=attach&attach_id=22620

  3. Jeśli XVM nie wykrywa prawidłowo języka gry,
   to w pliku konfiguracji (standardowo\res_mods\xvm\configs\@default\@xvm.xc)
    zmień wartość "language" z "auto" na kod języka(np. pl).

  4. Jest też możliwość instalacji tzw. "Nightly builds".
    Możesz je pobrać na http://wargaming.by-reservation.com/xvm/

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
  Możesz wybrać gotowy plik konfiguracji z katalogu \res_mods\xvm\configs\user configs\ 
  Możesz utworzyć nową konfigurację lub edytować istniejącą w:
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
      {{vehicle}}     - Nazwa pojazdu
      {{vehiclename}} - Wewnętrzna nazwa pojazdu (usa-M24_Chaffee)
      {{vtype}}       - Typ pojazdu
      {{c:vtype}}     - Kolor zależny od typu pojazdu
      + makra na statystykach (poniżej)

    W znacznikach pojazdów:
      {{nick}}        - Nick gracza z nazwą klanu
      {{name}}        - Nick gracza bez nazwy klanu
      {{clan}}        - Nazwa klanu z nawiasami (puste, jeśli nie ma klanu)
      {{clannb}}      - Nazwa klanu bez nawiasów
      {{squad}}       - wartość '1' dla własnego plutonu, pusty dla innych
      {{vehicle}}     - Nazwa pojazdu
      {{vehiclename}} - Wewnętrzna nazwa pojazdu (usa-M24_Chaffee)
      {{vtype}}       - Typ pojazdu
      {{level}}       - Tier pojazdu (Cyfry arabskie)
      {{rlevel}}      - vehicle level (Cyfry rzymskie)
      {{turret}}      - wskaźnik stockowej kopułki:
                         symbol "*"  - stockowa kopułka, nie można zamontować najlepszego działa
                         symbol "'"  - stockowa kopułka, można zamontować najlepsze działo
                         puste       - najlepsza kopułka
      {{hp}}          - Aktualne punkty wytrzymałości
      {{hp-ratio}}    - Aktualny współczynnik punktów wytrzymałości (bez '%')
      {{hp-max}}      - Maksymalne punkty wytrzymałości
      {{dmg}}         - Obrażenia
      {{dmg-ratio}}   - Współczynnik obrażeń (bez '%')
      {{dmg-kind}}    - Typ obrażeń (zwykły atak, podpalenie, taranowanie, ...)
      {{c:hp}}        - Kolor zależny od aktualnych punktów wytrzymałości (tylko we wskaźnikach pojazdów)
      {{c:hp-ratio}}  - Kolor zależny od aktualnego współczynnika punktów wytrzymałości (tylko we wskaźnikach pojazdów)
      {{c:dmg}}       - Kolor zależny od źródła obrażeń
      {{c:dmg-kind}}  - Kolor zależny od typu obrażeń
      {{c:vtype}}     - Kolor zależny od typu pojazdu
      {{c:system}}    - Kolor systemowy (wyłączenie nadpisania kolorów)
      {{a:hp}}        - przezroczystość zależna od aktualnych punktów wytrzymałości (tylko we wskaźnikach pojazdów)
      {{a:hp-ratio}}  - przezroczystość zależna od aktualnego współczynnika punktów wytrzymałości (tylko we wskaźnikach pojazdów)
      {{l10n:blownUp}}  - przetłumaczony tekst "Blown-up!", tylko w "blowupMessage"
      + makra statystyk (poniżej)

    W hitlogu:
      {{n}}           - Ogólna liczba trafień
      {{n-player}}    - Liczba trafień dla każdego gracza
      {{dmg}}         - Wartość obrażeń dla ostatniego trafienia
      {{dmg-total}}   - Całkowita wartość zadanych obrażeń
      {{dmg-avg}}     - Średnie obrażenia w bitwie
      {{dmg-player}}  - Suma trafień dla gracza
      {{dead}}        - Wskaźnik dla zniszczonego pojazdu
      {{nick}}        - Nick gracza z nazwą klanu
      {{name}}        - Nick gracza bez nazwy klanu
      {{clan}}        - Nazwa klanu z nawiasami (puste, jeśli nie ma klanu)
      {{clannb}}      - Nazwa klanu bez nawiasów
      {{vehicle}}     - Nazwa pojazdu
      {{vehiclename}} - Wewnętrzna nazwa pojazdu (usa-M24_Chaffee)
      {{vtype}}       - Typ pojazdu
      {{level}}       - Tier pojazdu (Cyfry arabskie)
      {{rlevel}}      - Tier level (Cyfry rzymskie)
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
      {{level}}       - Tier pojazdu (Cyfry arabskie)
      {{rlevel}}      - Tier pojazdu (Cyfry rzymskie)
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
      {{level}}          - Tier
      {{short-nick}}     - Skrócony nick
      {{vehicle}}        - Pełna nazwa typu pojazdu
      {{vehicle-type}}   - Pełna nazwa typu pojazdu
      {{vehicle-class}}  - Specjalny symbol zależny od typu pojazdu
      {{cellsize}}       - Wielkość kwadratu na minimapie
      {{vehicle-name}}   - zwraca nazwę wewnętrzną według ustalenia - usa-M24_Chaffee
      {{vehiclename}}    - Nazwa wewnętrzna pojazdu - usa-M24_Chaffee
      {{vehicle-short}}  - Skrócona nazwa pojazdu

    Makra dla statystyk ('klasyfikacja/showPlayersStatistics' muszą być włączone):
      {{avglvl}}      - Przeciętny tier pojazdów
      {{eff}}         - Wartość "efficiency" gracza: http://wot-news.com/index.php/stat/calc/en/
      {{eff:4}}       - Zaokrąglona wartość "efficiency" gracza
      {{teff}}, {{e}} - Wartość "efficiency" gracza dla danego pojazdu: http://www.koreanrandom.com/forum/topic/1643-
      {{twr}}         - TWR (T-Calc): http://www.koreanrandom.com/forum/topic/2389-
      {{wn}}          - WN6 : http://www.koreanrandom.com/forum/topic/2575-
      {{xeff}}        - Skala XVM dla "efficiency" (wartości 00-99)
      {{xwn}}         - Skala XVM dla WN6 (wartości 00-99)
      {{rating}}      - GWR (Global Win Ratio)
      {{rating:3}}    - GWR zaokrąglone do 3 liczb
      {{battles}}     - Całkowita liczba bitw
      {{wins}}        - Całkowita liczba wygranych bitw
      {{kb}}          - Kilo-bitwy (Ogólna liczba bitw podzielona przez 1000).
      {{kb:3}}        - Liczba kilo-bitw zaokrąglona do 3 liczb
      {{t-rating}}    - Wartość wygranych dla danego pojazdu
      {{t-rating:3}}  - Wartość wygranych dla danego pojazdu zaokrąglona do 3 liczb
      {{t-battles}}   - Ogólna liczba bitw dla danego pojazdu
      {{t-battles:4}} - Zaokrąglona całkowita liczba bitw dla danego pojazdu
      {{t-wins}}      - Całkowita liczba bitw dla danego pojazdu
      {{t-kb}}        - Liczba kilo-bitw dla danego pojazdu
      {{t-kb-0}}      - Liczba kilo-bitw dla danego pojazdu poprzedzona zerem
      {{t-kb:4}}      - Zaokrąglona liczba kilo-bitw dla danego pojazdu
      {{t-hb}}        - Liczba hekto-bitw dla danego pojazdu (hekto = 100)
      {{t-hb:3}}      - Liczba hekto-bitw dla danego pojazdu zaokrąglona do 3 liczb
      {{tdb}}, {{tdb:4}} - Przeciętne obrażenia dla danego pojazdu - obrażenia/bitwy
      {{tdv}} - Średnia wydajność obrażeń dla danego pojazdu - obrażenia/(bitwy*maxHP)
      {{tfb}} - Średnia ilość fragów dla danego pojazdu
      {{tsb}} - Średnia ilość wykrytych pojazdów dla danego czołgu na bitwę
      {{c:tdb}}, {{c:tdv}}, {{c:tfb}}, {{c:tsb}} - dynamiczne kolory dla podanych makr
      {{c:eff}}       - Kolor zależny od wartości "efficiency" gracza
      {{c:e}}         - Kolor zależny od wartości "efficiency" dla danego pojazdu gracza
      {{c:twr}}       - Kolor zależny od TWR (T-Calc)
      {{c:wn}}        - Kolor zależny od WN6 
      {{c:xeff}}      - Kolor zależny od skali XVM dla "efficiency"
      {{c:xwn}}       - Kolor zależny od skali XVM dla WN6
      {{c:rating}}    - Kolor zależny od GWR
      {{c:kb}}        - Kolor zależny od kilo-bitw
      {{c:t-rating}}  - Kolor zależny od aktualnej wartości wygranych
      {{c:t-battles}} - Kolor zależny od aktualnej liczby bitw pojazdu
      Każdy kolor możesz zmienić na makro przezroczystości ({{a: tdb}}).

    Używanie makr tłumaczenia języka - {{l10n:localizationKey}}
      Makra to po prostu odnośniki do wartości w plikach językowych res_mods/xvm/l10n/XX.xc file (XX oznacza kod języka).
      Jeśli nie znaleziono języka, to zostaje wyświetlona wiadomość: "localizationKey".

      Przykład na panelu przejmowania bazy
        /l10n/en.xc
          "enemyBaseCaptured": "Przejmujemy bazę wroga!"
        captureBar.xc
          "captureDoneFormat":    "<font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>"
         formated: "<font size='17' color='#FFCC66'>Przejmujemy bazę wroga!</font>"

      Więcej na temat tłumaczenia: https://code.google.com/p/wot-xvm/wiki/LocalizingXVM

  Przykłady formatów:
    1. Pokaż liczbę kilo-bitw, "efficiency" i GWR bez zmiany koloru:
      "{{kb}} {{xwn}} {{rating}}"
    2. To samo, tylko z przypisanymi kolorami według typu:
      "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating}}</font>"
    3. To samo co numer 2, tylko z przypisanymi kolumnami:
      "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>"
    4. Pokaż kolor GWR według XVM:
      "<font color='{{c:xwn}}'>{{rating}}</font>"

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
  Działa tylko z xvm-stat!

  Zegar w czasie ładowania bitwy.
  Format: Y:rok, M:miesiąc, D:dzień, H:godzina, N:minuta, S:sekunda. "" - usuwa zegar.
  Np:
  "clockFormat": "H:N"          => 01:23
  "clockFormat": "Y.M.D H:N:S"  => 2013.05.20 01:23:45
  Jest możliwość ustawienia tagów HTML dla zegara.

  Wartości Efficiency {{teff}}, {{e}}.
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
