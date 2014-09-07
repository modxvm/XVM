package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.interfaces.IClanBattleTimer;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.filters.GlowFilter;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
    import net.wg.data.constants.Values;
    
    public class ClanBattleTimer extends MovieClip implements IClanBattleTimer, IDisposable
    {
        
        public function ClanBattleTimer()
        {
            super();
        }
        
        private static var TIMER_SEPARATOR:String = ":";
        
        private static var TIMER_TICK_SEC:int = 1000;
        
        protected static function getGlowFilter(param1:Number) : Array
        {
            var _loc2_:Array = [];
            var _loc3_:Number = 1;
            var _loc4_:Number = 10;
            var _loc5_:Number = 10;
            var _loc6_:Number = 1.2;
            var _loc7_:Number = 3;
            var _loc8_:* = false;
            var _loc9_:* = false;
            var _loc10_:GlowFilter = new GlowFilter(param1,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
            _loc2_.push(_loc10_);
            return _loc2_;
        }
        
        private static function formatTimeValue(param1:int) : String
        {
            return param1 < 10?"0" + param1.toString():param1.toString();
        }
        
        public var minutes:TextField = null;
        
        public var seconds:TextField = null;
        
        public var separator:TextField = null;
        
        public var leftTime:int = 0;
        
        protected var model:ClanBattleTimerVO = null;
        
        private var min:int = -1;
        
        private var sec:int = -1;
        
        private var date:Date = null;
        
        public function setData(param1:ClanBattleTimerVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            this.model = param1;
            this.updateFilters();
            this.updateSeparator();
            this.leftTime = this.model.deltaTime;
            this.timerHandler();
        }
        
        public function stopTimer() : void
        {
            App.utils.scheduler.cancelTask(this.timerHandler);
        }
        
        public function timerTick() : void
        {
            App.utils.scheduler.scheduleTask(this.timerHandler,TIMER_TICK_SEC);
        }
        
        public function formatDelta(param1:int) : void
        {
            this.date = new Date(null,null,null,null,null,param1);
        }
        
        protected function updateSeparator() : void
        {
            this.separator.htmlText = this.replaceFormatter(TIMER_SEPARATOR);
        }
        
        protected function getSeconds() : int
        {
            return this.date.getSeconds();
        }
        
        protected function getMinutes() : int
        {
            return this.date.getMinutes();
        }
        
        protected function updateText() : void
        {
            this.minutes.htmlText = this.replaceFormatter(formatTimeValue(this.min));
            this.seconds.htmlText = this.replaceFormatter(formatTimeValue(this.sec));
        }
        
        protected function replaceFormatter(param1:String) : String
        {
            return this.model.htmlFormatter.replace("###",param1);
        }
        
        protected function updateFilters() : void
        {
            var _loc1_:Array = null;
            if((this.model) && !(this.model.glowColor == Values.DEFAULT_INT))
            {
                _loc1_ = getGlowFilter(this.model.glowColor);
                this.minutes.filters = _loc1_;
                this.seconds.filters = _loc1_;
                this.separator.filters = _loc1_;
            }
        }
        
        private function timerHandler() : void
        {
            if(this.leftTime <= 0)
            {
                this.stopTimer();
                return;
            }
            this.leftTime = this.leftTime - 1;
            this.updateLabels();
            this.timerTick();
        }
        
        private function updateLabels() : void
        {
            this.formatDelta(this.leftTime);
            this.min = this.getMinutes();
            this.sec = this.getSeconds();
            this.updateText();
        }
        
        public function dispose() : void
        {
            App.utils.scheduler.cancelTask(this.timerHandler);
            this.minutes = null;
            this.seconds = null;
            this.separator = null;
        }
    }
}
