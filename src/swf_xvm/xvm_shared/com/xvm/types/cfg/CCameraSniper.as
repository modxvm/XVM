/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCameraSniper implements ICloneable
    {
        public var zoomIndicator:CExtraField;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
