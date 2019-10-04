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

        private static const DESCR_V_OFFSET_TITLE_BIG:int = 137;

        private static const DESCR_V_OFFSET_TITLE_SMALL:int = 76;

        private static const SEPARATOR_V_OFFSET_BIG:int = 8;

        private static const SEPARATOR_V_OFFSET_SMALL:int = 5;

        private static const SEPARATOR_HEIGTH_BIG:int = 20;

        private static const SEPARATOR_HEIGTH_SMALL:int = 18;

        private static const SEPARATOR_GAP:int = 15;

        private static const TITLE_BIG_FORMAT:TextFormat = new TextFormat(Fonts.TITLE_FONT,130,16777215);

        private static const TITLE_SMALL_FORMAT:TextFormat = new TextFormat(Fonts.TITLE_FONT,70,16777215);

        private static const DESCR_BIG_FORMAT:TextFormat = new TextFormat(Fonts.FIELD_FONT,24,16777215);

        private static const DESCR_SMALL_FORMAT:TextFormat = new TextFormat(Fonts.FIELD_FONT,18,16777215);

        private static const TF_ALPHA:Number = 0.6;

        private static const TITLE_TF_ALPHA:Number = 0.3;

        private static const LEFT_SIDE_TF_WIDTH_FACTOR:Number = 0.75;

        public var titleTf:TextField = null;

        public var rightSideTf:TextField = null;

        public var leftSideTf:TextField = null;

        public var separator:Sprite = null;

        private var _data:RankedBattlesPageHeaderVO = null;

        private var _commons:ICommons = null;

        private var _isSmall:Boolean = false;

        private var _tooltipMgr:ITooltipMgr;

        private var _titleFormat:TextFormat;

        private var _descriptionFormat:TextFormat;

        private var _headerHeight:int = -1;

        private var _subTitleMultiline:Boolean = false;

        public function RankedBattlesPageHeader()
        {
            this._titleFormat = TITLE_BIG_FORMAT;
            this._descriptionFormat = DESCR_BIG_FORMAT;
            super();
            this._commons = App.utils.commons;
            this._tooltipMgr = App.toolTipMgr;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.rightSideTf.alpha = TF_ALPHA;
            this.leftSideTf.alpha = TF_ALPHA;
            this.titleTf.alpha = TITLE_TF_ALPHA;
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
            this._titleFormat = null;
            this._descriptionFormat = null;
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

        public function setScreenSize(param1:Boolean) : void
        {
            if(this._isSmall == param1)
            {
                return;
            }
            this._isSmall = param1;
            this._titleFormat = this._isSmall?TITLE_SMALL_FORMAT:TITLE_BIG_FORMAT;
            this._descriptionFormat = this._isSmall?DESCR_SMALL_FORMAT:DESCR_BIG_FORMAT;
            invalidateSize();
        }

        private function updateLayout() : void
        {
            this.titleTf.setTextFormat(this._titleFormat);
            this._commons.updateTextFieldSize(this.titleTf);
            this.titleTf.x = width - this.titleTf.width >> 1;
            this._descriptionFormat.align = this._data.useOneSideDescription?TextFormatAlign.CENTER:TextFormatAlign.LEFT;
            this.leftSideTf.setTextFormat(this._descriptionFormat);
            this.leftSideTf.width = LEFT_SIDE_TF_WIDTH_FACTOR * this.titleTf.width;
            this._commons.updateTextFieldSize(this.leftSideTf);
            var _loc1_:int = this.titleTf.y + (this._isSmall?DESCR_V_OFFSET_TITLE_SMALL:DESCR_V_OFFSET_TITLE_BIG);
            this.leftSideTf.y = _loc1_;
            var _loc2_:int = this.leftSideTf.width + (SEPARATOR_GAP << 1);
            if(!this._data.useOneSideDescription)
            {
                this.rightSideTf.y = _loc1_;
                this.rightSideTf.setTextFormat(this._descriptionFormat);
                this._commons.updateTextFieldSize(this.rightSideTf);
                _loc2_ = _loc2_ + this.rightSideTf.width;
                this.rightSideTf.x = width - _loc2_ >> 1;
                this.separator.x = this.rightSideTf.x + this.rightSideTf.width + SEPARATOR_GAP | 0;
                this.separator.y = _loc1_ + (this._isSmall?SEPARATOR_V_OFFSET_SMALL:SEPARATOR_V_OFFSET_BIG);
                this.separator.height = this._isSmall?SEPARATOR_HEIGTH_SMALL:SEPARATOR_HEIGTH_BIG;
                this.leftSideTf.x = this.separator.x + SEPARATOR_GAP;
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
