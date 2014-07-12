package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.BuildingModernizationVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortModernizationWindowMeta extends AbstractWindowView
    {
        
        public function FortModernizationWindowMeta() {
            super();
        }
        
        public var applyAction:Function = null;
        
        public function applyActionS() : void {
            App.utils.asserter.assertNotNull(this.applyAction,"applyAction" + Errors.CANT_NULL);
            this.applyAction();
        }
        
        public function as_setData(param1:Object) : void {
            var _loc2_:BuildingModernizationVO = new BuildingModernizationVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:BuildingModernizationVO) : void {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
