/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CLogin extends Object implements ICloneable
    {
        public var saveLastServer:*;
        public var autologin:*;
        public var confirmOldReplays:*;
        public var pingServers:CPingServers;
        public var onlineServers:COnlineServers;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
