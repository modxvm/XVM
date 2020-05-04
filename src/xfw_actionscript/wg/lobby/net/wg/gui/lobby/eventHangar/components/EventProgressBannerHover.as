package net.wg.gui.lobby.eventHangar.components
{
    import net.wg.gui.components.controls.SoundButton;
    import flash.display.MovieClip;
    import net.wg.utils.IClassFactory;

    public class EventProgressBannerHover extends SoundButton
    {

        private static const HOVER_BIG:String = "EventBannerHoverUI";

        private static const HOVER_SMALL:String = "EventBannerHoverSmallUI";

        private static const STATE_BIG:String = "big";

        public var holder:MovieClip = null;

        private var _hover:MovieClip = null;

        private var _classFactory:IClassFactory;

        public function EventProgressBannerHover()
        {
            this._classFactory = App.utils.classFactory;
            super();
        }

        public function setHoverState(param1:String) : void
        {
            this.removeHover();
            if(param1 == STATE_BIG)
            {
                this._hover = this._classFactory.getComponent(HOVER_BIG,MovieClip);
            }
            else
            {
                this._hover = this._classFactory.getComponent(HOVER_SMALL,MovieClip);
            }
            this.holder.addChild(this._hover);
        }

        override protected function configUI() : void
        {
            super.configUI();
            preventAutosizing = true;
        }

        override protected function onDispose() : void
        {
            this.removeHover();
            this.holder = null;
            this._classFactory = null;
            super.onDispose();
        }

        private function removeHover() : void
        {
            if(this._hover)
            {
                this.holder.removeChild(this._hover);
                this._hover = null;
            }
        }
    }
}
