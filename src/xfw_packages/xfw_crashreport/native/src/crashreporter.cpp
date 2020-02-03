#include <Windows.h>



#include "common.h"
#include "dllMain.h"
#include "crashreporter.h"


CrashReporter::CrashReporter()
{
    if (GetModuleHandleW(library_name.c_str()) == nullptr) {
        LoadLibraryW((GetModuleDirectory(hDLL) / library_name).c_str());
    }

    //create options
    _options = sentry_options_new();
    sentry_options_set_handler_pathw(_options, (GetModuleDirectory(hDLL) / L"crashpad_handler.exe").c_str());
    sentry_options_set_database_pathw(_options, (GetModuleDirectory(hDLL) / L"db/").c_str());
    sentry_options_set_debug(_options, 1);
}


CrashReporter::~CrashReporter()
{
    shutdown();
    sentry_options_free(_options);
}


bool CrashReporter::is_platform_supported()
{
    return true;
}


bool CrashReporter::is_initialized()
{
    return _initialized;
}


bool CrashReporter::set_release(const std::string& version) {
    if (is_initialized())
        return false;

    sentry_options_set_release(_options, version.c_str());
    return true;
}


bool CrashReporter::add_attachment(const std::string& name, const std::wstring& filepath) {
    if (is_initialized())
        return false;

    sentry_options_add_attachmentw(_options, name.c_str(), filepath.c_str());
    return true;
}


bool CrashReporter::set_dsn(const std::string& dsn) {
    if (is_initialized())
        return false;

    sentry_options_set_dsn(_options, dsn.c_str());
    return true;
}

bool CrashReporter::set_environment(const std::string& environment)
{
    if (is_initialized())
        return false;

    sentry_options_set_environment(_options, environment.c_str());
    return true;
}


bool CrashReporter::initialize()
{
    sentry_init(_options);
    _initialized = true;
    return true;
}


bool CrashReporter::shutdown()
{
    sentry_shutdown();
    _initialized = false;
    return true;
}


bool CrashReporter::set_tag(const std::string& key, const std::string& value) {
    if (!is_initialized()) {
        return false;
    }

    sentry_set_tag(key.c_str(), value.c_str());
    return true;
}
