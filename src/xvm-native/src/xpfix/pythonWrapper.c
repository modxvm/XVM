/**
 * XVM Native XPFix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 * @author Fecell
 */

#include "pythonWrapper.h"
#include "pythonWrapperHelper.h"

wrp_PyObject_IsTrue_typedef* wrp_PyObject_IsTrue_func;
wrp_PyErr_Format_typedef* wrp_PyErr_Format_func;
wrp_PyErr_NoMemory_typedef* wrp_PyErr_NoMemory_func;
wrp_PyErr_NormalizeException_typedef* wrp_PyErr_NormalizeException_func;
wrp_PyErr_Occurred_typedef* wrp_PyErr_Occurred_func;
wrp_Py_InitModule4_typedef* wrp_Py_InitModule4_func;
wrp_PySys_GetObject_typedef* wrp_PySys_GetObject_func;
wrp_PySys_WriteStderr_typedef* wrp_PySys_WriteStderr_func;
wrp_PyImport_Cleanup_typedef* wrp_PyImport_Cleanup_func;
wrp_PyImport_ExecCodeModuleEx_typedef* wrp_PyImport_ExecCodeModuleEx_func;
wrp_check_compiled_module_typedef* wrp_check_compiled_module_func;
wrp_find_init_module_typedef* wrp_find_init_module_func;
wrp_load_source_module_typedef* wrp_load_source_module_func;
wrp_make_compiled_pathname_typedef* wrp_make_compiled_pathname_func;
wrp_parse_source_module_typedef* wrp_parse_source_module_func;
wrp_read_compiled_module_typedef* wrp_read_compiled_module_func;
wrp_update_compiled_module_typedef* wrp_update_compiled_module_func;
wrp_win32_mtime_typedef* wrp_win32_mtime_func;
wrp_write_compiled_module_typedef* wrp_write_compiled_module_func;

int* wrp_Py_VerboseFlag_struct;
PyObject ** wrp_PyExc_RuntimeError_struct;

void pythonWrapperInit(void)
{
    DWORD startpos;
    DWORD curpos;
    DWORD endpos;
    TCHAR lpFilename[2048];

    GetModuleFileName(NULL, lpFilename, 2048);
    startpos = (DWORD)GetModuleHandleA(lpFilename);
    endpos = (DWORD)GetModuleSize(lpFilename);
    curpos = startpos;

    wrp_PyObject_IsTrue_func = (wrp_PyObject_IsTrue_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x8B\x45\x08\x3D\x00\x00\x00\x00\x74\x61", "xxxxxxx????xx"));
    wrp_PyErr_Format_func = (wrp_PyErr_Format_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x56\x8D\x45\x10\x50\xFF\x75\x0C\xE8\x00\x00\x00\x00\x8B\xF0\x56\xFF\x75\x08\xE8", "xxxxxxxxxxxx????xxxxxxx"));
    wrp_PyErr_NoMemory_func = (wrp_PyErr_NoMemory_typedef*)(FindFunction(startpos, endpos, &curpos, "\xA1\x00\x00\x00\x00\xFF\x35\x00\x00\x00\x00\xFF\x70\x28", "x????xx????xxx"));
    wrp_PyErr_NormalizeException_func = (wrp_PyErr_NormalizeException_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x51\x53\x56\x8B\x75\x0C\x33\xDB\x57\x8B\x7D\x08\x8B", "xxxxxxxxxxxxxxxx"));
    wrp_PyErr_Occurred_func = (wrp_PyErr_Occurred_typedef*)(FindFunction(startpos, endpos, &curpos, "\xA1\x00\x00\x00\x00\x8B\x40\x28\xC3\xCC\xCC\xCC\xCC\xCC\xCC\xCC\x55\x8B\xEC\x81\xEC\xF0\x03\x00\x00", "x????xxxxxxxxxxxxxxxxxxxx"));
    wrp_Py_InitModule4_func = (wrp_Py_InitModule4_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x81\xEC\x14\x02\x00\x00\xA1\x00\x00\x00\x00\x33\xC5\x89\x45\xFC\x8B\x45\x10\x53\x8B\x5D\x0C\x89\x85\x00\xFD\xFF\xFF","xxxxxxxxxx????xxxxxxxxxxxxxx?xxx"));
    wrp_PySys_GetObject_func = (wrp_PySys_GetObject_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\xA1\x00\x00\x00\x00\x8B\x40\x04\x8B\x40\x0C\x85\xC0", "xxxx????xxxxxxxx"));
    wrp_PySys_WriteStderr_func = (wrp_PySys_WriteStderr_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x8D\x45\x0C\x50\xFF\x75\x08\x6A\x02\xFF\x15", "xxxxxxxxxxxxxx"));
    wrp_PyImport_Cleanup_func = (wrp_PyImport_Cleanup_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x83\xEC\x14\xA1\x00\x00\x00\x00\x53\x8B\x40\x04\x89\x45\xEC", "xxxxxxx????xxxxxxx"));
    wrp_PyImport_ExecCodeModuleEx_func = (wrp_PyImport_ExecCodeModuleEx_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x51\xA1\x00\x00\x00\x00\x56\x57\x8B\x70\x04\x83\x7E\x08\x00", "xxxxx????xxxxxxxxx"));
    wrp_check_compiled_module_func = (wrp_check_compiled_module_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x56\x57\x8B\x7D\x14\x68\x00\x00\x00\x00\x57\xFF\x15\x00\x00\x00\x00\x8B\xF0\x83\xC4\x08", "xxxxxxxxx????xxx????xxxxx"));
    wrp_find_init_module_func = (wrp_find_init_module_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x83\xEC\x34\xA1\x00\x00\x00\x00\x33\xC5\x89\x45\xFC\x56\x57\x8B\x7D\x08\x8B\xF7\x8D\x4E\x01\x66\x0F\x1F\x44\x00\x00", "xxxxxxx????xxxxxxxxxxxxxxxxxxxxx"));
    wrp_load_source_module_func = (wrp_load_source_module_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x83\xEC\x44\xA1\x00\x00\x00\x00\x33\xC5\x89\x45\xFC\x8B\x45\x08\x56\x8B\x75\x10\x57\x8B\x7D\x0C\x56\x89\x45\xC8\xFF\x15", "xxxxxxx????xxxxxxxxxxxxxxxxxxxxxx"));
    wrp_make_compiled_pathname_func = (wrp_make_compiled_pathname_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x56\x8B\x75\x08\x57\x8B\xFE\x8D\x4F\x01\x0F\x1F\x00", "xxxxxxxxxxxxxxxx"));
    wrp_parse_source_module_func = (wrp_parse_source_module_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x51\x56\x57\x33\xFF\xE8", "xxxxxxxxx"));
    wrp_read_compiled_module_func = (wrp_read_compiled_module_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x56\xFF\x75\x0C\xE8\x00\x00\x00\x00\x8B\xF0\x83\xC4\x04\x85\xF6\x74\x30\x81\x7E\x04", "xxxxxxxx????xxxxxxxxxxxx"));
    wrp_update_compiled_module_func = (wrp_update_compiled_module_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x53\x8B\x5D\x08\x56\x57\x8B\x7D\x0C\x8B\xF7\xFF\x73", "xxxxxxxxxxxxxxxx"));
    wrp_win32_mtime_func = (wrp_win32_mtime_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x83\xEC\x38\xA1\x00\x00\x00\x00\x33\xC5\x89\x45\xFC\x8B\x45\x08\x56\x8B\x75\x0C\x50\xFF\x15", "xxxxxxx????xxxxxxxxxxxxxxx"));
    wrp_write_compiled_module_func = (wrp_write_compiled_module_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x8B\x45\x10\xB9\xBF\xFF\x00\x00\x56\x57\x8B\x7D\x0C", "xxxxxxxxxxxxxxxx"));

    wrp_Py_VerboseFlag_struct = (int*)(FindStructure(wrp_PyImport_Cleanup_func, 0x63));
    wrp_PyExc_RuntimeError_struct = (PyObject **)(FindStructure(wrp_PyErr_NormalizeException_func, 0x1EC));

    return;
}