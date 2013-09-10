package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    
    public class TankmanTrainingButton extends net.wg.gui.components.controls.SoundButton
    {
        public function TankmanTrainingButton()
        {
            this._priceColors = {"normal":16314069, "disabled":16711680};
            _stateMap = {"up":["up"], "over":["over"], "down":["down"], "release":["release", "over"], "out":["out", "up"], "disabled":["disabled"], "selecting":["selecting", "out"], "kb_selecting":["kb_selecting", "up"], "kb_release":["kb_release", "out", "up"], "kb_down":["kb_down", "down"], "buy":["buy"]};
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            super();
            return;
        }

        public function get buy():Boolean
        {
            return this._buy;
        }

        public function set buy(arg1:Boolean):void
        {
            if (this._buy == arg1) 
                return;
            this._buy = arg1;
            this.priceLabel.visible = !this._buy && !(this._type == "free");
            clearRepeatInterval();
            setState(this._buy ? "buy" : "up");
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            if (this._buy == true) 
                return;
            super.handleMouseRollOver(arg1);
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            if (this._buy == true) 
                return;
            super.handleMouseRollOut(arg1);
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            if (this._buy == true) 
                return;
            super.handleMousePress(arg1);
            return;
        }

        protected override function handlePress(arg1:uint=0):void
        {
            if (this._buy == true) 
                return;
            super.handlePress(arg1);
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            if (this._buy == true) 
                return;
            super.handleMouseRelease(arg1);
            return;
        }

        protected override function handleRelease(arg1:uint=0):void
        {
            if (this._buy == true) 
                return;
            super.handleRelease(arg1);
            return;
        }

        protected override function handleReleaseOutside(arg1:flash.events.MouseEvent):void
        {
            if (this._buy == true) 
                return;
            super.handleReleaseOutside(arg1);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        public function get nation():Number
        {
            return this._nation;
        }

        public function set nation(arg1:Number):void
        {
            this._nation = arg1;
            invalidate("_nation");
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            if (this._type != arg1) 
            {
                this._type = arg1;
                invalidate(TYPE_INVALID);
            }
            return;
        }

        public function get price():String
        {
            return this.priceLabel.text;
        }

        public function set price(arg1:String):void
        {
            var loc1:*=enabled ? "normal" : "disabled";
            this.priceLabel.textColor = this._priceColors[loc1];
            this.priceLabel.text = this._type != "academy" ? App.utils.locale.integer(arg1) : App.utils.locale.gold(arg1);
            return;
        }

        public override function toString():String
        {
            return "[Wargaming TankmanTrainingButton " + name + "]";
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid("_nation")) 
                this.bg.gotoAndPlay(isNaN(this._nation) ? "empty" : App.utils.nations.getNationName(this._nation));
            if (isInvalid(TYPE_INVALID)) 
            {
                this.priceLabel.visible = !(this._type == "free");
                this.typeLabel.text = MENU.tankmantrainingwindow(this._type);
                this.typeSwitcher.gotoAndPlay(this._type);
            }
            return;
        }

        public static const TYPE_INVALID:String="typeInvalid";

        public var bg:flash.display.MovieClip;

        public var typeSwitcher:flash.display.MovieClip;

        public var priceLabel:flash.text.TextField;

        public var typeLabel:flash.text.TextField;

        internal var _buy:Boolean=false;

        internal var _nation:Number;

        internal var _type:String="free";

        internal var _priceColors:Object;
    }
}
