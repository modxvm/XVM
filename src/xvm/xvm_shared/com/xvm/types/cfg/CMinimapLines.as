/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    CMinimapLine;

    public dynamic class CMinimapLines extends Object implements ICloneable
    {
        public var vehicle:Array;
        public var camera:Array;
        public var traverseAngle:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
