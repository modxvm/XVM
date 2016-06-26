/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCameraSniper extends Object implements ICloneable
    {
        public var zooms:Array;
        public var startZoom:*;
        public var zoomIndicator:CExtraField;
        public var dynamicCameraEnabled:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
