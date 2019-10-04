#define NOMINMAX
#include <algorithm>

#include "winapi_EnumFontsFamiliesEx.h"
#include "pythonModule.h"

EnumFontFamiliesExW_typedef EnumFontFamiliesExW_trampoline;

int __stdcall EnumFontFamiliesExW_Detour(
    HDC           hdc,
    LPLOGFONTW    lpLogfont,
    FONTENUMPROCW lpEnumFontFamExProc,
    LPARAM        lParam,
    DWORD         dwFlags)
{
    //PySys_WriteStdout("[XFW/Fonts][EnumFontsFamiliesExW] REQUEST: %s\n", ConvertUTF16ToUTF8(lpLogfont->lfFaceName).c_str());
    std::wstring fontName(lpLogfont->lfFaceName);
    std::transform(fontName.begin(), fontName.end(), fontName.begin(), towlower);
	if(fontMap.find(fontName) != fontMap.end())
	{
		auto replacement = fontMap[fontName];

        //PySys_WriteStdout("[XFW/Fonts][EnumFontsFamiliesExW] REDIRECT: %s\n", ConvertUTF16ToUTF8(replacement.c_str()).c_str());
		wcsncpy(lpLogfont->lfFaceName,replacement.c_str(), LF_FACESIZE);
	}


	int result =  EnumFontFamiliesExW_trampoline(hdc,lpLogfont, lpEnumFontFamExProc, lParam, dwFlags);
    //PySys_WriteStdout("[XFW/Fonts][EnumFontsFamiliesExW] RESULT: %i\n\n", result);
    return result;
}
