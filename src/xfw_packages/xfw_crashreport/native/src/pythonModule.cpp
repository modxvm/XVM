/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2018-2019 XVM Team.
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

#include <Windows.h>
#include <Shlwapi.h>

#include <Python.h>

#include "crashreporter.h"
#include "fix_suef.h"


PyMethodDef XFW_CrashReportMethods[] = {
    { "restore_suef"         , Py_Restore_SUEF        , METH_VARARGS, "Fix SetUnhandledExceptionFilter() WinAPI function"},
    { "crashrpt_is_supported", Py_CrashRpt_IsSupported, METH_VARARGS, "Check if CrashRpt is supported" },
    { "crashrpt_install"     , Py_CrashRpt_Install    , METH_VARARGS, "Init CrashReporter" },
    { "crashrpt_set_language", Py_CrashRpt_SetLanguage, METH_VARARGS, "Set CrashReporter language" },
    { "crashrpt_add_prop"    , Py_CrashRpt_AddProp    , METH_VARARGS, "Add property to bugreport" },
    { "crashrpt_add_file"    , Py_CrashRpt_AddFile    , METH_VARARGS, "Add file to bugreport" },
    { 0, 0, 0, 0 }
};

PyMODINIT_FUNC initXFW_CrashReport(void)
{
    Py_InitModule("XFW_CrashReport", XFW_CrashReportMethods);
}
