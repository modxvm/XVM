package net.wg.gui.lobby.rankedBattles19.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextFormat;
    import net.wg.data.constants.Fonts;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
    import net.wg.utils.ICommons;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFormatAlign;
    import flash.events.Event;

    public class RankedBattlesPageHeader extends UIComponentEx
    {

        private static const SEPARATOR_H_GAP:int = 15;

        private static const LEFT_SIDE_TF_WIDTH_FACTOR:int = 2;

        private static const DESCR_GAPS:Object = {};

        private static const SEPARATOR_V_GAPS:Object = {};

        private static const SEPARATOR_HEIGHTS:Object = {};

        private static const TITLE_FORMATS:Object = {};

        private static const DESCR_FORMATS:Object = {};

        {
            DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 91;
            DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_BIG] = 70;
            DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 70;
            DESCR_GAPS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 52;
            SEPARATOR_V_GAPS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 8;
            SEPARATOR_V_GAPS[RankedBattlesPageHeaderHelper.SIZE_BIG] = 8;
            SEPARATOR_V_GAPS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 5;
            SEPARATOR_V_GAPS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 5;
            SEPARATOR_HEIGHTS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = 20;
            SEPARATOR_HEIGHTS[RankedBattlesPageHeaderHelper.SIZE_BIG] = 20;
            SEPARATOR_HEIGHTS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = 18;
            SEPARATOR_HEIGHTS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = 18;
            TITLE_FORMATS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = new TextFormat(Fonts.TITLE_FONT,73,15921911);
            TITLE_FORMATS[RankedBattlesPageHeaderHelper.SIZE_BIG] = new TextFormat(Fonts.TITLE_FONT,56,15921911);
            TITLE_FORMATS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = new TextFormat(Fonts.TITLE_FONT,56,15921911);
            TITLE_FORMATS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = new TextFormat(Fonts.TITLE_FONT,45,15921911);
            DESCR_FORMATS[RankedBattlesPageHeaderHelper.SIZE_HUGE] = new TextFormat(Fonts.FIELD_FONT,24,15921911);
            DESCR_FORMATS[RankedBattlesPageHeaderHelper.SIZE_BIG] = new TextFormat(Fonts.FIELD_FONT,24,15921911);
            DESCR_FORMATS[RankedBattlesPageHeaderHelper.SIZE_MEDIUM] = new TextFormat(Fonts.FIELD_FONT,18,15921911);
            DESCR_FORMATS[RankedBattlesPageHeaderHelper.SIZE_SMALL] = new TextFormat(Fonts.FIELD_FONT,18,15921911);
        }

        public var titleTf:TextField = null;

        public var rightSideTf:TextField = null;

        public var leftSideTf:TextField = null;

        public var separator:Sprite = null;

        private var _data:RankedBattlesPageHeaderVO = null;

        private var _commons:ICommons = null;

        private var _size:String = "small";

        private var _tooltipMgr:ITooltipMgr;

        private var _headerHeight:int = -1;

        private var _subTitleMultiline:Boolean = false;

        public function RankedBattlesPageHeader()
        {
            super();
            this._commons = App.utils.commons;
            this._tooltipMgr = App.toolTipMgr;
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    this.titleTf.text = this._data.title;
                    this.leftSideTf.text = this._data.leftSideText;
                    this.rightSideTf.visible = this.separator.visible = !this._data.useOneSideDescription;
                    if(this.rightSideTf.visible)
                    {
                        this.rightSideTf.text = this._data.rightSideText;
                    }
                    invalidateSize();
                }
                if(isInvalid(InvalidationType.SIZE))
                {
                    this.updateLayout();
                }
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.titleTf = null;
            this.rightSideTf = null;
            this.leftSideTf = null;
            this.separator = null;
            this._commons = null;
            this._tooltipMgr = null;
            this._data = null;
            super.onDispose();
        }

        public function setData(param1:RankedBattlesPageHeaderVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function setSizeId(param1:String) : void
        {
            if(this._size != param1)
            {
                this._size = param1;
                invalidateSize();
            }
        }

        private function updateLayout() : void
        {
            var _loc1_:TextFormat = DESCR_FORMATS[this._size];
            this.titleTf.setTextFormat(TITLE_FORMATS[this._size]);
            this._commons.updateTextFieldSize(this.titleTf);
            this.titleTf.x = width - this.titleTf.width >> 1;
            _loc1_.align = this._data.useOneSideDescription?TextFormatAlign.CENTER:TextFormatAlign.LEFT;
            this.leftSideTf.setTextFormat(_loc1_);
            this.leftSideTf.width = LEFT_SIDE_TF_WIDTH_FACTOR * this.titleTf.width;
            this._commons.updateTextFieldSize(this.leftSideTf);
            var _loc2_:int = this.titleTf.y + DESCR_GAPS[this._size];
            this.leftSideTf.y = _loc2_;
            var _loc3_:int = this.leftSideTf.width + (SEPARATOR_H_GAP << 1);
            if(!this._data.useOneSideDescription)
            {
                this.rightSideTf.y = _loc2_;
                this.rightSideTf.setTextFormat(_loc1_);
                this._commons.updateTextFieldSize(this.rightSideTf);
                _loc3_ = _loc3_ + this.rightSideTf.width;
                this.rightSideTf.x = width - _loc3_ >> 1;
                this.separator.x = this.rightSideTf.x + this.rightSideTf.width + SEPARATOR_H_GAP | 0;
                this.separator.y = _loc2_ + SEPARATOR_V_GAPS[this._size];
                this.separator.height = SEPARATOR_HEIGHTS[this._size];
                this.leftSideTf.x = this.separator.x + SEPARATOR_H_GAP;
            }
            else
            {
                this.leftSideTf.x = width - this.leftSideTf.width >> 1;
            }
            this._headerHeight = this.leftSideTf.y + this.leftSideTf.height;
            dispatchEvent(new Event(Event.RESIZE));
        }

        override public function get height() : Number
        {
            return this._headerHeight;
        }

        public function set subTitleMultiline(param1:Boolean) : void
        {
            if(this._subTitleMultiline != param1)
            {
                this._subTitleMultiline = param1;
                this._subTitleMultiline = this.rightSideTf.multiline = this.leftSideTf.multiline = this.rightSideTf.wordWrap = this.leftSideTf.wordWrap = param1;
                invalidateSize();
            }
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            if(this._data && this._data.tooltip)
            {
                this._tooltipMgr.showSpecial(this._data.tooltip,null,null);
            }
        }
    }
}
