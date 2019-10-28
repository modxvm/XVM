#pragma once

#include <Windows.h>

typedef int(__stdcall *EnumFontFamiliesExW_typedef) (
    HDC           hdc,
    LPLOGFONTW    lpLogfont,
    FONTENUMPROCW lpEnumFontFamExProc,
    LPARAM        lParam,
    DWORD         dwFlags);

int __stdcall EnumFontFamiliesExW_Detour(
    HDC           hdc,
    LPLOGFONTW    lpLogfont,
    FONTENUMPROCW lpEnumFontFamExProc,
    LPARAM        lParam,
    DWORD         dwFlags);

extern EnumFontFamiliesExW_typedef EnumFontFamiliesExW_trampoline;

