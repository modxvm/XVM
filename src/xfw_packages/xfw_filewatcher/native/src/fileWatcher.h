/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2018-2021 XVM Team.
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

#include <string>
#include <thread>

#include <Windows.h>

#define CANCELATION_CHECK_TIME 500

class FileWatcher {

public:
    FileWatcher(std::string ID, std::wstring Directory, std::string PythonCommand, bool StopWatcherAfterEvent);
    ~FileWatcher();

    void StartWatch();
    void StopWatch();

    bool IsRunning();

private:
    std::string  ID;
    std::wstring Directory;
    std::string  PythonCommand;
    bool         StopWatcherAfterEvent;

    std::thread Thread;
    HANDLE Handles[2] {0};

    void WorkingThread();

    bool PrepareFileHandle();
    bool CloseFileHandle();

    bool isRunning;
};