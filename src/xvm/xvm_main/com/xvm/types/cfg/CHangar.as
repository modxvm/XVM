/**
 * XVM Config - "hangar" section
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CHangar extends Object
    {
        public var xwnInCompany:Boolean;
        public var enableGoldLocker:Boolean;
        public var enableFreeXpLocker:Boolean;
        public var defaultBoughtForCredits:Boolean;
        public var hidePricesInTechTree:Boolean;
        public var masteryMarkInTechTree:Boolean;
        public var allowExchangeXPInTechTree:Boolean;
        public var enableCrewAutoReturn:Boolean;
        public var widgetsEnabled:Boolean;
        public var pingServers:CPingServers;
        public var serverInfo:CHangarServerInfo;
        public var carousel:CCarousel;
        public var clock:CHangarClock;
    }
}
