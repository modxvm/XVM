package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortClanMemberVO extends DAAPIDataClass
    {
        
        public function FortClanMemberVO(param1:Object)
        {
            super(param1);
        }
        
        public var himself:Boolean = false;
        
        public var dbID:Number = -1;
        
        public var uid:Number = -1;
        
        public var userName:String = "";
        
        public var fullName:String = "";
        
        public var playerRole:String = "";
        
        public var thisWeek:String = "";
        
        public var allTime:String = "";
    }
}
