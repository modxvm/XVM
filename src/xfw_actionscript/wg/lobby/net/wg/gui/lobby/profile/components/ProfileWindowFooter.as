package net.wg.gui.lobby.profile.components
{
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.profile.ProfileOpenInfoEvent;

    public class ProfileWindowFooter extends ProfileFooter
    {

        private static const LAYOUT_INVALID:String = "layInv";

        private static const HEIGHT:int = 181;

        private static const TOP_GAP:int = 25;

        private static const GROUPS_GAP:int = 120;

        private static const SIDES_GAP:uint = 10;

        public var registerDateTf:TextField = null;

        public var lastBattleTf:TextField = null;

        public var noGroupsTf:TextField = null;

        public var background:Sprite = null;

        public var noGroupsProxy:Sprite = null;

        private var _clanGroupBlock:ProfileGroupBlock = null;

        private var _clan:ProfileGroupBlockVO = null;

        private var _clanEmblem:String = null;

        public function ProfileWindowFooter()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.registerDateTf.autoSize = TextFieldAutoSize.LEFT;
            this.lastBattleTf.autoSize = TextFieldAutoSize.LEFT;
            this.registerDateTf.selectable = this.lastBattleTf.selectable = false;
            this.registerDateTf.x = SIDES_GAP;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(LAYOUT_INVALID))
            {
                this.lastBattleTf.x = this.width - this.lastBattleTf.width - SIDES_GAP;
                this.noGroupsProxy.visible = this.noGroupsTf.visible = false;
                if(data)
                {
                    if(this._clan)
                    {
                        this._clanGroupBlock.y = TOP_GAP;
                        this._clanGroupBlock.x = width - this._clanGroupBlock.width >> 1;
                    }
                    else
                    {
                        this.noGroupsProxy.visible = this.noGroupsTf.visible = true;
                        this.noGroupsTf.text = PROFILE.PROFILE_SUMMARY_NOGROUPS;
                    }
                }
            }
        }

        override protected function applyDataChanges() : void
        {
            super.applyDataChanges();
            this.lastBattleTf.htmlText = data.lastBattleDate;
            this.registerDateTf.htmlText = data.registrationDate;
            this.updateClanBlock();
            invalidate(LAYOUT_INVALID);
        }

        override protected function onDispose() : void
        {
            this.removeClanBlock();
            this.lastBattleTf = null;
            this.registerDateTf = null;
            this.background = null;
            this.noGroupsTf = null;
            this.noGroupsProxy = null;
            this._clan = null;
            super.onDispose();
        }

        public function setClanData(param1:ProfileGroupBlockVO) : void
        {
            this._clan = param1;
            invalidateData();
        }

        public function setClanEmblem(param1:String) : void
        {
            this._clanEmblem = param1;
            if(this._clanGroupBlock)
            {
                this._clanGroupBlock.setEmblem(param1);
            }
        }

        private function createGroupBlock() : ProfileGroupBlock
        {
            var _loc1_:ProfileGroupBlock = null;
            _loc1_ = ProfileGroupBlock(App.utils.classFactory.getComponent(Linkages.PROFILE_GROUP_BLOCK,ProfileGroupBlock));
            this.addChild(_loc1_);
            _loc1_.visible = false;
            return _loc1_;
        }

        private function updateClanBlock() : void
        {
            if(this._clan)
            {
                if(this._clanGroupBlock == null)
                {
                    this._clanGroupBlock = this.createGroupBlock();
                    this._clanGroupBlock.actionBtn.addEventListener(ButtonEvent.CLICK,this.onClanGroupBlockActionBtnClickHandler);
                    App.utils.scheduler.scheduleOnNextFrame(this.updateClanData);
                    invalidate(LAYOUT_INVALID);
                }
                else
                {
                    this.updateClanData();
                }
            }
            else
            {
                this.removeClanBlock();
                invalidate(LAYOUT_INVALID);
            }
        }

        private function updateClanData() : void
        {
            this._clanGroupBlock.setData(this._clan);
            this._clanGroupBlock.setEmblem(this._clanEmblem);
            this._clanGroupBlock.visible = true;
        }

        private function removeClanBlock() : void
        {
            if(this._clanGroupBlock)
            {
                App.utils.scheduler.cancelTask(this.updateClanData);
                this._clanGroupBlock.actionBtn.removeEventListener(ButtonEvent.CLICK,this.onClanGroupBlockActionBtnClickHandler);
                removeChild(this._clanGroupBlock);
                this._clanGroupBlock.dispose();
                this._clanGroupBlock = null;
            }
        }

        override public function get height() : Number
        {
            return HEIGHT;
        }

        private function onClanGroupBlockActionBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new ProfileOpenInfoEvent(ProfileOpenInfoEvent.CLAN));
        }
    }
}
