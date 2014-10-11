/**
 * XVM Config
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.types.cfg
{
    public dynamic class CConfig extends Object
    {
        public var xvmVersion:String;
        public var configVersion:String;
        public var language:String; // auto, en, ru, ...
        public var region:String; // auto, RU, EU, NA, CN, SEA, VN, KR
        public var definition:CDefinition;
        public var rating:CRating;
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
        public var vehicleNames:Object;
        public var consts:Object; // internal
    }
}
