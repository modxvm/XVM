package net.wg.gui.lobby.eventAwards.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;

    public class EventAwardScreenAnimatedLoaderContainer extends Sprite implements IDisposable
    {

        public var icon:UILoaderAlt;

        public function EventAwardScreenAnimatedLoaderContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        protected function onDispose() : void
        {
            this.icon.dispose();
            this.icon = null;
        }

        public function get loaderHeight() : int
        {
            return this.icon.height;
        }

        public function set loaderHeight(param1:int) : void
        {
            this.icon.height = param1;
        }

        public function get loaderWidth() : int
        {
            return this.icon.width;
        }

        public function set loaderWidth(param1:int) : void
        {
            this.icon.width = param1;
        }

        public function get loaderX() : int
        {
            return this.icon.x;
        }

        public function set loaderX(param1:int) : void
        {
            this.icon.x = param1;
        }

        public function get loaderY() : int
        {
            return this.icon.y;
        }

        public function set loaderY(param1:int) : void
        {
            this.icon.y = param1;
        }

        public function set loaderScaleY(param1:Number) : void
        {
            this.icon.scaleY = param1;
        }

        public function set loaderScaleX(param1:Number) : void
        {
            this.icon.scaleX = param1;
        }

        public function get loader() : UILoaderAlt
        {
            return this.icon;
        }

        public function get source() : String
        {
            return this.icon.source;
        }

        public function set source(param1:String) : void
        {
            this.icon.source = param1;
        }

        public function get autoSize() : Boolean
        {
            return this.icon.autoSize;
        }

        public function set autoSize(param1:Boolean) : void
        {
            this.icon.autoSize = param1;
        }
    }
}
