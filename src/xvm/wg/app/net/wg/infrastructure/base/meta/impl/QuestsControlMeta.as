package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.controls.SoundButton;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.header.vo.QuestsControlBtnVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class QuestsControlMeta extends SoundButton
    {
        
        public function QuestsControlMeta()
        {
            super();
        }
        
        public var showQuestsWindow:Function = null;
        
        public function showQuestsWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.showQuestsWindow,"showQuestsWindow" + Errors.CANT_NULL);
            this.showQuestsWindow();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:QuestsControlBtnVO = new QuestsControlBtnVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:QuestsControlBtnVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
