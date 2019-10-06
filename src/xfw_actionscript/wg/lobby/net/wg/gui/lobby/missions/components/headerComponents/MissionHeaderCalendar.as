package net.wg.gui.lobby.missions.components.headerComponents
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import org.idmedia.as3commons.util.StringUtils;

    public class MissionHeaderCalendar extends UIComponentEx
    {

        private static const INV_ICON_VISIBLE:String = "inv_icon_visible";

        private static const CALENDAR_TEXT_X:int = 24;

        private static const DOTS:String = "...";

        private static const MAX_LINE_NUMBER:uint = 2;

        public var calendarIcon:UILoaderAlt;

        public var calendarText:TextField;

        private var _isIconVisible:Boolean = false;

        private var _isCalendarTextTruncated:Boolean = false;

        public function MissionHeaderCalendar()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INV_ICON_VISIBLE))
            {
                if(this._isIconVisible && StringUtils.isEmpty(this.calendarIcon.source))
                {
                    this.calendarIcon.source = RES_ICONS.MAPS_ICONS_BUTTONS_CALENDAR;
                }
                this.calendarIcon.visible = this._isIconVisible;
                this.calendarText.x = this._isIconVisible?CALENDAR_TEXT_X:0;
                invalidateSize();
            }
        }

        override protected function onDispose() : void
        {
            this.calendarIcon.dispose();
            this.calendarIcon = null;
            this.calendarText = null;
            super.onDispose();
        }

        public function setText(param1:String) : void
        {
            this._isCalendarTextTruncated = App.utils.commons.truncateHtmlTextMultiline(this.calendarText,param1,MAX_LINE_NUMBER,DOTS);
            App.utils.commons.updateTextFieldSize(this.calendarText);
            invalidateSize();
        }

        override public function get width() : Number
        {
            return this.calendarText.textWidth + (this._isIconVisible?CALENDAR_TEXT_X:0);
        }

        public function set isIconVisible(param1:Boolean) : void
        {
            this._isIconVisible = param1;
            invalidate(INV_ICON_VISIBLE);
        }

        public function get isCalendarTextTruncated() : Boolean
        {
            return this._isCalendarTextTruncated;
        }
    }
}
