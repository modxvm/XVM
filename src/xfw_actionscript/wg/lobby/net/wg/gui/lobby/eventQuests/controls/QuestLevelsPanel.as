package net.wg.gui.lobby.eventQuests.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.advanced.ButtonBarEx;
    import flash.text.TextField;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.components.containers.GroupEx;
    import net.wg.gui.lobby.eventQuests.data.QuestsChainVO;
    import net.wg.gui.lobby.eventQuests.data.QuestLevelProgressVO;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
    import net.wg.utils.ILocale;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;

    public class QuestLevelsPanel extends UIComponentEx
    {

        private static const QUEST_BTN_WIDTH:int = 44;

        private static const QUEST_BTN_SPACE:int = 14;

        private static const SPACING_SMALL:int = -16;

        private static const BAR_OFFSET:int = 8;

        private static const GROUP_RENDERER_GAP:int = 80;

        private static const GROUP_RENDERER_GAP_SMALL:int = 64;

        private static const GROUP_GAP:int = 30;

        private static const GROUP_RENDERER:String = "EventQuestRewardRendererUI";

        private static const GROUP_RENDERER_SMALL:String = "EventQuestRewardRendererSmallUI";

        private static const QUEST_INVALIDATE:String = "questInvalidate";

        private static const STATE_COMPLETE:String = "complete";

        private static const STATE_IDLE:String = "idle";

        private static const STATE_LOCK:String = "lock";

        private static const SMALL_FRAME:String = "smallFrame";

        private static const FULL_FRAME:String = "fullFrame";

        private static const CHAIN_BIG:String = "LevelPageBigUI";

        public var chainBar:ButtonBarEx = null;

        public var textCurrent:TextField = null;

        public var textTotal:TextField = null;

        public var textHeader:TextField = null;

        public var textName:TextField = null;

        public var status:AnimatedTextContainer = null;

        public var icon:UILoaderAlt = null;

        public var iconSmall:UILoaderAlt = null;

        public var progress:MovieClip = null;

        public var bg:MovieClip = null;

        public var iconNew:MovieClip = null;

        public var divider:MovieClip = null;

        public var sizeMc:MovieClip = null;

        public var rewards:GroupEx = null;

        public var rewardSmall:GroupEx = null;

        private var _data:QuestsChainVO = null;

        private var _dataQuest:QuestLevelProgressVO = null;

        private var _selectedQuestId:int = -1;

        private var _firstTime:Boolean = true;

        private var _isSmall:Boolean = false;

        private var _dataProvider:DataProvider = null;

        public function QuestLevelsPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.initBar();
            this.rewards.itemRendererLinkage = GROUP_RENDERER;
            this.rewardSmall.itemRendererLinkage = GROUP_RENDERER_SMALL;
            this.chainBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onLevelsIndexChangeHandler);
            var _loc1_:CenterAlignedGroupLayout = new CenterAlignedGroupLayout(GROUP_RENDERER_GAP,GROUP_RENDERER_GAP);
            _loc1_.gap = GROUP_GAP;
            var _loc2_:CenterAlignedGroupLayout = new CenterAlignedGroupLayout(GROUP_RENDERER_GAP_SMALL,GROUP_RENDERER_GAP_SMALL);
            _loc2_.gap = GROUP_GAP;
            this.rewards.layout = _loc1_;
            this.rewardSmall.layout = _loc2_;
            this.chainBar.itemRendererName = CHAIN_BIG;
            this.chainBar.spacing = SPACING_SMALL;
        }

        override protected function draw() : void
        {
            var _loc2_:String = null;
            var _loc3_:ILocale = null;
            var _loc4_:* = false;
            super.draw();
            var _loc1_:Boolean = isInvalid(InvalidationType.DATA);
            if(this._dataProvider != null && _loc1_)
            {
                this.chainBar.x = this.bg.width - QUEST_BTN_WIDTH * this._dataProvider.length - QUEST_BTN_SPACE >> 1;
                this.chainBar.y = this.bg.y + this.bg.height + BAR_OFFSET;
                this.icon.visible = !this._isSmall;
                this.iconSmall.visible = this._isSmall;
            }
            if(this._data != null && _loc1_)
            {
                this.icon.source = this._data.icon;
                this.iconSmall.source = this._data.icon;
                this.iconNew.visible = this._data.isNew;
                this.textName.text = this._data.label;
                if(this._firstTime)
                {
                    this._firstTime = false;
                    this.chainBar.selectedIndex = this._data.currentIndex;
                }
            }
            if(this._dataQuest != null && isInvalid(QUEST_INVALIDATE))
            {
                _loc2_ = STATE_IDLE;
                if(!this._dataQuest.unlocked)
                {
                    _loc2_ = STATE_LOCK;
                }
                else if(this._dataQuest.completed)
                {
                    _loc2_ = STATE_COMPLETE;
                }
                this.status.gotoAndStop(_loc2_);
                this.bg.gotoAndStop(_loc2_);
                this.rewards.dataProvider = this._dataQuest.rewards;
                this.rewardSmall.dataProvider = this._dataQuest.rewards;
                _loc3_ = App.utils.locale;
                this.textCurrent.text = _loc3_.integer(this._dataQuest.progressCurrent);
                this.textTotal.text = _loc3_.integer(this._dataQuest.progressTotal);
                this.textHeader.text = this._dataQuest.header;
                this.status.text = this._dataQuest.status;
                this.progress.gotoAndStop(this._dataQuest.progress);
                _loc4_ = this._dataQuest.progress != Values.DEFAULT_INT;
                this.textTotal.visible = this.textCurrent.visible = this.divider.visible = this.progress.visible = _loc4_;
            }
        }

        override protected function onDispose() : void
        {
            this.chainBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onLevelsIndexChangeHandler);
            this.chainBar.dispose();
            this.chainBar = null;
            this.icon.dispose();
            this.icon = null;
            this.rewards.dispose();
            this.rewards = null;
            this.rewardSmall.dispose();
            this.rewardSmall = null;
            this.iconSmall.dispose();
            this.iconSmall = null;
            this.bg = null;
            this.progress = null;
            this.status.dispose();
            this.status = null;
            this.textHeader = null;
            this.textTotal = null;
            this.textCurrent = null;
            this.divider = null;
            this.iconNew = null;
            this.textName = null;
            this.sizeMc = null;
            this._data = null;
            this._dataQuest = null;
            if(this._dataProvider)
            {
                this._dataProvider.cleanUp();
                this._dataProvider = null;
            }
            super.onDispose();
        }

        public function getBGHeight() : int
        {
            return this.sizeMc.height;
        }

        public function getBGWidth() : int
        {
            return this.sizeMc.width;
        }

        public function setData(param1:QuestsChainVO) : void
        {
            if(param1 != null && param1 != this._data)
            {
                this._data = param1;
                this._dataProvider = this._data.quests;
                this.chainBar.dataProvider = this._dataProvider;
                invalidateData();
            }
        }

        public function setSmallSize(param1:Boolean) : void
        {
            if(this._isSmall != param1)
            {
                gotoAndStop(param1?SMALL_FRAME:FULL_FRAME);
                this._isSmall = param1;
                this.initBar();
                invalidateData();
                invalidate(QUEST_INVALIDATE);
            }
        }

        private function initBar() : void
        {
            this.rewards.visible = !this._isSmall;
            this.rewardSmall.visible = this._isSmall;
        }

        private function onLevelsIndexChangeHandler(param1:IndexEvent) : void
        {
            var _loc2_:* = 0;
            if(this.chainBar != null)
            {
                _loc2_ = this.chainBar.selectedIndex;
                if(this._selectedQuestId != _loc2_)
                {
                    this._dataQuest = QuestLevelProgressVO(param1.data);
                    this._selectedQuestId = _loc2_;
                    invalidate(QUEST_INVALIDATE);
                }
            }
        }
    }
}
