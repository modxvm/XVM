/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CLogin extends Object
    {
        public var saveLastServer:*;
        public var autologin:*;
        public var confirmOldReplays:*;
        public var pingServers:CPingServers;
        public var onlineServers:COnlineServers;
    }
}
