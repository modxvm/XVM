package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class TankCarouselMeta extends net.wg.gui.components.controls.Carousel
    {
        public function TankCarouselMeta()
        {
            super();
            return;
        }

        public function showVehicleInfoS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.showVehicleInfo, "showVehicleInfo" + net.wg.data.constants.Errors.CANT_NULL);
            this.showVehicleInfo(arg1);
            return;
        }

        public function toResearchS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.toResearch, "toResearch" + net.wg.data.constants.Errors.CANT_NULL);
            this.toResearch(arg1);
            return;
        }

        public function vehicleSellS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.vehicleSell, "vehicleSell" + net.wg.data.constants.Errors.CANT_NULL);
            this.vehicleSell(arg1);
            return;
        }

        public function vehicleChangeS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.vehicleChange, "vehicleChange" + net.wg.data.constants.Errors.CANT_NULL);
            this.vehicleChange(arg1);
            return;
        }

        public function buySlotS():void
        {
            App.utils.asserter.assertNotNull(this.buySlot, "buySlot" + net.wg.data.constants.Errors.CANT_NULL);
            this.buySlot();
            return;
        }

        public function buyTankClickS():void
        {
            App.utils.asserter.assertNotNull(this.buyTankClick, "buyTankClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.buyTankClick();
            return;
        }

        public function setVehiclesFilterS(arg1:Number, arg2:String, arg3:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.setVehiclesFilter, "setVehiclesFilter" + net.wg.data.constants.Errors.CANT_NULL);
            this.setVehiclesFilter(arg1, arg2, arg3);
            return;
        }

        public function favoriteVehicleS(arg1:String, arg2:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.favoriteVehicle, "favoriteVehicle" + net.wg.data.constants.Errors.CANT_NULL);
            this.favoriteVehicle(arg1, arg2);
            return;
        }

        public function getVehicleTypeProviderS():Array
        {
            App.utils.asserter.assertNotNull(this.getVehicleTypeProvider, "getVehicleTypeProvider" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getVehicleTypeProvider();
        }

        public var showVehicleInfo:Function=null;

        public var toResearch:Function=null;

        public var vehicleSell:Function=null;

        public var vehicleChange:Function=null;

        public var buySlot:Function=null;

        public var buyTankClick:Function=null;

        public var setVehiclesFilter:Function=null;

        public var favoriteVehicle:Function=null;

        public var getVehicleTypeProvider:Function=null;
    }
}
