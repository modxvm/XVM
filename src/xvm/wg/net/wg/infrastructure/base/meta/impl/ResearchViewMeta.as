package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ResearchViewMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function ResearchViewMeta()
        {
            super();
            return;
        }

        public function request4UnlockS(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            App.utils.asserter.assertNotNull(this.request4Unlock, "request4Unlock" + net.wg.data.constants.Errors.CANT_NULL);
            this.request4Unlock(arg1, arg2, arg3, arg4);
            return;
        }

        public function request4BuyS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.request4Buy, "request4Buy" + net.wg.data.constants.Errors.CANT_NULL);
            this.request4Buy(arg1);
            return;
        }

        public function request4SellS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.request4Sell, "request4Sell" + net.wg.data.constants.Errors.CANT_NULL);
            this.request4Sell(arg1);
            return;
        }

        public function requestVehicleInfoS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.requestVehicleInfo, "requestVehicleInfo" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestVehicleInfo(arg1);
            return;
        }

        public function showSystemMessageS(arg1:String, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.showSystemMessage, "showSystemMessage" + net.wg.data.constants.Errors.CANT_NULL);
            this.showSystemMessage(arg1, arg2);
            return;
        }

        public var request4Unlock:Function=null;

        public var request4Buy:Function=null;

        public var request4Sell:Function=null;

        public var requestVehicleInfo:Function=null;

        public var showSystemMessage:Function=null;
    }
}
