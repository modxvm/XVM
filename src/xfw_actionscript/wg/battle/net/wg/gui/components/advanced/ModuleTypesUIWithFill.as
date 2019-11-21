package net.wg.gui.components.advanced
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.BitmapFill;
    import net.wg.gui.components.controls.Image;
    import flash.events.Event;

    public class ModuleTypesUIWithFill extends UIComponentEx
    {

        public var extraIconBitmapFill:BitmapFill = null;

        private var _icon:Image = null;

        public function ModuleTypesUIWithFill()
        {
            super();
            this.hideExtraIcon();
        }

        override protected function onDispose() : void
        {
            if(this._icon != null)
            {
                this._icon.removeEventListener(Event.CHANGE,this.onIconLoadedHandler);
                this._icon.dispose();
                this._icon = null;
            }
            this.extraIconBitmapFill.dispose();
            this.extraIconBitmapFill = null;
            super.onDispose();
        }

        public function hideExtraIcon() : void
        {
            this.extraIconBitmapFill.visible = false;
        }

        public function setExtraIconByLinkage(param1:String) : void
        {
            this.extraIconBitmapFill.source = param1;
            this.extraIconBitmapFill.validateNow();
        }

        public function setExtraIconBySource(param1:String) : void
        {
            if(this._icon == null)
            {
                this._icon = new Image();
                this._icon.addEventListener(Event.CHANGE,this.onIconLoadedHandler);
            }
            this._icon.source = param1;
        }

        public function showExtraIcon() : void
        {
            this.extraIconBitmapFill.visible = true;
        }

        public function set extraIconX(param1:Number) : void
        {
            this.extraIconBitmapFill.x = param1;
        }

        public function set extraIconY(param1:Number) : void
        {
            this.extraIconBitmapFill.y = param1;
        }

        public function get extraIconAlpha() : Number
        {
            return this.extraIconBitmapFill.alpha;
        }

        public function set extraIconAlpha(param1:Number) : void
        {
            this.extraIconBitmapFill.alpha = param1;
        }

        private function onIconLoadedHandler(param1:Event) : void
        {
            this.extraIconBitmapFill.setBitmap(this._icon.bitmapData);
            this.extraIconBitmapFill.validateNow();
        }
    }
}
