package net.wg.gui.lobby.techtree.controls
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class TechTreeTitle extends MovieClip implements IDisposable
    {

        private static const _BIG_TITLE_STATE:String = "big";

        private static const _SMALL_TITLE_STATE:String = "small";

        private static const _TITLE_SIZE_FACTOR:int = 111;

        private static const _TITLE_SHOW_FACTOR:int = 51;

        private static const _ALREADY_DISPOSED_MESSAGE:String = "(TechTreeTitle) already disposed!";

        public var titleTF:TextField = null;

        protected var _baseDisposed:Boolean = false;

        private var _titleStr:String = "";

        public function TechTreeTitle()
        {
            super();
        }

        protected function onDispose() : void
        {
            this.titleTF = null;
        }

        public final function dispose() : void
        {
            App.utils.asserter.assert(!this._baseDisposed,name + _ALREADY_DISPOSED_MESSAGE);
            this.onDispose();
            this._baseDisposed = true;
        }

        public function updateTitle(param1:String) : void
        {
            this._titleStr = param1;
            this.titleTF.text = param1;
        }

        public function updateSize(param1:Number, param2:Number) : void
        {
            this.visible = param2 >= _TITLE_SHOW_FACTOR;
            if(this.visible)
            {
                if(param2 >= _TITLE_SIZE_FACTOR)
                {
                    this.gotoAndStop(_BIG_TITLE_STATE);
                }
                else
                {
                    this.gotoAndStop(_SMALL_TITLE_STATE);
                }
                if(this._baseDisposed)
                {
                    return;
                }
                this.titleTF.width = param1;
                this.titleTF.height = param2;
                this.titleTF.text = this._titleStr;
                TextFieldEx.setVerticalAlign(this.titleTF,TextFieldEx.VALIGN_CENTER);
            }
        }
    }
}
