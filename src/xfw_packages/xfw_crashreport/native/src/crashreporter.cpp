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


bool CrashReporter::options_release_set(const std::string& version) {
    if (is_initialized())
        return false;

    sentry_options_set_release(_options, version.c_str());
    return true;
}

bool CrashReporter::options_databasepath_set(const std::wstring& path)
{
    if (is_initialized())
        return false;

    sentry_options_set_database_pathw(_options, path.c_str());
    return true;
}


bool CrashReporter::options_attachment_add(const std::string& name, const std::wstring& filepath) {
    if (is_initialized())
        return false;

    sentry_options_add_attachmentw(_options, name.c_str(), filepath.c_str());
    return true;
}

bool CrashReporter::options_consent_required_set(bool val)
{
    if (is_initialized())
        return false;

    sentry_options_set_require_user_consent(_options, val);
    return true;
}


bool CrashReporter::options_dsn_set(const std::string& dsn) {
    if (is_initialized())
        return false;

    sentry_options_set_dsn(_options, dsn.c_str());
    return true;
}

bool CrashReporter::options_environment_set(const std::string& environment)
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

bool CrashReporter::consent_get()
{
    switch (sentry_user_consent_get()) {
        case SENTRY_USER_CONSENT_GIVEN:
            return true;
        case SENTRY_USER_CONSENT_UNKNOWN:
        case SENTRY_USER_CONSENT_REVOKED:
        default:
            return false;
    }

    return false;
}

bool CrashReporter::consent_set(bool val)
{
    if (!is_initialized()) {
        return false;
    }

    if (val) {
        sentry_user_consent_give(); 
    }
    else {
        sentry_user_consent_revoke();
    }
    return true;
}



bool CrashReporter::set_tag(const std::string& key, const std::string& value) {
    if (!is_initialized()) {
        return false;
    }

    sentry_set_tag(key.c_str(), value.c_str());
    return true;
}

bool CrashReporter::set_user(const std::string& user_id, const std::string& user_name) {
    sentry_value_t user = sentry_value_new_object();
    if (user_id.size() > 0) {
        sentry_value_set_by_key(user, "id", sentry_value_new_string(user_id.c_str()));
    }
    if (user_name.size() > 0) {
        sentry_value_set_by_key(user, "username", sentry_value_new_string(user_name.c_str()));
    }

    sentry_set_user(user);
    return true;
}