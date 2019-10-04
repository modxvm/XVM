package net.wg.gui.bootcamp.battleResult.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;

    public class BCBattleViewVO extends DAAPIDataClass
    {

        private static const STATS_FIELD:String = "stats";

        private static const UNLOCKS_FIELD:String = "unlocksAndMedals";

        private static const VEHICLE_FIELD:String = "playerVehicle";

        private static const XP_STATS_FIELD:String = "xp";

        private static const CREDITS_STATS_FIELD:String = "credits";

        public var stats:DataProvider;

        public var unlocksAndMedals:DataProvider;

        public var showRewards:Boolean = true;

        public var credits:RewardDataVO = null;

        public var xp:RewardDataVO = null;

        public var hasUnlocks:Boolean = false;

        public var finishReasonStr:String = "";

        public var playerVehicle:PlayerVehicleVO = null;

        public var background:String = "";

        public var resultTypeStr:String = "";

        public function BCBattleViewVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            var _loc4_:BattleItemRendrerVO = null;
            var _loc5_:Array = null;
            if(param1 == STATS_FIELD)
            {
                this.stats = new DataProvider();
                _loc5_ = param2 as Array;
                for each(_loc3_ in _loc5_)
                {
                    _loc4_ = new BattleItemRendrerVO(_loc3_);
                    this.stats.push(_loc4_);
                }
                return false;
            }
            if(param1 == UNLOCKS_FIELD)
            {
                this.unlocksAndMedals = new DataProvider();
                _loc5_ = param2 as Array;
                for each(_loc3_ in _loc5_)
                {
                    _loc4_ = new BattleItemRendrerVO(_loc3_);
                    this.unlocksAndMedals.push(_loc4_);
                }
                return false;
            }
            if(param1 == VEHICLE_FIELD)
            {
                this.playerVehicle = new PlayerVehicleVO(param2);
                return false;
            }
            if(param1 == XP_STATS_FIELD)
            {
                this.xp = new RewardDataVO(param2);
                return false;
            }
            if(param1 == CREDITS_STATS_FIELD)
            {
                this.credits = new RewardDataVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:BattleItemRendrerVO = null;
            if(this.stats)
            {
                for each(_loc1_ in this.stats)
                {
                    _loc1_.dispose();
                }
                this.stats.cleanUp();
                this.stats = null;
            }
            if(this.unlocksAndMedals)
            {
                for each(_loc1_ in this.unlocksAndMedals)
                {
                    _loc1_.dispose();
                }
                this.unlocksAndMedals.cleanUp();
                this.unlocksAndMedals = null;
            }
            this.resultTypeStr = null;
            this.background = null;
            this.finishReasonStr = null;
            this.xp.dispose();
            this.xp = null;
            this.credits.dispose();
            this.credits = null;
            this.playerVehicle.dispose();
            this.playerVehicle = null;
            super.onDispose();
        }
    }
}
