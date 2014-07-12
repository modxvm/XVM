package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    
    public class GlowArrowAsset extends UIComponent
    {
        
        public function GlowArrowAsset() {
            super();
            hitArea = this.hit;
        }
        
        public var hit:MovieClip;
        
        override public function get width() : Number {
            return this.hit.width;
        }
        
        override public function get height() : Number {
            return this.hit.height;
        }
    }
}
