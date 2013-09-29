package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class ClanEmblem extends scaleform.clik.core.UIComponent
    {
        public function ClanEmblem()
        {
            super();
            return;
        }

        public function setImage(arg1:String):void
        {
            if (arg1) 
            {
                this.loader.source = "img://" + arg1;
                this.default_icon_mc.visible = false;
            }
            else 
            {
                this.loader.visible = false;
                this.default_icon_mc.visible = true;
                this.default_icon_mc.width = this._iconWidth;
                this.default_icon_mc.height = this._iconHeight;
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.default_icon_mc.visible = false;
            return;
        }

        public override function dispose():void
        {
            if (this.loader) 
            {
                this.loader.dispose();
                this.loader = null;
            }
            this.default_icon_mc = null;
            return;
        }

        public var _iconWidth:int;

        public var _iconHeight:int;

        public var default_icon_mc:flash.display.MovieClip;

        public var loader:net.wg.gui.components.controls.UILoaderAlt;
    }
}
