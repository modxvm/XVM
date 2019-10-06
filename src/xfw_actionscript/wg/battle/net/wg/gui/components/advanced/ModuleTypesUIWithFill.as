package net.wg.gui.components.advanced
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.BitmapFill;

    public class ModuleTypesUIWithFill extends UIComponentEx
    {

        public var extraIconBitmapFill:BitmapFill;

        public function ModuleTypesUIWithFill()
        {
            super();
            this.hideExtraIcon();
        }

        override protected function onDispose() : void
        {
            this.extraIconBitmapFill.dispose();
            this.extraIconBitmapFill = null;
            super.onDispose();
        }

        public function hideExtraIcon() : void
        {
            this.extraIconBitmapFill.visible = false;
        }

        public function setExtraIcon(param1:String) : void
        {
            this.extraIconBitmapFill.source = param1;
            this.extraIconBitmapFill.validateNow();
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
    }
}
