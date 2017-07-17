/*
 * This file is part of the Findwot project.
 *
 * Copyright (c) 2016-2017 Findwot contributors.
 *
 * Findwot is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, version 3.
 *
 * Findwot is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
 
#include "wotdetector.h"

#include "filesystem.h"
#include "wgc.h"
#include "wotlauncher.h"

#include <algorithm>
#include <filesystem>
using namespace std::experimental::filesystem::v1;

bool WotDetector::isInitialized = false;
std::vector<WotClient> WotDetector::clients;

void WotDetector::FindClients()
{
	std::vector<std::wstring> paths;

	//1.wgc
	std::wstring wgcPath = WGC::GetWGCInstallPath();
	if (!wgcPath.empty())
	{
		std::wstring preferredPath = WGC::GetWotPreferedPath();
		if (!preferredPath.empty())
		{
			paths.push_back(preferredPath);
		}

		std::vector<std::wstring> wotPaths = WGC::GetWotPaths();
		for (auto path : wotPaths)
		{
			if (std::find(paths.begin(), paths.end(), path) == paths.end())
			{
				paths.push_back(path);
			}
		}
	}

	//2. legacy
	std::vector<std::wstring> legacyPaths = WotLauncher::GetWotPaths();
	for (auto path : legacyPaths)
	{
		if (std::find(paths.begin(), paths.end(), path) == paths.end())
		{
			paths.push_back(path);
		}
	}

	//3. DRIVE:\Games\World_of_Tanks*
	std::vector<std::wstring> drives = Filesystem::GetLogicalDrives();
	std::vector<directory_entry> dir_entries;
    std::vector<std::wstring> pathes{L"", L"Games\\", L"Games\\Wargaming.net\\" , L"Powder\\"};

    for (auto& drive : drives)
    {
        for (auto& path : pathes)
        {
            for (auto& p : directory_iterator(drive + path))
            {
                dir_entries.push_back(p);
            }
        }
    }

	for (auto&p : dir_entries)
	{
		if (!is_directory(p))
		{
			continue;
		}

		std::wstring path = p.path().wstring();
		std::transform(path.begin(), path.end(), path.begin(), ::tolower);

		if ((path.find(L"world_of_tanks") != std::wstring::npos) || (path.find(L"wot") != std::wstring::npos))
		{
			if (std::find(paths.begin(), paths.end(), p.path().wstring()) == paths.end())
			{
				paths.push_back(p.path().wstring());
			}
		}
	}

	for (auto& path : paths)
	{
		WotDetector::AddClient(path);
	}

	WotDetector::isInitialized = true;
}

int WotDetector::AddClient(std::wstring directory)
{
	if (directory.back() != *L"\\")
	{
		directory.append(L"\\");
	}

	auto exists = [&](const std::wstring &s) {
		return std::find_if(
			begin(WotDetector::clients), 
			end(WotDetector::clients), 
			[&](WotClient &f) { 
				std::wstring path_1 = f.GetPath();
				std::transform(path_1.begin(), path_1.end(), path_1.begin(), ::tolower);

				std::wstring path_2 = s;
				std::transform(path_2.begin(), path_2.end(), path_2.begin(), ::tolower);

				return path_1 == path_2; 
			});
	};

	auto dir_it = exists(directory);
	if (dir_it!=WotDetector::clients.end())
	{
		return std::distance(WotDetector::clients.begin(), dir_it);
	}

	WotClient client(directory);
	if (client.IsValid())
	{
		WotDetector::clients.push_back(client);
		return WotDetector::clients.size() - 1;
	}
	else
	{
		return -1;
	}
}

bool WotDetector::IsInitialized()
{
	return isInitialized;
}
