package net.wg.gui.components.common.crosshair 
{
    public class CrosshairPanelSniper extends net.wg.gui.components.common.crosshair.CrosshairPanelBase
    {
        public function CrosshairPanelSniper()
        {
            super();
            return;
        }

        protected override function initCallbacks():void
        {
            return;
        }

        protected override function onSetNetType(arg1:Number, arg2:Number):void
        {
            super.onSetNetType(arg1, arg2);
            var loc1:*=0;
            var loc2:*=g_modeMC.currentframe;
            switch (loc2) 
            {
                case 1:
                    loc1 = CASSETE_POSITION_ARCADE;
                    break;
                case 2:
                    loc1 = CASSETE_POSITION_SNIPER;
                    break;
                case 3:
                    loc1 = CASSETE_POSITION_PANZER;
                    break;
            }
            g_modeMC.cassette.y = loc1;
            return;
        }

        internal static const CASSETE_POSITION_ARCADE:Number=-1;

        internal static const CASSETE_POSITION_SNIPER:Number=13;

        internal static const CASSETE_POSITION_PANZER:Number=-1;
    }
}
