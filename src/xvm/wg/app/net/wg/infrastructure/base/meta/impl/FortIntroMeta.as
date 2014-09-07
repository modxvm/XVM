package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.views.intro.BaseRallyIntroView;
    import net.wg.gui.lobby.fortifications.data.battleRoom.IntroViewVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortIntroMeta extends BaseRallyIntroView
    {
        
        public function FortIntroMeta()
        {
            super();
        }
        
        public function as_setIntroData(param1:Object) : void
        {
            var _loc2_:IntroViewVO = new IntroViewVO(param1);
            this.setIntroData(_loc2_);
        }
        
        protected function setIntroData(param1:IntroViewVO) : void
        {
            var _loc2_:String = "as_setIntroData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
