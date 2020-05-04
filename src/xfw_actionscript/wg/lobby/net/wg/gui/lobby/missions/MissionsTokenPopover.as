package net.wg.gui.lobby.missions
{
    import net.wg.infrastructure.base.meta.impl.MissionsTokenPopoverMeta;
    import net.wg.infrastructure.base.meta.IMissionsTokenPopoverMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.Sprite;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.missions.event.MissionsTokenListRendererEvent;
    import net.wg.gui.lobby.missions.data.MissionsTokenPopoverVO;
    import scaleform.gfx.TextFieldEx;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popovers.PopOver;

    public class MissionsTokenPopover extends MissionsTokenPopoverMeta implements IMissionsTokenPopoverMeta
    {

        private static const POPOVER_WIDTH:int = 339;

        private static const LIST_MAX_RENDERERS:int = 4;

        private static const BUY_BTN_OFFSET:int = 15;

        private static const BUY_BTN_ONLY_SHOP_OFFSET:int = 1;

        private static const BUY_BTN_X:int = 90;

        private static const HEIGHT_BUY_AVAILABLE_OFFSET:int = 39;

        private static const HEIGHT_BUY_UNAVAILABLE_OFFSET:int = 12;

        public var headerTF:TextField = null;

        public var descrTF:TextField = null;

        public var image:Image = null;

        public var list:ScrollingListEx = null;

        public var buyBtn:ISoundButtonEx = null;

        public var separatorTop:Sprite = null;

        public var separatorBottom:Sprite = null;

        private var _separatorHitArea:Sprite;

        private var _originalListHeight:int = -1;

        private var _rendererHeight:int = -1;

        private var _descrLeft:int = -1;

        private var _descrWidth:int = -1;

        public function MissionsTokenPopover()
        {
            this._separatorHitArea = new Sprite();
            super();
            addChild(this._separatorHitArea);
            this.separatorTop.hitArea = this._separatorHitArea;
            this.separatorBottom.hitArea = this._separatorHitArea;
            this._descrLeft = this.descrTF.x;
            this._descrWidth = this.descrTF.width;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.buyBtn.tooltip = TOOLTIPS.MISSIONS_TOKENPOPOVER_BUYBTN;
            this._originalListHeight = this.list.height;
            this._rendererHeight = this._originalListHeight / LIST_MAX_RENDERERS;
            this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.list.addEventListener(MissionsTokenListRendererEvent.QUEST_RENDERER_CLICK,this.onQuestRendererClickHandler);
        }

        override protected function setStaticData(param1:MissionsTokenPopoverVO) : void
        {
            this.headerTF.htmlText = param1.headerText;
            this.descrTF.htmlText = param1.descrText;
            this.descrTF.x = this._descrLeft + param1.descrLeftPadding;
            this.descrTF.width = this._descrWidth - param1.descrLeftPadding;
            TextFieldEx.setVerticalAlign(this.descrTF,TextFieldEx.VALIGN_CENTER);
            this.image.source = param1.imageSrc;
            this.buyBtn.label = param1.buyBtnLabel;
            this.buyBtn.visible = param1.buyBtnVisible;
            invalidateSize();
        }

        override protected function setListDataProvider(param1:DataProvider) : void
        {
            if(this.list.dataProvider != null)
            {
                this.list.dataProvider.cleanUp();
            }
            this.list.dataProvider = param1;
            invalidateSize();
        }

        override protected function onDispose() : void
        {
            this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.list.removeEventListener(MissionsTokenListRendererEvent.QUEST_RENDERER_CLICK,this.onQuestRendererClickHandler);
            removeChild(this._separatorHitArea);
            this.headerTF = null;
            this.descrTF = null;
            this.image.dispose();
            this.image = null;
            this.list.dispose();
            this.list = null;
            this.buyBtn.dispose();
            this.buyBtn = null;
            this.separatorTop = null;
            this.separatorBottom = null;
            this._separatorHitArea = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = this.list.dataProvider.length;
                this.list.height = _loc1_ < LIST_MAX_RENDERERS?this._rendererHeight * _loc1_:this._originalListHeight;
                if(_loc1_ > 0)
                {
                    this.separatorTop.visible = this.separatorBottom.visible = true;
                    this.separatorBottom.y = this.list.y + this.list.height;
                    this.buyBtn.x = BUY_BTN_X;
                    this.buyBtn.y = this.separatorBottom.y + BUY_BTN_OFFSET;
                    _loc2_ = this.buyBtn.visible?this.buyBtn.y + HEIGHT_BUY_AVAILABLE_OFFSET:this.separatorBottom.y + HEIGHT_BUY_UNAVAILABLE_OFFSET;
                }
                else
                {
                    this.separatorTop.visible = this.separatorBottom.visible = false;
                    this.buyBtn.x = this.descrTF.x;
                    this.buyBtn.y = this.descrTF.y + this.descrTF.height + BUY_BTN_ONLY_SHOP_OFFSET;
                    _loc2_ = this.buyBtn.visible?this.buyBtn.y + HEIGHT_BUY_AVAILABLE_OFFSET:this.descrTF.y + this.descrTF.height + HEIGHT_BUY_UNAVAILABLE_OFFSET;
                }
                setViewSize(POPOVER_WIDTH,_loc2_);
            }
        }

        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            PopOver(param1).isCloseBtnVisible = true;
        }

        private function onQuestRendererClickHandler(param1:MissionsTokenListRendererEvent) : void
        {
            onQuestClickS(param1.idx);
        }

        private function onBuyBtnClickHandler(param1:ButtonEvent) : void
        {
            onBuyBtnClickS();
        }
    }
}
