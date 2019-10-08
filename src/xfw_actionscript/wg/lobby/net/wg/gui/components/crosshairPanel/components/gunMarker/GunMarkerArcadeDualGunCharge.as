package net.wg.gui.components.crosshairPanel.components.gunMarker
{
    import net.wg.infrastructure.base.SimpleContainer;
    import flash.display.Graphics;
    import net.wg.gui.utils.GraphicsUtilities;
    import flash.display.Shape;
    import flash.display.BlendMode;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import net.wg.data.constants.generated.DUAL_GUN_MARKER_STATE;

    public class GunMarkerArcadeDualGunCharge extends SimpleContainer implements IGunMarkerMixing
    {

        protected static const HAIRLINE_THICKNESS:uint = 1;

        protected static const ACTIVE_COLOR:uint = 16771755;

        protected static const INACTIVE_COLOR:uint = 16745484;

        protected static const MIN_CHARGE_LINE_THICKNESS:uint = 3;

        protected static const LIGHTEN_ALPHA:Number = 1;

        protected static const CIRCLE_LENGTH_RAD:Number = Math.PI * 2;

        protected static const ARC_CENTER:Number = Math.PI * 3 / 2;

        protected static const LEFT_DASH_START_GAP_RAD:Number = -Math.PI / 56;

        protected static const RIGHT_DASH_START_GAP_RAD:Number = Math.PI / 34;

        private static const RADIUS:int = 256;

        private static const MAX_CHARGE_LINE_THICKNESS:uint = 4;

        private static const DASHES_PER_180_DEGREE:Number = 14;

        private static const INVALID_CHARGE_PROGRESS:String = "invalidChargeProgress";

        private static const CHARGE_LINE_GAP:int = 15;

        private static const LINE_HEIGHT:int = 30;

        private static const SCALE_BREAK_POINT:Number = 0.2;

        protected var _hairlineGraphics:Graphics;

        protected var _chargeGraphics:Graphics;

        protected var _markerState:int;

        private var _charge:Number;

        public function GunMarkerArcadeDualGunCharge()
        {
            super();
        }

        protected static function drawArc(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Boolean, param6:Number) : void
        {
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc9_:* = NaN;
            var _loc10_:* = NaN;
            var _loc11_:* = NaN;
            var _loc12_:Function = null;
            var _loc13_:* = NaN;
            var param2:Number = param2 + param6;
            var param3:Number = param3 - param6 * 2;
            if(!param5)
            {
                GraphicsUtilities.drawArc(param1,0,0,param2,param3,param4);
            }
            else
            {
                _loc7_ = param3 > 0?1:-1;
                _loc8_ = _loc7_ * Math.PI / DASHES_PER_180_DEGREE;
                _loc9_ = _loc7_ * Math.PI / (DASHES_PER_180_DEGREE + 2);
                _loc10_ = param2 + param3;
                _loc11_ = param2;
                while(_loc7_ > 0 && _loc11_ < _loc10_ || _loc7_ < 0 && _loc11_ > _loc10_)
                {
                    _loc12_ = _loc7_ > 0?Math.min:Math.max;
                    _loc13_ = _loc12_(_loc8_ + _loc9_,_loc10_ - _loc11_);
                    GraphicsUtilities.drawArc(param1,0,0,_loc11_,_loc13_,param4);
                    _loc11_ = _loc11_ + (_loc8_ * 2 + _loc9_);
                }
            }
        }

        protected static function drawLine(param1:Graphics, param2:int, param3:Boolean, param4:Boolean) : void
        {
            var _loc5_:int = (param3?-1:1) * (CHARGE_LINE_GAP + MAX_CHARGE_LINE_THICKNESS) + ARC_CENTER;
            param1.moveTo(_loc5_,param2 * (param4?-1:1));
            param1.lineTo(_loc5_,(param2 + LINE_HEIGHT - (MAX_CHARGE_LINE_THICKNESS >> 1)) * (param4?-1:1));
        }

        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:Shape = new Shape();
            var _loc2_:Shape = new Shape();
            this._hairlineGraphics = _loc1_.graphics;
            this._chargeGraphics = _loc2_.graphics;
            addChild(_loc1_);
            addChild(_loc2_);
            blendMode = BlendMode.SCREEN;
        }

        override protected function onDispose() : void
        {
            while(numChildren)
            {
                removeChildAt(0);
            }
            this._hairlineGraphics = null;
            this._chargeGraphics = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = NaN;
            super.draw();
            if(isInvalid(INVALID_CHARGE_PROGRESS))
            {
                _loc1_ = scaleX < SCALE_BREAK_POINT?MIN_CHARGE_LINE_THICKNESS:MAX_CHARGE_LINE_THICKNESS;
                _loc2_ = RADIUS + (HAIRLINE_THICKNESS >> 1);
                _loc3_ = RADIUS + (_loc1_ >> 1);
                this._hairlineGraphics.clear();
                this._chargeGraphics.clear();
                _loc4_ = this._charge * CIRCLE_LENGTH_RAD;
                this._hairlineGraphics.lineStyle(HAIRLINE_THICKNESS,INACTIVE_COLOR,LIGHTEN_ALPHA,false,LineScaleMode.NONE,CapsStyle.NONE);
                this.drawMarker(_loc4_,_loc1_,_loc3_,_loc2_);
            }
        }

        public function setReloadingAsPercent(param1:Number) : void
        {
            if(this._charge == param1)
            {
                return;
            }
            this._charge = param1;
            invalidate(INVALID_CHARGE_PROGRESS);
        }

        public function setReloadingState(param1:String) : void
        {
        }

        public function updateMakerState(param1:int) : void
        {
            if(this._markerState != param1)
            {
                this._markerState = param1;
                invalidate(INVALID_CHARGE_PROGRESS);
            }
        }

        protected function drawMarker(param1:Number, param2:int, param3:int, param4:int) : void
        {
            var _loc6_:* = NaN;
            var _loc5_:Number = param1 / 2;
            if(this._markerState == DUAL_GUN_MARKER_STATE.VISIBLE)
            {
                this._chargeGraphics.lineStyle(MIN_CHARGE_LINE_THICKNESS,ACTIVE_COLOR,LIGHTEN_ALPHA,false,LineScaleMode.NONE,CapsStyle.NONE);
                drawArc(this._chargeGraphics,ARC_CENTER - _loc5_,param1,param3,false,0);
                this._hairlineGraphics.drawCircle(0,0,param4);
            }
            else
            {
                this._chargeGraphics.lineStyle(MIN_CHARGE_LINE_THICKNESS,INACTIVE_COLOR,LIGHTEN_ALPHA,false,LineScaleMode.NONE,CapsStyle.NONE);
                this._hairlineGraphics.lineStyle(HAIRLINE_THICKNESS,INACTIVE_COLOR,LIGHTEN_ALPHA,false,LineScaleMode.NONE,CapsStyle.NONE);
                _loc6_ = CIRCLE_LENGTH_RAD / 2;
                drawArc(this._chargeGraphics,ARC_CENTER,-_loc5_,param3,true,LEFT_DASH_START_GAP_RAD);
                drawArc(this._hairlineGraphics,ARC_CENTER,-_loc6_,param4,true,LEFT_DASH_START_GAP_RAD);
                drawArc(this._chargeGraphics,ARC_CENTER,_loc5_,param3,true,RIGHT_DASH_START_GAP_RAD);
                drawArc(this._hairlineGraphics,ARC_CENTER,_loc6_,param4,true,RIGHT_DASH_START_GAP_RAD);
            }
        }
    }
}
