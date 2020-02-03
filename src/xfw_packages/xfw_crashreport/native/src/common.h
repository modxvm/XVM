#pragma once

#include <string>
#include <filesystem>

#include <Windows.h>

template<typename ... Args>
std::wstring string_format(const std::wstring& format, Args ... args);

std::wstring string_to_wstring(const std::string& str);

std::wstring GetModuleVersion(HMODULE hModule);

std::wstring GetModuleVersion(const wchar_t* moduleName);

std::filesystem::path GetModuleDirectory(HMODULE hModule);

std::filesystem::path GetModuleDirectory(const char* moduleName);

std::filesystem::path GetWorkingDirectory();
