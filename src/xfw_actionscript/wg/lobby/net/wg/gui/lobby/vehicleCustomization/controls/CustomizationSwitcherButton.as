package net.wg.gui.lobby.vehicleCustomization.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.ComponentState;
    import flash.events.MouseEvent;
    import net.wg.data.constants.SoundManagerStates;
    import net.wg.data.constants.SoundTypes;

    public class CustomizationSwitcherButton extends SoundButtonEx
    {

        private static const HOVER_ALPHA:Number = 0.8;

        private static const SWITCHER_DISABLED_ALPHA:Number = 0.35;

        public function CustomizationSwitcherButton()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            dynamicSizeByText = true;
            paddingHorizontal = textField.x;
            autoSize = TextFieldAutoSize.LEFT;
            addEventListener(ButtonEvent.CLICK,this.onClickHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:String = _newFrame;
            super.draw();
            if(_loc1_ && isInvalid(InvalidationType.STATE))
            {
                bgMc.gotoAndStop(_loc1_);
                hitMc.gotoAndStop(_loc1_);
                if(!this.enabled)
                {
                    textField.alpha = SWITCHER_DISABLED_ALPHA;
                }
                else if(this.selected)
                {
                    textField.alpha = ENABLED_ALPHA;
                }
                else
                {
                    textField.alpha = _loc1_ == ComponentState.OVER?HOVER_ALPHA:DISABLED_ALPHA;
                }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                updateDisable();
            }
        }

        override public function canPlaySound(param1:String) : Boolean
        {
            return false;
        }

        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            if(this.enabled)
            {
                App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.CUSTOMIZATION_DEFAULT,null);
            }
        }

        private function onClickHandler(param1:ButtonEvent) : void
        {
            if(this.enabled)
            {
                this.selected = true;
            }
        }
    }
}
