package net.wg.gui.bootcamp
{
    import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
    import net.wg.gui.interfaces.IHighlighted;
    import net.wg.data.constants.InvalidationType;
    import net.wg.data.constants.InteractiveStates;
    import flash.display.MovieClip;

    public class BCBattleEquipmentButton extends BattleEquipmentButton implements IHighlighted
    {

        private static const HIGHLIGHT_LABEL:String = "highlight";

        private static const HIGHLIGHT_SCALE:Number = 1.2;

        private static const ICON_NORMAL_POS:int = 8;

        private static const ICON_HIGHLIGHT_POS:int = 3;

        private static const SHOW_GLOW_HIGHLIGHT_STATE:String = "highlight";

        private var _highlighted:Boolean = false;

        public function BCBattleEquipmentButton()
        {
            super();
            consumableBackground = new MovieClip();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                iconLoader.scaleX = iconLoader.scaleY = !this._highlighted?1:HIGHLIGHT_SCALE;
                iconLoader.x = iconLoader.y = !this._highlighted?ICON_NORMAL_POS:ICON_HIGHLIGHT_POS;
            }
        }

        override protected function getFrameLabel(param1:String) : String
        {
            return !this._highlighted?param1:HIGHLIGHT_LABEL;
        }

        public function get highlight() : Boolean
        {
            return this._highlighted;
        }

        public function set highlight(param1:Boolean) : void
        {
            if(this._highlighted != param1 && !_baseDisposed)
            {
                this._highlighted = param1;
                state = this._highlighted?HIGHLIGHT_LABEL:InteractiveStates.UP;
                invalidateState();
                if(this._highlighted)
                {
                    glow.gotoAndPlay(SHOW_GLOW_HIGHLIGHT_STATE);
                }
                else
                {
                    glow.hideGlow();
                }
            }
        }
    }
}
