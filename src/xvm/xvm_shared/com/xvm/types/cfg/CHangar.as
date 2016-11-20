/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHangar extends Object implements ICloneable
    {
        public var xwnInCompany:*;
        public var enableGoldLocker:*;
        public var enableFreeXpLocker:*;
        public var defaultBoughtForCredits:*;
        public var hidePricesInTechTree:*;
        public var masteryMarkInTechTree:*;
        public var allowExchangeXPInTechTree:*;
        public var enableCrewAutoReturn:*;
        public var crewReturnByDefault:*;
        public var crewMaxPerksCount:*;
        public var barracksShowFlags:*;
        public var barracksShowSkills:*;
        public var enableEquipAutoReturn:*;
        public var blockVehicleIfLowAmmo:*;
        public var lowAmmoPercentage:*;
        public var widgetsEnabled:*;
        public var pingServers:CPingServers;
        public var onlineServers:COnlineServers;
        public var serverInfo:CHangarServerInfo;
        public var showBuyPremiumButton:*;
        public var showPremiumShopButton:*;
        public var showNotificationsCounter:*;
        public var carousel:CCarousel;
        public var clock:CHangarClock;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
