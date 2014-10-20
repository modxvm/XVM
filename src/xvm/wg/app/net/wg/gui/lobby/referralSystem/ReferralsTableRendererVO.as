package net.wg.gui.lobby.referralSystem
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.VO.UserVO;
    
    public class ReferralsTableRendererVO extends DAAPIDataClass
    {
        
        public function ReferralsTableRendererVO(param1:Object)
        {
            super(param1);
        }
        
        private static var REFERRAL_VO:String = "referralVO";
        
        public var isEmpty:Boolean = true;
        
        public var btnEnabled:Boolean = true;
        
        public var referralNo:String = "";
        
        public var isOnline:Boolean = false;
        
        public var exp:String = "";
        
        public var multiplier:String = "";
        
        public var btnTooltip:String = "";
        
        public var referralVO:UserVO = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == REFERRAL_VO && !(param2 == null))
            {
                this.referralVO = new UserVO(param2);
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            this.referralVO.dispose();
            this.referralVO = null;
            super.onDispose();
        }
    }
}
