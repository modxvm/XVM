package net.wg.gui.lobby.epicBattles.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import net.wg.utils.ICommons;

    public class EpicLevelTextWrapper extends MovieClip implements IDisposable
    {

        public var text:TextField;

        public var overlay:MovieClip;

        private var _commons:ICommons;

        public function EpicLevelTextWrapper()
        {
            this._commons = App.utils.commons;
            super();
        }

        private static function updateTextSize(param1:TextField, param2:int) : void
        {
            var _loc3_:TextFormat = param1.getTextFormat();
            _loc3_.size = param2;
            param1.setTextFormat(_loc3_);
            param1.defaultTextFormat = _loc3_;
        }

        override public function gotoAndStop(param1:Object, param2:String = null) : void
        {
            super.gotoAndStop(param1,param2);
            this.overlay.gotoAndStop(param1,param2);
        }

        public function setText(param1:String) : void
        {
            this.text.text = param1;
            this.overlay.text.text = param1;
        }

        public function setTextSize(param1:int) : void
        {
            updateTextSize(this.text,param1);
            updateTextSize(this.overlay.text,param1);
            this._commons.updateTextFieldSize(this.text,true,true);
            this._commons.updateTextFieldSize(this.overlay.text,true,true);
            this.overlay.eraser.width = this.text.width;
            this.overlay.eraser.height = this.text.height;
        }

        public final function dispose() : void
        {
            this._commons = null;
            this.text = null;
            this.overlay = null;
        }
    }
}
