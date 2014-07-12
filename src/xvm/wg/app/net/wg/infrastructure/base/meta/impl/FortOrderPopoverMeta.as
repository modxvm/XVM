package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.OrderPopoverVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortOrderPopoverMeta extends SmartPopOverView
    {
        
        public function FortOrderPopoverMeta() {
            super();
        }
        
        public var requestForCreateOrder:Function = null;
        
        public var requestForUseOrder:Function = null;
        
        public var getLeftTime:Function = null;
        
        public var getLeftTimeStr:Function = null;
        
        public var getLeftTimeTooltip:Function = null;
        
        public function requestForCreateOrderS() : void {
            App.utils.asserter.assertNotNull(this.requestForCreateOrder,"requestForCreateOrder" + Errors.CANT_NULL);
            this.requestForCreateOrder();
        }
        
        public function requestForUseOrderS() : void {
            App.utils.asserter.assertNotNull(this.requestForUseOrder,"requestForUseOrder" + Errors.CANT_NULL);
            this.requestForUseOrder();
        }
        
        public function getLeftTimeS() : Number {
            App.utils.asserter.assertNotNull(this.getLeftTime,"getLeftTime" + Errors.CANT_NULL);
            return this.getLeftTime();
        }
        
        public function getLeftTimeStrS() : String {
            App.utils.asserter.assertNotNull(this.getLeftTimeStr,"getLeftTimeStr" + Errors.CANT_NULL);
            return this.getLeftTimeStr();
        }
        
        public function getLeftTimeTooltipS() : String {
            App.utils.asserter.assertNotNull(this.getLeftTimeTooltip,"getLeftTimeTooltip" + Errors.CANT_NULL);
            return this.getLeftTimeTooltip();
        }
        
        public function as_setInitData(param1:Object) : void {
            var _loc2_:OrderPopoverVO = new OrderPopoverVO(param1);
            this.setInitData(_loc2_);
        }
        
        protected function setInitData(param1:OrderPopoverVO) : void {
            var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
