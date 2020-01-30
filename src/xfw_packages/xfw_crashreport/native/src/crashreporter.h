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
    bool set_release(const std::string& version);
    bool add_attachment(const std::string& name, const std::wstring& filepath);
    bool set_dsn(const std::string& dsn);

    //initialization
    bool initialize();
    bool shutdown();

    //other thing
    bool set_tag(const std::string& key, const std::string& value);

private:
    sentry_options_t* _options = nullptr;
    bool _initialized = false;

    std::wstring library_name = L"sentry_crashpad.dll";
};
