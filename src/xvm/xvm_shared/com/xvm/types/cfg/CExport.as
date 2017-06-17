/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CExport implements ICloneable
    {
        public var fps:CExportFps;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
