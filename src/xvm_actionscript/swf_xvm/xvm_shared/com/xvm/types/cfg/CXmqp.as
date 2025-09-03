/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CXmqp implements ICloneable
    {
        public var minimapDrawAlpha:*;
        public var minimapDrawColor:*;
        public var minimapDrawLineThickness:*;
        public var minimapDrawTime:*;
        public var spottedTime:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
