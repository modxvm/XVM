package net.wg.gui.battle.battleRoyale.views.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class BattleRoyaleTimerContainer extends MovieClip implements IDisposable
    {

        private static const TIME_TF_X:int = 0;

        private static const TIME_TF_Y:int = 16;

        private static const TIME_TF_SMALL_X:int = -9;

        private static const TIME_TF_SMALL_Y:int = 15;

        private static const TIME_TEMPLATE_DEFAULT:String = "00:00";

        public var tf:TextField = null;

        public var timeTF:TextField = null;

        private var _countdownVisible:Boolean = true;

        private var _defaultAutoSize:String = "left";

        private var _title:String = "";

        private var _timeTfMinWidth:int = 0;

        public function BattleRoyaleTimerContainer()
        {
            super();
            this.tf.autoSize = this._defaultAutoSize;
            this.timeTF.autoSize = this._defaultAutoSize;
            this.timeTF.text = TIME_TEMPLATE_DEFAULT;
            TextFieldEx.setNoTranslate(this.tf,true);
            TextFieldEx.setNoTranslate(this.timeTF,true);
            this._timeTfMinWidth = this.timeTF.width;
        }

        public function cropSize() : void
        {
            var _loc1_:uint = 0;
            _loc1_ = this.tf.textColor;
            gotoAndStop(BattleRoyaleTimer.SMALL_SIZE_FRAME_LABEL);
            this.updateTimeTfVisible();
            this.tf.visible = false;
            this.timeTF.x = TIME_TF_SMALL_X;
            this.timeTF.y = TIME_TF_SMALL_Y;
            this.setTextColor(_loc1_);
        }

        public final function dispose() : void
        {
            this.tf = null;
            this.timeTF = null;
        }

        public function fullSize() : void
        {
            var _loc1_:uint = 0;
            _loc1_ = this.tf.textColor;
            gotoAndStop(BattleRoyaleTimer.FULL_SIZE_FRAME_LABEL);
            this.updateTimeTfVisible();
            this.tf.autoSize = this._defaultAutoSize;
            this.tf.text = this._title;
            this.tf.visible = true;
            this.timeTF.autoSize = this._defaultAutoSize;
            this.timeTF.x = TIME_TF_X;
            this.timeTF.y = TIME_TF_Y;
            this.setTextColor(_loc1_);
        }

        public function setTextColor(param1:uint) : void
        {
            this.tf.textColor = param1;
            this.timeTF.textColor = param1;
        }

        public function setTime(param1:String) : void
        {
            this.timeTF.text = param1;
        }

        public function setTitle(param1:String) : void
        {
            this._title = param1;
            this.tf.text = this._title;
        }

        private function updateTimeTfVisible() : void
        {
            this.timeTF.visible = this._countdownVisible;
        }

        public function get actualWidth() : uint
        {
            return Math.max(width,this._timeTfMinWidth);
        }

        public function set countdownVisible(param1:Boolean) : void
        {
            this._countdownVisible = param1;
            this.updateTimeTfVisible();
        }
    }
}
