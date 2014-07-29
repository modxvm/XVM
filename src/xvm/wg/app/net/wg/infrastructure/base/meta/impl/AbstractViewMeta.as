package net.wg.infrastructure.base.meta.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.data.constants.Errors;
    
    public class AbstractViewMeta extends UIComponent
    {
        
        public function AbstractViewMeta()
        {
            super();
        }
        
        public var registerFlashComponent:Function = null;
        
        public var unregisterFlashComponent:Function = null;
        
        public function registerFlashComponentS(param1:IDAAPIModule, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.registerFlashComponent,"registerFlashComponent" + Errors.CANT_NULL);
            this.registerFlashComponent(param1,param2);
        }
        
        public function unregisterFlashComponentS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.unregisterFlashComponent,"unregisterFlashComponent" + Errors.CANT_NULL);
            this.unregisterFlashComponent(param1);
        }
    }
}
