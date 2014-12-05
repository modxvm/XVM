package net.wg.gui.lobby.quests.data.seasonAwards
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.constants.generated.QUESTS_SEASON_AWARDS_TYPES;
    
    public class SeasonAwardsVO extends DAAPIDataClass
    {
        
        public function SeasonAwardsVO(param1:Object)
        {
            super(param1);
        }
        
        public var windowTitle:String = "";
        
        public var basicAwardsTitle:String = "";
        
        public var basicAwards:Array = null;
        
        public var extraAwardsTitle:String = "";
        
        public var extraAwards:Array = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            switch(param1)
            {
                case "extraAwards":
                    this.extraAwards = this.parseAwards(param2);
                    return false;
                case "basicAwards":
                    this.basicAwards = this.parseAwards(param2);
                    return false;
                default:
                    return true;
            }
        }
        
        private function parseAwards(param1:Object) : Array
        {
            var _loc4_:Object = null;
            var _loc2_:Array = new Array();
            var _loc3_:Array = param1 as Array;
            for each(_loc4_ in _loc3_)
            {
                App.utils.asserter.assertNotNull(_loc4_,"Season basic award data object must be non null!");
                _loc2_.push(this.parseBasicAwardItem(_loc4_));
            }
            return _loc2_;
        }
        
        private function parseBasicAwardItem(param1:Object) : BaseSeasonAwardVO
        {
            App.utils.asserter.assert((param1.hasOwnProperty("type")) && !(param1["type"] == undefined),"Season basic award type must be non null!");
            var _loc2_:int = param1["type"];
            switch(_loc2_)
            {
                case QUESTS_SEASON_AWARDS_TYPES.VEHICLE:
                    return new VehicleSeasonAwardVO(param1);
                case QUESTS_SEASON_AWARDS_TYPES.FEMALE_TANKMAN:
                case QUESTS_SEASON_AWARDS_TYPES.COMMENDATION_LISTS:
                    return new IconTitleDescSeasonAwardVO(param1);
                default:
                    App.utils.asserter.assert(false,"Can\'t recognize season basic award type " + _loc2_);
                    return null;
            }
        }
        
        private function disposeAwards(param1:Array) : void
        {
            var _loc2_:BaseSeasonAwardVO = null;
            if(param1)
            {
                while(param1.length > 0)
                {
                    _loc2_ = param1.pop();
                    _loc2_.dispose();
                }
            }
        }
        
        override protected function onDispose() : void
        {
            this.disposeAwards(this.basicAwards);
            this.disposeAwards(this.extraAwards);
            this.basicAwards = null;
            this.extraAwards = null;
            super.onDispose();
        }
    }
}
