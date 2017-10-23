/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CDefinition implements ICloneable
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
