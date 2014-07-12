package net.wg.gui.components.common.crosshair
{
    public class CrosshairPanelArcade extends CrosshairPanelBase
    {
        
        public function CrosshairPanelArcade() {
            super();
        }
        
        private static var CASSETE_POSITION_ARCADE:Number = -1;
        
        private static var CASSETE_POSITION_SNIPER:Number = 13;
        
        private static var CASSETE_POSITION_PANZER:Number = -11;
        
        override protected function initCallbacks() : void {
        }
        
        override protected function onSetNetType(param1:Number, param2:Number) : void {
            super.onSetNetType(param1,param2);
            var _loc3_:Number = 0;
            switch(g_modeMC.currentframe)
            {
                case 1:
                    _loc3_ = CASSETE_POSITION_ARCADE;
                    break;
                case 2:
                    _loc3_ = CASSETE_POSITION_SNIPER;
                    break;
                case 3:
                    _loc3_ = CASSETE_POSITION_PANZER;
                    break;
            }
            g_modeMC.cassette.y = _loc3_;
        }
    }
}
