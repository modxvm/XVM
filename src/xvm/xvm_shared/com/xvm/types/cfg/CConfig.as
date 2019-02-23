/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    // add unreferenced classes
    CWidget;

    public dynamic class CConfig implements ICloneable
    {
        // public
        public var alpha:CAlpha;
        public var autoReloadConfig:*;
        public var battle:CBattle;
        public var battleLabels:CBattleLabels;
        public var battleLoading:CBattleLoading;
        public var battleLoadingTips:CBattleLoading;
        public var battleResults:CBattleResults;
        public var captureBar:CCaptureBar;
        public var colors:CColors;
        public var configVersion:String;
        public var hangar:CHangar;
        public var hitLog:CHitlog;
        public var hotkeys:CHotkeys;
        public var iconset:CIconset;
        public var login:CLogin;
        public var markers:CMarkers;
        public var minimap:CMinimap;
        public var minimapAlt:CMinimap;
        public var playersPanel:CPlayersPanel;
        public var region:String; // auto, RU, EU, NA, CN, SEA, VN, KR
        public var statisticForm:CStatisticForm;
        public var texts:CTexts;
        public var userInfo:CUserInfo;
        public var vehicleNames:Object;
        public var xmqp:CXmqp;
        // internal
        public var __wgApiAvailable:Boolean;
        public var __wotVersion:String;
        public var __xvmRevision:String;
        public var __xvmVersion:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        public function applyGlobalBattleMacros():void
        {
            if (battle)
            {
                battle.applyGlobalBattleMacros();
            }
            if (battleLoading)
            {
                battleLoading.applyGlobalBattleMacros();
            }
            if (battleLoadingTips)
            {
                battleLoadingTips.applyGlobalBattleMacros();
            }
            if (markers)
            {
                markers.applyGlobalBattleMacros();
            }
            if (minimap)
            {
                minimap.applyGlobalBattleMacros();
            }
            if (minimapAlt)
            {
                minimapAlt.applyGlobalBattleMacros();
            }
            if (statisticForm)
            {
                statisticForm.applyGlobalBattleMacros();
            }
        }
    }
}
