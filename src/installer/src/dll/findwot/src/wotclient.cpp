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

#include "wotclient.h"

#include "filesystem.h"
#include "string.h"

#include <filesystem>

using namespace std::experimental::filesystem::v1;

#include "rapidxml.hpp"
using namespace rapidxml;


bool WotClient::IsValid()
{
    return isValid;
}

////////CTOR
WotClient::WotClient()
{
}

WotClient::WotClient(const std::wstring& wotDirectory)
{
    SetPath(wotDirectory);
}


////GET/SET
std::wstring WotClient::GetPath()
{
    return path;
}

void WotClient::SetPath(const std::wstring& path)
{
    this->path = path;
    updateData();
}

ClientBranch WotClient::GetClientBranch()
{
    return clientBranch;
}

std::wstring WotClient::GetClientExeVersion()
{
    return this->exeVersion;
}

std::wstring WotClient::GetClientVersion()
{
    return clientVersion;
}

std::wstring WotClient::GetClientLocale()
{
    return clientLocale;
}

ClientType WotClient::GetClientType()
{
    return clientType;
}

////////
void WotClient::updateData()
{
    clear();

    if (!exists(path + L"\\WorldOfTanks.exe"))
    {
        return;
    }

    exeVersion = Filesystem::GetExeVersion(path + L"\\WorldOfTanks.exe");

    if (!updateData_versionxml())
    {
        return;
    }

    if (!updateData_apptype())
    {
        return;
    }

    isValid = true;
}

bool WotClient::updateData_apptype()
{
    std::wstring apptypexml(path + L"app_type.xml");
    if (!exists(apptypexml))
        return false;

    std::wstring content = Filesystem::GetFileContent(apptypexml);
    xml_document<wchar_t> apptypedoc;
    apptypedoc.parse<0>(_wcsdup(content.c_str()));
    try
    {
        xml_node<wchar_t> *node_root = apptypedoc.first_node(L"protocol");
        if (node_root == nullptr)
            return false;

        //get version
        xml_node<wchar_t> *node_apptype = node_root->first_node(L"app_type");
        if (node_apptype == nullptr)
            return false;

        std::wstring apptype(node_apptype->value());
        if (apptype == L"sd")
        {
            this->clientType = ClientType::WoTType_SD;
        }
        else if (apptype == L"hd")
        {
            this->clientType = ClientType::WoTType_HD;
        }
    }
    catch (const std::exception&)
    {
        return false;
    }

    return true;
}

bool WotClient::updateData_versionxml()
{
    std::wstring versionxml(path + L"version.xml");
    if (!exists(versionxml))
        return false;

    std::wstring content = Filesystem::GetFileContent(versionxml);
    xml_document<wchar_t> versiondoc;
    versiondoc.parse<0>(_wcsdup(content.c_str()));
    try
    {
        xml_node<wchar_t> *node_root = versiondoc.first_node(L"version.xml");
        if (node_root == nullptr)
            return false;

        //get version
        xml_node<wchar_t> *node_version = node_root->first_node(L"version");
        if (node_version == nullptr)
            return false;

        std::wstring clientver = node_version->value();
        clientver.replace(clientver.find(L" v."), std::wstring(L" v.").length(), L"");
        clientVersion = clientver.substr(0, clientver.find(L' '));
        std::wstring type = clientver.substr(clientver.find(L' ') + 1);
        type = type.substr(0, type.find(L'#'));
        type = String::Trim(type);

        if (type.empty())
        {
            this->clientBranch = ClientBranch::WoT_Release;
        }
        else if (type == "Common Test")
        {
            this->clientBranch = ClientBranch::WoT_CommonTest;
        }
        else if (type == "ST")
        {
            this->clientBranch = ClientBranch::WoT_SuperTest;
        }
        else if (type == "SB")
        {
            this->clientBranch = ClientBranch::WoT_Sandbox;
        }
        else
        {
            this->clientBranch = ClientBranch::WoT_Unknown;
        }

        //get locale
        xml_node<wchar_t> *node_meta = node_root->first_node(L"meta");
        if (node_meta == nullptr)
            return false;

        xml_node<wchar_t> *node_localization = node_meta->first_node(L"localization");
        if (node_localization == nullptr)
            return false;

        std::wstring locale(node_localization->value());
        clientLocale = locale.substr(locale.find(L' ') + 1);
    }
    catch (const std::exception&)
    {
        return false;
    }

    return true;
}

void WotClient::clear()
{
    isValid = false;
    clientBranch = ClientBranch::WoT_Unknown;
    exeVersion.clear();
    clientVersion.clear();
}
