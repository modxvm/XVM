/*
 * This file is part of the Findwot project.
 *
 * Copyright (c) 2016-2020 Findwot contributors.
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
#include <vector>

class WGC {
public:
    static std::wstring GetWGCInstallPath();
    static std::vector<std::wstring> GetWotPaths();
    static std::wstring GetWotPreferedPath();
};
