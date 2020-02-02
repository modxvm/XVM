/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2018-2020 XVM Team.
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

#include <Python.h>

#include "common.h"
#include "crashreporter.h"
#include "fix_suef.h"

CrashReporter* crashreporter = nullptr;

//Python API

PyObject* Py_is_platform_supported(PyObject* self, PyObject* args)
{
    if (!crashreporter)
    {
        return nullptr;
    }

    if (!crashreporter->is_platform_supported()) 
    {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}

PyObject* Py_is_initialized(PyObject* self, PyObject* args)
{
    if (!crashreporter)
    {
        return nullptr;
    }

    if (!crashreporter->is_initialized())
    {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}

PyObject* Py_set_release(PyObject* self, PyObject* args)
{
    if (!crashreporter)
    {
        return nullptr;
    }

    char* release_str = nullptr;
    if (!PyArg_ParseTuple(args, "s", &release_str))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_release] Cannot parse tuple (expected s)\n");
        return nullptr;
    }

    if (crashreporter->is_initialized())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_release] CrashRpt is already initialized\n");
        Py_RETURN_FALSE;
    }

    if (!crashreporter->set_release(release_str)) {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}

PyObject* Py_add_attachment(PyObject* self, PyObject* args)
{
    wchar_t* prop_path = nullptr;
    char* prop_desc = nullptr;

    if (!crashreporter)
    {
        return nullptr;
    }

    if (!PyArg_ParseTuple(args, "us", &prop_path, &prop_desc))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [add_attachment] Cannot parse tuple (expected us)\n");
        return nullptr;;
    }

    if (crashreporter->is_initialized())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [add_attachment] CrashRpt is already initialized\n");
        Py_RETURN_FALSE;
    }

    if (!crashreporter->add_attachment(prop_desc, GetWorkingDirectory() / std::wstring(prop_path))) {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}


PyObject* Py_set_dsn(PyObject* self, PyObject* args)
{
    if (!crashreporter)
    {
        return nullptr;
    }

    char* release_str = nullptr;
    if (!PyArg_ParseTuple(args, "s", &release_str))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_dsn] Cannot parse tuple (expected s)\n");
        return nullptr;
    }

    if (crashreporter->is_initialized())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_dsn] CrashRpt is already initialized\n");
        Py_RETURN_FALSE;
    }

    if (!crashreporter->set_dsn(release_str)) {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}


PyObject* Py_set_environment(PyObject* self, PyObject* args)
{
    if (!crashreporter)
    {
        return nullptr;
    }

    char* environment_name = nullptr;
    if (!PyArg_ParseTuple(args, "s", &environment_name))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_environment] Cannot parse tuple (expected s)\n");
        return nullptr;
    }

    if (crashreporter->is_initialized())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_environment] CrashRpt is already initialized\n");
        Py_RETURN_FALSE;
    }

    if (!crashreporter->set_environment(environment_name)) {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}
\
PyObject* Py_initialize(PyObject* self, PyObject* args)
{
    if (!crashreporter)
    {
        return nullptr;
    }

    if (!crashreporter->is_platform_supported())
    {
        Py_RETURN_FALSE;
    }

    if (!crashreporter->initialize()) {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}

PyObject* Py_shutdown(PyObject* self, PyObject* args)
{
    if (!crashreporter)
    {
        return nullptr;
    }

    if (!crashreporter->is_platform_supported())
    {
        Py_RETURN_FALSE;
    }

    if (!crashreporter->shutdown()) {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}

PyObject* Py_set_tag(PyObject* self, PyObject* args)
{
    char* prop_name = nullptr;
    char* prop_val = nullptr;

    if (!crashreporter)
    {
        return nullptr;
    }

    if (!PyArg_ParseTuple(args, "ss", &prop_name, &prop_val))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_tag] Cannot parse tuple (expected ss)\n");
        return nullptr;
    }

    if (!crashreporter->is_initialized())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_tag] CrashRpt is not initialized\n");
        Py_RETURN_FALSE;
    }


    if (!crashreporter->set_tag(prop_name, prop_val)) {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}

PyObject* Py_set_user(PyObject* self, PyObject* args)
{
    char* prop_name = nullptr;
    char* prop_val = nullptr;

    if (!crashreporter)
    {
        return nullptr;
    }

    if (!PyArg_ParseTuple(args, "ss", &prop_name, &prop_val))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_tag] Cannot parse tuple (expected ss)\n");
        return nullptr;
    }

    if (!crashreporter->is_initialized())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [set_tag] CrashRpt is not initialized\n");
        Py_RETURN_FALSE;
    }


    if (!crashreporter->set_tag(prop_name, prop_val)) {
        Py_RETURN_FALSE;
    }

    Py_RETURN_TRUE;
}


PyMethodDef XFW_CrashReportMethods[] = {
    { "restore_suef"          , Py_Restore_SUEF          , METH_VARARGS, "Fix SetUnhandledExceptionFilter() WinAPI function"},
    
    { "is_platform_supported" , Py_is_platform_supported , METH_VARARGS, "" },
    { "is_initialized"        , Py_is_initialized        , METH_VARARGS, "" },

    { "set_release"           , Py_set_release           , METH_VARARGS, "" },
    { "add_attachment"        , Py_add_attachment        , METH_VARARGS, "" },
    { "set_dsn"               , Py_set_dsn               , METH_VARARGS, "" },
    { "set_environment"       , Py_set_environment       , METH_VARARGS, "" },

    { "initialize"            , Py_initialize            , METH_VARARGS, "" },
    { "shutdown"              , Py_shutdown              , METH_VARARGS, "" },

    { "set_tag"               , Py_set_tag               , METH_VARARGS, "" },
    { "set_user"              , Py_set_user              , METH_VARARGS, "" },
    { 0, 0, 0, 0 }
};

PyMODINIT_FUNC initXFW_CrashReport(void)
{
    Py_InitModule("XFW_CrashReport", XFW_CrashReportMethods);
    crashreporter = new CrashReporter();
}
