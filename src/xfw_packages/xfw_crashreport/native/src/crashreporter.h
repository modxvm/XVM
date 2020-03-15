#pragma once

#include <string>

#include "sentry.h"

class CrashReporter {

public:
    CrashReporter();
    ~CrashReporter();

    //general getters
    bool is_platform_supported();
    bool is_initialized();

    //options (should be executed before initialization)
    bool options_attachment_add(const std::string& name, const std::wstring& filepath);
    bool options_consent_required_set(bool val);
    bool options_dsn_set(const std::string& dsn);
    bool options_environment_set(const std::string& environment);
    bool options_release_set(const std::string& version);
    bool options_databasepath_set(const std::wstring& path);

    //initialization
    bool initialize();
    bool shutdown();

    //consent
    bool consent_get();
    bool consent_set(bool val);

    //tag
    bool set_tag(const std::string& key, const std::string& value);

    //user
    bool set_user(const std::string& user_id, const std::string& user_name);

private:
    sentry_options_t* _options = nullptr;
    bool _initialized = false;

    std::wstring library_name = L"sentry.dll";
};
