package net.wg.gui.lobby.profile.components
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.profile.data.ProfileUserVO;
    import scaleform.clik.constants.InvalidationType;
    
    public class ProfileFooter extends UIComponent
    {
        
        public function ProfileFooter()
        {
            super();
        }
        
        protected var initData:ProfileUserVO;
        
        public function setUserData(param1:ProfileUserVO) : void
        {
            this.initData = param1;
            invalidateData();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.initData))
            {
                this.applyDataChanges();
            }
        }
        
        protected function applyDataChanges() : void
        {
        }
        
        override protected function onDispose() : void
        {
            this.initData = null;
            super.onDispose();
        }
    }
}
