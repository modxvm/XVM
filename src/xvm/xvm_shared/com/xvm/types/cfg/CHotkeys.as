/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHotkeys extends Object implements ICloneable
    {
        public var minimapZoom:CHotkeysParams;
        public var minimapAltMode:CHotkeysParams;
        public var playersPanelAltMode:CHotkeysParams;
        public var markersAltMode:CHotkeysParams;
        public var battleLabelsHotKeys:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
