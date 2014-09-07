package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortCalendarEventVO extends DAAPIDataClass
    {
        
        public function FortCalendarEventVO(param1:Object)
        {
            super(param1);
        }
        
        public var title:String = "";
        
        public var timeInfo:String = "";
        
        public var direction:String = "";
        
        public var result:String = "";
        
        public var icon:String = "";
        
        public var background:String = "";
        
        public var clanID:Number = -1;
        
        public var resultTTHeader:String = "";
        
        public var resultTTBody:String = "";
    }
}
