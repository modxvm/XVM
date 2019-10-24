#include "crashreporter.h"

#include <filesystem>

#include <Windows.h>
#include <Shlwapi.h>

#include "dllMain.h"
#include "common.h"

class CrashReporter {

private:
    CR_INSTALL_INFOW info{};
    bool installed = false;
    bool silentMode = false;

    std::wstring CrashRpt_langpath = L"";
    std::wstring PrivacyPolicy = L"";

public:
    CrashReporter()
    {
        SetLangugage(L"EN", L"EN");
    }

    bool IsSupported()
    {
        HMODULE hNtdll = GetModuleHandleW(L"ntdll.dll");

        if (hNtdll == nullptr)
            return false;

        FARPROC wineGetVersionAddr = GetProcAddress(hNtdll, "wine_get_version");
        if (wineGetVersionAddr != nullptr)
            return false;

        return true;
    }

    bool LoadLib()
    {
        return LoadLibraryW((GetModuleDirectory(hDLL) / L"CrashRpt1500.dll").wstring().c_str()) != nullptr;
    }

    bool IsInstalled()
    {
        return installed;
    }

    bool SetPrivacyPolicy(const std::wstring& language, const std::wstring& region)
    {
        if (region == L"ru" || region == L"RU")
        {
            PrivacyPolicy = L"https://nightly.modxvm.com/privacy/ru";
        }
        else
        {
            PrivacyPolicy = L"https://nightly.modxvm.com/privacy/en";
        }

        return true;
    }

    bool SetSilentMode(bool mode)
    {
        silentMode = mode;
        return true;
    }

    bool SetLangugage(const std::wstring& language, const std::wstring& region)
    {
        auto langfile = std::wstring(L"crashrpt_lang_") + language + L".ini";
        auto langpath = GetModuleDirectory(hDLL) / L"lang_files" / langfile;
        if (std::filesystem::exists(langpath))
        {
            CrashRpt_langpath = langpath;
            return true;
        }

        if (region == L"ru" || region == L"RU")
        {
            langfile = std::wstring(L"crashrpt_lang_RU.ini");
            langpath = GetModuleDirectory(hDLL) / L"lang_files" / langfile;
            if (std::filesystem::exists(langpath))
            {
                CrashRpt_langpath = langpath;
                return true;
            }
        }

        langfile = std::wstring(L"crashrpt_lang_EN.ini");
        langpath = GetModuleDirectory(hDLL) / L"lang_files" / langfile;
        if (std::filesystem::exists(langpath))
        {
            CrashRpt_langpath = langpath;
            return true;
        }

        return false;
    }

    int Install(const std::wstring& version)
    {
        info.cb = sizeof(info);

        if(silentMode)
            info.pszAppName = L"WoT+XVM_silent";
        else
            info.pszAppName = L"WoT+XVM";

        auto appVersion = GetModuleVersion(static_cast<HMODULE>(nullptr));
        if (!version.empty())
            appVersion = appVersion + L"_" + version;

        info.pszAppVersion = appVersion.c_str();

        info.pszUrl = L"https://crashfix.modxvm.com/index.php/crashReport/uploadExternal";

        auto crashSenderPath = GetModuleDirectory(hDLL).wstring();
        info.pszCrashSenderPath = crashSenderPath.c_str();

        info.uPriorities[CR_HTTP] = TRUE;
        info.uPriorities[CR_SMTP] = CR_NEGATIVE_PRIORITY;
        info.uPriorities[CR_SMAPI] = CR_NEGATIVE_PRIORITY;

        info.dwFlags |= CR_INST_HTTP_BINARY_ENCODING;
        info.dwFlags |= CR_INST_SEH_EXCEPTION_HANDLER;
        info.dwFlags |= CR_INST_SEH_CALL_PREV_HANDLER;

        if(silentMode)
            info.dwFlags |= CR_INST_NO_GUI;

        auto debugHelpDll = (GetModuleDirectory(static_cast<HMODULE>(nullptr)) / L"DbgHelp.dll").wstring();
        info.pszDebugHelpDLL = debugHelpDll.c_str();

        info.uMiniDumpType = static_cast<MINIDUMP_TYPE>(MiniDumpNormal
            | MiniDumpWithHandleData
            | MiniDumpWithUnloadedModules
            | MiniDumpWithProcessThreadData
            | MiniDumpWithFullMemoryInfo
            | MiniDumpWithThreadInfo
            | MiniDumpWithTokenInformation);

        auto reportsFolder = (GetModuleDirectory(static_cast<HMODULE>(nullptr)) / L"Reports_XFW").wstring();
        info.pszErrorReportSaveDir = reportsFolder.c_str();

        info.pszRestartCmdLine = GetCommandLineW();

        info.pszLangFilePath = this->CrashRpt_langpath.c_str();

        if (!PrivacyPolicy.empty())
            info.pszPrivacyPolicyURL = PrivacyPolicy.c_str();

        int retcode = crInstallW(&info);
        if (retcode == 0)
            installed = true;

        return retcode;
    }
};

auto crashreporter = new CrashReporter();

//Python API

PyObject* Py_CrashRpt_IsSupported(PyObject* self, PyObject* args)
{
    if (crashreporter->IsSupported())
        Py_RETURN_TRUE;

    Py_RETURN_FALSE;
}

PyObject * Py_CrashRpt_SetLanguage(PyObject * self, PyObject * args)
{
    wchar_t* prop_lang = nullptr;
    wchar_t* prop_region = nullptr;

    if (!PyArg_ParseTuple(args, "uu", &prop_lang, &prop_region))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [SetLanguage] Cannot parse tuple (expected uu)\n");
        return NULL;
    }

    if (crashreporter->SetLangugage(prop_lang, prop_region) && crashreporter->SetPrivacyPolicy(prop_lang,prop_region))
        Py_RETURN_TRUE;

    Py_RETURN_FALSE;
}

std::wstring Py_GetXvmVersion()
{
    PyObject* py_module_xfwloader = PyImport_AddModule("xfw_loader");
    if (py_module_xfwloader == nullptr)
        return L"";

    PyObject* py_dict_mods = PyObject_GetAttrString(py_module_xfwloader, "mods");
    if (py_dict_mods == nullptr)
        return L"";

    PyObject* py_dict_mods_xvm = PyDict_GetItemString(py_dict_mods, "com.modxvm.xvm");
    if (py_dict_mods_xvm == nullptr)
        return L"";

    PyObject* py_str_xvm_version = PyDict_GetItemString(py_dict_mods_xvm, "version");
    if (py_str_xvm_version == nullptr)
        return L"";

    char* ver = PyString_AsString(py_str_xvm_version);
    if (ver == nullptr)
        return L"";

    return string_to_wstring(std::string(ver));
}

PyObject* Py_CrashRpt_Install(PyObject* self, PyObject* args)
{
    if (!crashreporter->IsSupported())
        Py_RETURN_FALSE;

    if (!crashreporter->LoadLib())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/CrashReport] failed to load CrashRpt library");
        return nullptr;
    }

    if(std::filesystem::exists(GetModuleDirectory(static_cast<HMODULE>(nullptr)) / L"wargaming_qa.conf"))
    {
        crashreporter->SetSilentMode(true);
    }

    if (crashreporter->Install(Py_GetXvmVersion()) != 0)
    {
        char buff[256]{};
        crGetLastErrorMsgA(buff, 256);
        PyErr_SetString(PyExc_RuntimeError, buff);
        return nullptr;
    }

    Py_RETURN_TRUE;
}

PyObject* Py_CrashRpt_AddFile(PyObject* self, PyObject* args)
{
    wchar_t* prop_path = nullptr;
    wchar_t* prop_name = nullptr;
    wchar_t* prop_desc = nullptr;

    if (!PyArg_ParseTuple(args, "uuu", &prop_path, &prop_name, &prop_desc))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [AddFile] Cannot parse tuple (expected uuu)\n");
        return NULL;
    }

    if (!crashreporter->IsInstalled())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [AddFile] CrashRpt is not registered\n");
        return NULL;
    }

    if (crAddFile2W(prop_path, prop_name, prop_desc, CR_AF_MAKE_FILE_COPY | CR_AF_ALLOW_DELETE | CR_AF_MISSING_FILE_OK) != 0)
    {
        char buff[256]{};
        crGetLastErrorMsgA(buff, 256);
        PyErr_SetString(PyExc_RuntimeError, buff);
        return NULL;
    }

    Py_RETURN_TRUE;
}

PyObject* Py_CrashRpt_AddProp(PyObject* self, PyObject* args)
{
    wchar_t* prop_name = nullptr;
    wchar_t* prop_val = nullptr;

    if (!PyArg_ParseTuple(args, "uu", &prop_name, &prop_val))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [AddProp] Cannot parse tuple\n");
        return NULL;
    }

    if (!crashreporter->IsInstalled())
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW/Crashreport] [AddFile] CrashRpt is not registered\n");
        return NULL;
    }

    if (crAddPropertyW(prop_name, prop_val) != 0)
    {
        char buff[256]{};
        crGetLastErrorMsgA(buff, 256);
        PyErr_SetString(PyExc_RuntimeError, buff);
        return NULL;
    }

    Py_RETURN_TRUE;
}
