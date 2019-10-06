/**
 * This file is part of the XVM Framework project.
 * Copyright (c) 2016-2019 XVM Team.
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

#include "path.h"

#include <Shlwapi.h>

std::wstring Path::GetRoot(const std::wstring &path)
{
	std::wstring::size_type pos = path.find('\\');
	if (pos != std::wstring::npos)
		return path.substr(0, pos + 1);
	else
		return path;
}

std::wstring Path::GetAbsolute(const std::wstring &path)
{
	wchar_t absolute_path[32767] = { 0 };
	GetFullPathNameW(path.c_str(), MAX_PATH, absolute_path, NULL);
	return std::wstring(absolute_path);
}

std::wstring Path::GetFilename(const std::wstring &path)
{
	return std::wstring(PathFindFileNameW(path.c_str()));
}

bool Path::FileExists(const std::wstring &path)
{
	DWORD dwAttrib = GetFileAttributesW(path.c_str());

	return (dwAttrib != INVALID_FILE_ATTRIBUTES &&
		!(dwAttrib & FILE_ATTRIBUTE_DIRECTORY));
}

bool Path::DirectoryExists(const std::wstring &path)
{
	DWORD dwAttrib = GetFileAttributesW(path.c_str());

	return (dwAttrib != INVALID_FILE_ATTRIBUTES &&
		(dwAttrib & FILE_ATTRIBUTE_DIRECTORY));
}

bool Path::OnNTFS(const std::wstring &path)
{
	wchar_t fs[10] = { 0 };

	GetVolumeInformationW(Path::GetRoot(path).c_str(), NULL, NULL, NULL, NULL, NULL, fs, sizeof(fs));
	if (wcsncmp(fs, L"NTFS", 4) == 0)
		return true;

	return false;
}

bool Path::CreateDirectory(const std::wstring &path)
{
	return (CreateDirectoryW(path.c_str(), NULL)!=FALSE);
}

bool Path::DeleteFile(const std::wstring &path)
{
	return (DeleteFileW(path.c_str())!=FALSE);
}

bool Path::CopyFile(const std::wstring &path_from, const std::wstring &path_to)
{
	return (CopyFileW(path_from.c_str(), path_to.c_str(), FALSE)!=FALSE);
}

bool Path::CreateHardlink(const std::wstring &path_from, const std::wstring &path_to)
{
	if (!(
			(GetDriveTypeW(Path::GetRoot(path_from).c_str()) < 4) &&
			(GetDriveTypeW(Path::GetRoot(path_to).c_str()) < 4) &&
			Path::OnNTFS(path_from) &&
			Path::OnNTFS(path_to)
		))
	{
		return false;
	}

	return (CreateHardLinkW(path_to.c_str(), path_from.c_str(), NULL)!=FALSE);
}

bool Path::AreEqual(const std::wstring &path_one, const std::wstring &path_two)
{
	WIN32_FILE_ATTRIBUTE_DATA fileInfo_one;
	WIN32_FILE_ATTRIBUTE_DATA fileInfo_two;

	if (!GetFileAttributesExW(path_one.c_str(), GetFileExInfoStandard, (void*)&fileInfo_one) ||
		!GetFileAttributesExW(path_two.c_str(), GetFileExInfoStandard, (void*)&fileInfo_two))
	{
		return false;
	}

	//size
	if ((fileInfo_one.nFileSizeHigh != fileInfo_two.nFileSizeHigh) ||
		(fileInfo_one.nFileSizeLow != fileInfo_two.nFileSizeLow))
	{
		return false;
	}

	//last writing time
	if (CompareFileTime(&(fileInfo_one.ftLastWriteTime), &(fileInfo_two.ftLastWriteTime)) != 0)
	{
		return false;
	}

	return true;
}