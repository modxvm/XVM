package net.wg.gui.lobby.vehicleCustomization
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.BitmapFill;

    public class CustomizationTriggerBgDisable extends Sprite implements IDisposable
    {

        public var bgMask:MovieClip = null;

        public var bitmapFill:BitmapFill = null;

        public function CustomizationTriggerBgDisable()
        {
            super();
        }

        public function dispose() : void
        {
            this.bgMask = null;
            this.bitmapFill.dispose();
            this.bitmapFill = null;
        }

        override public function set width(param1:Number) : void
        {
            this.bgMask.width = param1;
            this.bitmapFill.widthFill = param1;
            this.bitmapFill.validateNow();
        }
    }
}
