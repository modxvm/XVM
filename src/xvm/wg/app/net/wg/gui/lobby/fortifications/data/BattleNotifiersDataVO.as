package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BattleNotifiersDataVO extends DAAPIDataClass
    {
        
        public function BattleNotifiersDataVO(param1:Object)
        {
            this.directionsBattles = new Vector.<BattleNotifierVO>();
            super(param1);
        }
        
        private static var DIRECTIONS_BATTLES:String = "directionsBattles";
        
        public var directionsBattles:Vector.<BattleNotifierVO>;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            var _loc4_:BattleNotifierVO = null;
            if(param1 == DIRECTIONS_BATTLES)
            {
                for each(_loc3_ in param2)
                {
                    _loc4_ = new BattleNotifierVO(_loc3_);
                    this.directionsBattles.push(_loc4_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:BattleNotifierVO = null;
            for each(_loc1_ in this.directionsBattles)
            {
                _loc1_.dispose();
            }
            this.directionsBattles.splice(0,this.directionsBattles.length);
            super.onDispose();
        }
    }
}
