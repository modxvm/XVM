/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c)           Microsoft corporation.
 * Copyright (c) 2016-2021 XVM Team.
 *
 * XVM Framework is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, version 3.
 *
 * XVM Framework is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>
#include <icmpapi.h>

int ping(char* address)
{
    HANDLE hIcmpFile = NULL;
    INT intRetVal = 0;
    DWORD dwRetVal = 0;
    char SendData[32] = { 0 };
    unsigned long ipaddr = INADDR_NONE;
    LPVOID ReplyBuffer = NULL;
    DWORD ReplySize = 0;
    int ping = -1;

    //for host resolving
    struct addrinfo hints, *res;
    WSADATA data;

    //Parse IP address
    ipaddr = inet_addr(address);
    if (ipaddr == INADDR_NONE)
    {
        //Try to resolve Host
        WSAStartup(MAKEWORD(2, 0), &data);

        memset(&hints, 0, sizeof(hints));
        hints.ai_socktype = SOCK_STREAM;
        hints.ai_family = AF_INET;

        if ((intRetVal = getaddrinfo(address, NULL, &hints, &res)) != 0)
        {
            return -1;
        }

        ipaddr = ((struct sockaddr_in *)(res->ai_addr))->sin_addr.S_un.S_addr;

        freeaddrinfo(res);
        WSACleanup();
    }

    //open handle
    hIcmpFile = IcmpCreateFile();
    if (hIcmpFile == INVALID_HANDLE_VALUE)
    {
        return -2;
    }

    // Allocate space for at a single reply
    ReplySize = sizeof (ICMP_ECHO_REPLY) + sizeof (SendData) + 8;
    ReplyBuffer = (VOID *) malloc(ReplySize);
    if (ReplyBuffer == NULL)
    {
        IcmpCloseHandle(hIcmpFile);
        return -3;
    }

    //Send ping
    dwRetVal = IcmpSendEcho(hIcmpFile, ipaddr, SendData, sizeof(SendData), NULL, ReplyBuffer, ReplySize, 1000);

    if (dwRetVal != 0)
    {
        PICMP_ECHO_REPLY pEchoReply = (PICMP_ECHO_REPLY) ReplyBuffer;
        struct in_addr ReplyAddr;
        ReplyAddr.S_un.S_addr = pEchoReply->Address;

        switch (pEchoReply->Status)
        {
            case IP_DEST_HOST_UNREACHABLE:
            case IP_DEST_NET_UNREACHABLE:
                ping = -4;
                break;
            case IP_REQ_TIMED_OUT:
                ping = -5;
                break;
            default:
                ping = pEchoReply->RoundTripTime;
                break;
        }
    }
    else
    {
        ping = -6;
    }

    free(ReplyBuffer);
    IcmpCloseHandle(hIcmpFile);
    return ping;
}
