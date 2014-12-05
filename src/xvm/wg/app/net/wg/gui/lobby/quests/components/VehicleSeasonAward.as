package net.wg.gui.lobby.quests.components
{
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.tooltips.helpers.TankTypeIco;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.quests.data.seasonAwards.BaseSeasonAwardVO;
    import net.wg.gui.lobby.quests.data.seasonAwards.VehicleSeasonAwardVO;
    import scaleform.clik.constants.InvalidationType;
    
    public class VehicleSeasonAward extends SeasonAward
    {
        
        public function VehicleSeasonAward()
        {
            super();
        }
        
        public var iconLoader:UILoaderAlt;
        
        public var levelIconLoader:UILoaderAlt;
        
        public var typeIcon:TankTypeIco;
        
        public var nameTf:TextField;
        
        public var buttonAbout:SoundButtonEx;
        
        public var nationFlag:MovieClip;
        
        private var _vehicleId:Number;
        
        private var _buttonAboutCallback:Function;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.buttonAbout.addEventListener(ButtonEvent.PRESS,this.onButtonAboutPress);
        }
        
        private function onButtonAboutPress(param1:ButtonEvent) : void
        {
            if(this._buttonAboutCallback != null)
            {
                this._buttonAboutCallback(this._vehicleId);
            }
        }
        
        public function set buttonAboutCallback(param1:Function) : void
        {
            this._buttonAboutCallback = param1;
        }
        
        override public function setData(param1:BaseSeasonAwardVO) : void
        {
            var _loc2_:VehicleSeasonAwardVO = param1 as VehicleSeasonAwardVO;
            App.utils.asserter.assertNotNull(_loc2_,"data must be VehicleSeasonAwardVO");
            this.buttonAbout.label = _loc2_.buttonText;
            this.buttonAbout.tooltip = _loc2_.buttonTooltipId;
            this.typeIcon.type = _loc2_.vehicleType;
            this.nameTf.htmlText = _loc2_.name;
            this.iconLoader.source = _loc2_.iconPath;
            this.levelIconLoader.source = _loc2_.levelIconPath;
            this._vehicleId = _loc2_.vehicleId;
            this.nationFlag.gotoAndStop(_loc2_.nation);
            invalidateData();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.layoutVehicleInfo();
            }
        }
        
        private function layoutVehicleInfo() : void
        {
            var _loc3_:* = NaN;
            var _loc1_:Number = 5;
            var _loc2_:Number = this.nameTf.x + this.nameTf.textWidth - this.levelIconLoader.x + _loc1_;
            _loc3_ = this.iconLoader.x + (this.iconLoader.width - _loc2_) * 0.5 - this.levelIconLoader.x;
            this.levelIconLoader.x = this.levelIconLoader.x + _loc3_;
            this.typeIcon.x = this.typeIcon.x + _loc3_;
            this.nameTf.x = this.nameTf.x + _loc3_;
        }
        
        override protected function onDispose() : void
        {
            this.iconLoader.dispose();
            this.iconLoader = null;
            this.levelIconLoader.dispose();
            this.levelIconLoader = null;
            this.buttonAbout.removeEventListener(ButtonEvent.PRESS,this.onButtonAboutPress);
            this.buttonAbout.dispose();
            this.buttonAbout = null;
            this.typeIcon.dispose();
            this.typeIcon = null;
            this.nameTf = null;
            this._buttonAboutCallback = null;
            this.nationFlag = null;
            super.onDispose();
        }
        
        override public function getTabIndexItems() : Array
        {
            return [this.buttonAbout];
        }
    }
}
