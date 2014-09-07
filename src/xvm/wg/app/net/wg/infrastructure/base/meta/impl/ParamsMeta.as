package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.hangar.data.HangarParamsVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class ParamsMeta extends BaseDAAPIComponent
    {
        
        public function ParamsMeta()
        {
            super();
        }
        
        public function as_setValues(param1:Object) : void
        {
            var _loc2_:HangarParamsVO = new HangarParamsVO(param1);
            this.setValues(_loc2_);
        }
        
        protected function setValues(param1:HangarParamsVO) : void
        {
            var _loc2_:String = "as_setValues" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
