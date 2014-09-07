package net.wg.gui.components.advanced
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    
    public class ClanEmblem extends UIComponent
    {
        
        public function ClanEmblem()
        {
            super();
        }
        
        private var _iconWidth:int;
        
        private var _iconHeight:int;
        
        public var default_icon_mc:MovieClip = null;
        
        public var loader:UILoaderAlt = null;
        
        override protected function onDispose() : void
        {
            if(this.loader)
            {
                this.loader.dispose();
                this.loader = null;
            }
            this.default_icon_mc = null;
            super.onDispose();
        }
        
        public function setImage(param1:String) : void
        {
            if(param1)
            {
                this.default_icon_mc.visible = false;
                this.loader.source = "img://" + param1;
            }
            else
            {
                this.default_icon_mc.visible = true;
                this.default_icon_mc.width = this._iconWidth;
                this.default_icon_mc.height = this._iconHeight;
            }
            this.loader.visible = !this.default_icon_mc.visible;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.default_icon_mc.visible = false;
        }
        
        public function get iconWidth() : int
        {
            return this._iconWidth;
        }
        
        public function set iconWidth(param1:int) : void
        {
            this._iconWidth = param1;
            this.width = param1;
        }
        
        public function get iconHeight() : int
        {
            return this._iconHeight;
        }
        
        public function set iconHeight(param1:int) : void
        {
            this._iconHeight = param1;
            this.height = param1;
        }
    }
}
