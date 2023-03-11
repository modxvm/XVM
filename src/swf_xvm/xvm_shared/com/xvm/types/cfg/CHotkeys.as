/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHotkeys implements ICloneable
    {
        public var minimapZoom:CHotkeysParams;
        public var minimapAltMode:CHotkeysParams;
        public var playersPanelAltMode:CHotkeysParams;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
