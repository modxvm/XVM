package net.wg.gui.components.advanced
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    
    public class ToggleButton extends ButtonIconLoader
    {
        
        public function ToggleButton()
        {
            super();
            this.rFlagsFrame.visible = false;
            this.vType.visible = false;
            _data = {};
            this.hightLight.visible = false;
        }
        
        public static var FLAGS_SOURCE:String = "../maps/icons/filters/nations/";
        
        public var rFlagsFrame:Sprite;
        
        public var vType:MovieClip;
        
        public var sizeArea:MovieClip;
        
        public var hightLight:MovieClip;
        
        public var toggleBg:MovieClip;
        
        private var _vehicleType:String = null;
        
        private var _nationFlag:String = null;
        
        private var _buttonCursor:Boolean = false;
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            this.alpha = param1?1:0.5;
        }
        
        public function get vehicleType() : String
        {
            return this._vehicleType;
        }
        
        public function set vehicleType(param1:String) : void
        {
            if((param1) && !(param1 == "") && !(param1 == "none"))
            {
                this._vehicleType = param1;
                this.rFlagsFrame.visible = false;
                this.changeViewState(true);
            }
        }
        
        public function get nationFlag() : String
        {
            return this._nationFlag;
        }
        
        public function set nationFlag(param1:String) : void
        {
            if((param1) && !(param1 == "") && !(param1 == "none"))
            {
                this._nationFlag = param1;
                externalSource = true;
                _data = this._nationFlag;
                iconSource = FLAGS_SOURCE + this._nationFlag + ".png";
                this.rFlagsFrame.visible = true;
                this.changeViewState(false);
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.sizeArea.visible = false;
            buttonMode = true;
            this._buttonCursor = false;
            mouseChildren = true;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.STATE)) && (this.hightLight))
            {
                this.hightLight.visible = selected;
            }
        }
        
        protected function changeViewState(param1:Boolean) : void
        {
            if(externalSource)
            {
                return;
            }
            this.vType.visible = param1;
            if(param1)
            {
                this.vType.gotoAndStop(this.vehicleType);
                _data = this.vehicleType;
            }
        }
        
        override protected function completeHandler(param1:Event) : void
        {
            if((loader) && (this.toggleBg.contains(loader)))
            {
                this.toggleBg.removeChild(loader);
            }
            loader.scaleX = 1 / this.toggleBg.scaleX;
            loader.scaleY = 1 / this.toggleBg.scaleY;
            loader.x = Math.floor((this.toggleBg.width / this.toggleBg.scaleX - loader.width) / 2);
            loader.y = Math.floor((this.toggleBg.height / this.toggleBg.scaleY - loader.height) / 2);
            this.toggleBg.addChild(loader);
        }
    }
}
