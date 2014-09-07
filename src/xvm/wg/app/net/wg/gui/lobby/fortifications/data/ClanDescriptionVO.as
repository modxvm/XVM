package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ClanDescriptionVO extends DAAPIDataClass
    {
        
        public function ClanDescriptionVO(param1:Object)
        {
            super(param1);
        }
        
        private static var FIELD_DIRECTIONS:String = "directions";
        
        private static var KEYS_CLAN_DESCR_ITEM_VO:Vector.<String> = new <String>["clanBattles","clanWins","clanAvgDefres"];
        
        public var canAttackDirection:Boolean = false;
        
        public var canAddToFavorite:Boolean = false;
        
        public var numOfFavorites:int = 0;
        
        public var favoritesLimit:int = 0;
        
        public var dateSelected:String = "";
        
        public var selectedDayTimestamp:Number = NaN;
        
        public var isSelected:Boolean = false;
        
        public var haveResults:Boolean = false;
        
        public var clanEmblem:String = "";
        
        public var clanTag:String = "";
        
        public var clanName:String = "";
        
        public var clanInfo:String = "";
        
        public var isFavorite:Boolean = false;
        
        public var isFrozen:Boolean = false;
        
        public var isWarDeclared:Boolean = false;
        
        public var isAlreadyFought:Boolean = false;
        
        public var warPlannedDate:String = "";
        
        public var warPlannedTime:String = "";
        
        public var warPlannedTimeTT:String = "";
        
        public var warNextAvailableDate:String = "";
        
        public var clanBattles:ClanStatItemVO;
        
        public var clanWins:ClanStatItemVO;
        
        public var clanAvgDefres:ClanStatItemVO;
        
        public var clanId:Number = -1;
        
        public var directions:Array;
        
        public function get hasDirections() : Boolean
        {
            return (this.directions) && this.directions.length > 0;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:DirectionVO = null;
            if(KEYS_CLAN_DESCR_ITEM_VO.indexOf(param1) >= 0)
            {
                this[param1] = new ClanStatItemVO(param2);
                return false;
            }
            if(param1 == FIELD_DIRECTIONS)
            {
                this.directions = [];
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = _loc4_?new DirectionVO(_loc4_):null;
                    this.directions.push(_loc5_);
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            var _loc2_:ClanStatItemVO = null;
            var _loc1_:Vector.<ClanStatItemVO> = new <ClanStatItemVO>[this.clanBattles,this.clanWins,this.clanAvgDefres];
            while(_loc1_.length > 0)
            {
                _loc2_ = _loc1_.pop();
                if(_loc2_ != null)
                {
                    _loc2_.dispose();
                }
            }
            this.clanBattles = null;
            this.clanWins = null;
            this.clanAvgDefres = null;
            this.disposeDirections();
            super.onDispose();
        }
        
        private function disposeDirections() : void
        {
            var _loc1_:DirectionVO = null;
            if(this.directions)
            {
                for each(_loc1_ in this.directions)
                {
                    if(_loc1_)
                    {
                        _loc1_.dispose();
                    }
                }
                this.directions.splice(0);
                this.directions = null;
            }
        }
    }
}
