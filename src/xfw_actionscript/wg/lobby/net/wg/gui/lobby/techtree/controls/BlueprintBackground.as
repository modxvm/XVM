package net.wg.gui.lobby.techtree.controls
{
    import net.wg.gui.components.controls.BitmapFill;
    import flash.display.Sprite;

    public class BlueprintBackground extends FadeComponent
    {

        private static const _MEDIUM_SIZE_BREAKPOINT:Number = 1280;

        private static const _LARGE_SIZE_BREAKPOINT:Number = 1600;

        private static const _SMALL_BACKGROUND_SCALE:Number = 1;

        private static const _MEDIUM_BACKGROUND_SCALE:Number = 1.6;

        private static const _LARGE_BACKGROUND_SCALE:Number = 2;

        private static const _TECHTREE_BG_CENTER_OFFSET_X:int = -252;

        public var gridFill:BitmapFill = null;

        public var blueprintBg:Sprite = null;

        public var techtreeBg:Sprite = null;

        public var backgroundFill:Sprite = null;

        public function BlueprintBackground()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.gridFill.dispose();
            this.gridFill = null;
            this.blueprintBg = null;
            this.techtreeBg = null;
            this.backgroundFill = null;
            super.onDispose();
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            this.gridFill.setSize(param1,param2);
            this.techtreeBg.x = (param1 >> 1) + _TECHTREE_BG_CENTER_OFFSET_X;
            this.techtreeBg.y = param2 >> 1;
            if(param1 >= _LARGE_SIZE_BREAKPOINT)
            {
                this.techtreeBg.scaleX = this.techtreeBg.scaleY = _LARGE_BACKGROUND_SCALE;
            }
            else if(param1 >= _MEDIUM_SIZE_BREAKPOINT)
            {
                this.techtreeBg.scaleX = this.techtreeBg.scaleY = _MEDIUM_BACKGROUND_SCALE;
            }
            else
            {
                this.techtreeBg.scaleX = this.techtreeBg.scaleY = _SMALL_BACKGROUND_SCALE;
            }
            this.backgroundFill.width = param1;
            this.backgroundFill.height = param2;
            this.blueprintBg.getChildAt(0).width = param1;
            this.blueprintBg.getChildAt(0).height = param2;
        }
    }
}
