package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class QuestsWindowMeta extends AbstractWindowView
    {
        
        public function QuestsWindowMeta()
        {
            super();
        }
        
        public var onTabSelected:Function = null;
        
        public function onTabSelectedS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onTabSelected,"onTabSelected" + Errors.CANT_NULL);
            this.onTabSelected(param1);
        }
    }
}
