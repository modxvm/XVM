package net.wg.gui.battle.views.consumablesPanel
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;
    import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
    import flash.events.Event;

    public class BattleEquipmentButtonGlow extends BattleUIComponent
    {

        public static const ON_IDLE_STATE:String = "onIdleStateEvent";

        private static const SHOW_GLOW_HIDE_STATE:String = "hide";

        private static const SHOW_GLOW_GREEN_STATE:String = "green";

        private static const SHOW_GLOW_GREEN_SPECIAL_STATE:String = "greenSpecial";

        private static const SHOW_GLOW_ORANGE_STATE:String = "orange";

        private static const SHOW_GLOW_GREE_NO_HOT_KEY_STATE:String = "greenNoHotKey";

        private static const SHOW_GLOW_ORANGE_NO_HOT_KEY_STATE:String = "orangeNoHotKey";

        private static const SHOW_GLOW_HIDE_NO_HOT_KEY_STATE:String = "hideNoHotKey";

        private static const RED_TEXT_COLOR:uint = 16768409;

        private static const GREEN_TEXT_COLOR:uint = 11854471;

        protected static const NORMAL_TEXT_COLOR:uint = 0;

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

        override protected function onDispose() : void
        {
            addFrameScript(0,null);
            stop();
            this._textField = null;
            this.tfContainer = null;
            super.onDispose();
        }

        public function showGlow(param1:int) : void
        {
            switch(param1)
            {
                case CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN:
                    this._textField.textColor = GREEN_TEXT_COLOR;
                    gotoAndPlay(SHOW_GLOW_GREEN_STATE);
                    break;
                case CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN_NO_HOT_KEY:
                    this._textField.textColor = GREEN_TEXT_COLOR;
                    gotoAndPlay(SHOW_GLOW_GREE_NO_HOT_KEY_STATE);
                    break;
                case CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE:
                    this._textField.textColor = RED_TEXT_COLOR;
                    gotoAndPlay(SHOW_GLOW_ORANGE_STATE);
                    break;
                case CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE_NO_HOT_KEY:
                    this._textField.textColor = RED_TEXT_COLOR;
                    gotoAndPlay(SHOW_GLOW_ORANGE_NO_HOT_KEY_STATE);
                    break;
                case CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN_SPECIAL:
                    this._textField.textColor = GREEN_TEXT_COLOR;
                    gotoAndPlay(SHOW_GLOW_GREEN_SPECIAL_STATE);
                    break;
                default:
                    this._textField.textColor = NORMAL_TEXT_COLOR;
                    gotoAndPlay(SHOW_GLOW_HIDE_STATE);
            }
        }

        public function hideGlow(param1:Boolean = true) : void
        {
            if(param1)
            {
                gotoAndPlay(SHOW_GLOW_HIDE_STATE);
            }
            else
            {
                gotoAndPlay(SHOW_GLOW_HIDE_NO_HOT_KEY_STATE);
            }
        }

        public function setBindKeyText(param1:String) : void
        {
            this._textField.text = param1;
        }

        protected function goIdle() : void
        {
            stop();
            this._textField.textColor = NORMAL_TEXT_COLOR;
            dispatchEvent(new Event(BattleEquipmentButtonGlow.ON_IDLE_STATE));
        }

        protected function get bindKeyField() : TextField
        {
            return this._textField;
        }
    }
}
