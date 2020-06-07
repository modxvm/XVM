package net.wg.gui.battle.views.consumablesPanel
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class BattleEquipmentButtonGlow extends BattleUIComponent
    {

        private static const SHOW_GLOW_HIDE_STATE:String = "hide";

        private static const SHOW_GLOW_GREEN_STATE:String = "green";

        private static const SHOW_GLOW_GREEN_SPECIAL_STATE:String = "greenSpecial";

        private static const SHOW_GLOW_ORANGE_STATE:String = "orange";

        private static const RED_TEXT_COLOR:uint = 16768409;

        private static const GREEN_TEXT_COLOR:uint = 11854471;

        private static const NORMAL_TEXT_COLOR:uint = 0;

        public var tfContainer:MovieClip = null;

        private var _textField:TextField = null;

        public function BattleEquipmentButtonGlow()
        {
            super();
            addFrameScript(0,this.goIdle);
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._textField = this.tfContainer.bindKeyField;
            TextFieldEx.setNoTranslate(this._textField,true);
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            mouseChildren = false;
        }

        public function glowGreen() : void
        {
            this._textField.textColor = GREEN_TEXT_COLOR;
            gotoAndPlay(SHOW_GLOW_GREEN_STATE);
        }

        public function glowGreenSpecial() : void
        {
            this._textField.textColor = GREEN_TEXT_COLOR;
            gotoAndPlay(SHOW_GLOW_GREEN_SPECIAL_STATE);
        }

        public function glowOrange() : void
        {
            this._textField.textColor = RED_TEXT_COLOR;
            gotoAndPlay(SHOW_GLOW_ORANGE_STATE);
        }

        public function hideGlow() : void
        {
            gotoAndPlay(SHOW_GLOW_HIDE_STATE);
        }

        public function setBindKeyText(param1:String) : void
        {
            this._textField.text = param1;
        }

        private function goIdle() : void
        {
            stop();
            this._textField.textColor = NORMAL_TEXT_COLOR;
        }

        override protected function onDispose() : void
        {
            stop();
            this._textField = null;
            this.tfContainer = null;
            super.onDispose();
        }
    }
}
