package net.wg.gui.lobby.manual.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import scaleform.gfx.TextFieldEx;
    import flash.text.TextFormat;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.manual.data.ChapterItemRendererVO;

    public class ChapterItemRenderer extends SoundButtonEx
    {

        public var loader:UILoaderAlt;

        private const FONT_SMALL:int = 21;

        private const FONT_NORMAL:int = 30;

        public function ChapterItemRenderer()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.loader.mouseChildren = false;
            this.loader.mouseEnabled = false;
            TextFieldEx.setVerticalAlign(textField,TextFieldEx.VALIGN_CENTER);
            displayFocus = false;
        }

        override protected function onDispose() : void
        {
            this.loader.dispose();
            this.loader = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:TextFormat = null;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = textField.getTextFormat();
                _loc1_.size = scaleX < 1?this.FONT_SMALL:this.FONT_NORMAL;
                textField.setTextFormat(_loc1_);
            }
        }

        override public function set data(param1:Object) : void
        {
            super.data = param1;
            var _loc2_:ChapterItemRendererVO = ChapterItemRendererVO(data);
            this.loader.source = _loc2_.image;
            label = _loc2_.label;
            tooltip = _loc2_.tooltip;
        }
    }
}
