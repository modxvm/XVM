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

#pragma once

#include <string>

enum ClientBranch
{
    WoT_Unknown,
    WoT_Release,
    WoT_CommonTest,
    WoT_SuperTest,
    WoT_Sandbox,
};

enum ClientType
{
    WoTType_Unknown,
    WoTType_SD,
    WoTType_HD,
};


class WotClient {
private:
    bool isValid = false;

    std::wstring path;

    ClientBranch clientBranch = ClientBranch::WoT_Unknown;
    ClientType clientType = ClientType::WoTType_Unknown;

    std::wstring exeVersion;
    std::wstring clientVersion;

    std::wstring clientLocale;

    void updateData();
    bool updateData_apptype();
    bool updateData_versionxml();
    void clear();

public:
    bool IsValid();

    WotClient();
    WotClient(const std::wstring& wotDirectory);

    std::wstring GetPath();
    void SetPath(const std::wstring& path);

    ClientBranch GetClientBranch();
    std::wstring GetClientExeVersion();
    std::wstring GetClientVersion();
    std::wstring GetClientLocale();
    ClientType GetClientType();

};
