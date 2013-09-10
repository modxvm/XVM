package net.wg.gui.components.common.crosshair 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class CrosshairBase extends flash.display.Sprite implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function CrosshairBase()
        {
            super();
            this.init();
            return;
        }

        internal function init():void
        {
            this.initCallbacks();
            this.initView();
            if (stage) 
            {
                this.initStage();
            }
            else 
            {
                addEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            }
            return;
        }

        internal function initStage(arg1:flash.events.Event=null):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.align = flash.display.StageAlign.TOP_LEFT;
            return;
        }

        protected function initView():void
        {
            return;
        }

        protected function initCallbacks():void
        {
            return;
        }

        protected function onSetReloading(arg1:Number, arg2:Number, arg3:Boolean, arg4:Number=0):void
        {
            return;
        }

        protected function onSetReloadingAsPercent(arg1:Number):void
        {
            return;
        }

        public function dispose():void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            return;
        }
    }
}
