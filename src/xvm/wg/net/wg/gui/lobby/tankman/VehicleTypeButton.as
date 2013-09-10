package net.wg.gui.lobby.tankman 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    
    public class VehicleTypeButton extends net.wg.gui.components.controls.SoundButtonEx
    {
        public function VehicleTypeButton()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.typeSwitcher.mouseEnabled = false;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            if (this._type == arg1) 
                return;
            this._type = arg1;
            this.typeSwitcher.gotoAndStop(arg1);
            return;
        }

        public var typeSwitcher:flash.display.MovieClip;

        public var _type:String="free";

        public var inspectableGroupName:String;
    }
}
