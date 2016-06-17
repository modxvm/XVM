/**
 * XVM - lobby
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class LobbyXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:LOBBY]";
        }

        private static const _views:Object =
        {
            "lobby": LobbyXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
