package net.wg.gui.components.common.crosshair
{
    public class CrosshairPanelStrategic extends CrosshairPanelBase
    {
        
        public function CrosshairPanelStrategic() {
            super();
        }
        
        override protected function initCallbacks() : void {
        }
        
        override protected function initView() : void {
            this.setDefaultDistanceState();
            onSetAmmoStock(0,0,true,"critical");
        }
        
        protected function onUpdateDistance(param1:Number) : void {
            g_modeMC.distanceLbl.text = param1 + "m";
        }
        
        private function setDefaultDistanceState() : void {
            g_modeMC.distanceLbl.text = "";
        }
    }
}
