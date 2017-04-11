#include <iostream>
#include <io.h>
#include <fcntl.h>

#include "findwot.h"

int main()
{
	_setmode(_fileno(stdout), _O_U16TEXT);

	//WGC
	std::wcout << L"WGC: " << std::endl;
	std::wstring wgcpath = WGC_GetWGCInstallPath();
	if (wgcpath != L"")
	{
		std::wcout << L"    Installed      : True" << std::endl<<std::endl;
		std::wcout << L"    Path           : " << wgcpath << std::endl<<std::endl;
		std::wcout << L"    Installed games: ";
		
		std::vector<std::wstring> games = WGC_GetWotPaths();
		for (auto game : games)
		{
			std::wcout << game << std::endl << L"                     ";
		}
		std::wcout << L"\r"<<std::endl;

		std::wcout << L"    Preferred game : " << WGC_GetWotPreferedPath()<<std::endl;
	}
	else
	{
		std::wcout << L"    Installed: False" << std::endl;
	}

	//Legacy
	std::wcout << std::endl<<std::endl<< L"Legacy: " << std::endl;
	std::vector<std::wstring> paths = Legacy_GetWotPaths();
	std::wcout << L"    Installed games: ";
	for (auto path : paths)
	{
		std::wcout << path << std::endl << L"                     ";
	}
	std::wcout << std::endl;
	
	//Result
	std::wcout << std::endl << L"Result(W): "<<std::endl;
	int count = GetWotPathsCount();
	wchar_t path[260]{ 0 };
	if (count > 0)
	{
		for (int i = 0; i < count; i++)
		{
			GetWotPathsItemW(&path[0], 260, i);
			std::wcout << L"    " << i+1 << L": " << path << std::endl;
		}
	}

	//Result
	std::wcout << std::endl << L"Result(A): " << std::endl;
	char pathA[260]{ 0 };
	if (count > 0)
	{
		for (int i = 0; i < count; i++)
		{
			GetWotPathsItemA(&pathA[0], 260, i);
			std::wcout << L"    " << i + 1 << L": " << pathA << std::endl;
		}
	}

	std::wcout<<std::endl << L"Press any key..." << std::endl;
	std::wcin.get();
}