#include "ttfInfo.h"
#include <iostream>

int main()
{
    std::cout << GetFontFamilyFromFile(std::wstring(L"D:\\opr\\VehicleType.ttf")) << std::endl;

    std::cout << GetFontFamilyFromFile(std::wstring(L"D:\\opr\\ZurichCondMono.ttf")) << std::endl;
}
