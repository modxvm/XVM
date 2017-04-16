#include <algorithm>
#include <iostream>
#include <fstream>
#include <filesystem>
#include <vector>

#include <Windows.h>
#include <Shlobj.h>

#include "rapidxml.hpp"

#include "findwot.h"

using namespace rapidxml;
using namespace std::experimental::filesystem::v1;

////// Globals
std::vector<std::wstring> g_paths;
bool g_initialized = false;


////// Helpers
std::wstring getRegistryValue(const wchar_t* subkey, const wchar_t* value)
{
	HKEY hKey = 0;
	wchar_t val[1024] { 0 };
	DWORD value_length = 1024;
	
	if (RegOpenKeyW(HKEY_CURRENT_USER, subkey, &hKey) != ERROR_SUCCESS)
	{
		if(RegOpenKeyW(HKEY_LOCAL_MACHINE, subkey, &hKey) != ERROR_SUCCESS)
		{
			return std::wstring();
		}
	}

	if (RegQueryValueExW(hKey, value, nullptr, nullptr, (LPBYTE)&val, &value_length) != ERROR_SUCCESS)
	{
		return std::wstring();
	}

	return std::wstring(val);
}

std::wstring getFileContent(std::wstring filepath)
{
	std::wstring content;
	
	std::wifstream in(filepath, std::wifstream::in);
	if (!in.is_open())
	{
		return std::wstring(L"");
	}
	in.imbue(std::locale(in.getloc(), new std::codecvt_utf8_utf16<wchar_t,0x10FFFF, std::consume_header>()));

	content.assign(std::istreambuf_iterator<wchar_t>(in), std::istreambuf_iterator<wchar_t>());
	in.close();

	return content;
}

std::wstring getProgramDataPath()
{
	wchar_t szProgramDataPath[MAX_PATH]{ 0 };
	if (!SUCCEEDED(SHGetFolderPathW(NULL, CSIDL_COMMON_APPDATA, NULL, 0, szProgramDataPath)))
	{
		return std::wstring(L"");
	}
	return std::wstring(szProgramDataPath);
}

template <typename T> 
void removeDuplicates(std::vector<T>& vec)
{
	std::sort(vec.begin(), vec.end());
	vec.erase(std::unique(vec.begin(), vec.end()), vec.end());
}

////// WGC
std::wstring WGC_GetWGCInstallPath()
{
	std::wstring programDataPath = getProgramDataPath();

	std::wstring wgcPathFile(programDataPath + L"\\Wargaming.net\\GameCenter\\data\\wgc_path.dat");
	if (exists(wgcPathFile))
	{
		std::wstring path = getFileContent(wgcPathFile);
		if (exists(path + L"\\wgc.exe"))
		{
			return path;
		}
	}
	else if(exists(programDataPath + L"\\Wargaming.net\\GameCenter\\wgc.exe"))
	{
		return programDataPath + L"\\Wargaming.net\\GameCenter";
	}

	return std::wstring(L"");
}

std::vector<std::wstring> WGC_GetWotPaths()
{
	std::wstring programDataPath = getProgramDataPath();

	std::vector<std::wstring> wotPaths;
	try
	{
		for (auto& p : directory_iterator(programDataPath + L"\\Wargaming.net\\GameCenter\\apps\\wot\\"))
		{
			std::wstring path = getFileContent(p.path().wstring());

			if (exists(path + L"\\WorldOfTanks.exe"))
			{
				wotPaths.push_back(path);
			}
		}
	}
	catch (const std::exception&) {}

	return wotPaths;
}

std::wstring WGC_GetWotPreferedPath()
{
	std::wstring wgcPath = WGC_GetWGCInstallPath();

	std::wstring preferences(wgcPath + L"\\preferences.xml");
	if (!exists(preferences))
		return std::wstring(L"");

	std::wstring content = getFileContent(preferences);
	xml_document<wchar_t> doc;
	doc.parse<0>(_wcsdup(content.c_str()));

	//try to get preferences.xml->protocol->application->games_manager->selectedGames->WOT
	try
	{
		xml_node<wchar_t> *protocol = doc.first_node(L"protocol");
		if (protocol == nullptr)
			return std::wstring(L"");

		xml_node<wchar_t> *application = protocol->first_node(L"application");
		if (application == nullptr)
			return std::wstring(L"");

		xml_node<wchar_t> *gamemanager = application->first_node(L"games_manager");
		if (gamemanager == nullptr)
			return std::wstring(L"");

		xml_node<wchar_t> *selectedgames = gamemanager->first_node(L"selectedGames");
		if (selectedgames == nullptr)
			return std::wstring(L"");

		xml_node<wchar_t> *target = selectedgames->first_node(L"WOT");
		if (target == nullptr)
			return std::wstring(L"");

		if (exists(std::wstring(target->value())+L"\\WorldOfTanks.exe"))
		{
			return std::wstring(target->value());
		}
		else {
			return std::wstring(L"");
		}

	}
	catch (const std::exception&) {
		return std::wstring(L"");
	}
}

////// Legacy
std::vector<std::wstring> Legacy_GetWotPaths() {
	std::vector<std::wstring> paths;

	std::vector<std::wstring> keys = {
		L"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812ru}_is1",
		L"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812ru}_is1",
		L"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812eu}_is1",
		L"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812eu}_is1",
		L"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812na}_is1",
		L"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812na}_is1",
		L"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812asia}_is1",
		L"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812asia}_is1",
		L"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812kr}_is1",
		L"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812kr}_is1",
		L"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812ct}_is1",
		L"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812ct}_is1" };

	for (auto& p : keys)
	{
		std::wstring path = getRegistryValue(p.c_str(), L"InstallLocation");
		if (!path.empty() && exists(path + L"\\WorldOfTanks.exe"))
		{
			paths.push_back(path);
		}
	}

	removeDuplicates(paths);
	return paths;
}

////// Do Work
void DoWork()
{
	//fill WGC
	std::wstring wgcPath = WGC_GetWGCInstallPath();
	if (wgcPath != L"")
	{
		std::wstring preferredPath = WGC_GetWotPreferedPath();
		if (preferredPath != L"")
		{
			g_paths.push_back(preferredPath);
		}

		std::vector<std::wstring> wotPaths = WGC_GetWotPaths();
		for (auto path : wotPaths)
		{
			if (std::find(g_paths.begin(), g_paths.end(), path) == g_paths.end())
			{
				g_paths.push_back(path);
			}
		}
	}

	//fill legacy
	std::vector<std::wstring> legacyPaths = Legacy_GetWotPaths();
	for (auto path : legacyPaths)
	{
		if (std::find(g_paths.begin(), g_paths.end(), path) == g_paths.end())
		{
			g_paths.push_back(path);
		}
	}

	g_initialized = true;
}


////// API
extern "C" void __cdecl GetWotPreferredW(wchar_t *buffer, int size)
{
	if (!g_initialized)
	{
		DoWork();
	}

	if (g_paths.size() > 0)
	{
		wcscpy_s(buffer, size, g_paths[0].c_str());
	}
	else
	{
		buffer[0] = '\0';
	}
}

extern "C" void __cdecl GetWotPreferredA(char *buffer, int size)
{
	wchar_t* wbuffer = (wchar_t*)malloc(size * sizeof(wchar_t));
	GetWotPreferredW(wbuffer, size);

	WideCharToMultiByte(
		CP_ACP,
		0,
		wbuffer,
		size * sizeof(wchar_t),
		buffer,
		size * sizeof(char),
		NULL,
		NULL);

	free(wbuffer);
}

extern "C" int  __cdecl GetWotPathsCount()
{
	if (!g_initialized)
	{
		DoWork();
	}
	return g_paths.size();
}

extern "C" void __cdecl GetWotPathsItemW(wchar_t *buffer, int size, int index)
{
	if (!g_initialized)
	{
		DoWork();
	}
	
	if (g_paths.size() > 0)
	{
		wcscpy_s(buffer, size, g_paths[index].c_str());
	}
	else
	{
		buffer[0] = '\0';
	}
}

extern "C" void __cdecl GetWotPathsItemA(char *buffer, int size, int index)
{
	wchar_t* wbuffer = (wchar_t*)malloc(size * sizeof(wchar_t));
	GetWotPathsItemW(wbuffer, size,index);

	WideCharToMultiByte(
		CP_ACP,
		0,
		wbuffer,
		size * sizeof(wchar_t),
		buffer,
		size * sizeof(char),
		NULL,
		NULL);

	free(wbuffer);
}

extern "C" BOOLEAN WINAPI DllMain(IN HINSTANCE hDllHandle, IN DWORD nReason, IN LPVOID Reserved)
{
	return TRUE;
}
