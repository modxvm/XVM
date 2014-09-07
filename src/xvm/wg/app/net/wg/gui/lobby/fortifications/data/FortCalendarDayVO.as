package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.interfaces.ICalendarDayVO;
    
    public class FortCalendarDayVO extends DAAPIDataClass implements ICalendarDayVO
    {
        
        public function FortCalendarDayVO(param1:Object)
        {
            super(param1);
        }
        
        private static var RAW_DATE_FIELD:String = "rawDate";
        
        public var rawDate:Number = NaN;
        
        private var _available:Boolean = true;
        
        private var _tooltipHeader:String = "";
        
        private var _tooltipBody:String = "";
        
        private var _iconSource:String = "";
        
        private var parsedDate:Date;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == RAW_DATE_FIELD)
            {
                this.parsedDate = App.utils.dateTime.fromPyTimestamp(param2 as Number);
            }
            return true;
        }
        
        public function get date() : Date
        {
            return this.parsedDate;
        }
        
        public function get available() : Boolean
        {
            return this._available;
        }
        
        public function set available(param1:Boolean) : void
        {
            this._available = param1;
        }
        
        public function get tooltipHeader() : String
        {
            return this._tooltipHeader;
        }
        
        public function set tooltipHeader(param1:String) : void
        {
            this._tooltipHeader = param1;
        }
        
        public function get tooltipBody() : String
        {
            return this._tooltipBody;
        }
        
        public function set tooltipBody(param1:String) : void
        {
            this._tooltipBody = param1;
        }
        
        public function get iconSource() : String
        {
            return this._iconSource;
        }
        
        public function set iconSource(param1:String) : void
        {
            this._iconSource = param1;
        }
    }
}
