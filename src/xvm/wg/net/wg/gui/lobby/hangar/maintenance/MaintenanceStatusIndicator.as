package net.wg.gui.lobby.hangar.maintenance 
{
    import flash.display.*;
    import flash.text.*;
    import scaleform.clik.controls.*;
    
    public class MaintenanceStatusIndicator extends scaleform.clik.controls.StatusIndicator
    {
        public function MaintenanceStatusIndicator()
        {
            super();
            return;
        }

        public function setDivisor(arg1:Number, arg2:Number):void
        {
            this.divisor_mc.visible = arg1 && arg2;
            var loc1:*=(width - 8) * arg1 / arg2;
            this.divisor_mc.x = Math.round(loc1 / scaleX);
            return;
        }

        public function get flashing():Boolean
        {
            return this._flashing;
        }

        public function set flashing(arg1:Boolean):void
        {
            this._flashing = arg1;
            this.alert_mc.visible = this._flashing;
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            this.textField.text = this._label;
            return;
        }

        public override function toString():String
        {
            return "[Wargaming ProgressBar " + name + "]";
        }

        internal var _flashing:Boolean=true;

        internal var _divisor:Number=-1;

        internal var _label:String="";

        public var alert_mc:flash.display.MovieClip;

        public var divisor_mc:flash.display.MovieClip;

        public var textField:flash.text.TextField;
    }
}
