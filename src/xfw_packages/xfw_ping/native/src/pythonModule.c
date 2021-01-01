/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2016-2021 XVM Team.
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

#include "Python.h"
#include "ping.h"

static char python_ping_docstring[] = "Send ping request to host"
""
"usage: ping(<address>, <unlockGIL>)"
"  address  : host domain name or IP"
"  unlockGIL: unlock GIL when perform I/O operation, 1 or 0"
""
"returns: ping time in msec"
""
"examples:"
"  ping(\"127.0.0.1\", 0)"
"  ping(\"localhost\", 0)";
static PyObject* python_ping(PyObject* self, PyObject* args)
{
    char* address;
    int pingValue;
    int unlockGIL;

    //check input value
    if (!PyArg_ParseTuple(args, "si", &address, &unlockGIL))
    {
        return NULL;
    }

    if (unlockGIL != 0)
    {
        Py_BEGIN_ALLOW_THREADS
            pingValue = ping(address);
        Py_END_ALLOW_THREADS
    }
    else
    {
        pingValue = ping(address);
    }

    return Py_BuildValue("i", pingValue);
}

static PyMethodDef XFW_PingMethods[] = {
    { "ping", python_ping, METH_VARARGS, python_ping_docstring},
    { NULL, NULL, 0, NULL}
};


PyMODINIT_FUNC initXFW_Ping(void)
{
    Py_InitModule("XFW_Ping", XFW_PingMethods);
}