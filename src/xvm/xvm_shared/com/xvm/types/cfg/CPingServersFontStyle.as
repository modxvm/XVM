/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPingServersFontStyle extends Object implements ICloneable
    {
        public var name:String;
        public var size:*;
        public var bold:*;
        public var italic:*;
        public var color: CPingServersFontStyleColors;
        public var markCurrentServer:*;
        public var serverColor:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
