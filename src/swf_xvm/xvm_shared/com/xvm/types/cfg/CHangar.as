/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHangar implements ICloneable
    {
        public var enableGoldLocker:*;
        public var enableFreeXpLocker:*;
        public var enableCrystalLocker:*;
        public var hidePricesInTechTree:*;
        public var masteryMarkInTechTree:*;
        public var enableCrewAutoReturn:*;
        public var crewReturnByDefault:*;
        public var crewMaxPerksCount:*;
        public var pingServers:CPingServers;
        public var onlineServers:COnlineServers;
        public var serverInfo:CHangarElement;
        public var vehicleName: CHangarElement;
        public var showBuyPremiumButton:*;
        public var showPremiumShopButton:*;
        public var showCreateSquadButtonText:*;
        public var showBattleTypeSelectorText:*;
        public var carousel:CCarousel;
        public var widgets:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
