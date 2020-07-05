[Files]
Source: "3rdparty_unmergf\unmerg_f.dll"; Flags: dontcopy;

[Code]

function UNPACK_divide(Path: String; FileName: String): Byte;
external 'UNPACK_divide@files:unmerg_f.dll cdecl';
