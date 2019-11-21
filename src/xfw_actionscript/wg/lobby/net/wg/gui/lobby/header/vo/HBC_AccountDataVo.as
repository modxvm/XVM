package net.wg.gui.lobby.header.vo
{
    import net.wg.data.VO.UserVO;

    public class HBC_AccountDataVo extends HBC_AbstractVO
    {

        public var userVO:UserVO = null;

        public var isTeamKiller:Boolean = false;

        public var isAnonymized:Boolean = false;

        public var badgeIcon:String = "";

        public var hasActiveBooster:Boolean = false;

        public var hasAvailableBoosters:Boolean = false;

        public var boosterIcon:String = "";

        public var boosterBg:String = "";

        public var boosterText:String = "";

        public function HBC_AccountDataVo(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            this.userVO.dispose();
            this.userVO = null;
            super.dispose();
        }
    }
}
