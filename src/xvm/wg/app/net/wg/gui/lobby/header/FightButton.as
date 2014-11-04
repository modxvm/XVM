package net.wg.gui.lobby.header
{
    import net.wg.gui.components.controls.SoundButton;
    import flash.geom.Rectangle;
    
    public class FightButton extends SoundButton
    {
        
        public function FightButton()
        {
            super();
        }
        
        public function getRectangle() : Rectangle
        {
            var _loc1_:Rectangle = new Rectangle();
            _loc1_.x = this.x + hitMc.x;
            _loc1_.width = hitMc.width;
            return _loc1_;
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
    }
}
