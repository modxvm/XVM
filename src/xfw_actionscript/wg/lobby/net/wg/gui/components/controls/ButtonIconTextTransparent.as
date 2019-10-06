package net.wg.gui.components.controls
{
    import net.wg.gui.interfaces.IButtonIconTextTransparent;
    import flash.display.MovieClip;

    public class ButtonIconTextTransparent extends SoundButtonEx implements IButtonIconTextTransparent
    {

        public static const ICON_NO_ICON:String = "noIcon";

        public static const ICON_CROSS:String = "cross";

        public static const ICON_LOCK:String = "lock";

        public static const ICON_UP:String = "up";

        public static const ICON_DOWN:String = "down";

        private static const INVALID_ICON:String = "invalidIcon";

        public var iconContainer:MovieClip;

        private var _icon:String = "noIcon";

        private var _iconVisible:Boolean = true;

        public function ButtonIconTextTransparent()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.iconContainer = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_ICON))
            {
                if(this._icon)
                {
                    this.iconContainer.gotoAndStop(this._icon);
                    this.iconContainer.visible = this._iconVisible;
                }
                else
                {
                    this.iconContainer.visible = false;
                }
            }
        }

        public function get icon() : String
        {
            return this._icon;
        }

        public function set icon(param1:String) : void
        {
            this._icon = param1;
            invalidate(INVALID_ICON);
        }
    }
}
