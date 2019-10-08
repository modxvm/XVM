package net.wg.gui.components.crosshairPanel.components.gunMarker
{
    import net.wg.data.constants.generated.DUAL_GUN_MARKER_STATE;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;

    public class GunMarkerSniperDualGunCharge extends GunMarkerArcadeDualGunCharge
    {

        public function GunMarkerSniperDualGunCharge()
        {
            super();
        }

        override protected function drawMarker(param1:Number, param2:int, param3:int, param4:int) : void
        {
            var _loc5_:Number = param1 / 2;
            var _loc6_:Number = CIRCLE_LENGTH_RAD / 2;
            var _loc7_:Boolean = _markerState == DUAL_GUN_MARKER_STATE.LEFT_PART_ACTIVE || _markerState == DUAL_GUN_MARKER_STATE.VISIBLE;
            var _loc8_:Boolean = _markerState == DUAL_GUN_MARKER_STATE.RIGHT_PART_ACTIVE || _markerState == DUAL_GUN_MARKER_STATE.VISIBLE;
            var _loc9_:uint = _loc7_?ACTIVE_COLOR:INACTIVE_COLOR;
            var _loc10_:uint = _loc8_?ACTIVE_COLOR:INACTIVE_COLOR;
            _chargeGraphics.lineStyle(param2,_loc9_,LIGHTEN_ALPHA,false,LineScaleMode.NONE,CapsStyle.NONE);
            drawArc(_chargeGraphics,ARC_CENTER,-_loc5_,param3,!_loc7_,LEFT_DASH_START_GAP_RAD);
            drawArc(_hairlineGraphics,ARC_CENTER,-_loc6_,param4,!_loc7_,LEFT_DASH_START_GAP_RAD);
            _chargeGraphics.lineStyle(param2,_loc10_,LIGHTEN_ALPHA,false,LineScaleMode.NONE,CapsStyle.NONE);
            drawArc(_chargeGraphics,ARC_CENTER,_loc5_,param3,!_loc8_,RIGHT_DASH_START_GAP_RAD);
            drawArc(_hairlineGraphics,ARC_CENTER,_loc6_,param4,!_loc8_,RIGHT_DASH_START_GAP_RAD);
            _hairlineGraphics.lineStyle(HAIRLINE_THICKNESS,_loc9_,LIGHTEN_ALPHA,false,LineScaleMode.NONE,CapsStyle.NONE);
            drawLine(_hairlineGraphics,param4,true,true);
            drawLine(_hairlineGraphics,param4,true,false);
            _hairlineGraphics.lineStyle(HAIRLINE_THICKNESS,_loc10_,LIGHTEN_ALPHA,false,LineScaleMode.NONE,CapsStyle.NONE);
            drawLine(_hairlineGraphics,param4,false,true);
            drawLine(_hairlineGraphics,param4,false,false);
        }
    }
}
