set PFiles=%ProgramFiles%
if DEFINED ProgramFiles(x86) set PFiles=%ProgramFiles(x86)%

SET MONO=%PFiles%\Mono-3.0.10\bin

"%MONO%\mono.exe" xvm-stat.exe
