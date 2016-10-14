/**
 * XVM - lobby
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.infrastructure.*;
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
    import com.xvm.lobby.ping.PingLoginXvmView;
    import com.xvm.lobby.ping.PingLobbyXvmView;
    import com.xvm.lobby.profile.ProfileXvmView;
    import com.xvm.lobby.squad.SquadXvmView;
    import com.xvm.lobby.techtree.ResearchXvmView;
    import com.xvm.lobby.techtree.TechTreeXvmView;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;

    import com.xvm.lobby.vo.VOLobbyMacrosOptions; VOLobbyMacrosOptions;

    public class LobbyXvmMod extends XvmModBase
    {
        public function LobbyXvmMod()
        {
            super();
            Xvm.addEventListener(HangarXvmView.ON_HANGAR_AFTER_POPULATE, onHangarAfterPopulate);
            Xvm.addEventListener(HangarXvmView.ON_HANGAR_BEFORE_DISPOSE, onHangarBeforeDispose);
        }

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

        public override function get views():Object
        {
            return _views;
        }

        override protected function processView(view:IView, populated:Boolean):Vector.<IXfwView>
        {
            try
            {
                var mods:Vector.<IXfwView> = super.processView(view, populated);
                if (view.as_config.alias == "lobby" && mods)
                {
                    for each (var mod:IXfwView in mods)
                    {
                        if (mod is ClockXvmView)
                        {
                            _clockXvmView = mod as ClockXvmView;
                        }
                        else if (mod is OnlineLobbyXvmView)
                        {
                            _onlineLobbyXvmView = mod as OnlineLobbyXvmView;
                        }
                        else if (mod is PingLobbyXvmView)
                        {
                            _pingLobbyXvmView = mod as PingLobbyXvmView;
                        }
                    }
                }
                return mods;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        // PRIVATE

        private var _clockXvmView:ClockXvmView = null;
        private var _onlineLobbyXvmView:OnlineLobbyXvmView = null;
        private var _pingLobbyXvmView:PingLobbyXvmView = null;

        private function onHangarAfterPopulate():void
        {
            setModsVisibility(true);
        }

        private function onHangarBeforeDispose():void
        {
            setModsVisibility(false);
        }

        private function setModsVisibility(isHangar:Boolean):void
        {
            if (_clockXvmView)
            {
                _clockXvmView.setVisibility(isHangar);
            }
            if (_onlineLobbyXvmView)
            {
                _onlineLobbyXvmView.setVisibility(isHangar);
            }
            if (_pingLobbyXvmView)
            {
                _pingLobbyXvmView.setVisibility(isHangar);
            }
        }
    }
}
