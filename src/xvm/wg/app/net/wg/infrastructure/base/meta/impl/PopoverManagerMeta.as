package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIModule;
    import net.wg.data.constants.Errors;
    
    public class PopoverManagerMeta extends BaseDAAPIModule
    {
        
        public function PopoverManagerMeta()
        {
            super();
        }
        
        public var requestShowPopover:Function = null;
        
        public var requestHidePopover:Function = null;
        
        public function requestShowPopoverS(param1:String, param2:Object) : void
        {
            App.utils.asserter.assertNotNull(this.requestShowPopover,"requestShowPopover" + Errors.CANT_NULL);
            this.requestShowPopover(param1,param2);
        }
        
        public function requestHidePopoverS() : void
        {
            App.utils.asserter.assertNotNull(this.requestHidePopover,"requestHidePopover" + Errors.CANT_NULL);
            this.requestHidePopover();
        }
    }
}
