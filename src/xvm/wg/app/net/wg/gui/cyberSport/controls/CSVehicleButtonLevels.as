package net.wg.gui.cyberSport.controls
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    
    public class CSVehicleButtonLevels extends UIComponent
    {
        
        public function CSVehicleButtonLevels()
        {
            super();
        }
        
        private static var UPDATE_LEVELS:String = "updateLevels";
        
        public var vehicleLevelEff:MovieClip;
        
        public var vehicleLevel:MovieClip;
        
        private var state:String;
        
        private var levels:uint = 0;
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(UPDATE_LEVELS)) && !(this.levels == 0))
            {
                this.vehicleLevel.gotoAndStop(this.levels);
                this.vehicleLevelEff.gotoAndStop(this.levels);
            }
        }
        
        public function setData(param1:uint) : void
        {
            this.levels = param1;
            invalidate(UPDATE_LEVELS);
        }
        
        public function setState(param1:String) : void
        {
            this.state = param1;
            gotoAndPlay(this.state);
        }
    }
}
