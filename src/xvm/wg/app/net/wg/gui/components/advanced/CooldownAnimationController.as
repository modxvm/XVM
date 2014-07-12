package net.wg.gui.components.advanced
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import net.wg.gui.events.CooldownEvent;
    
    public class CooldownAnimationController extends UIComponent
    {
        
        public function CooldownAnimationController() {
            super();
        }
        
        private static var DELTA_OF_PIXELS_FOR_ANIMATION:int = 47;
        
        private static var VERTICAL_PADDING:int = 5;
        
        public var maskMc:MovieClip;
        
        private var _cooldownPeriod:Number;
        
        private var _deltaPixels:int = 0;
        
        private var _isDischarging:Boolean = false;
        
        override protected function onDispose() : void {
            App.utils.scheduler.cancelTask(this.updateAnimation);
            super.onDispose();
        }
        
        public function startCooldown(param1:Number) : void {
            App.utils.scheduler.cancelTask(this.updateAnimation);
            this._cooldownPeriod = param1 / DELTA_OF_PIXELS_FOR_ANIMATION;
            this._deltaPixels = this._isDischarging?DELTA_OF_PIXELS_FOR_ANIMATION:0;
            this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
            App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
        }
        
        public function clearCooldown() : void {
            App.utils.scheduler.cancelTask(this.updateAnimation);
        }
        
        public function restartCooldownFromCurrentProgress(param1:Number) : void {
            App.utils.scheduler.cancelTask(this.updateAnimation);
            var _loc2_:int = this._isDischarging?this._deltaPixels:DELTA_OF_PIXELS_FOR_ANIMATION - this._deltaPixels;
            this._cooldownPeriod = param1 / _loc2_;
            this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
            App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
        }
        
        public function setPositionAsPercent(param1:Number) : void {
            App.utils.scheduler.cancelTask(this.updateAnimation);
            var _loc2_:Number = this._isDischarging?(100 - param1) / 100:param1 / 100;
            this._deltaPixels = Math.round(DELTA_OF_PIXELS_FOR_ANIMATION * _loc2_);
            this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
        }
        
        private function updateAnimation() : void {
            if((this._isDischarging) && this._deltaPixels > 0)
            {
                this._deltaPixels--;
                this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
                App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
            }
            else if(!this._isDischarging && this._deltaPixels < DELTA_OF_PIXELS_FOR_ANIMATION)
            {
                this._deltaPixels++;
                this.maskMc.height = Math.round(VERTICAL_PADDING + this._deltaPixels);
                App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
            }
            else
            {
                dispatchEvent(new CooldownEvent(CooldownEvent.FINISHED));
            }
            
        }
        
        public function get isDischarging() : Boolean {
            return this._isDischarging;
        }
        
        public function set isDischarging(param1:Boolean) : void {
            this._isDischarging = param1;
        }
    }
}
