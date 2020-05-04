package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.gui.login.ISparksManager;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Linkages;
    import flash.geom.Rectangle;

    public class EventAwardScreenBgHolder extends UIComponentEx
    {

        private static const SPARK_QUANTITY:uint = 150;

        public var vignette:Sprite;

        public var shine:Sprite;

        public var loaderWrapper:EventAwardScreenAnimatedLoaderContainer;

        public var sparksContainer:MovieClip = null;

        private var _sparksManager:ISparksManager = null;

        public function EventAwardScreenBgHolder()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.loaderWrapper.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
            this.sparksContainer.mouseChildren = this.sparksContainer.mouseEnabled = false;
            this.createSparks();
        }

        override protected function onDispose() : void
        {
            stop();
            this.vignette = null;
            this.shine = null;
            this.sparksContainer = null;
            if(this._sparksManager != null)
            {
                this._sparksManager.dispose();
                this._sparksManager = null;
            }
            this.loaderWrapper.dispose();
            this.loaderWrapper = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.shine.x = this.loaderWrapper.loaderX = -_width >> 1;
                this.shine.y = this.loaderWrapper.loaderY = App.appHeight - _height >> 1;
                this.shine.width = this.loaderWrapper.loaderWidth = _width;
                this.shine.height = this.loaderWrapper.loaderHeight = _height;
                this.sparksContainer.x = this.vignette.x = -App.appWidth >> 1;
                this.vignette.width = App.appWidth;
                this.vignette.height = App.appHeight;
                if(this._sparksManager != null)
                {
                    this._sparksManager.resetZone(this.getSparkZone());
                }
            }
        }

        override protected function onBeforeDispose() : void
        {
            this.loaderWrapper.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
            super.onBeforeDispose();
        }

        public function setBackground(param1:String) : void
        {
            this.loaderWrapper.source = param1;
        }

        private function createSparks() : void
        {
            if(this._sparksManager == null)
            {
                this._sparksManager = ISparksManager(App.utils.classFactory.getObject(Linkages.SPARKS_MGR));
                this._sparksManager.zone = this.getSparkZone();
                this._sparksManager.scope = this.sparksContainer;
                this._sparksManager.sparkQuantity = SPARK_QUANTITY;
                this._sparksManager.createSparks();
            }
        }

        private function getSparkZone() : Rectangle
        {
            return new Rectangle(0,0,App.appWidth,App.appHeight);
        }

        private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidateSize();
        }
    }
}
