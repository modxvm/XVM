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

#include "string.h"

#include <algorithm>
#include <locale>

std::wstring & String::Trim(std::wstring & str)
{
    return LTrim(RTrim(str));
}

std::wstring & String::LTrim(std::wstring & str)
{
    auto it2 = std::find_if(str.begin(), str.end(), [](wchar_t ch) { return !std::isspace<wchar_t>(ch, std::locale::classic()); });
    str.erase(str.begin(), it2);
    return str;
}

std::wstring & String::RTrim(std::wstring & str)
{
    auto it1 = std::find_if(str.rbegin(), str.rend(), [](wchar_t ch) { return !std::isspace<wchar_t>(ch, std::locale::classic()); });
    str.erase(it1.base(), str.end());
    return str;
}