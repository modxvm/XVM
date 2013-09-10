package net.wg.gui.components.common.crosshair 
{
    public class CrosshairPanelStrategic extends net.wg.gui.components.common.crosshair.CrosshairPanelBase
    {
        public function CrosshairPanelStrategic()
        {
            super();
            return;
        }

        protected override function initCallbacks():void
        {
            return;
        }

        protected override function initView():void
        {
            this.setDefaultDistanceState();
            onSetAmmoStock(0, 0, true, "critical");
            return;
        }

        protected function onUpdateDistance(arg1:Number):void
        {
            g_modeMC.distanceLbl.text = arg1 + "m";
            return;
        }

        internal function setDefaultDistanceState():void
        {
            g_modeMC.distanceLbl.text = "";
            return;
        }
    }
}
