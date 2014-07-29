package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.controls.Carousel;
    import net.wg.data.constants.Errors;
    
    public class TankCarouselMeta extends Carousel
    {
        
        public function TankCarouselMeta()
        {
            super();
        }
        
        public var showVehicleInfo:Function = null;
        
        public var toResearch:Function = null;
        
        public var vehicleSell:Function = null;
        
        public var vehicleChange:Function = null;
        
        public var buySlot:Function = null;
        
        public var buyTankClick:Function = null;
        
        public var setVehiclesFilter:Function = null;
        
        public var favoriteVehicle:Function = null;
        
        public var showVehicleStats:Function = null;
        
        public var getVehicleTypeProvider:Function = null;
        
        public function showVehicleInfoS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.showVehicleInfo,"showVehicleInfo" + Errors.CANT_NULL);
            this.showVehicleInfo(param1);
        }
        
        public function toResearchS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.toResearch,"toResearch" + Errors.CANT_NULL);
            this.toResearch(param1);
        }
        
        public function vehicleSellS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.vehicleSell,"vehicleSell" + Errors.CANT_NULL);
            this.vehicleSell(param1);
        }
        
        public function vehicleChangeS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.vehicleChange,"vehicleChange" + Errors.CANT_NULL);
            this.vehicleChange(param1);
        }
        
        public function buySlotS() : void
        {
            App.utils.asserter.assertNotNull(this.buySlot,"buySlot" + Errors.CANT_NULL);
            this.buySlot();
        }
        
        public function buyTankClickS() : void
        {
            App.utils.asserter.assertNotNull(this.buyTankClick,"buyTankClick" + Errors.CANT_NULL);
            this.buyTankClick();
        }
        
        public function setVehiclesFilterS(param1:Number, param2:String, param3:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setVehiclesFilter,"setVehiclesFilter" + Errors.CANT_NULL);
            this.setVehiclesFilter(param1,param2,param3);
        }
        
        public function favoriteVehicleS(param1:String, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.favoriteVehicle,"favoriteVehicle" + Errors.CANT_NULL);
            this.favoriteVehicle(param1,param2);
        }
        
        public function showVehicleStatsS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.showVehicleStats,"showVehicleStats" + Errors.CANT_NULL);
            this.showVehicleStats(param1);
        }
        
        public function getVehicleTypeProviderS() : Array
        {
            App.utils.asserter.assertNotNull(this.getVehicleTypeProvider,"getVehicleTypeProvider" + Errors.CANT_NULL);
            return this.getVehicleTypeProvider();
        }
    }
}
