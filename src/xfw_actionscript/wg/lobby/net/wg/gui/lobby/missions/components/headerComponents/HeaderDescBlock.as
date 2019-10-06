package net.wg.gui.lobby.missions.components.headerComponents
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import flash.text.TextField;
    import net.wg.gui.lobby.missions.data.HeaderDescBlockVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.gfx.TextFieldEx;
    import flash.events.MouseEvent;
    import org.idmedia.as3commons.util.StringUtils;

    public class HeaderDescBlock extends UIComponentEx implements IUpdatable
    {

        private static const PERFORMED_TASKS_RIGHT_PADDING:int = 26;

        private static const DESC_TEXT_OFFSET_Y:int = 30;

        private static const DOTS:String = "...";

        private static const MAX_LINE_NUMBER:uint = 5;

        public var calendar:MissionHeaderCalendar = null;

        public var descText:TextField = null;

        private var _data:HeaderDescBlockVO = null;

        private var _tooltipMgr:ITooltipMgr = null;

        private var _isDescrTextTruncated:Boolean = false;

        public function HeaderDescBlock()
        {
            super();
            this._tooltipMgr = App.toolTipMgr;
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.removeDescTextListeners();
                if(this._data.isMultiline)
                {
                    TextFieldEx.setVerticalAlign(this.descText,TextFieldEx.VAUTOSIZE_CENTER);
                    this._isDescrTextTruncated = App.utils.commons.truncateHtmlTextMultiline(this.descText,this._data.descr,MAX_LINE_NUMBER,DOTS);
                    if(this._isDescrTextTruncated)
                    {
                        this.descText.addEventListener(MouseEvent.ROLL_OVER,this.onDescTextRollOverHandler);
                        this.descText.addEventListener(MouseEvent.ROLL_OUT,this.onDescTextRollOutHandler);
                    }
                }
                else
                {
                    this.descText.htmlText = this._data.descr;
                }
                _loc1_ = StringUtils.isNotEmpty(this._data.period);
                this.calendar.visible = _loc1_;
                if(_loc1_)
                {
                    this.calendar.setText(this._data.period);
                    this.calendar.isIconVisible = this._data.hasCalendarIcon;
                    if(this.calendar.isCalendarTextTruncated)
                    {
                        this.descText.y = this.calendar.height + DESC_TEXT_OFFSET_Y;
                    }
                }
                invalidateSize();
            }
            if(this._data != null && isInvalid(InvalidationType.SIZE))
            {
                if(!this._data.isMultiline)
                {
                    this.descText.x = width - this.descText.width - PERFORMED_TASKS_RIGHT_PADDING | 0;
                }
                this.calendar.x = width - this.calendar.width >> 1;
            }
        }

        override protected function onDispose() : void
        {
            this.calendar.dispose();
            this.calendar = null;
            this.removeDescTextListeners();
            this.descText = null;
            this._data = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        public function update(param1:Object) : void
        {
            this._data = HeaderDescBlockVO(param1);
            invalidateData();
        }

        private function removeDescTextListeners() : void
        {
            if(this._isDescrTextTruncated)
            {
                this.descText.removeEventListener(MouseEvent.ROLL_OVER,this.onDescTextRollOverHandler);
                this.descText.removeEventListener(MouseEvent.ROLL_OUT,this.onDescTextRollOutHandler);
            }
        }

        private function onDescTextRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data != null)
            {
                this._tooltipMgr.show(this._data.descr);
            }
        }

        private function onDescTextRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
