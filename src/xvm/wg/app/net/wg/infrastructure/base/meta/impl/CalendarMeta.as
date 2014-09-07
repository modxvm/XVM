package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class CalendarMeta extends BaseDAAPIComponent
    {
        
        public function CalendarMeta()
        {
            super();
        }
        
        public var onMonthChanged:Function = null;
        
        public var onDateSelected:Function = null;
        
        public function onMonthChangedS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.onMonthChanged,"onMonthChanged" + Errors.CANT_NULL);
            this.onMonthChanged(param1);
        }
        
        public function onDateSelectedS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.onDateSelected,"onDateSelected" + Errors.CANT_NULL);
            this.onDateSelected(param1);
        }
    }
}
