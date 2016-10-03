#include "load_source_module.h"
#include <Windows.h>

#define MS_WINDOWS 1
#define MAXPATHLEN 256

PyObject *
load_source_module_replacement(char *name, char *pathname, FILE *fp)
{
    struct stat st;
    FILE *fpc;
    char *buf;
    char *cpathname;
    PyCodeObject *co = NULL;
    PyObject *m;
    time_t mtime;

    //HACK: do not return if fstat fails
    fstat(fileno(fp), &st);
    /*if (fstat(fileno(fp), &st) != 0) {
        PyErr_Format(PyExc_RuntimeError,
            "unable to get file status from '%s'",
            pathname);
        return NULL;
    }*/

#ifdef MS_WINDOWS
    mtime = win32_mtime(fp, pathname);
    if (mtime == (time_t)-1 && PyErr_Occurred())
        return NULL;
#else
    mtime = st.st_mtime;
#endif
    if (sizeof mtime > 4) {
        /* Python's .pyc timestamp handling presumes that the timestamp fits
        in 4 bytes. Since the code only does an equality comparison,
        ordering is not important and we can safely ignore the higher bits
        (collisions are extremely unlikely).
        */
        mtime &= 0xFFFFFFFF;
    }
    buf = PyMem_MALLOC(MAXPATHLEN + 1);
    if (buf == NULL) {
        return PyErr_NoMemory();
    }
    cpathname = make_compiled_pathname(pathname, buf,
        (size_t)MAXPATHLEN + 1);
    if (cpathname != NULL &&
        (fpc = check_compiled_module(pathname, mtime, cpathname))) {
        co = read_compiled_module(cpathname, fpc);
        fclose(fpc);
        if (co == NULL)
            goto error_exit;
        if (update_compiled_module(co, pathname) < 0)
            goto error_exit;
        if (Py_VerboseFlag)
            PySys_WriteStderr("import %s # precompiled from %s\n",
                name, cpathname);
        pathname = cpathname;
    }
    else {
        co = parse_source_module(pathname, fp);
        if (co == NULL)
            goto error_exit;
        if (Py_VerboseFlag)
            PySys_WriteStderr("import %s # from %s\n",
                name, pathname);
        if (cpathname) {
            PyObject *ro = PySys_GetObject("dont_write_bytecode");
            int b = (ro == NULL) ? 0 : PyObject_IsTrue(ro);
            if (b < 0)
                goto error_exit;
            if (!b)
                write_compiled_module(co, cpathname, &st, mtime);
        }
    }
    m = PyImport_ExecCodeModuleEx(name, (PyObject *)co, pathname);
    Py_DECREF(co);

    PyMem_FREE(buf);
    return m;

error_exit:
    Py_XDECREF(co);
    PyMem_FREE(buf);
    return NULL;
}
