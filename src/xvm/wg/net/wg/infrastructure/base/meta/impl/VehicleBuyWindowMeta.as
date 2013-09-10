package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class VehicleBuyWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function VehicleBuyWindowMeta()
        {
            super();
            return;
        }

        public function submitS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.submit, "submit" + net.wg.data.constants.Errors.CANT_NULL);
            this.submit(arg1);
            return;
        }

        public function storeSettingsS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.storeSettings, "storeSettings" + net.wg.data.constants.Errors.CANT_NULL);
            this.storeSettings(arg1);
            return;
        }

        public var submit:Function=null;

        public var storeSettings:Function=null;
    }
}
