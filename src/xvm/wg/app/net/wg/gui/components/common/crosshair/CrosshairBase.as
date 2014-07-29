package net.wg.gui.components.common.crosshair
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.Event;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    
    public class CrosshairBase extends Sprite implements IDisposable
    {
        
        public function CrosshairBase()
        {
            super();
            this.init();
        }
        
        private function init() : void
        {
            this.initCallbacks();
            this.initView();
            if(stage)
            {
                this.initStage();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE,this.initStage);
            }
        }
        
        private function initStage(param1:Event = null) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE,this.initStage);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }
        
        protected function initView() : void
        {
        }
        
        protected function initCallbacks() : void
        {
        }
        
        protected function onSetReloading(param1:Number, param2:Number, param3:Boolean, param4:Number = 0) : void
        {
        }
        
        protected function onSetReloadingAsPercent(param1:Number) : void
        {
        }
        
        public final function dispose() : void
        {
            this.onDispose();
        }
        
        protected function onDispose() : void
        {
            removeEventListener(Event.ADDED_TO_STAGE,this.initStage);
        }
    }
}
