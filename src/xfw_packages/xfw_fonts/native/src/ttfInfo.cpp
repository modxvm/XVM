#include <fstream>

#include <Windows.h>

#include "ttfInfo.h"

#pragma pack(push,1)

typedef struct _tagTT_OFFSET_TABLE{
    uint16_t    uMajorVersion;
    uint16_t    uMinorVersion;
    uint16_t    uNumOfTables;
    uint16_t    uSearchRange;
    uint16_t    uEntrySelector;
    uint16_t    uRangeShift;
}TT_OFFSET_TABLE;

typedef struct _tagTT_TABLE_DIRECTORY{
    char        szTag[4];           //table name
    uint32_t    uCheckSum;          //Check sum
    uint32_t    uOffset;            //Offset from beginning of file
    uint32_t    uLength;            //length of the table in bytes
}TT_TABLE_DIRECTORY;

typedef struct _tagTT_NAME_TABLE_HEADER{
    uint16_t    uFSelector;          //format selector. Always 0
    uint16_t    uNRCount;            //Name Records count
    uint16_t    uStorageOffset;      //Offset for strings storage, from start of the table
}TT_NAME_TABLE_HEADER;

typedef struct _tagTT_NAME_RECORD{
    uint16_t    uPlatformID;
    uint16_t    uEncodingID;
    uint16_t    uLanguageID;
    uint16_t    uNameID;
    uint16_t    uStringLength;
    uint16_t    uStringOffset;       //from start of storage area
}TT_NAME_RECORD;

#pragma pack(pop)

#define SWAPWORD(x)        MAKEWORD(HIBYTE(x), LOBYTE(x))
#define SWAPLONG(x)        MAKELONG(SWAPWORD(HIWORD(x)), SWAPWORD(LOWORD(x)))



std::string ws2s(const std::wstring& s)
{
    int slength = (int)s.length() + 1;
    int len = WideCharToMultiByte(CP_ACP, 0, s.c_str(), slength, 0, 0, 0, 0);
    std::string r(len, '\0');
    WideCharToMultiByte(CP_ACP, 0, s.c_str(), slength, &r[0], len, 0, 0);
    return r;
}

std::string getNameRecord(std::ifstream& fileStream, TT_TABLE_DIRECTORY tblDir, int id) {
    fileStream.seekg(tblDir.uOffset);

    TT_NAME_TABLE_HEADER ttNTHeader{};
    fileStream.read(reinterpret_cast<char*>(&ttNTHeader), sizeof(ttNTHeader));

    ttNTHeader.uNRCount = SWAPWORD(ttNTHeader.uNRCount);
    ttNTHeader.uStorageOffset = SWAPWORD(ttNTHeader.uStorageOffset);

    TT_NAME_RECORD ttRecord{};
    for (uint16_t i = 0; i < ttNTHeader.uNRCount; i++)
    {
        fileStream.read(reinterpret_cast<char*>(&ttRecord), sizeof(ttRecord));
        ttRecord.uNameID = SWAPWORD(ttRecord.uNameID);
        if (ttRecord.uNameID != id)
            continue;

        ttRecord.uStringLength = SWAPWORD(ttRecord.uStringLength);
        ttRecord.uStringOffset = SWAPWORD(ttRecord.uStringOffset);
        const auto n_pos = fileStream.tellg();

        fileStream.seekg(tblDir.uOffset + ttRecord.uStringOffset + ttNTHeader.uStorageOffset);


        if (SWAPWORD(ttRecord.uEncodingID) == 1) {
            const auto buf = static_cast<wchar_t*>(calloc(ttRecord.uStringLength / 2 + 1, sizeof(wchar_t)));
            fileStream.read(reinterpret_cast<char*>(buf), ttRecord.uStringLength);
            for (auto i = 0; i < ttRecord.uStringLength / 2; i++) {
                buf[i] = SWAPWORD(buf[i]);
            }
            if (wcslen(reinterpret_cast<wchar_t*>(buf)) > 0) {
                return ws2s(std::wstring(reinterpret_cast<wchar_t*>(buf)));
            }
        }
        else {
            const auto buf = static_cast<char*>(calloc(ttRecord.uStringLength + 1, sizeof(char)));
            fileStream.read(buf, ttRecord.uStringLength);
            if (strlen(buf) > 0) {
                return std::string(buf);
            }
        }

        fileStream.seekg(n_pos);
    }

    return "";
}

std::string GetFontFamilyFromFile(std::wstring& filePath)
{
    std::ifstream fileStream;

    fileStream.open(filePath, std::ifstream::binary);

    if (!fileStream.is_open())
    {
        return "";
    }

    TT_OFFSET_TABLE ttOffsetTable{};
    fileStream.read(reinterpret_cast<char*>(&ttOffsetTable), sizeof(ttOffsetTable));
    ttOffsetTable.uNumOfTables = SWAPWORD(ttOffsetTable.uNumOfTables);
    ttOffsetTable.uMajorVersion = SWAPWORD(ttOffsetTable.uMajorVersion);
    ttOffsetTable.uMinorVersion = SWAPWORD(ttOffsetTable.uMinorVersion);

    //check is this is a true type font and the version is 1.0
    if (ttOffsetTable.uMajorVersion != 1 || ttOffsetTable.uMinorVersion != 0)
    {
        fileStream.close();
        return "";
    }

    bool bFound = false;

    TT_TABLE_DIRECTORY tblDir{};
    for (uint16_t i = 0; i < ttOffsetTable.uNumOfTables; i++)
    {
        fileStream.read(reinterpret_cast<char*>(&tblDir), sizeof(TT_TABLE_DIRECTORY));
        if (strncmp(tblDir.szTag, "name", 4) == 0)
        {
            bFound = TRUE;
            tblDir.uLength = SWAPLONG(tblDir.uLength);
            tblDir.uOffset = SWAPLONG(tblDir.uOffset);
            break;
        }
    }

    if (!bFound)
    {
        fileStream.close();
        return "";
    }

    auto id_name = getNameRecord(fileStream, tblDir, 1);
    fileStream.close();
    return id_name;
}
