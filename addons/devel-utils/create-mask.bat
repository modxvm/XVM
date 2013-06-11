@echo off

mkdir New

for %%i in (*.*); do (
  echo %%i
rem  convert "%%i" ^( +clone -channel A -morphology Edge Diamond +channel +level-colors black ^) -compose Dst_Over -composite "New\\%%i"
rem  convert "%%i" -fuzz 60%% -fill white -opaque white "New\\%%i"

rem  convert "%%i" -alpha extract -alpha on "New\\%%i"
rem  convert "%%i" -morphology Edge Diamond "New\\%%i"
rem  convert "%%i" -colorspace Gray -negate -edge 2 -negate -blur 0x.5 "New\\%%i"
rem  convert "%%i" ^( -clone 0 -roll +1+0 -clone 0 -compose difference -composite ^) ^( -clone 0 -roll +0+1 -clone 0 -compose difference -composite ^) -delete 0 -compose screen -composite -negate -alpha extract -alpha on "New\\%%i"
  convert "%%i" -color-matrix ' 1 1 1 1 1 1 1 1 1 ' "New\\%%i"
)
