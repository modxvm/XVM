package net.wg.gui.components.crosshairPanel.components.autoloader
{
    import net.wg.data.constants.generated.AUTOLOADERBOOSTVIEWSTATES;

    public class BoostIndicatorStateParamsVO extends Object
    {

        public var remainingDurationMsec:Number = 0;

        public var currentLeftX:Number = 0;

        public var currentRightX:Number = 0;

        public var currentAlpha:Number = 0;

        public var currentFrame:int = 2;

        public var currentState:int = -1;

        public var isRecharging:Boolean = false;

        public var isFadingOut:Boolean = false;

        public var isSideFadeOut:Boolean = false;

        private var _leftOriginX:Number;

        private var _rightOriginX:Number;

        private var _leftShiftedX:Number;

        private var _rightShiftedX:Number;

        public function BoostIndicatorStateParamsVO(param1:Number, param2:Number, param3:Number, param4:Number)
        {
            super();
            this._leftOriginX = param1;
            this._rightOriginX = param2;
            this._leftShiftedX = param3;
            this._rightShiftedX = param4;
        }

        public function resetToDefault() : void
        {
            this.remainingDurationMsec = 0;
            this.currentLeftX = this._leftOriginX;
            this.currentRightX = this._rightOriginX;
            this.currentAlpha = 0;
            this.currentFrame = 2;
            this.currentState = AUTOLOADERBOOSTVIEWSTATES.INVISIBLE;
            this.isRecharging = false;
            this.isFadingOut = false;
            this.isSideFadeOut = false;
        }

        public function get leftShiftedX() : Number
        {
            return this._leftShiftedX;
        }

        public function get rightShiftedX() : Number
        {
            return this._rightShiftedX;
        }
    }
}
