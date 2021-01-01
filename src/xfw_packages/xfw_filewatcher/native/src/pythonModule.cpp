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

#include <map>
#include <string>
#include <thread>

#include "Python.h"
#include "Windows.h"

#include "threadHelper.h"
#include "fileWatcher.h"

std::map<std::string, FileWatcher*> watcherList;


static char python_watcher_is_exists_docstring[] = "Checks if watcher exists"
""
"usage: watcher_is_exists(<watcher_id>)"
"  watcher_id : watcher ID"
""
"returns: True/False"
""
"examples:"
"  watcher_is_exists(\"XVM_CONFIG\")";
static PyObject* python_watcher_is_exists(PyObject* self, PyObject* args)
{
    char* watcherID;

    //check input value
    if (!PyArg_ParseTuple(args, "s", &watcherID))
    {
        return NULL;
    }

    if (watcherList.count(std::string(watcherID)))
    {
        Py_RETURN_TRUE;
    }
    else
    {
        Py_RETURN_FALSE;
    }
}


static char python_watcher_is_running_docstring[] = "Checks if watcher is running"
""
"usage: watcher_is_running(<watcher_id>)"
"  watcher_id : watcher ID"
""
"returns: True/False"
""
"examples:"
"  watcher_is_running(\"XVM_CONFIG\")";
static PyObject* python_watcher_is_running(PyObject* self, PyObject* args)
{
    char* watcherID;

    //check input value
    if (!PyArg_ParseTuple(args, "s", &watcherID))
    {
        return NULL;
    }

    if (!watcherList.count(std::string(watcherID)))
    {
        Py_RETURN_FALSE;
    }

    if (watcherList.at(std::string(watcherID))->IsRunning())
    {
        Py_RETURN_TRUE;
    }
    else
    {
        Py_RETURN_FALSE;
    }
}


static char python_watcher_add_docstring[] = "Starts new directory watcher"
""
"usage: watcher_add(<watcher_id>, <directory_path>, <event_call_text>)"
"  watcher_id      : watcher ID"
"  directory_path  : unicode string with directory path"
"  event_call_text : g_eventBus.handeEvent() function argument"
"  stop_after_event: stop watcher after event occured, True/False"
""
"returns: None"
""
"examples:"
"  watcher_add(\"XVM_CONFIG\", u\"config/default\", \"events.HasCtxEvent(XVM_EVENT.RELOAD_CONFIG, {'filename':XVM.CONFIG_FILE})\")";
static PyObject* python_watcher_add(PyObject* self, PyObject* args)
{
    char*    watcherID;
    wchar_t* directory;
    char*    eventCallText;
    int      stopWatcherAfterEvent;

    //check input value
    if (!PyArg_ParseTuple(args, "susi", &watcherID, &directory, &eventCallText, &stopWatcherAfterEvent))
    {
        return NULL;
    }

    if (watcherList.count(std::string(watcherID)))
    {
        PyErr_SetString(PyExc_RuntimeError, "watcher is already exists");
        return NULL;
    }

    watcherList.insert({
        std::string(watcherID),
        new FileWatcher(std::string(watcherID), std::wstring(directory),
            std::string(eventCallText), static_cast<bool>(stopWatcherAfterEvent))
    });

    Py_RETURN_NONE;
}


static char python_watcher_delete_docstring[] = "Deletes directory watcher"
""
"usage: watcher_delete(<watcher_id>)"
"  watcher_id : watcher ID"
""
"returns: None"
""
"examples:"
"  watcher_delete(\"XVM_CONFIG\")";
static PyObject* python_watcher_delete(PyObject* self, PyObject* args)
{
    char* watcherID;

    if (!PyArg_ParseTuple(args, "s", &watcherID))
    {
        return NULL;
    }

    if (watcherList.count(std::string(watcherID)))
    {
        delete watcherList[std::string(watcherID)];
        watcherList.erase(std::string(watcherID));
    }

    Py_RETURN_NONE;
}

static char python_watcher_delete_all_docstring[] = "Deletes all directory watchers"
""
"usage   : watcher_delete_all()"
""
"returns : None"
""
"examples:"
"  watcher_delete_all()";
static PyObject* python_watcher_delete_all(PyObject* self, PyObject* args)
{
    for (auto& item : watcherList)
    {
        delete item.second;
        watcherList.erase(item.first);
    }

    Py_RETURN_NONE;
}


static char python_watcher_start_docstring[] = "Starts directory watcher"
""
"usage: watcher_start(<watcher_id>)"
"  watcher_id : watcher ID"
""
"returns:"
"  True : watcher found and started"
"  False: watcher not found"
""
"examples:"
"  watcher_start(\"XVM_CONFIG\")";
static PyObject* python_watcher_start(PyObject* self, PyObject* args)
{
    char* watcherID;

    if (!PyArg_ParseTuple(args, "s", &watcherID))
    {
        return NULL;
    }

    if (watcherList.count(std::string(watcherID)))
    {
        watcherList[std::string(watcherID)]->StartWatch();
        Py_RETURN_TRUE;
    }

    Py_RETURN_FALSE;
}


static char python_watcher_start_all_docstring[] = "Starts all directory watchers"
""
"usage   : watcher_start_all()"
""
"returns : None"
""
"examples:"
"  watcher_start_all()";
static PyObject* python_watcher_start_all(PyObject* self, PyObject* args)
{
    for (auto& item : watcherList)
    {
        item.second->StartWatch();
    }

    Py_RETURN_NONE;
}

static char python_watcher_stop_docstring[] = "Stops directory watcher"
""
"usage: watcher_stop(<watcher_id>)"
"  watcher_id : watcher ID"
""
"returns:"
"  True : watcher found and stopped"
"  False: watcher not found"
""
"examples:"
"  watcher_stop(\"XVM_CONFIG\")";
static PyObject* python_watcher_stop(PyObject* self, PyObject* args)
{
    char* watcherID;

    if (!PyArg_ParseTuple(args, "s", &watcherID))
    {
        return NULL;
    }

    if (watcherList.count(std::string(watcherID)))
    {
        watcherList[std::string(watcherID)]->StopWatch();
        Py_RETURN_TRUE;
    }

    Py_RETURN_FALSE;
}

static char python_watcher_stop_all_docstring[] = "Stops all directory watchers"
""
"usage   : watcher_stop_all()"
""
"returns : None"
""
"examples:"
"  watcher_stop_all()";
static PyObject* python_watcher_stop_all(PyObject* self, PyObject* args)
{
    for (auto& item : watcherList)
    {
        item.second->StopWatch();
    }

    Py_RETURN_NONE;
}


static PyMethodDef XFW_FileWatcherMethods[] = {
    { "watcher_is_exists"  , python_watcher_is_exists , METH_VARARGS, python_watcher_is_exists_docstring  },
    { "watcher_is_running" , python_watcher_is_running, METH_VARARGS, python_watcher_is_running_docstring },

    { "watcher_add"        , python_watcher_add       , METH_VARARGS, python_watcher_add_docstring        },

    { "watcher_delete"     , python_watcher_delete    , METH_VARARGS, python_watcher_delete_docstring     },
    { "watcher_delete_all" , python_watcher_delete_all, METH_VARARGS, python_watcher_delete_all_docstring },

    { "watcher_start"      , python_watcher_start     , METH_VARARGS, python_watcher_start_docstring      },
    { "watcher_start_all"  , python_watcher_start_all , METH_VARARGS, python_watcher_start_all_docstring  },

    { "watcher_stop"       , python_watcher_stop      , METH_VARARGS, python_watcher_stop_docstring       },
    { "watcher_stopall"    , python_watcher_stop_all  , METH_VARARGS, python_watcher_stop_all_docstring   },
    { NULL, NULL, 0, NULL}
};


PyMODINIT_FUNC initXFW_FileWatcher(void)
{
    Py_InitModule("XFW_FileWatcher", XFW_FileWatcherMethods);
}
