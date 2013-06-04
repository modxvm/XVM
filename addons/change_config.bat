::
:: Скрипт для быстрой замены XVM конфига
:: The script to automatically change the XVM config.
::
:: Поместите скрипт в папку xvm\configs 
:: и просто перетаскивайте нужный конфиг или папку с конфигом на этот скрипт
:: Put the script into xvm\configs and drag'n'drop the folder(or file any.xc)
:: with wanted config on the scpirt. The config from that folder will be substituted into xvm/xvm.xc
::
:: http://www.koreanrandom.com/forum/topic/4643-
::
@echo off

:: сохраняем ссылку на старый конфиг
copy /y "..\xvm.xc" "..\xvm.xc.old" >nul

:: Если перетащили папку, ищем конфиг внутри нее
if exist "%~nx1\@xvm.xc" echo ${"configs/%~nx1/@xvm.xc":"."}>"..\xvm.xc"
if exist "%~nx1\xvm.xc" echo ${"configs/%~nx1/xvm.xc":"."}>"..\xvm.xc"

:: если перетащили файл с расширением .xc, задаем этот конфиг
if "%~x1"==".xc" if not exist "%~nx1\*.*" echo ${"configs/%~nx1":"."}>"..\xvm.xc"

:: если нет параметра, определяем дефолтный конфиг
:: if "%1"=="" echo ${"configs/@Default/@xvm.xc":"."}>"..\xvm.xc"