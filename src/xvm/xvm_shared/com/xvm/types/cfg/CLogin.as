/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CLogin implements ICloneable
    {
        public var saveLastServer:*;
        public var autologin:*;
        public var confirmOldReplays:*;
        public var pingServers:CPingServers;
        public var onlineServers:COnlineServers;
        public var widgets:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
