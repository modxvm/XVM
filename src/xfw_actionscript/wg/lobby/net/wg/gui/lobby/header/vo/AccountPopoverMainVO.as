package net.wg.gui.lobby.header.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.VO.UserVO;

    public class AccountPopoverMainVO extends DAAPIDataClass
    {

        private static const USER_DATA:String = "userData";

        public var isTeamKiller:Boolean = false;

        public var boostersBlockTitle:String = "";

        public var boostersBlockTitleTooltip:String = "";

        public var badgeIcon:String = "";

        private var _userData:UserVO = null;

        public function AccountPopoverMainVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == USER_DATA)
            {
                this._userData = new UserVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            this._userData.dispose();
            this._userData = null;
            super.onDispose();
        }

        public function get userData() : UserVO
        {
            return this._userData;
        }
    }
}
