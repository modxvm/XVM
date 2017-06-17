/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CExportFps implements ICloneable
    {
        public var enabled:*;
        public var interval:*;
        public var outputDir:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
