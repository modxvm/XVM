/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.lobby.online.OnlineServers.OnlineServers;
    import com.xvm.lobby.ping.PingServers.PingServers;

    public class LobbyXvmApp extends XvmAppBase
    {
        public static const AS_UPDATE_BATTLE_TYPE:String = "xvm_hangar.as_update_battle_type";

        private var lobbyXvmMod:LobbyXvmMod;

        public function LobbyXvmApp():void
        {
            Logger.setCounterPrefix("L");
            super(Defines.APP_TYPE_LOBBY);

            lobbyXvmMod = new LobbyXvmMod();
            addChild(lobbyXvmMod);

            // loading ui mods
            XfwComponent.tryLoadUISWF("xvm_lobby", "xvm_lobby_ui.swf", [ "battleResults.swf", "TankCarousel.swf", "nodesLib.swf", "crew.swf" ]);

            // mod: online
            // init as earlier as possible
            OnlineServers.initFeature((Config.config.login.onlineServers.enabled || Config.config.hangar.onlineServers.enabled) && Config.config.__wgApiAvailable);

            // mod: ping
            // init pinger as earlier as possible
            PingServers.initFeature(Config.config.login.pingServers.enabled || Config.config.hangar.pingServers.enabled);

            Xfw.addCommandListener(LobbyXvmApp.AS_UPDATE_BATTLE_TYPE, onUpdateBattleType);

            LobbyMacros.RegisterMyStatMacros();
            LobbyMacros.RegisterVehiclesMacros();
        }

        // PRIVATE

        private function onUpdateBattleType(battleType:String):void
        {
            LobbyMacros.RegisterBattleTypeMacros(battleType);
        }
    }
}
