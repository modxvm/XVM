package net.wg.gui.lobby.vehicleCompare.controls.view
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.Sprite;
    import flash.text.TextField;

    public class VehCompareBubble extends UIComponentEx
    {

        private static const MARGIN:int = 30;

        private static const REVERTED_Y:int = -11;

        private static const NOT_REVERTED_Y:int = 11;

        public var bubble:Sprite = null;

        public var bubbleArrow:Sprite = null;

        public var bubbleText:TextField = null;

        public function VehCompareBubble()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.bubble = null;
            this.bubbleText = null;
            this.bubbleArrow = null;
            super.onDispose();
        }

        public function set isReverted(param1:Boolean) : void
        {
            this.bubbleArrow.y = param1?REVERTED_Y:NOT_REVERTED_Y;
            this.bubbleArrow.scaleY = param1?-1:1;
        }

        public function set text(param1:String) : void
        {
            this.bubbleText.htmlText = param1;
            width = this.bubble.width = this.bubbleText.textWidth + MARGIN | 0;
        }
    }
}
