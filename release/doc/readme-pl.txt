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