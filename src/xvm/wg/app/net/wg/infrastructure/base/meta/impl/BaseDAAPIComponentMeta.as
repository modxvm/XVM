package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    
    public class BaseDAAPIComponentMeta extends scaleform.clik.core.UIComponent
    {
        public function BaseDAAPIComponentMeta()
        {
            super();
            return;
        }

        public function registerFlashComponentS(arg1:net.wg.infrastructure.interfaces.IDAAPIModule, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.registerFlashComponent, "registerFlashComponent" + net.wg.data.constants.Errors.CANT_NULL);
            this.registerFlashComponent(arg1, arg2);
            return;
        }

        public function isFlashComponentRegisteredS(arg1:String):Boolean
        {
            App.utils.asserter.assertNotNull(this.isFlashComponentRegistered, "isFlashComponentRegistered" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isFlashComponentRegistered(arg1);
        }

        public function unregisterFlashComponentS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.unregisterFlashComponent, "unregisterFlashComponent" + net.wg.data.constants.Errors.CANT_NULL);
            this.unregisterFlashComponent(arg1);
            return;
        }

        public var registerFlashComponent:Function=null;

        public var isFlashComponentRegistered:Function=null;

        public var unregisterFlashComponent:Function=null;
    }
}
