#include <algorithm>
#include <iostream>
#include <fstream>
#include <filesystem>
#include <vector>

#include <Windows.h>
#include <Shlobj.h>

#include "rapidxml.hpp"

////// Helpers
std::wstring getRegistryValue(const wchar_t* subkey, const wchar_t* value);
std::wstring getFileContent(std::wstring filepath);
std::wstring getProgramDataPath();
template <typename T> void removeDuplicates(std::vector<T>& vec);

////// WGC
std::wstring WGC_GetWGCInstallPath();
std::vector<std::wstring> WGC_GetWotPaths();
std::wstring WGC_GetWotPreferedPath();

////// Legacy
std::vector<std::wstring> Legacy_GetWotPaths();

////// Do Work
void DoWork();

////// API
extern "C" void __cdecl GetWotPreferredW(wchar_t *buffer, int size);
extern "C" void __cdecl GetWotPreferredA(char *buffer, int size);
extern "C" int  __cdecl GetWotPathsCount();
extern "C" void __cdecl GetWotPathsItemW(wchar_t *buffer, int size, int index);
extern "C" void __cdecl GetWotPathsItemA(char *buffer, int size, int index);

extern "C" BOOLEAN WINAPI DllMain(IN HINSTANCE hDllHandle, IN DWORD nReason, IN LPVOID Reserved);
