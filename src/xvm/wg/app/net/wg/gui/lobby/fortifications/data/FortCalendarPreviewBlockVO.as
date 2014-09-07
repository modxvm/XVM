package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortCalendarPreviewBlockVO extends DAAPIDataClass
    {
        
        public function FortCalendarPreviewBlockVO(param1:Object)
        {
            super(param1);
        }
        
        private static var EVENTS_FIELD:String = "events";
        
        public var dateString:String = "";
        
        public var dateInfo:String = "";
        
        public var noEventsText:String = "";
        
        public var events:Array = null;
        
        public function get hasEvents() : Boolean
        {
            return (this.events) && this.events.length > 0;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:FortCalendarEventVO = null;
            if(param1 == EVENTS_FIELD)
            {
                this.events = [];
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new FortCalendarEventVO(_loc4_);
                    this.events.push(_loc5_);
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            this.disposeEvents();
            super.onDispose();
        }
        
        private function disposeEvents() : void
        {
            var _loc1_:FortCalendarEventVO = null;
            if(this.events)
            {
                for each(_loc1_ in this.events)
                {
                    if(_loc1_)
                    {
                        _loc1_.dispose();
                    }
                }
                this.events.splice(0);
                this.events = null;
            }
        }
    }
}
