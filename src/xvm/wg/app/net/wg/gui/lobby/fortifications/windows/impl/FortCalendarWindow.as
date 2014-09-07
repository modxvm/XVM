package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortCalendarWindowMeta;
    import net.wg.infrastructure.base.meta.IFortCalendarWindowMeta;
    import net.wg.gui.components.advanced.Calendar;
    import net.wg.gui.lobby.fortifications.cmp.calendar.impl.CalendarPreviewBlock;
    import net.wg.gui.lobby.fortifications.data.FortCalendarDayVO;
    import net.wg.data.Aliases;
    import net.wg.gui.lobby.fortifications.data.FortCalendarPreviewBlockVO;
    
    public class FortCalendarWindow extends FortCalendarWindowMeta implements IFortCalendarWindowMeta
    {
        
        public function FortCalendarWindow()
        {
            super();
        }
        
        public var calendar:Calendar;
        
        public var previewBlock:CalendarPreviewBlock;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.calendar.modalFocusHolder = this;
            this.calendar.dayVOClass = FortCalendarDayVO;
            this.calendar.setOutOfBoundsTooltip(App.utils.locale.makeString(FORTIFICATIONS.FORTCALENDARWINDOW_CALENDAR_DAYTOOLTIP_NOTAVAILABLE_HEADER),App.utils.locale.makeString(FORTIFICATIONS.FORTCALENDARWINDOW_CALENDAR_DAYTOOLTIP_NOTAVAILABLE_BODY));
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerComponent(this.calendar,Aliases.CALENDAR);
            window.title = FORTIFICATIONS.FORTCALENDARWINDOW_TITLE;
        }
        
        override protected function onDispose() : void
        {
            this.calendar = null;
            this.previewBlock.dispose();
            this.previewBlock = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override protected function updatePreviewData(param1:FortCalendarPreviewBlockVO) : void
        {
            this.previewBlock.model = param1;
        }
    }
}
