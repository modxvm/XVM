package net.wg.gui.battle.views.battleTimer
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class EventAdditionalTimeText extends MovieClip implements IDisposable
    {

        private static const FIRST_FRAME:uint = 1;

        private static const SECOND_FRAME:uint = 2;

        private static const DEFAULT_TEXT_MARGIN:uint = 8;

        private static const EXTRA_TEXT_MARGIN:uint = 11;

        private static const CHANGE_MARGIN_POINT:uint = 9;

        public var tf:TextField = null;

        private var _currentMargin:uint = 0;

        public function EventAdditionalTimeText()
        {
            super();
        }

        public function dispose() : void
        {
            stop();
            this.tf = null;
        }

        public function update(param1:String, param2:Boolean, param3:Number) : void
        {
            if(param2)
            {
                gotoAndStop(SECOND_FRAME);
            }
            else
            {
                gotoAndStop(FIRST_FRAME);
            }
            this.tf.text = param1;
            this.updateMargin(param3);
        }

        public function updateMargin(param1:Number) : void
        {
            var _loc3_:TextFormat = null;
            var _loc2_:int = param1 > CHANGE_MARGIN_POINT?EXTRA_TEXT_MARGIN:DEFAULT_TEXT_MARGIN;
            if(this._currentMargin != _loc2_)
            {
                this._currentMargin = _loc2_;
                _loc3_ = this.tf.getTextFormat();
                _loc3_.rightMargin = this._currentMargin;
                this.tf.setTextFormat(_loc3_);
            }
        }
    }
}
