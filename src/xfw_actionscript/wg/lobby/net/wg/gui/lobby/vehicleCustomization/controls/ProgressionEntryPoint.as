package net.wg.gui.lobby.vehicleCustomization.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
    import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.SoundTypes;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
    import flash.text.TextFieldAutoSize;

    public class ProgressionEntryPoint extends UIComponentEx implements IDisposable
    {

        private static const OVER_STATE:String = "over";

        private static const OUT_STATE:String = "out";

        private static const BORDERS_HIT_AREA_NAME:String = "borderHit";

        private static const BASE_SCALE:uint = 1;

        private static const FREE_SPACE_WIDTH:uint = 184;

        public var hitMc:Sprite = null;

        public var border:Sprite = null;

        public var borderHover:Sprite = null;

        public var textField:TextField = null;

        public function ProgressionEntryPoint()
        {
            var _loc1_:Sprite = null;
            super();
            hitArea = this.hitMc;
            buttonMode = true;
            hitArea.buttonMode = true;
            this.textField.autoSize = TextFieldAutoSize.CENTER;
            _loc1_ = new Sprite();
            _loc1_.name = BORDERS_HIT_AREA_NAME;
            addChild(_loc1_);
            this.border.mouseEnabled = this.border.mouseChildren = false;
            this.borderHover.mouseEnabled = this.borderHover.mouseChildren = false;
            this.border.hitArea = _loc1_;
            this.borderHover.hitArea = _loc1_;
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            stop();
            this.textField = null;
            this.border = null;
            this.borderHover = null;
            this.hitMc = null;
            super.onDispose();
        }

        public function setScale(param1:Number) : void
        {
            scaleX = scaleY = param1;
            this.textField.scaleX = this.textField.scaleY = BASE_SCALE / param1;
            this.textField.width = this.textField.width | 0;
            this.textField.height = this.textField.height | 0;
            this.textField.x = FREE_SPACE_WIDTH - this.textField.width >> 1;
        }

        public function set label(param1:String) : void
        {
            this.textField.htmlText = param1;
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            gotoAndPlay(OVER_STATE);
            dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_HIGHLIGHT));
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            gotoAndPlay(OUT_STATE);
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            if(param1 is MouseEventEx)
            {
                if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
                {
                    dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,SoundTypes.CUSTOMIZATION_SELECT));
                    dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_PROGRESSION_DECALS_WINDOW));
                }
            }
        }
    }
}
