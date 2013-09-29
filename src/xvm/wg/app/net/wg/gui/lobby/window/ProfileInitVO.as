package net.wg.gui.lobby.window 
{
    import net.wg.data.daapi.base.*;
    
    public class ProfileInitVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ProfileInitVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var name:String="";

        public var registrationDate:String="";

        public var lastBattleDate:String="";

        public var clanName:String="";

        public var clanNameDescr:String="";

        public var clanLabel:String="";

        public var clanJoinTime:String="";

        public var clanPosition:String="";

        public var clanEmblem:*;
    }
}
