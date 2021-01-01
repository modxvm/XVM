/**
* This file is part of the XVM project.
*
* Copyright (c) 2017-2021 XVM contributors.
*
* This file is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as
* published by the Free Software Foundation, version 3.
*
* This file is distributed in the hope that it will be useful, but
* WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
* Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include <Windows.h>

size_t GetModuleSize(const wchar_t* filename);

BOOL DataCompare(const char* pData, const char* bMask, const char* szMask);

size_t FindFunction(size_t startpos, size_t endpos, const char* pattern, const char* mask);
