package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import scaleform.clik.core.*;
    
    public class UnClickableShadowBG extends scaleform.clik.core.UIComponent
    {
        public function UnClickableShadowBG()
        {
            super();
            this.shadow.buttonMode = true;
            this.shadow.hitArea = this.hit;
            return;
        }

        public var shadow:flash.display.MovieClip;

        public var hit:flash.display.MovieClip;
    }
}
