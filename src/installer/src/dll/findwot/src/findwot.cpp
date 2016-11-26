#include <iostream>
#include <fstream>
#include <filesystem>
#include <vector>

#include <Windows.h>
#include <Shlobj.h>

#include "rapidxml.hpp"

using namespace rapidxml;
using namespace std::experimental::filesystem::v1;

std::string getRegistryValue(const char* subkey, const char* value)
{
	HKEY hKey = 0;
	char val[1024] { 0 };
	DWORD value_length = 1024;
	
	if (RegOpenKey(HKEY_CURRENT_USER, subkey, &hKey) != ERROR_SUCCESS)
	{
		if(RegOpenKey(HKEY_LOCAL_MACHINE, subkey, &hKey) != ERROR_SUCCESS)
		{
			return std::string();
		}
	}

	if (RegQueryValueEx(hKey, value, nullptr, nullptr, (LPBYTE)&val, &value_length) != ERROR_SUCCESS)
	{
		return std::string();
	}

	return std::string(val);
}

std::string getFileContent(std::string filepath)
{
	std::string content;
	
	std::ifstream in(filepath, std::ifstream::in);
	if (!in.is_open())
	{
		return nullptr;
	}
	
	content.assign((std::istreambuf_iterator<char>(in)), (std::istreambuf_iterator<char>()));
	in.close();

	return content;
}

void FindWot_WGC(char* buffer, size_t size)
{
	//try to get ProgramData path
	TCHAR szPath[MAX_PATH];
	if (!SUCCEEDED(SHGetFolderPath(NULL, CSIDL_COMMON_APPDATA , NULL, 0, szPath)))
	{
		return;
	}
	
	//1. open first file from ProgramData\Wargaming.Net\GameCenter\apps\wot and write it's value
	try
	{
		for (auto& p : directory_iterator(std::string(szPath) + "\\Wargaming.net\\GameCenter\\apps\\wot\\"))
		{
			strcpy_s(buffer, size, getFileContent(p.path().string()).c_str());
		}
	}
	catch (const std::exception&) {}

	//2. read preferences.xml and get selected WoT version
	std::string preferences(std::string(szPath) + "\\Wargaming.net\\GameCenter\\preferences.xml");
	if (!exists(preferences))
	{
		return;
	}
	std::string content = getFileContent(preferences);
	xml_document<> doc;
	doc.parse<0>((char*)content.c_str());
	
	//try to get preferences.xml->protocol->application->games_manager->selectedGames->WOT
	try 
	{
		xml_node<> *protocol = doc.first_node("protocol");
		if (protocol == nullptr)
			return;

		xml_node<> *application = protocol->first_node("application");
		if (application == nullptr)
			return;

		xml_node<> *gamemanager = application->first_node("games_manager");
		if (gamemanager == nullptr)
			return;

		xml_node<> *selectedgames= gamemanager->first_node("selectedGames");
		if (selectedgames == nullptr)
			return;

		xml_node<> *target=selectedgames->first_node("WOT");
		if (target == nullptr)
		{
			return;
		}
		strcpy_s(buffer, size, target->value());
	}
	catch (const std::exception&){}

}

void FindWot_Legacy(char* buffer, size_t size) {
	std::vector<std::string> keys = {
		"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812ru}_is1",
		"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812ru}_is1",
		"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812eu}_is1",
		"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812eu}_is1",
		"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812na}_is1",
		"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812na}_is1",
		"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812asia}_is1",
		"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812asia}_is1",
		"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812kr}_is1",
		"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812kr}_is1",
		"SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812ct}_is1",
		"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\{1EAC1D02-C6AC-4FA6-9A44-96258C37C812ct}_is1" };

	for (auto& p : keys)
	{
		std::string path = getRegistryValue(p.c_str(), "InstallLocation");
		if (!path.empty())
		{
			strcpy_s(buffer, size, path.c_str());
			return;
		}
	}
}

void FindWotA_CPP(char * buffer, DWORD size)
{
	if (strcmp(buffer, "") == 0)
	{
		FindWot_WGC(buffer, size);
	}

	if (strcmp(buffer, "") == 0)
	{
		FindWot_Legacy(buffer, size);
	}

	if (strcmp(buffer, "") == 0)
	{
		strcpy_s(buffer, size, "C:\\Games\\World_of_Tanks");
	}
}

extern "C" _declspec(dllexport) void __cdecl FindWotA(char *buffer, DWORD size)
{
	FindWotA_CPP(buffer, size);
}

extern "C" _declspec(dllexport) BOOLEAN WINAPI DllMain(IN HINSTANCE hDllHandle, IN DWORD nReason, IN LPVOID Reserved)
{
	return TRUE;
}