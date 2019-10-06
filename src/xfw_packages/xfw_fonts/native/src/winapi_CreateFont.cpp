#include <algorithm>

#include "winapi_CreateFont.h"
#include "pythonModule.h"

CreateFontW_typedef CreateFontW_trampoline;

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
   LPCWSTR lpszFace)
{
    const wchar_t* face = lpszFace;

    std::wstring fontName(lpszFace);
    std::transform(fontName.begin(), fontName.end(), fontName.begin(), towlower);
    if(fontMap.find(fontName) != fontMap.end())
    {
        face = fontMap[fontName].c_str();
        //PySys_WriteStdout("[XFW/Fonts][CreateFontW] REDIRECT: %s\n", ConvertUTF16ToUTF8(face).c_str());
    }

    HFONT result =  CreateFontW_trampoline(
        nHeight,
        nWidth,
        nEscapement,
        nOrientation,
        fnWeight,
        fdwItalic,
        fdwUnderline,
        fdwStrikeOut,
        fdwCharSet,
        fdwOutputPrecision,
        fdwClipPrecision,
        fdwQuality,
        fdwPitchAndFamily,
        face
    );

    //PySys_WriteStdout("[XFW/Fonts][CreateFontW] RESULT: %p\n\n", result);
    return result;
}

