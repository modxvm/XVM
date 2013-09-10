package net.wg.gui.components.common.markers 
{
    public class AnimateExplosion extends net.wg.gui.components.common.markers.HealthBarAnimatedPart
    {
        public function AnimateExplosion()
        {
            super();
            return;
        }

        public function setColorAndDamageType(arg1:String, arg2:String):void
        {
            setAnimationType(arg1 + "_" + arg2);
            return;
        }
    }
}
