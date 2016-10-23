package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.lobby.online.OnlineServers.OnlineServers;
    import com.xvm.lobby.ping.PingServers.PingServers;

    public class LobbyXvmApp extends XvmAppBase
    {
        private var lobbyXvmMod:LobbyXvmMod;

        public function LobbyXvmApp():void
        {
            lobbyXvmMod = new LobbyXvmMod();
            addChild(lobbyXvmMod);

            Logger.counterPrefix = "L";

            // loading ui mods
            XfwComponent.try_load_ui_swf("xvm_lobby", "xvm_lobby_ui.swf", [ "battleResults.swf", "TankCarousel.swf", "nodesLib.swf", "crew.swf" ]);
            XfwComponent.try_load_ui_swf("xvm_lobby", "xvm_lobbybattleloading_ui.swf", [ "battleloading.swf" ]);

            // mod: online
            // init as earlier as possible
            OnlineServers.initFeature((Config.config.login.onlineServers.enabled || Config.config.hangar.onlineServers.enabled) && Config.config.__wgApiAvailable);

            // mod: ping
            // init pinger as earlier as possible
            PingServers.initFeature(Config.config.login.pingServers.enabled || Config.config.hangar.pingServers.enabled);

            LobbyMacros.RegisterVehiclesMacros();
            LobbyMacros.RegisterClockMacros();
        }
    }
}
