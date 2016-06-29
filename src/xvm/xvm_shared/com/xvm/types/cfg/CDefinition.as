/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CDefinition extends Object implements ICloneable
    {
        public var author:String;
        public var description:String;
        public var url:String;
        public var date:String;
        public var gameVersion:String;
        public var modMinVersion:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
