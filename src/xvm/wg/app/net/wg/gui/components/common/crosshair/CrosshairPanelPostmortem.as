package net.wg.gui.components.common.crosshair 
{
    public class CrosshairPanelPostmortem extends net.wg.gui.components.common.crosshair.CrosshairPanelBase
    {
        public function CrosshairPanelPostmortem()
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
            this.onUpdatePlayerInfo("");
            this.onUpdateAmmoState(true);
            return;
        }

        protected override function initFrameWalkers():void
        {
            return;
        }

        protected function onUpdatePlayerInfo(arg1:String):void
        {
            g_modeMC.playerInfo.text = arg1;
            this.updateAmmoInfoPos();
            return;
        }

        protected function onUpdateAmmoState(arg1:Boolean):void
        {
            g_modeMC.ammoInfo.visible = !arg1;
            this.updateAmmoInfoPos();
            return;
        }

        internal function updateAmmoInfoPos():void
        {
            if (g_modeMC.ammoInfo.visible) 
            {
                g_modeMC.ammoInfo.y = Math.round(g_modeMC.playerInfo.y + g_modeMC.playerInfo.textHeight + AMMO_INFO_VERTICAL_OFFSET);
            }
            return;
        }

        internal static const AMMO_INFO_VERTICAL_OFFSET:Number=4;
    }
}
