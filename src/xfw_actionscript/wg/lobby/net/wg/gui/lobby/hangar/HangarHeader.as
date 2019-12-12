package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.HangarHeaderMeta;
    import net.wg.infrastructure.base.meta.IHangarHeaderMeta;
    import net.wg.utils.helpLayout.IHelpLayoutComponent;
    import net.wg.gui.lobby.hangar.interfaces.IHangarHeader;
    import net.wg.gui.components.tooltips.helpers.TankTypeIco;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.hangar.quests.HeaderQuestsFlags;
    import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.gui.lobby.hangar.quests.HeaderQuestsEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import flash.geom.Rectangle;
    import net.wg.data.constants.Directions;
    import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;

    public class HangarHeader extends HangarHeaderMeta implements IHangarHeaderMeta, IHelpLayoutComponent, IHangarHeader
    {

        private static const SEPARATOR:String = "_";

        private static const HELP_OFFSET_WIDTH:int = 56;

        private static const HELP_OFFSET_HEIGHT:int = -3;

        private static const HELP_OFFSET_WIDTH_GAP:int = 199;

        private static const QUESTS_FLAGS_DEFAULT_X_OFFSET:int = -79;

        private static const QUESTS_FLAGS_NY_X_OFFSET_SMALL:int = -160;

        private static const QUESTS_FLAGS_NY_X_OFFSET_BIG:int = -200;

        private static const INVALIDATE_OBJECTS_OFFSET:String = "invalidateObjectOffset";

        private static const WINDOW_SIZE_SMALL:String = "small";

        private static const WINDOW_SIZE_BIG:String = "big";

        private static const POSITION_NY_BONUS_CREDIT_WIDGET:Object = {
            "small":{
                "x":-40,
                "y":30
            },
            "big":{
                "x":0,
                "y":50
            }
        };

        private static const POSITION_NY_BONUS_CREDIT_POST_NY:Object = {
            "small":{
                "x":-30,
                "y":18
            },
            "big":{
                "x":-20,
                "y":18
            }
        };

        public var tankTypeIcon:TankTypeIco;

        public var txtTankInfo:TextField;

        public var mcBackground:Sprite;

        public var premIGRBg:Sprite = null;

        public var questsFlags:HeaderQuestsFlags;

        public var nyCreditBonus:NYCreditBonus = null;

        private var _data:HangarHeaderVO;

        private var _isSmallScreen:Boolean = false;

        public function HangarHeader()
        {
            super();
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this._isSmallScreen = App.appWidth <= StageSizeBoundaries.WIDTH_1366 || App.appHeight <= StageSizeBoundaries.HEIGHT_768;
            invalidate(INVALIDATE_OBJECTS_OFFSET);
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.tankTypeIcon.mouseEnabled = this.tankTypeIcon.mouseChildren = false;
            this.mcBackground.mouseEnabled = this.mcBackground.mouseChildren = false;
            this.txtTankInfo.mouseEnabled = false;
            this.premIGRBg.mouseEnabled = this.premIGRBg.mouseChildren = false;
            this.questsFlags.addEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
            App.utils.helpLayout.registerComponent(this);
        }

        override protected function onBeforeDispose() : void
        {
            this.questsFlags.removeEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.questsFlags.dispose();
            this.questsFlags = null;
            this.tankTypeIcon.dispose();
            this.tankTypeIcon = null;
            this.premIGRBg = null;
            this.mcBackground = null;
            this.txtTankInfo = null;
            this._data = null;
            this.nyCreditBonus.dispose();
            this.nyCreditBonus = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = false;
            var _loc3_:* = NaN;
            var _loc4_:String = null;
            var _loc5_:* = NaN;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                _loc1_ = this._data?this._data.isNYWidgetVisible:false;
                _loc2_ = this._data?this._data.isPostNYEnabled:false;
                visible = this._data.isVisible;
                if(this._data.isVisible)
                {
                    this.tankTypeIcon.visible = this.txtTankInfo.visible = !_loc1_;
                    this.premIGRBg.visible = this._data.isPremIGR && !_loc1_;
                    if(!_loc1_)
                    {
                        this.tankTypeIcon.type = this._data.tankType;
                        this.txtTankInfo.htmlText = this._data.tankInfo;
                        App.utils.commons.updateTextFieldSize(this.txtTankInfo,true,false);
                    }
                    this.questsFlags.setData(this._data.questsGroups);
                    this.nyCreditBonus.bonusAmount = this._data.nyCreditBonus;
                    this.nyCreditBonus.visible = _loc1_ || _loc2_;
                }
            }
            if(isInvalid(INVALIDATE_OBJECTS_OFFSET))
            {
                _loc1_ = this._data?this._data.isNYWidgetVisible:false;
                _loc2_ = this._data?this._data.isPostNYEnabled:false;
                _loc3_ = this._isSmallScreen?QUESTS_FLAGS_NY_X_OFFSET_SMALL:QUESTS_FLAGS_NY_X_OFFSET_BIG;
                this.questsFlags.x = _loc1_?_loc3_:QUESTS_FLAGS_DEFAULT_X_OFFSET;
                if(_loc1_ || _loc2_)
                {
                    _loc4_ = this._isSmallScreen?WINDOW_SIZE_SMALL:WINDOW_SIZE_BIG;
                    _loc5_ = _loc1_?POSITION_NY_BONUS_CREDIT_WIDGET[_loc4_].x:POSITION_NY_BONUS_CREDIT_POST_NY[_loc4_].x;
                    this.nyCreditBonus.x = _loc1_?this.questsFlags.x + this.questsFlags.width - _loc3_ + _loc5_:this.txtTankInfo.x + this.txtTankInfo.width + _loc5_;
                    this.nyCreditBonus.y = _loc1_?POSITION_NY_BONUS_CREDIT_WIDGET[_loc4_].y:POSITION_NY_BONUS_CREDIT_POST_NY[_loc4_].y;
                    this.nyCreditBonus.updateSize(this._isSmallScreen);
                }
            }
        }

        override protected function setData(param1:HangarHeaderVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            this._data = param1;
            invalidateData();
            invalidate(INVALIDATE_OBJECTS_OFFSET);
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            var _loc1_:HelpLayoutVO = new HelpLayoutVO();
            var _loc2_:Rectangle = this.questsFlags.getHitRect();
            _loc1_.x = this.questsFlags.x + _loc2_.x;
            _loc1_.y = this.questsFlags.y;
            _loc1_.width = _loc2_.width;
            _loc1_.height = _loc2_.height + HELP_OFFSET_HEIGHT;
            _loc1_.message = LOBBY_HELP.HANGAR_HEADER_QUESTS;
            _loc1_.extensibilityDirection = Directions.RIGHT;
            _loc1_.id = name + SEPARATOR + Math.random();
            _loc1_.scope = this;
            var _loc3_:HelpLayoutVO = new HelpLayoutVO();
            _loc3_.x = _loc1_.x + _loc1_.width;
            _loc3_.y = this.questsFlags.y;
            _loc3_.width = this.txtTankInfo.x + this.txtTankInfo.textWidth - _loc3_.x + HELP_OFFSET_WIDTH;
            _loc3_.height = _loc1_.height;
            _loc3_.message = LOBBY_HELP.HANGAR_HEADER_VEHICLE;
            _loc3_.extensibilityDirection = Directions.RIGHT;
            _loc3_.id = name + SEPARATOR + Math.random();
            _loc3_.scope = this;
            if(_loc3_.width > HELP_OFFSET_WIDTH_GAP)
            {
                _loc3_.width = HELP_OFFSET_WIDTH_GAP;
            }
            return new <HelpLayoutVO>[_loc1_,_loc3_];
        }

        public function getQuestGroupByType(param1:String) : IHeaderQuestsContainer
        {
            return this.questsFlags.getQuestGroupByID(param1);
        }

        private function onBtnHeaderQuestClickHandler(param1:HeaderQuestsEvent) : void
        {
            onQuestBtnClickS(param1.questType,param1.questID);
        }
    }
}
