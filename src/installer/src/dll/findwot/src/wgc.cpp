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

#include "wgc.h"
#include "filesystem.h"

#include <filesystem>

#include "rapidxml\rapidxml.hpp"

using namespace rapidxml;
using namespace std::experimental::filesystem::v1;

std::wstring WGC::GetWGCInstallPath()
{
    std::wstring programDataPath = Filesystem::GetProgramDataPath();

    std::wstring wgcPathFile(programDataPath + L"\\Wargaming.net\\GameCenter\\data\\wgc_path.dat");
    if (exists(wgcPathFile))
    {
        std::wstring path = Filesystem::GetFileContent(wgcPathFile);
        if (exists(path + L"\\wgc.exe"))
        {
            return path;
        }
    }
    else if (exists(programDataPath + L"\\Wargaming.net\\GameCenter\\wgc.exe"))
    {
        return programDataPath + L"\\Wargaming.net\\GameCenter";
    }

    return std::wstring();
}


std::vector<std::wstring> WGC::GetWotPaths()
{
    std::wstring programDataPath = Filesystem::GetProgramDataPath();

    std::vector<std::wstring> wotPaths;

    try
    {
        for (auto& p : directory_iterator(programDataPath + L"\\Wargaming.net\\GameCenter\\apps\\wot\\"))
        {
            std::wstring path = Filesystem::GetFileContent(p.path().wstring());

            if (exists(path + L"\\WorldOfTanks.exe"))
            {
                wotPaths.push_back(path);
            }
        }
    }
    catch (const std::exception&) {}

    return wotPaths;
}


std::wstring WGC::GetWotPreferedPath()
{
    std::wstring wgcPath = GetWGCInstallPath();

    std::wstring preferences(wgcPath + L"\\preferences.xml");
    if (!exists(preferences))
        return std::wstring();

    std::wstring content = Filesystem::GetFileContent(preferences);
    xml_document<wchar_t> doc;
    doc.parse<0>(_wcsdup(content.c_str()));

    //try to get preferences.xml->protocol->application->games_manager->selectedGames->WOT
    try
    {
        xml_node<wchar_t> *protocol = doc.first_node(L"protocol");
        if (protocol == nullptr)
            return std::wstring();

        xml_node<wchar_t> *application = protocol->first_node(L"application");
        if (application == nullptr)
            return std::wstring();

        xml_node<wchar_t> *gamemanager = application->first_node(L"games_manager");
        if (gamemanager == nullptr)
            return std::wstring();

        xml_node<wchar_t> *selectedgames = gamemanager->first_node(L"selectedGames");
        if (selectedgames == nullptr)
            return std::wstring();

        xml_node<wchar_t> *target = selectedgames->first_node(L"WOT");
        if (target == nullptr)
            return std::wstring();

        if (exists(std::wstring(target->value()) + L"\\WorldOfTanks.exe"))
        {
            return std::wstring(target->value());
        }
        else {
            return std::wstring();
        }

    }
    catch (const std::exception&) {
        return std::wstring();
    }
}
