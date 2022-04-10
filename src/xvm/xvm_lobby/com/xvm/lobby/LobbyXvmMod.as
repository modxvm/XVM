/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.lobby.battleresults.BattleResultsXvmView;
    import com.xvm.lobby.contacts.ContactsXvmView;
    import com.xvm.lobby.crew.CrewXvmView;
    import com.xvm.lobby.hangar.HangarXvmView;
    import com.xvm.lobby.limits.LimitsXvmView;
    import com.xvm.lobby.online.OnlineLobbyXvmView;
    import com.xvm.lobby.online.OnlineLoginXvmView;
    import com.xvm.lobby.ping.PingLobbyXvmView;
    import com.xvm.lobby.ping.PingLoginXvmView;
    import com.xvm.lobby.profile.ProfileXvmView;
    import com.xvm.lobby.techtree.ResearchXvmView;
    import com.xvm.lobby.techtree.TechTreeXvmView;
    import com.xvm.lobby.widgets.WidgetsLobbyXvmView;
    import com.xvm.lobby.widgets.WidgetsLoginXvmView;
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

        private static const VIEWS:Object =
        {
            "login": [ OnlineLoginXvmView, PingLoginXvmView, WidgetsLoginXvmView ],
            "lobby": [ LobbyXvmView, LimitsXvmView, OnlineLobbyXvmView, PingLobbyXvmView, WidgetsLobbyXvmView ],
            "hangar": [ CrewXvmView, HangarXvmView ],
            "battleResults": [ BattleResultsXvmView ],
            //"ContactsPopover": [ ContactsXvmView ],
            //"profile": [ ProfileXvmView ],
            //"profileWindow": [ ProfileXvmView ],
            "techtree": [ TechTreeXvmView ],
            "research": [ ResearchXvmView ]
        }

        public override function get views():Object
        {
            return VIEWS;
        }

        override protected function processView(view:IView, populated:Boolean):Vector.<IXfwView>
        {
            try
            {
                var mods:Vector.<IXfwView> = super.processView(view, populated);
                if (view.as_config.alias == "lobby")
                {
                    if (mods)
                    {
                        for each (var mod:IXfwView in mods)
                        {
                            if (mod is OnlineLobbyXvmView)
                            {
                                _onlineLobbyXvmView = mod as OnlineLobbyXvmView;
                            }
                            else if (mod is PingLobbyXvmView)
                            {
                                _pingLobbyXvmView = mod as PingLobbyXvmView;
                            }
                            else if (mod is WidgetsLobbyXvmView)
                            {
                                _widgetsLobbyXvmView = mod as WidgetsLobbyXvmView;
                            }
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

        private var _onlineLobbyXvmView:OnlineLobbyXvmView = null;
        private var _pingLobbyXvmView:PingLobbyXvmView = null;
        private var _widgetsLobbyXvmView:WidgetsLobbyXvmView = null;

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
            if (_onlineLobbyXvmView)
            {
                _onlineLobbyXvmView.setVisibility(isHangar);
            }
            if (_pingLobbyXvmView)
            {
                _pingLobbyXvmView.setVisibility(isHangar);
            }
            if (_widgetsLobbyXvmView)
            {
                _widgetsLobbyXvmView.setVisibility(isHangar);
            }
        }
    }
}
