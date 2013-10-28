/**
 * XVM Config - "login" section
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CLogin extends Object
    {
        public var skipIntro:Boolean; // Skip intro movie
        public var autologin:Boolean; // Autologin
        public var pingServers:CPingServers; // Show ping to the servers
    }
}
