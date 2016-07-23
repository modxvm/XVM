/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CConfig extends Object implements ICloneable
    {
        // internal
        public var __stateInfo:Object;
        public var __xvmVersion:String;
        public var __wotVersion:String;
        public var __xvmIntro:String;
        public var __wgApiAvailable:Boolean;
        // public
        public var configVersion:String;
        public var autoReloadConfig:*;
        public var language:String; // auto, en, ru, ...
        public var region:String; // auto, RU, EU, NA, CN, SEA, VN, KR
        public var definition:CDefinition;
        public var login:CLogin;
        public var hangar:CHangar;
        public var userInfo:CUserInfo;
        public var battle:CBattle;
        public var battleLabels:CBattleLabels;
        public var fragCorrelation:CFragCorrelation;
        public var expertPanel:CExpertPanel;
        public var hotkeys:CHotkeys;
        public var squad:CSquad;
        public var battleLoading:CBattleLoading;
        public var battleLoadingTips:CBattleLoading;
        public var statisticForm:CStatisticForm;
        public var playersPanel:CPlayersPanel;
        public var battleResults:CBattleResults;
        public var hitLog:CHitlog;
        public var captureBar:CCaptureBar;
        public var minimap:CMinimap;
        public var minimapAlt:CMinimap;
        public var markers:CMarkers;
        public var colors:CColors;
        public var alpha:CAlpha;
        public var texts:CTexts;
        public var iconset:CIconset;
        public var vehicleNames:Object;
        public var export:CExport;
        public var tooltips:CTooltips;
        public var sounds:CSounds;
        public var xmqp:CXmqp;
        public var consts:Object; // internal

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        public function applyGlobalBattleMacros():void
        {
            if (markers)
            {
                markers.applyGlobalBattleMacros();
            }
            if (statisticForm)
            {
                statisticForm.applyGlobalBattleMacros();
            }
        }
    }
}
