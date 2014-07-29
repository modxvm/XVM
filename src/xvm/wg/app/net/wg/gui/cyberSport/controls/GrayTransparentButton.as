package net.wg.gui.cyberSport.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.rally.controls.IGrayTransparentButton;
    import flash.display.MovieClip;
    
    public class GrayTransparentButton extends SoundButtonEx implements IGrayTransparentButton
    {
        
        public function GrayTransparentButton()
        {
            super();
        }
        
        public static var ICON_NO_ICON:String = "noIcon";
        
        public static var ICON_CROSS:String = "cross";
        
        public static var ICON_LOCK:String = "lock";
        
        public static var ICON_UP:String = "up";
        
        public static var ICON_DOWN:String = "down";
        
        public var iconContainer:MovieClip;
        
        private var _icon:String = "noIcon";
        
        public function get icon() : String
        {
            return this._icon;
        }
        
        public function set icon(param1:String) : void
        {
            this._icon = param1;
            if(this._icon)
            {
                this.iconContainer.gotoAndStop(this._icon);
                this.iconContainer.visible = true;
            }
            else
            {
                this.iconContainer.visible = false;
            }
        }
    }
}
