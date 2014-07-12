package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ClanStatItemVO extends DAAPIDataClass
    {
        
        public function ClanStatItemVO(param1:Object) {
            super(param1);
        }
        
        public var label:String = "";
        
        public var value:String = "";
        
        public var icon:String = "";
        
        public var enabled:Boolean = true;
        
        public var ttHeader:String = "";
        
        public var ttBody:String = "";
    }
}
