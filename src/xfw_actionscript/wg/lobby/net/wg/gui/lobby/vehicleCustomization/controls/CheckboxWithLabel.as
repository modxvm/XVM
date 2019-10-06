package net.wg.gui.lobby.vehicleCustomization.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.Values;

    public class CheckboxWithLabel extends UIComponentEx
    {

        private static const PADDING:uint = 10;

        private static const OVER_STATE_LABEL:String = "over";

        private static const OUT_STATE_LABEL:String = "out";

        private static const SELECTED_PREFIX:String = "selected_";

        private static const LABEL_TF_HOVER_COLOR:Number = 13224374;

        public var greenCheckbox:SoundButtonEx = null;

        public var hitMc:MovieClip = null;

        public var labelTf:TextField = null;

        private var _selectedPrefix:String = "";

        private var _labelTfDefaultFormat:TextFormat = null;

        private var _labelTfHoverFormat:TextFormat = null;

        public function CheckboxWithLabel()
        {
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.updateHitSize();
            this._labelTfDefaultFormat = this.labelTf.defaultTextFormat;
            this._labelTfHoverFormat = new TextFormat(this._labelTfDefaultFormat.font,this._labelTfDefaultFormat.size,LABEL_TF_HOVER_COLOR);
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.greenCheckbox.dispose();
            this.greenCheckbox = null;
            this.hitMc = null;
            this.labelTf = null;
            this._labelTfDefaultFormat = null;
            this._labelTfHoverFormat = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            this.hitMc.buttonMode = true;
            this.labelTf.autoSize = TextFieldAutoSize.LEFT;
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
            super.configUI();
        }

        private function updateHitSize() : void
        {
            this.hitMc.width = this.labelTf.x + this.labelTf.textWidth + PADDING | 0;
        }

        private function updateSelectedPrefix() : void
        {
            this._selectedPrefix = this.greenCheckbox.selected?SELECTED_PREFIX:Values.EMPTY_STR;
        }

        override public function get width() : Number
        {
            return this.hitMc.width;
        }

        public function set text(param1:String) : void
        {
            this.labelTf.text = param1;
            this.updateHitSize();
        }

        public function get selected() : Boolean
        {
            return this.greenCheckbox.selected;
        }

        public function set selected(param1:Boolean) : void
        {
            this.greenCheckbox.selected = param1;
            this.updateSelectedPrefix();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            this.greenCheckbox.gotoAndPlay(this._selectedPrefix + OVER_STATE_LABEL);
            this.labelTf.setTextFormat(this._labelTfHoverFormat);
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this.greenCheckbox.gotoAndPlay(this._selectedPrefix + OUT_STATE_LABEL);
            this.labelTf.setTextFormat(this._labelTfDefaultFormat);
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            this.greenCheckbox.selected = !this.greenCheckbox.selected;
            this.updateSelectedPrefix();
        }
    }
}
