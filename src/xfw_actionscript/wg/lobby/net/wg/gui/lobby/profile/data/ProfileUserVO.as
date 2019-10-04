package net.wg.gui.lobby.profile.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class ProfileUserVO extends DAAPIDataClass
    {

        public var name:String = "";

        public var registrationDate:String = "";

        public var lastBattleDate:String = "";

        public function ProfileUserVO(param1:Object)
        {
            super(param1);
        }
    }
}
