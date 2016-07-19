/**
 * XVM - lobby
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.lobby.battleloading.BattleLoadingXvmView;
    import com.xvm.lobby.battleresults.BattleResultsXvmView;
    import com.xvm.lobby.clock.ClockXvmView;
    import com.xvm.lobby.company.CompanyXvmView;
    import com.xvm.lobby.contacts.ContactsXvmView;
    import com.xvm.lobby.crew.CrewXvmView;
    import com.xvm.lobby.hangar.HangarXvmView;
    import com.xvm.lobby.limits.LimitsXvmView;
    import com.xvm.lobby.loginlayout.LoginLayoutXvmView;
    import com.xvm.lobby.online.OnlineLoginXvmView;
    import com.xvm.lobby.online.OnlineLobbyXvmView;
    import com.xvm.lobby.online.OnlineServers.OnlineServers;
    import com.xvm.lobby.ping.PingLoginXvmView;
    import com.xvm.lobby.ping.PingLobbyXvmView;
    import com.xvm.lobby.ping.PingServers.PingServers;
    import com.xvm.lobby.profile.ProfileXvmView;
    import com.xvm.lobby.squad.SquadXvmView;
    import com.xvm.lobby.techtree.ResearchXvmView;
    import com.xvm.lobby.techtree.TechTreeXvmView;

    import com.xvm.lobby.vo.VOLobbyMacrosOptions; VOLobbyMacrosOptions;

    public class LobbyXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:LOBBY]";
        }

        private static const _views:Object =
        {
            "login": [ LoginLayoutXvmView, OnlineLoginXvmView, PingLoginXvmView/*, WidgetsXvmView*/ ],
            "lobby": [ LobbyXvmView, ClockXvmView, LimitsXvmView, OnlineLobbyXvmView, PingLobbyXvmView/*, WidgetsXvmView*/ ],
            "hangar": [ CrewXvmView, HangarXvmView ],
            "battleLoading": [ BattleLoadingXvmView ],
            "battleResults": [ BattleResultsXvmView ],
            "prb_windows/companyWindow": [ CompanyXvmView ],
            "ContactsPopover": [ ContactsXvmView ],
            "profile": [ ProfileXvmView ],
            "profileWindow": [ ProfileXvmView ],
            "prb_windows/squadWindow": [ SquadXvmView ],
            "techtree": [ TechTreeXvmView ],
            "research": [ ResearchXvmView ]
        }

        override public function entryPoint():void
        {
            super.entryPoint();

            Logger.counterPrefix = "L";

            // loading ui mods
            XfwComponent.try_load_ui_swf("xvm_lobby", "xvm_lobby_ui.swf", [ "battleResults.swf", "TankCarousel.swf", "nodesLib.swf" ]);
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

        public override function get views():Object
        {
            return _views;
        }
    }
}
