package net.wg.gui.lobby.store.actions.cards
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.store.actions.interfaces.IStoreActionCard;
    import net.wg.gui.components.controls.IconText;
    import net.wg.infrastructure.interfaces.IImage;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.lobby.store.actions.data.CardSettings;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;
    import flash.display.DisplayObject;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import net.wg.data.constants.IconsTypes;

    public class StoreActionCardAbstract extends UIComponentEx implements IStoreActionCard
    {

        protected static const VIEW_SIZE_SHORT_ID:String = "viewSizeShort";

        protected static const VIEW_SIZE_WIDE_ID:String = "viewSizeWide";

        private static const VIEW_SIZE_CHANGE_BRAKE_POINT:Number = 1200;

        private static const IS_ACTION_TIME_INVALID:String = "isActionTimeInvalid";

        private static const IS_SELECT_INVALID:String = "isSelectInvalid";

        private static const TIME_LEFT_ICO_X_CORRECT:Number = -16;

        private static const TIME_LEFT_ICO_Y_CORRECT:Number = -2;

        public var title:StoreActionCardTitle = null;

        public var timeLeft:IconText = null;

        public var header:StoreActionCardHeader = null;

        public var image:IImage = null;

        public var picture:UILoaderAlt = null;

        public var hitAreaMc:Sprite = null;

        protected var cardSettingsVo:CardSettings = null;

        protected var viewSizeBreakPointId:String = "";

        private var _cardId:String = "";

        private var _triggerChainID:String = "";

        private var _linkage:String = "";

        private var _data:StoreActionCardVo = null;

        private var _cardTime:StoreActionTimeVo = null;

        private var _shiftFromCenterByX:Number = 0;

        private var _selectFrameNeedUpdate:Boolean = false;

        private var _actualPicture:DisplayObject = null;

        private var _isDataSetCompleted:Boolean = false;

        private var _stageW:Number = 0;

        public function StoreActionCardAbstract()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._actualPicture = this.picture;
            this.picture.visible = false;
            this.image.visible = false;
            this.timeLeft.useHtmlText = true;
            this.title.mouseEnabled = false;
            this.title.mouseChildren = false;
            this.timeLeft.mouseEnabled = false;
            this.timeLeft.mouseChildren = false;
            this.header.mouseEnabled = false;
            this.header.mouseChildren = false;
            this.image.mouseEnabled = false;
            this.image.mouseChildren = false;
            this.picture.mouseEnabled = false;
            this.picture.mouseChildren = false;
            this.hitArea = this.hitAreaMc;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA) && this._data)
            {
                this.updateData(this._data);
                invalidateSize();
            }
            if(isInvalid(IS_ACTION_TIME_INVALID) && this._cardTime)
            {
                this.setTime(this._cardTime);
            }
            if(isInvalid(InvalidationType.SIZE) && this._data)
            {
                this.updateSize();
            }
            if(isInvalid(IS_SELECT_INVALID) && this._selectFrameNeedUpdate)
            {
                this._selectFrameNeedUpdate = false;
                this.showSelect();
            }
        }

        override protected function onDispose() : void
        {
            this._data = null;
            this._cardTime = null;
            this.cardSettingsVo = null;
            this.title.dispose();
            this.title = null;
            this.timeLeft.dispose();
            this.timeLeft = null;
            this.header.dispose();
            this.header = null;
            if(this._actualPicture)
            {
                this._actualPicture = null;
            }
            this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.image.dispose();
            this.image = null;
            this.picture.dispose();
            this.picture = null;
            this.hitAreaMc = null;
            super.onDispose();
        }

        public function getPermanentBottomMargin() : Number
        {
            return this.cardSettingsVo.cardBottomMargin;
        }

        public function getPermanentHeight() : Number
        {
            return this.cardSettingsVo.permanentHeight;
        }

        public function getPermanentLeftMargin() : Number
        {
            return this.cardSettingsVo.cardLeftMargin;
        }

        public function getPermanentWidth() : Number
        {
            return this.cardSettingsVo.permanentWidth;
        }

        public function setData(param1:StoreActionCardVo) : void
        {
            this._data = param1;
            this._cardId = param1.id;
            this._linkage = param1.linkage;
            this._triggerChainID = param1.triggerChainID;
            invalidateData();
        }

        public function setSelect() : void
        {
            this._selectFrameNeedUpdate = true;
            invalidate(IS_SELECT_INVALID);
        }

        public function updateSize() : void
        {
            if(!this._isDataSetCompleted || this._stageW == 0)
            {
                return;
            }
            if(this._stageW >= VIEW_SIZE_CHANGE_BRAKE_POINT && this.viewSizeBreakPointId != VIEW_SIZE_WIDE_ID)
            {
                this.viewSizeBreakPointId = VIEW_SIZE_WIDE_ID;
                this.updateCardSize(this.viewSizeBreakPointId);
            }
            else if(this._stageW < VIEW_SIZE_CHANGE_BRAKE_POINT && this.viewSizeBreakPointId != VIEW_SIZE_SHORT_ID)
            {
                this.viewSizeBreakPointId = VIEW_SIZE_SHORT_ID;
                this.updateCardSize(this.viewSizeBreakPointId);
            }
        }

        public function updateStageSize(param1:Number, param2:Number) : void
        {
            if(this._stageW == param1)
            {
                return;
            }
            this._stageW = param1;
            invalidateSize();
        }

        public function updateTime(param1:StoreActionTimeVo) : void
        {
            this._cardTime = param1;
            invalidate(IS_ACTION_TIME_INVALID);
        }

        protected function showSelect() : void
        {
        }

        protected function updateCardSize(param1:String) : void
        {
        }

        protected function updateData(param1:StoreActionCardVo) : void
        {
            if(param1.picture.isWeb)
            {
                this.picture.visible = false;
                this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
                this.image.visible = true;
                this.image.source = param1.picture.src;
                this._actualPicture = DisplayObject(this.image);
            }
            else
            {
                this.image.visible = false;
                this.picture.visible = true;
                this.picture.source = param1.picture.src;
                this._actualPicture = this.picture;
            }
            this.setTime(param1.time);
            this._isDataSetCompleted = true;
        }

        protected function setTime(param1:StoreActionTimeVo) : void
        {
            this.timeLeft.text = param1.timeLeft;
            this.timeLeft.textFieldYOffset = TIME_LEFT_ICO_Y_CORRECT;
            if(param1.isShowTimeIco)
            {
                this.timeLeft.icon = IconsTypes.RENTALS;
                this.timeLeft.xCorrect = TIME_LEFT_ICO_X_CORRECT;
            }
            else
            {
                this.timeLeft.icon = IconsTypes.EMPTY;
                this.timeLeft.xCorrect = 0;
            }
            this.timeLeft.validateNow();
        }

        private function updateImageScale() : void
        {
            this.image.scaleX = this.image.scaleY = this.cardSettingsVo.pictureScale;
        }

        public function get shiftFromCenterByX() : Number
        {
            return this._shiftFromCenterByX;
        }

        public function set shiftFromCenterByX(param1:Number) : void
        {
            this._shiftFromCenterByX = param1;
        }

        public function get cardId() : String
        {
            return this._cardId;
        }

        public function get linkage() : String
        {
            return this._linkage;
        }

        public function set settings(param1:CardSettings) : void
        {
            this.cardSettingsVo = param1;
        }

        public function get triggerChainID() : String
        {
            return this._triggerChainID;
        }

        public function get actualPicture() : DisplayObject
        {
            return this._actualPicture;
        }

        private function onImageChangeHandler(param1:Event) : void
        {
            this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.updateImageScale();
        }
    }
}
