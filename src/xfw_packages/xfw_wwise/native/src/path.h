/**
 * This file is part of the XVM Framework project.
 * Copyright (c) 2016-2020 XVM Team.
 *
 * XVM Framework is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, version 3.
 *
 * XVM Framework is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#pragma once

#include <Windows.h>
#include <string>

#undef CreateDirectory
#undef DeleteFile
#undef CopyFile

class Path {
public:
    static std::wstring GetRoot(const std::wstring &path);
    static std::wstring GetAbsolute(const std::wstring &path);
    static std::wstring GetFilename(const std::wstring &path);

    static bool AreEqual(const std::wstring &path_one, const std::wstring &path_two);
    static bool FileExists(const std::wstring &path);
    static bool DirectoryExists(const std::wstring &path);
    static bool OnNTFS(const std::wstring &path);
    static bool CreateDirectory(const std::wstring &path);
    static bool DeleteFile(const std::wstring &path);
    static bool CopyFile(const std::wstring &path_from, const std::wstring &path_to);
    static bool CreateHardlink(const std::wstring &path_from, const std::wstring &path_to);
};