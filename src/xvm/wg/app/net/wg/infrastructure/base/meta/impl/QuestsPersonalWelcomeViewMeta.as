package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.quests.data.seasonAwards.QuestsPersonalWelcomeViewVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class QuestsPersonalWelcomeViewMeta extends BaseDAAPIComponent
    {
        
        public function QuestsPersonalWelcomeViewMeta()
        {
            super();
        }
        
        public var success:Function = null;
        
        public function successS() : void
        {
            App.utils.asserter.assertNotNull(this.success,"success" + Errors.CANT_NULL);
            this.success();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:QuestsPersonalWelcomeViewVO = new QuestsPersonalWelcomeViewVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:QuestsPersonalWelcomeViewVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
