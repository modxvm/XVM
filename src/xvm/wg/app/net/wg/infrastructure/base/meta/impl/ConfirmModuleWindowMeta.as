package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ConfirmModuleWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function ConfirmModuleWindowMeta()
        {
            super();
            return;
        }

        public function submitS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.submit, "submit" + net.wg.data.constants.Errors.CANT_NULL);
            this.submit(arg1, arg2);
            return;
        }

        public var submit:Function=null;
    }
}
