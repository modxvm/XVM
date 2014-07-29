package net.wg.gui.lobby.fortifications.cmp.main.impl
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.DisplayObject;
    import flash.text.TextField;
    
    public class VignetteYellow extends UIComponentEx
    {
        
        public function VignetteYellow()
        {
            super();
        }
        
        public var bg:DisplayObject;
        
        public var descrText:TextField = null;
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            constraints.dispose();
            constraints = null;
            this.descrText = null;
            this.bg = null;
            super.onDispose();
        }
    }
}
