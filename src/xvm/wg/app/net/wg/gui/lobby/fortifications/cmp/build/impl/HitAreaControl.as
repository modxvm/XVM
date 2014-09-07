package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.geom.Point;
    
    public class HitAreaControl extends SoundButtonEx
    {
        
        public function HitAreaControl()
        {
            super();
        }
        
        public function get absPosition() : Point
        {
            return localToGlobal(new Point(0,0));
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
    }
}
