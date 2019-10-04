package net.wg.gui.lobby.store
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.components.IResizableContent;
    import scaleform.clik.motion.Tween;
    import scaleform.clik.events.ComponentEvent;
    import fl.motion.easing.Cubic;
    import flash.display.InteractiveObject;

    public class StoreComponentViewBase extends BaseDAAPIComponent implements IResizableContent
    {

        private static const FADE_IN_DELAY:Number = 250;

        private static const FADE_IN_DURATION:Number = 1500;

        private var _fadeInTween:Tween = null;

        public function StoreComponentViewBase()
        {
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            addEventListener(ComponentEvent.SHOW,this.onShowHandler);
            this._fadeInTween = new Tween(FADE_IN_DURATION,this,{"alpha":1},{
                "paused":false,
                "ease":Cubic.easeOut,
                "delay":FADE_IN_DELAY,
                "onComplete":null
            });
            this._fadeInTween.fastTransform = false;
            this._fadeInTween.paused = true;
        }

        override protected function onDispose() : void
        {
            removeEventListener(ComponentEvent.SHOW,this.onShowHandler);
            this._fadeInTween.dispose();
            this._fadeInTween = null;
            super.onDispose();
        }

        public function canShowAutomatically() : Boolean
        {
            return true;
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }

        public function setViewSize(param1:Number, param2:Number) : void
        {
            setSize(param1,param2);
        }

        public function update(param1:Object) : void
        {
        }

        public function get centerOffset() : int
        {
            return 0;
        }

        public function set centerOffset(param1:int) : void
        {
        }

        public function get active() : Boolean
        {
            return false;
        }

        public function set active(param1:Boolean) : void
        {
        }

        private function onShowHandler(param1:ComponentEvent) : void
        {
            alpha = 0;
            this._fadeInTween.reset();
            this._fadeInTween.paused = false;
        }
    }
}
