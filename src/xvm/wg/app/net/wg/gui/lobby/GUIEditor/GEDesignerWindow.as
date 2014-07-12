package net.wg.gui.lobby.GUIEditor
{
    import net.wg.dev.base.meta.impl.GEDesignerWindowMeta;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.Sprite;
    
    public class GEDesignerWindow extends GEDesignerWindowMeta
    {
        
        public function GEDesignerWindow() {
            super();
        }
        
        public var bg:MovieClip = null;
        
        override protected function onPopulate() : void {
            super.onPopulate();
            this.bg.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
        }
        
        override protected function onDispose() : void {
            this.bg.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.bg = null;
            super.onDispose();
        }
        
        private function onMouseClickHandler(param1:MouseEvent) : void {
            var _loc2_:Sprite = App.cursor.getAttachedSprite();
            if(_loc2_ != null)
            {
                App.cursor.detachFromCursor();
                this.bg.addChild(_loc2_);
                _loc2_.x = param1.localX;
                _loc2_.y = param1.localY;
            }
        }
    }
}
