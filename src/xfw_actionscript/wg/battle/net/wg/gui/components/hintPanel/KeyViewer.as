package net.wg.gui.components.hintPanel
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.text.TextFieldAutoSize;

    public class KeyViewer extends Sprite implements IDisposable
    {

        private static const TEXTFIELD_PADDING:int = 5;

        private static const KEY_LEFT_SIDE:int = 17;

        private static const KEY_RIGHT_SIDE:int = 17;

        private static const LEFT_MOUSE_BUTTON:String = "LMB";

        private static const RIGHT_MOUSE_BUTTON:String = "RMB";

        private static const MIDDLE_MOUSE_BUTTON:String = "MMB";

        private static const ADDITIONAL_MOUSE_BUTTON_UP:String = "UP_MB";

        private static const ADDITIONAL_MOUSE_BUTTON_DOWN:String = "DOWN_MB";

        private static const LEFT_ARROW_BUTTON:String = "Left Arrow";

        private static const RIGHT_ARROW_BUTTON:String = "Right Arrow";

        private static const DOWN_ARROW_BUTTON:String = "Down Arrow";

        private static const UP_ARROW_BUTTON:String = "Up Arrow";

        private static const BUTTONS_WITH_CUSTOM_ICON:Vector.<String> = new <String>[LEFT_MOUSE_BUTTON,RIGHT_MOUSE_BUTTON,MIDDLE_MOUSE_BUTTON,ADDITIONAL_MOUSE_BUTTON_UP,ADDITIONAL_MOUSE_BUTTON_DOWN,LEFT_ARROW_BUTTON,RIGHT_ARROW_BUTTON,DOWN_ARROW_BUTTON,UP_ARROW_BUTTON];

        public var keyTF:TextField = null;

        public var buttonBgMc:Sprite = null;

        public var customButtonIcon:MovieClip = null;

        public function KeyViewer()
        {
            super();
            this.keyTF.autoSize = TextFieldAutoSize.LEFT;
            this.keyTF.x = KEY_LEFT_SIDE;
        }

        public final function dispose() : void
        {
            this.keyTF = null;
            this.buttonBgMc = null;
            this.customButtonIcon = null;
        }

        public function setKey(param1:String) : void
        {
            var _loc2_:* = false;
            _loc2_ = BUTTONS_WITH_CUSTOM_ICON.indexOf(param1) >= 0;
            this.customButtonIcon.visible = _loc2_;
            this.keyTF.visible = !_loc2_;
            this.buttonBgMc.visible = !_loc2_;
            if(_loc2_)
            {
                this.customButtonIcon.gotoAndStop(param1);
            }
            else
            {
                this.keyTF.text = param1;
                this.keyTF.width = this.keyTF.textWidth + TEXTFIELD_PADDING | 0;
                this.buttonBgMc.width = this.keyTF.width + KEY_LEFT_SIDE + KEY_RIGHT_SIDE;
            }
        }
    }
}
