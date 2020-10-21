package net.wg.gui.lobby.eventHangar.components
{
    import net.wg.infrastructure.base.meta.impl.HE20EntryPointMeta;
    import net.wg.gui.lobby.hangar.eventEntryPoint.IEventEntryPoint;
    import net.wg.utils.helpLayout.IHelpLayoutComponent;
    import net.wg.infrastructure.base.meta.IHE20EntryPointMeta;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventHangar.data.EventProgressBannerVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.ICommons;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import scaleform.gfx.TextFieldEx;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import flash.geom.Rectangle;
    import net.wg.gui.lobby.hangar.eventEntryPoint.EntryPointSize;
    import scaleform.gfx.MouseEventEx;

    public class EventProgressBanner extends HE20EntryPointMeta implements IEventEntryPoint, IHelpLayoutComponent, IHE20EntryPointMeta
    {

        private static const HIDE_POS_Y:int = -2500;

        private static const BOTTOM_PADDING:int = 5;

        private static const OFFSET_HEADER:int = 6;

        private static const BANNER_STATE_SMALL:String = "small";

        private static const BANNER_STATE_BIG:String = "big";

        private static const BANNER_STATE_WIDE:String = "wide_";

        public var txtHeader:TextField = null;

        public var txtInfo:TextField = null;

        public var txtBanInfo:TextField = null;

        public var txtTanks:TextField = null;

        public var hover:EventProgressBannerHover = null;

        public var tankIcon:Sprite = null;

        public var background:Sprite = null;

        private var _helpDirection:String = "L";

        private var _data:EventProgressBannerVO = null;

        private var _helpLayoutId:String = "";

        private var _isBigState:Boolean = true;

        private var _isWideState:Boolean = true;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _commons:ICommons = null;

        private var _size:int;

        public function EventProgressBanner()
        {
            this._size = EntryPointSize.BIG | EntryPointSize.WIDE_MASK;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.hover.addEventListener(MouseEvent.ROLL_OVER,this.onOverHandler);
            this.hover.addEventListener(MouseEvent.ROLL_OUT,this.onOutHandler);
            App.utils.helpLayout.registerComponent(this);
            this.txtTanks.autoSize = TextFieldAutoSize.RIGHT;
            this._toolTipMgr = App.toolTipMgr;
            this._commons = App.utils.commons;
            buttonMode = useHandCursor = true;
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.hover.removeEventListener(MouseEvent.ROLL_OVER,this.onOverHandler);
            this.hover.removeEventListener(MouseEvent.ROLL_OUT,this.onOutHandler);
            this.txtInfo = null;
            this.txtBanInfo = null;
            this.txtTanks = null;
            this.txtHeader = null;
            this.tankIcon = null;
            this.hover.dispose();
            this.hover = null;
            this.background = null;
            this._toolTipMgr = null;
            this._commons = null;
            this._data = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            var _loc2_:* = false;
            var _loc3_:TextField = null;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                _loc1_ = this._isWideState?BANNER_STATE_WIDE:Values.EMPTY_STR;
                _loc1_ = _loc1_.concat(this._isBigState?BANNER_STATE_BIG:BANNER_STATE_SMALL);
                this.hover.setHoverState(this._size);
                gotoAndStop(_loc1_);
                if(_baseDisposed)
                {
                    return;
                }
                this.txtInfo.text = this._data.info;
                TextFieldEx.setNoTranslate(this.txtBanInfo,false);
                this.txtBanInfo.htmlText = this._data.banMessage;
                this.txtTanks.text = this._data.status;
                this.txtHeader.text = EVENT.HANGAR_BANNER_HEADER_LABEL;
                this.tankIcon.mouseEnabled = this.txtHeader.mouseEnabled = this.txtTanks.mouseEnabled = this.txtInfo.mouseEnabled = false;
                this.txtBanInfo.mouseEnabled = false;
                this._commons.updateTextFieldSize(this.txtInfo,false,true);
                this._commons.updateTextFieldSize(this.txtBanInfo,false,true);
                _width = this.getWidth();
                _height = this.getHeight();
                _loc2_ = StringUtils.isNotEmpty(this._data.banMessage);
                this.txtInfo.y = _height - BOTTOM_PADDING - this.txtInfo.height >> 0;
                this.txtInfo.visible = !_loc2_;
                this.txtBanInfo.y = _height - BOTTOM_PADDING - this.txtBanInfo.height >> 0;
                this.txtBanInfo.visible = _loc2_;
                _loc3_ = _loc2_?this.txtBanInfo:this.txtInfo;
                this.txtHeader.y = _loc3_.y - this.txtHeader.height + OFFSET_HEADER >> 0;
            }
        }

        override protected function setData(param1:EventProgressBannerVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function getHeight() : int
        {
            return this.background.height;
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            if(!this._helpLayoutId)
            {
                this._helpLayoutId = name + "_" + Math.random();
            }
            var _loc1_:HelpLayoutVO = new HelpLayoutVO();
            _loc1_.x = -1;
            _loc1_.y = visible?0:HIDE_POS_Y;
            _loc1_.width = this.getWidth();
            _loc1_.height = this.getHeight();
            _loc1_.extensibilityDirection = this._helpDirection;
            _loc1_.message = LOBBY_HELP.HANGAR_EVENT;
            _loc1_.id = this._helpLayoutId;
            _loc1_.scope = this;
            return new <HelpLayoutVO>[_loc1_];
        }

        public function getWidth() : int
        {
            return this.background.width;
        }

        public function get margin() : Rectangle
        {
            return new Rectangle(0,0,0,0);
        }

        public function get size() : int
        {
            return this._size;
        }

        public function set size(param1:int) : void
        {
            if(param1 == this._size)
            {
                return;
            }
            this._size = param1;
            this._isBigState = EntryPointSize.isBig(this._size);
            this._isWideState = EntryPointSize.isWide(this._size);
            invalidateData();
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                onClickS();
            }
        }

        private function onOverHandler(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._data.tooltip))
            {
                this._toolTipMgr.showComplex(this._data.tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
            }
        }

        private function onOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
