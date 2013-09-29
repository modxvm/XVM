package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class VehicleSellDialogMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function VehicleSellDialogMeta()
        {
            super();
            return;
        }

        public function getDialogSettingsS():Object
        {
            App.utils.asserter.assertNotNull(this.getDialogSettings, "getDialogSettings" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getDialogSettings();
        }

        public function setDialogSettingsS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.setDialogSettings, "setDialogSettings" + net.wg.data.constants.Errors.CANT_NULL);
            this.setDialogSettings(arg1);
            return;
        }

        public function sellS(arg1:Object, arg2:Array, arg3:Array, arg4:Array, arg5:Array, arg6:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.sell, "sell" + net.wg.data.constants.Errors.CANT_NULL);
            this.sell(arg1, arg2, arg3, arg4, arg5, arg6);
            return;
        }

        public function setUserInputS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.setUserInput, "setUserInput" + net.wg.data.constants.Errors.CANT_NULL);
            this.setUserInput(arg1);
            return;
        }

        public function setResultCreditS(arg1:int):void
        {
            App.utils.asserter.assertNotNull(this.setResultCredit, "setResultCredit" + net.wg.data.constants.Errors.CANT_NULL);
            this.setResultCredit(arg1);
            return;
        }

        public var getDialogSettings:Function=null;

        public var setDialogSettings:Function=null;

        public var sell:Function=null;

        public var setUserInput:Function=null;

        public var setResultCredit:Function=null;
    }
}
