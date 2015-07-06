/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public dynamic class CConfig extends Object
    {
        // internal
        public var __stateInfo:Object;
        public var __xvmVersion:String;
        public var __wotVersion:String;
        public var __xvmIntro:String;
        public var __wgApiAvailable:Boolean;
        // public
        public var configVersion:String;
        public var autoReloadConfig:Boolean;
        public var language:String; // auto, en, ru, ...
        public var region:String; // auto, RU, EU, NA, CN, SEA, VN, KR
        public var definition:CDefinition;
        public var login:CLogin;
        public var hangar:CHangar;
        public var userInfo:CUserInfo;
        public var squad:CSquad;
        public var battleResults:CBattleResults;
        public var battle:CBattle;
        public var battleLoading:CBattleLoading;
        public var statisticForm:CStatisticForm;
        public var playersPanel:CPlayersPanel;
        public var expertPanel:CExpertPanel;
        public var captureBar:CCaptureBar;
        public var hitLog:CHitlog;
        public var minimap:CMinimap;
        public var minimapAlt:CMinimap;
        public var markers:CMarkers;
        public var colors:CColors;
        public var alpha:CAlpha;
        public var texts:CTexts;
        public var tooltips:CTooltips;
        public var sounds:CSounds;
        public var vehicleNames:Object;
        public var export:CExport;
        public var consts:Object; // internal
    }
}
