package net.wg.gui.components.advanced 
{
    import flash.events.*;
    import net.wg.gui.lobby.hangar.ammunitionPanel.*;
    import net.wg.gui.lobby.profile.components.*;
    
    public class ExtraModuleIcon extends net.wg.gui.components.advanced.ModuleIcon
    {
        public function ExtraModuleIcon()
        {
            super();
            return;
        }

        public function get extraIconSource():String
        {
            return this._extraIconSource;
        }

        public function set extraIconSource(arg1:String):void
        {
            this._extraIconSource = arg1;
            if (!this.extraIcon) 
            {
                this.extraIcon = new net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon();
                this.extraIcon.visible = false;
                this.extraIcon.addEventListener(net.wg.gui.lobby.profile.components.SimpleLoader.LOADED, this.onExtraIconLoaded, false, 0, true);
                addChild(this.extraIcon);
            }
            this.extraIcon.setSource(this._extraIconSource);
            return;
        }

        public override function dispose():void
        {
            if (this.extraIcon && contains(this.extraIcon)) 
            {
                removeChild(this.extraIcon);
            }
            super.dispose();
            return;
        }

        internal function onExtraIconLoaded(arg1:flash.events.Event):void
        {
            this.extraIcon.x = Math.round(moduleType.width - this.extraIcon.width - 6);
            this.extraIcon.y = Math.round(moduleType.height - this.extraIcon.height - 5);
            this.extraIcon.visible = true;
            return;
        }

        internal var extraIcon:net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon;

        internal var _extraIconSource:String;
    }
}
