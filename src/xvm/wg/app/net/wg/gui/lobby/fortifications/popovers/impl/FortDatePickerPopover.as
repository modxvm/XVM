package net.wg.gui.lobby.fortifications.popovers.impl
{
    import net.wg.infrastructure.base.meta.impl.FortDatePickerPopoverMeta;
    import net.wg.infrastructure.base.meta.IFortDatePickerPopoverMeta;
    import net.wg.gui.components.advanced.Calendar;
    import net.wg.gui.lobby.fortifications.data.FortCalendarDayVO;
    import net.wg.data.Aliases;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popOvers.PopOver;
    
    public class FortDatePickerPopover extends FortDatePickerPopoverMeta implements IFortDatePickerPopoverMeta
    {
        
        public function FortDatePickerPopover()
        {
            super();
        }
        
        public var calendar:Calendar;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.calendar.needToInitFocus = false;
            this.calendar.modalFocusHolder = this;
            this.calendar.dayVOClass = FortCalendarDayVO;
            this.calendar.setOutOfBoundsTooltip(App.utils.locale.makeString(FORTIFICATIONS.FORTDATEPICKERPOPOVER_CALENDAR_DAYTOOLTIP_NOTAVAILABLE_HEADER),App.utils.locale.makeString(FORTIFICATIONS.FORTDATEPICKERPOPOVER_CALENDAR_DAYTOOLTIP_NOTAVAILABLE_BODY));
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerComponent(this.calendar,Aliases.CALENDAR);
        }
        
        override protected function onDispose() : void
        {
            this.calendar = null;
            super.onDispose();
        }
        
        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            PopOver(param1).isCloseBtnVisible = true;
        }
    }
}
