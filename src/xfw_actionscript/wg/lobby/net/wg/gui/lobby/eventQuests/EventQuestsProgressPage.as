package net.wg.gui.lobby.eventQuests
{
    import net.wg.infrastructure.base.meta.impl.EventQuestsProgressMeta;
    import net.wg.infrastructure.base.meta.IEventQuestsProgressMeta;
    import net.wg.gui.lobby.eventQuests.controls.QuestLevelsPanel;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventQuests.data.QuestsProgressVO;
    import scaleform.clik.constants.InvalidationType;

    public class EventQuestsProgressPage extends EventQuestsProgressMeta implements IEventQuestsProgressMeta
    {

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const CHAIN_SPACING:int = 25;

        private static const SMALL_HEIGHT:int = 900;

        private static const SMALL_WIDTH:int = 1500;

        public var dailyQuests:QuestLevelsPanel = null;

        public var questChain1:QuestLevelsPanel = null;

        public var questChain2:QuestLevelsPanel = null;

        public var messengerBg:Sprite = null;

        public var background:Sprite = null;

        private var _data:QuestsProgressVO = null;

        private var _quests:Vector.<QuestLevelsPanel>;

        public function EventQuestsProgressPage()
        {
            this._quests = new Vector.<QuestLevelsPanel>(0);
            super();
            this._quests.push(this.dailyQuests,this.questChain1,this.questChain2);
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc4_:QuestLevelsPanel = null;
            super.updateStage(param1,param2);
            setSize(param1,param2 + this.messengerBg.height);
            var _loc3_:Boolean = param1 < SMALL_WIDTH || param2 < SMALL_HEIGHT;
            for each(_loc4_ in this._quests)
            {
                _loc4_.setSmallSize(_loc3_);
            }
        }

        override protected function onEscapeKeyDown() : void
        {
            closeViewS();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.messengerBg.y = _height - this.messengerBg.height;
                this.messengerBg.width = _width;
                this.background.width = _width;
                this.background.height = _height;
                _loc1_ = this.dailyQuests.getBGWidth();
                _loc2_ = (CHAIN_SPACING + _loc1_) * this._quests.length;
                this.dailyQuests.x = _width - _loc2_ >> 1;
                this.questChain1.x = this.dailyQuests.x + _loc1_ + CHAIN_SPACING;
                this.questChain2.x = this.questChain1.x + _loc1_ + CHAIN_SPACING;
                this.dailyQuests.y = this.questChain1.y = this.questChain2.y = _height - this.dailyQuests.getBGHeight() >> 1;
            }
        }

        override protected function layoutElements() : void
        {
            if(closeBtn != null)
            {
                closeBtn.validateNow();
                closeBtn.x = width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
        }

        override protected function setData(param1:QuestsProgressVO) : void
        {
            this._data = param1;
            var _loc2_:Array = param1.levels;
            var _loc3_:uint = _loc2_.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._quests[_loc4_].setData(_loc2_[_loc4_]);
                _loc4_++;
            }
            invalidateData();
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        override protected function onDispose() : void
        {
            this._data = null;
            this._quests.splice(0,this._quests.length);
            this._quests = null;
            this.messengerBg = null;
            this.questChain1.dispose();
            this.questChain1 = null;
            this.questChain2.dispose();
            this.questChain2 = null;
            this.dailyQuests.dispose();
            this.dailyQuests = null;
            closeBtn.dispose();
            closeBtn = null;
            this.background = null;
            super.onDispose();
        }
    }
}
