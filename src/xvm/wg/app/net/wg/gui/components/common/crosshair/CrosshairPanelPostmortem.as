package net.wg.gui.components.common.crosshair
{
    public class CrosshairPanelPostmortem extends CrosshairPanelBase
    {
        
        public function CrosshairPanelPostmortem() {
            super();
        }
        
        private static var AMMO_INFO_VERTICAL_OFFSET:Number = 4;
        
        override protected function initCallbacks() : void {
        }
        
        override protected function initView() : void {
            this.onUpdatePlayerInfo("");
            this.onUpdateAmmoState(true);
        }
        
        override protected function initFrameWalkers() : void {
        }
        
        protected function onUpdatePlayerInfo(param1:String) : void {
            g_modeMC.playerInfo.text = param1;
            this.updateAmmoInfoPos();
        }
        
        protected function onUpdateAmmoState(param1:Boolean) : void {
            g_modeMC.ammoInfo.visible = !param1;
            this.updateAmmoInfoPos();
        }
        
        private function updateAmmoInfoPos() : void {
            if(g_modeMC.ammoInfo.visible)
            {
                g_modeMC.ammoInfo.y = Math.round(g_modeMC.playerInfo.y + g_modeMC.playerInfo.textHeight + AMMO_INFO_VERTICAL_OFFSET);
            }
        }
    }
}
