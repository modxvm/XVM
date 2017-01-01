/**
 * XVM Native WOTFix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include <Windows.h>
#include "Python.h"
#include "PythonInternal.h"

typedef FARPROC dl_funcptr;

__declspec(dllexport) dl_funcptr _PyImport_GetDynLoadFunc_replacement(const char *fqname, const char *shortname, const char *pathname, FILE *fp)
{   
    char       buffer[256];
    char       funcname[258];
    char       pathbuf[260];
    char *     import_python;
    HINSTANCE  hDLL = NULL;

    LPTSTR dummy;
    unsigned int old_mode;

    PyOS_snprintf(funcname, sizeof(funcname), "init%.200s", shortname);

    old_mode = SetErrorMode(SEM_FAILCRITICALERRORS);

    if (GetFullPathName(pathname, sizeof(pathbuf), pathbuf, &dummy))
    {
        hDLL = LoadLibraryEx(pathbuf, NULL, LOAD_WITH_ALTERED_SEARCH_PATH);
    }

    SetErrorMode(old_mode);

    if (hDLL==NULL)
    {
        char errBuf[256];
        unsigned int errorCode;

        /* Get an error string from Win32 error code */
        char theInfo[256]; /* Pointer to error text from system */
        int theLength;     /* Length of error text */

        errorCode = GetLastError();

        theLength = FormatMessage(
            FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, /* flags */
            NULL,                                                       /* message source */
            errorCode,                                                  /* the message (error) ID */
            0,                                                          /* default language environment */
            (LPTSTR) theInfo,                                           /* the buffer */
            sizeof(theInfo),                                            /* the buffer size */
            NULL);                                                      /* no additional format args. */

        /* Problem: could not get the error message. This should not happen if called correctly. */
        if (theLength == 0) 
        {
            PyOS_snprintf(errBuf, sizeof(errBuf), "DLL load failed with error code %d", errorCode);
        } else {
            size_t len;
            /* For some reason a \r\n is appended to the text */
            if (theLength >= 2 && theInfo[theLength-2] == '\r' && theInfo[theLength-1] == '\n') 
            {
                theLength -= 2;
                theInfo[theLength] = '\0';
            }
            strcpy(errBuf, "DLL load failed: ");
            len = strlen(errBuf);
            strncpy(errBuf+len, theInfo, sizeof(errBuf)-len);
            errBuf[sizeof(errBuf)-1] = '\0';
        }
        PyErr_SetString(PyExc_ImportError, errBuf);
        return NULL;
    } 
        
    PyOS_snprintf(buffer, sizeof(buffer), "python%d%d.dll", PY_MAJOR_VERSION, PY_MINOR_VERSION);
    import_python = GetPythonImport(hDLL);

    if (import_python && strcasecmp(buffer,import_python)) 
    {
        PyOS_snprintf(buffer, sizeof(buffer), "Module use of %.150s conflicts with this version of Python.", import_python);
        PyErr_SetString(PyExc_ImportError, buffer);
        FreeLibrary(hDLL);
        return NULL;
    }
    
    return GetProcAddress(hDLL, funcname);
}