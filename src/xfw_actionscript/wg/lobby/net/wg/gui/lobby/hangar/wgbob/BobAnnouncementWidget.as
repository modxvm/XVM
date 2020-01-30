package net.wg.gui.lobby.hangar.wgbob
{
    import net.wg.infrastructure.base.meta.impl.BobAnnouncementWidgetMeta;
    import net.wg.infrastructure.base.meta.IBobAnnouncementWidgetMeta;
    import net.wg.infrastructure.interfaces.entity.ISoundable;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.SoundTypes;
    import flash.display.FrameLabel;

    public class BobAnnouncementWidget extends BobAnnouncementWidgetMeta implements IBobAnnouncementWidgetMeta, ISoundable
    {

        public static const PADDING_RIGHT:int = 8;

        public var eventTitle:BobAnnouncementWidgetTitle;

        public var headerText:TextField;

        public var description:BobAnnouncementWidgetDescription;

        public var hover:SimpleButton;

        private var _enabled:Boolean = true;

        private var _currentRealm:String;

        private var _title:String = "";

        private var _description:String = "";

        private var _header:String = "";

        private var _isLocked:Boolean;

        private var _hasTimer:Boolean;

        private var _frameLabels:Vector.<String>;

        public function BobAnnouncementWidget()
        {
            var _loc1_:FrameLabel = null;
            this._frameLabels = new Vector.<String>(0);
            super();
            for each(_loc1_ in currentLabels)
            {
                this._frameLabels.push(_loc1_.name);
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.hover.addEventListener(MouseEvent.CLICK,this.onClickHandler);
            if(App.soundMgr != null)
            {
                App.soundMgr.addSoundsHdlrs(this);
            }
        }

        override protected function onDispose() : void
        {
            this.eventTitle.dispose();
            this.eventTitle = null;
            this.description.dispose();
            this.description = null;
            this.headerText = null;
            this.hover.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.hover = null;
            this._frameLabels.splice(0,this._frameLabels.length);
            this._frameLabels = null;
            if(App.soundMgr != null)
            {
                App.soundMgr.removeSoundHdlrs(this);
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                if(!this._enabled)
                {
                    visible = false;
                }
                else
                {
                    if(currentFrameLabel != this._currentRealm && this._frameLabels.indexOf(this._currentRealm) != -1)
                    {
                        gotoAndStop(this._currentRealm);
                    }
                    if(!visible)
                    {
                        visible = true;
                    }
                }
            }
            if(isInvalid(InvalidationType.DATA))
            {
                this.description.setDescription(this._description,this._isLocked,this._hasTimer);
                this.eventTitle.setTitle(this._title);
                this.headerText.text = this._header;
            }
        }

        public function as_setCurrentRealm(param1:String) : void
        {
            this._currentRealm = param1;
            invalidateState();
        }

        public function as_setEnabled(param1:Boolean) : void
        {
            if(this._enabled != param1)
            {
                this._enabled = param1;
                invalidateState();
            }
        }

        public function as_setEventTitle(param1:String) : void
        {
            if(this._title != param1)
            {
                this._title = param1;
                invalidateData();
            }
        }

        public function as_showAnnouncement(param1:String, param2:String, param3:Boolean, param4:Boolean) : void
        {
            if(this._header == param1 && this._description == param2 && this._isLocked == param3 && this._hasTimer == param4)
            {
                return;
            }
            this._header = param1;
            this._description = param2;
            this._isLocked = param3;
            this._hasTimer = param4;
            invalidateData();
        }

        public function canPlaySound(param1:String) : Boolean
        {
            return true;
        }

        public function getSoundId() : String
        {
            return null;
        }

        public function getSoundType() : String
        {
            return SoundTypes.NORMAL_BTN;
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            onClickS();
        }
    }
}
