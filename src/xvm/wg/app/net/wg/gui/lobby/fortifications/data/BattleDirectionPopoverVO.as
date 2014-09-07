package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BattleDirectionPopoverVO extends DAAPIDataClass
    {
        
        public function BattleDirectionPopoverVO(param1:Object)
        {
            this._battlesList = [];
            super(param1);
        }
        
        private static var BATTLES_LIST:String = "battlesList";
        
        private var _title:String = "";
        
        private var _nextBattles:String = "";
        
        private var _battlesList:Array;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            var _loc4_:BattleDirectionRendererVO = null;
            if(param1 == BATTLES_LIST)
            {
                for each(_loc3_ in param2)
                {
                    _loc4_ = new BattleDirectionRendererVO(_loc3_);
                    this._battlesList.push(_loc4_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            if(this._battlesList)
            {
                this._battlesList.splice(0,this._battlesList.length);
                this._battlesList = null;
            }
            super.onDispose();
        }
        
        public function get title() : String
        {
            return this._title;
        }
        
        public function set title(param1:String) : void
        {
            this._title = param1;
        }
        
        public function get nextBattles() : String
        {
            return this._nextBattles;
        }
        
        public function set nextBattles(param1:String) : void
        {
            this._nextBattles = param1;
        }
        
        public function get battlesList() : Array
        {
            return this._battlesList;
        }
        
        public function set battlesList(param1:Array) : void
        {
            this._battlesList = param1;
        }
    }
}
