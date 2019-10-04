#pragma once

#include <string>
#include <filesystem>

#include <Windows.h>

using namespace std::experimental;

template<typename ... Args>
std::wstring string_format(const std::wstring& format, Args ... args);

std::wstring string_to_wstring(const std::string& str);

std::wstring GetModuleVersion(HMODULE hModule);

std::wstring GetModuleVersion(const wchar_t* moduleName);

filesystem::path GetModuleDirectory(HMODULE hModule);

filesystem::path GetModuleDirectory(const char* moduleName);
