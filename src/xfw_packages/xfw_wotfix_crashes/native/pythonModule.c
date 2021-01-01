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

#include <Windows.h>
#include <Python.h>

extern int patch_get_count();
extern int patch_apply(int);


PyObject* fix_count(PyObject* self, PyObject* args)
{
    return Py_BuildValue("i", patch_get_count());
}

PyObject* fix_apply(PyObject* self, PyObject* args)
{
    int i = 0;
    if (!PyArg_ParseTuple(args, "i", &i)) {
        return NULL;
    }

    return Py_BuildValue("i", patch_apply(i));
}


PyMethodDef crashfixMethods[] = {
    { "fix_count"  , fix_count , METH_VARARGS, "" },
    { "fix_apply"  , fix_apply , METH_VARARGS, "" },
    { 0, 0, 0, 0 }
};

PyMODINIT_FUNC initxfw_crashfix(void)
{
    Py_InitModule("xfw_crashfix", crashfixMethods);
}
