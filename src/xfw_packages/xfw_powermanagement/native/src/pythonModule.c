/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2009, Jay Loden, Giampaolo Rodola, PSUtils project.
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

#include "Python.h"
#include <Windows.h>

static PyObject *
py_battery_info(PyObject *self, PyObject *args) {
    SYSTEM_POWER_STATUS sps;

    if (GetSystemPowerStatus(&sps) == 0)
        return PyErr_SetFromWindowsErr(0);

    return Py_BuildValue(
        "iiiI",
        sps.ACLineStatus,  // whether AC is connected: 0=no, 1=yes, 255=unknown
        // status flag:
        // 1, 2, 4 = high, low, critical
        // 8 = charging
        // 128 = no battery
        sps.BatteryFlag,
        sps.BatteryLifePercent,  // percent
        sps.BatteryLifeTime  // remaining secs
    );
}


static PyMethodDef XFW_PowerManagementMethods[] = {
    { "battery_info", py_battery_info, METH_VARARGS, ""},
    { NULL, NULL, 0, NULL} 
};

PyMODINIT_FUNC initXFW_PowerManagement(void)
{
    Py_InitModule("XFW_PowerManagement", XFW_PowerManagementMethods);
}
