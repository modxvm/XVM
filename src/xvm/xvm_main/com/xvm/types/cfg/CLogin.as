/**
 * XVM Config - "login" section
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CLogin extends Object
    {
        public var skipIntro:Boolean; // Skip intro movie
        public var saveLastServer:Boolean; // Save last server
        public var autologin:Boolean; // Autologin
        public var confirmOldReplays:Boolean; // Auto confirm old replays playing
        public var pingServers:CPingServers; // Show ping to the servers
    }
}
