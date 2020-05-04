package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.gui.components.containers.SoundButtonContainer;
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionAwardBtnReflect;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.interfaces.ISoundButtonEx;

    public class EventAwardScreenBtnAnim extends EventAwardScreenAnim
    {

        public var awardBtn:SoundButtonContainer;

        public var reflect:PersonalMissionAwardBtnReflect;

        protected var _btnEnabled:Boolean = true;

        protected var _top:int;

        protected var _screenHeight:int;

        public function EventAwardScreenBtnAnim()
        {
            super();
            this.awardBtn.text = PERSONAL_MISSIONS.AWARDSSCREEN_ACCEPTBTN_LABEL;
            mouseEnabled = mouseChildren = false;
        }

        override public function setData(param1:Object) : void
        {
            if(param1 != null)
            {
                this.awardBtn.text = String(param1);
            }
        }

        override protected function onDispose() : void
        {
            this.awardBtn.dispose();
            this.awardBtn = null;
            if(this.reflect != null)
            {
                this.reflect.dispose();
                this.reflect = null;
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                y = this._top + (this._screenHeight - this._top + this.awardBtn.height >> 1);
            }
        }

        override protected function onFadeOutComplete() : void
        {
            this.setBtnEnabled(false);
            mouseEnabled = mouseChildren = false;
            super.onFadeOutComplete();
        }

        override protected function onFadeInComplete() : void
        {
            mouseChildren = true;
            this.setBtnEnabled(true);
            if(this.reflect != null)
            {
                this.reflect.playAnim();
            }
            super.onFadeInComplete();
        }

        public function getBtn() : ISoundButtonEx
        {
            return this.awardBtn.button;
        }

        public function setBtnEnabled(param1:Boolean) : void
        {
            if(this._btnEnabled != param1)
            {
                this._btnEnabled = param1;
                this.awardBtn.button.enabled = this._btnEnabled;
            }
        }

        public function setPositioning(param1:int, param2:int) : void
        {
            this._top = param1;
            this._screenHeight = param2;
            invalidateSize();
        }
    }
}
