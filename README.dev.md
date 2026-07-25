# Developer Notes

## SWF extraction

```powershell
./build.ps1 com.modxvm.xvm.actionscript swfpatch extract diff
```

## Build flavours

Both clients are built by default. Use `-Flavours` to limit client-specific compilation,
package archives, and the final deployment tree:

```powershell
./build.ps1 -Flavours WG
./build.ps1 -Flavours Lesta
./build.ps1 -Flavours Lesta,WG
```
