package net.wg.gui.lobby.tankman
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.data.constants.SoundTypes;

    public class VehicleTypeButton extends SoundButtonEx
    {

        public var typeSwitcher:MovieClip;

        public var _type:String = "free";

        public var inspectableGroupName:String;

        public function VehicleTypeButton()
        {
            super();
            soundType = SoundTypes.RNDR_NORMAL;
            preventAutosizing = true;
            constraintsDisabled = true;
        }

        override protected function onDispose() : void
        {
            this.typeSwitcher = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.typeSwitcher.mouseEnabled = false;
            toggle = false;
        }

        public function get type() : String
        {
            return this._type;
        }

        public function set type(param1:String) : void
        {
            if(this._type == param1)
            {
                return;
            }
            this._type = param1;
            this.typeSwitcher.gotoAndStop(param1);
        }
    }
}
