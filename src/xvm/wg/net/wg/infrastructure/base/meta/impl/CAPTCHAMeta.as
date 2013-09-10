package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class CAPTCHAMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function CAPTCHAMeta()
        {
            super();
            return;
        }

        public function submitS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.submit, "submit" + net.wg.data.constants.Errors.CANT_NULL);
            this.submit(arg1);
            return;
        }

        public function reloadS():void
        {
            App.utils.asserter.assertNotNull(this.reload, "reload" + net.wg.data.constants.Errors.CANT_NULL);
            this.reload();
            return;
        }

        public var submit:Function=null;

        public var reload:Function=null;
    }
}
