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

#include "fileWatcher.h"
#include "threadHelper.h"

#include <Windows.h>

#include "Python.h"

FileWatcher::FileWatcher(std::string ID, std::wstring Directory, std::string PythonCommand, bool StopWatcherAfterEvent)
{
    this->ID = ID;
    this->Directory = Directory;
    this->PythonCommand = PythonCommand;
    this->StopWatcherAfterEvent = StopWatcherAfterEvent;

    this->isRunning = false;

    Handles[1] = CreateEvent(NULL, FALSE, FALSE, NULL);
}

bool FileWatcher::IsRunning()
{
    return isRunning;
}

FileWatcher::~FileWatcher()
{
    StopWatch();
    CloseHandle(Handles[1]);
}

void FileWatcher::StartWatch()
{
    if (isRunning)
    {
        return;
    }

    if (Thread.joinable())
    {
        Thread.join();
    }

    Thread = std::thread([=] {WorkingThread(); });
    SetThreadName(&(this->Thread), "xfw-filewatcher-" + std::string(ID));
}

void FileWatcher::StopWatch()
{
    if (!isRunning)
    {
        return;
    }

    SetEvent(Handles[1]);
    Thread.join();
    ResetEvent(Handles[1]);
}

bool FileWatcher::PrepareFileHandle()
{
    if (Handles[0] != NULL)
    {
        return false;
    }

    Handles[0] = FindFirstChangeNotificationW(
        Directory.c_str(),
        true,
        FILE_NOTIFY_CHANGE_FILE_NAME | FILE_NOTIFY_CHANGE_LAST_WRITE);

    if ((Handles[0] == INVALID_HANDLE_VALUE) || (Handles[0] == NULL))
    {
        return false;
    }

    return true;
}

bool FileWatcher::CloseFileHandle()
{
    if (Handles[0] == NULL)
    {
        return false;
    }

    FindCloseChangeNotification(Handles[0]);
    Handles[0] = NULL;
}

void FileWatcher::WorkingThread()
{
    isRunning = true;

    DWORD dwWaitStatus;

    if (!PrepareFileHandle())
    {
        isRunning = false;
        return;
    }

    while (true)
    {
        dwWaitStatus = WaitForMultipleObjects(2, Handles, FALSE, INFINITE);

        switch (dwWaitStatus)
        {
        case WAIT_OBJECT_0 + 0:
            CloseFileHandle();

            PyGILState_STATE gstate;
            gstate = PyGILState_Ensure();
            PyRun_SimpleStringFlags(PythonCommand.c_str(), 0);
            PyGILState_Release(gstate);

            if (StopWatcherAfterEvent)
            {
                isRunning = false;
                return;
            }

            PrepareFileHandle();
            break;

        case WAIT_OBJECT_0 + 1:
            CloseFileHandle();
            isRunning = false;
            return;
            break;

        default:
            break;
        }
    }
}
