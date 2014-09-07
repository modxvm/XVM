package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.profile.components.ILditInfo;
    import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
    
    public class ClanStatsVO extends DAAPIDataClass
    {
        
        public function ClanStatsVO(param1:Object)
        {
            this.sortieBattlesStats = [];
            this.sortieDefresStats = [];
            this.periodBattlesStats = [];
            this.periodDefresStats = [];
            super(param1);
        }
        
        private static var KEYS_CLAN_STAT_ITEM_VO:Vector.<String> = new <String>["sortieBattlesCount","sortieWins","sortieAvgDefres","periodBattles","periodWins","periodAvgDefres"];
        
        private static var KEYS_GROUPEX:Vector.<String> = new <String>["sortieBattlesStats","sortieDefresStats","periodBattlesStats","periodDefresStats"];
        
        public var clanName:String = "";
        
        public var sortieBattlesCount:ILditInfo;
        
        public var sortieWins:ILditInfo;
        
        public var sortieAvgDefres:ILditInfo;
        
        public var sortieBattlesStats:Array;
        
        public var sortieDefresStats:Array;
        
        public var periodBattles:ILditInfo;
        
        public var periodWins:ILditInfo;
        
        public var periodAvgDefres:ILditInfo;
        
        public var periodBattlesStats:Array;
        
        public var periodDefresStats:Array;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(KEYS_CLAN_STAT_ITEM_VO.indexOf(param1) >= 0)
            {
                this[param1] = new StatisticsHeaderVO(param2);
                return false;
            }
            if(KEYS_GROUPEX.indexOf(param1) >= 0)
            {
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    (this[param1] as Array).push(new ClanStatItemVO(_loc4_));
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
    }
}
