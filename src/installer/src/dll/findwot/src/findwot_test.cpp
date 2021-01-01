/*
 * This file is part of the Findwot project.
 *
 * Copyright (c) 2016-2021 Findwot contributors.
 *
 * Findwot is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, version 3.
 *
 * Findwot is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <iostream>
#include <vector>

#include <io.h>
#include <fcntl.h>

#include "api.h"

#define BUF_SIZE 1024

int main()
{
    _setmode(_fileno(stdout), _O_U16TEXT);

    wchar_t* wbuffer = new wchar_t[BUF_SIZE];


    //WINE
    std::wcout << L"Wine: " << std::endl;
    WineStatus wine_st = WINE_GetStatus();
    if(wine_st.running_on==false)
    {
        std::wcout << L"    Running on    : False" << std::endl;
    }
    else
    {
        std::wcout << L"    Running on    : True" << std::endl;

        std::wcout << L"    Wine build    : ";
        if(wine_st.build!=nullptr)
        {
            std::wcout << wine_st.build;
        }
        std::wcout << std::endl;

        std::wcout << L"    System        : ";
        if (wine_st.system != nullptr)
        {
            std::wcout << wine_st.system;
        }
        std::wcout << std::endl;

        std::wcout << L"    Release       : ";
        if (wine_st.release != nullptr)
        {
            std::wcout << wine_st.release;
        }
        std::wcout << std::endl;
    }
    std::wcout << std::endl;

    //WGC
    std::wcout << L"WGC: " << std::endl;
    bool wgc_isinstalled = WGC_IsInstalled();
    if (wgc_isinstalled)
    {
        std::wcout << L"    Installed     : True" <<std::endl;

        WGC_GetInstallPathW(wbuffer, BUF_SIZE);
        std::wcout << L"    Path          : " << wbuffer << std::endl<<std::endl;
    }
    else
    {
        std::wcout << L"    Installed     : False" << std::endl;
    }
    std::wcout << std::endl;

    //Clients
    int count = WOT_GetClientsCount();
    if (count > 0)
    {
        for (int i = 0; i < count; i++)
        {
            std::wcout << L"Client #" << i + 1 << std::endl;


            WOT_GetClientPathW(wbuffer, BUF_SIZE, i);
            std::wcout << L"    Path          : " << wbuffer << std::endl;

            //client branch
            int branch = WOT_GetClientBranch(i);
            std::wcout << L"    Client branch : ";
            switch (branch)
            {
            case 0:
                std::wcout << L"Unknown" << std::endl;
                break;
            case 1:
                std::wcout << L"Release" << std::endl;
                break;
            case 2:
                std::wcout << L"Common Test" << std::endl;
                break;
            case 3:
                std::wcout << L"Super Test" << std::endl;
                break;
            case 4:
                std::wcout << L"Sandbox" << std::endl;
                break;
            default:
                std::wcout << L"Error" << std::endl;
                break;
            }

            //clientype
            int type = WOT_GetClientType(i);
            std::wcout << L"    Client type   : ";
            switch (type)
            {
            case 0:
                std::wcout << L"Unknown" << std::endl;
                break;
            case 1:
                std::wcout << L"SD" << std::endl;
                break;
            case 2:
                std::wcout << L"HD" << std::endl;
                break;
            default:
                std::wcout << L"Error" << std::endl;
                break;
            }

            WOT_GetClientLocaleW(wbuffer, BUF_SIZE, i);
            std::wcout << L"    Locale        : " << wbuffer << std::endl;


            WOT_GetClientVersionW(wbuffer, BUF_SIZE, i);
            std::wcout << L"    Client version: " << wbuffer << std::endl;


            WOT_GetClientExeVersionW(wbuffer, BUF_SIZE, i);
            std::wcout << L"    Exe version   : " << wbuffer << std::endl;

            std::wcout << std::endl;
        }
    }

    std::wcout<<std::endl << L"Press any key..." << std::endl;
    std::wcin.get();

    delete[] wbuffer;
    return 0;
}
