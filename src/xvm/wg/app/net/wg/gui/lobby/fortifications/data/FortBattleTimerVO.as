package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortBattleTimerVO extends DAAPIDataClass
    {
        
        public function FortBattleTimerVO(param1:Object)
        {
            super(param1);
        }
        
        private var _timeBeforeBattle:Number = -1;
        
        private var _htmlFormatter:String = "";
        
        private var _battleStartTime:Number = -1;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Date = null;
            var _loc4_:* = NaN;
            if(param1 == "timeBeforeBattle")
            {
                this._timeBeforeBattle = param2 as Number;
                _loc3_ = App.utils.dateTime.now();
                _loc4_ = App.utils.dateTime.toPyTimestamp(_loc3_);
                this._battleStartTime = _loc4_ + this._timeBeforeBattle;
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        public function get timeBeforeBattle() : Number
        {
            return this._timeBeforeBattle;
        }
        
        public function set timeBeforeBattle(param1:Number) : void
        {
            this._timeBeforeBattle = param1;
        }
        
        public function get htmlFormatter() : String
        {
            return this._htmlFormatter;
        }
        
        public function set htmlFormatter(param1:String) : void
        {
            this._htmlFormatter = param1;
        }
        
        public function get battleStartTime() : Number
        {
            return this._battleStartTime;
        }
        
        public function set battleStartTime(param1:Number) : void
        {
            this._battleStartTime = param1;
        }
    }
}
