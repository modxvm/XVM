package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;
    
    public class ResearchViewMeta extends AbstractView
    {
        
        public function ResearchViewMeta()
        {
            super();
        }
        
        public var request4Unlock:Function = null;
        
        public var request4Buy:Function = null;
        
        public var request4Sell:Function = null;
        
        public var request4SelectInHangar:Function = null;
        
        public var request4ShowVehicleStatistics:Function = null;
        
        public var requestVehicleInfo:Function = null;
        
        public var showSystemMessage:Function = null;
        
        public function request4UnlockS(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            App.utils.asserter.assertNotNull(this.request4Unlock,"request4Unlock" + Errors.CANT_NULL);
            this.request4Unlock(param1,param2,param3,param4);
        }
        
        public function request4BuyS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.request4Buy,"request4Buy" + Errors.CANT_NULL);
            this.request4Buy(param1);
        }
        
        public function request4SellS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.request4Sell,"request4Sell" + Errors.CANT_NULL);
            this.request4Sell(param1);
        }
        
        public function request4SelectInHangarS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.request4SelectInHangar,"request4SelectInHangar" + Errors.CANT_NULL);
            this.request4SelectInHangar(param1);
        }
        
        public function request4ShowVehicleStatisticsS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.request4ShowVehicleStatistics,"request4ShowVehicleStatistics" + Errors.CANT_NULL);
            this.request4ShowVehicleStatistics(param1);
        }
        
        public function requestVehicleInfoS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.requestVehicleInfo,"requestVehicleInfo" + Errors.CANT_NULL);
            this.requestVehicleInfo(param1);
        }
        
        public function showSystemMessageS(param1:String, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.showSystemMessage,"showSystemMessage" + Errors.CANT_NULL);
            this.showSystemMessage(param1,param2);
        }
    }
}
