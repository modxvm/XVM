/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapLine extends Object implements ICloneable
    {
        public var enabled:*;
        public var inmeters:*;
        public var color:*;
        public var from:*;
        public var to:*;
        public var thickness:*;
        public var alpha:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        public static function parse(format:Object):CMinimapLine
        {
            return ObjectConverter.convertData(format, CMinimapLine);
        }
    }
}
