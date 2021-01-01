/*
 * This file is part of the Findwot project.
 *
 * Copyright (c) 2016-2021 Findwot contributors.
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
#include "wine.h"
#include "wotlauncher.h"

#include <algorithm>
#include <filesystem>

#include <Windows.h>
#include <iostream>

using namespace std::experimental::filesystem::v1;

bool WotDetector::isInitialized = false;
std::vector<WotClient> WotDetector::clients;

void WotDetector::FindClients()
{
    // WGC
    std::wstring wgcPath = WGC::GetWGCInstallPath();
    if (!wgcPath.empty())
    {
        WotDetector::AddClient(WGC::GetWotPreferedPath());

        for (auto& path: WGC::GetWotPaths())
            WotDetector::AddClient(path);
    }

    // Legacy
    for (auto& path : WotLauncher::GetWotPaths())
        WotDetector::AddClient(path);

    // DRIVE:\Games\World_of_Tanks*
    std::vector<std::wstring> pathes{L"", L"Games\\", L"Games\\Wargaming.net\\"};

    std::vector<std::wstring> drives = Filesystem::GetLogicalDrives();

    // Non-windows additions
    WineStatus wine_status = Wine::GetStatus();
    if(wine_status.running_on)
    {
        wchar_t* buf = new wchar_t[256];
        GetEnvironmentVariableW(L"USERNAME", buf, 256);

        if (wcscmp(wine_status.system, L"Linux")==0)
        {
            // /media/<USERNAME>/ mounted partitions
            std::wstring linux_mounts(std::wstring(L"Z:\\media\\") + std::wstring(buf) + std::wstring(L"\\"));
            if (exists(linux_mounts))
            {
                for (auto& p : directory_iterator(linux_mounts))
                {
                    if (!is_directory(p))
                        continue;

                    drives.push_back(p.path().wstring()+L"\\");
                }
            }
        }

        if (wcscmp(wine_status.system, L"Darwin")==0)
        {
            // /Volumes/ mounted partitions
            if (exists(L"Z:\\Volumes\\"))
            {
                for (auto& p : directory_iterator(L"Z:\\Volumes\\"))
                {
                    if (!is_directory(p))
                        continue;

                    drives.push_back(p.path().wstring() + L"\\");
                }
            }
        }

        // WoT OSX edition (Wargaming.net wine wrapper)
        std::wstring wot_osx = std::wstring(L"Z:\\Users\\") + std::wstring(buf) + std::wstring(L"\\Library\\Application Support\\World of Tanks\\Bottles\\worldoftanks\\drive_c\\Games\\World_of_Tanks\\");
        if(exists(wot_osx))
            WotDetector::AddClient(wot_osx);

        delete[] buf;
    }

    for (auto& drive : drives)
    {
        for (auto& path : pathes)
        {
            for (auto& p : directory_iterator(drive + path))
            {
                if (!is_directory(p))
                    continue;

                WotDetector::AddClient(p.path().wstring());
            }
        }
    }

    WotDetector::isInitialized = true;
}

int WotDetector::AddClient(std::wstring directory)
{
    if (directory.empty())
        return -1;

    if (directory.back() != *L"\\")
        directory.append(L"\\");

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
        return std::distance(WotDetector::clients.begin(), dir_it);


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
