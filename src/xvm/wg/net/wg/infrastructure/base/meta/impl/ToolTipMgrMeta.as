package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ToolTipMgrMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function ToolTipMgrMeta()
        {
            super();
            return;
        }

        public function onCreateComplexTooltipS(arg1:String, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.onCreateComplexTooltip, "onCreateComplexTooltip" + net.wg.data.constants.Errors.CANT_NULL);
            this.onCreateComplexTooltip(arg1, arg2);
            return;
        }

        public function onCreateTypedTooltipS(arg1:String, arg2:Array, arg3:String):void
        {
            App.utils.asserter.assertNotNull(this.onCreateTypedTooltip, "onCreateTypedTooltip" + net.wg.data.constants.Errors.CANT_NULL);
            this.onCreateTypedTooltip(arg1, arg2, arg3);
            return;
        }

        public var onCreateComplexTooltip:Function=null;

        public var onCreateTypedTooltip:Function=null;
    }
}
