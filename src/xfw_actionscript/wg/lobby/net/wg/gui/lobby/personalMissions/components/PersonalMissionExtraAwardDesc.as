package net.wg.gui.lobby.personalMissions.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;

    public class PersonalMissionExtraAwardDesc extends MovieClip implements IDisposable
    {

        private static const ICON_WIDTH:uint = 83;

        private static const GAP:uint = 10;

        public var icon:UILoaderAlt = null;

        public var lvlTF:TextField;

        public var nameTF:TextField;

        private var _lvlTF:TextFormat = null;

        private var _nameTF:TextFormat = null;

        private var _extraGap:int = 0;

        public function PersonalMissionExtraAwardDesc()
        {
            super();
            this.lvlTF.autoSize = TextFieldAutoSize.RIGHT;
            this.nameTF.autoSize = TextFieldAutoSize.LEFT;
            this._lvlTF = this.lvlTF.getTextFormat();
            this._nameTF = this.nameTF.getTextFormat();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setComponentsY(param1:int, param2:int, param3:int) : void
        {
            this.lvlTF.y = param1;
            this.icon.y = param2;
            this.nameTF.y = param3;
        }

        public function setDesc(param1:String, param2:String, param3:String) : void
        {
            this.icon.source = param1;
            this.lvlTF.text = param2;
            this.nameTF.text = param3;
            this.layout();
        }

        public function setSize(param1:int, param2:int) : void
        {
            if(this._lvlTF.size != param1)
            {
                this._lvlTF.size = param1;
                this.lvlTF.setTextFormat(this._lvlTF);
            }
            if(this._nameTF.size != param2)
            {
                this._nameTF.size = param2;
                this.nameTF.setTextFormat(this._nameTF);
            }
            this.layout();
        }

        protected function onDispose() : void
        {
            this.icon.dispose();
            this.icon = null;
            this.lvlTF = null;
            this.nameTF = null;
            this._lvlTF = null;
            this._nameTF = null;
        }

        private function layout() : void
        {
            var _loc1_:uint = this.lvlTF.textWidth + ICON_WIDTH + this.nameTF.textWidth;
            var _loc2_:* = _loc1_ >> 1;
            this.lvlTF.x = -_loc2_;
            this.icon.x = this.lvlTF.x + this.lvlTF.width - GAP + this._extraGap >> 0;
            this.nameTF.x = this.icon.x + ICON_WIDTH - GAP;
        }

        public function set htmlText(param1:String) : void
        {
            this.lvlTF.htmlText = param1;
        }

        public function set extraGap(param1:int) : void
        {
            this._extraGap = param1;
            this.layout();
        }
    }
}
