#pragma once

#include <Windows.h>

typedef HFONT(__stdcall* CreateFontW_typedef) (
   int     nHeight,
   int     nWidth,
   int     nEscapement,
   int     nOrientation,
   int     fnWeight,
   DWORD   fdwItalic,
   DWORD   fdwUnderline,
   DWORD   fdwStrikeOut,
   DWORD   fdwCharSet,
   DWORD   fdwOutputPrecision,
   DWORD   fdwClipPrecision,
   DWORD   fdwQuality,
   DWORD   fdwPitchAndFamily,
   LPCWSTR lpszFace
);

HFONT __stdcall CreateFontW_Detour(
   int     nHeight,
   int     nWidth,
   int     nEscapement,
   int     nOrientation,
   int     fnWeight,
   DWORD   fdwItalic,
   DWORD   fdwUnderline,
   DWORD   fdwStrikeOut,
   DWORD   fdwCharSet,
   DWORD   fdwOutputPrecision,
   DWORD   fdwClipPrecision,
   DWORD   fdwQuality,
   DWORD   fdwPitchAndFamily,
   LPCWSTR lpszFace
);


extern CreateFontW_typedef CreateFontW_trampoline;

