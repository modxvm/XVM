package net.wg.data.components 
{
    import net.wg.data.constants.*;
    
    public class StoreMenuViewData extends net.wg.data.components.AccordionRendererData
    {
        public function StoreMenuViewData(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get fittingType():String
        {
            return this._fittingType;
        }

        public function set fittingType(arg1:String):void
        {
            App.utils.asserter.assertNotNull(arg1, "fittingType" + net.wg.data.constants.Errors.CANT_NULL);
            this._fittingType = arg1;
            return;
        }

        internal var _fittingType:String="";
    }
}
