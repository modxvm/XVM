package net.wg.gui.lobby.store.views.data
{
    import net.wg.data.constants.Errors;

    public class ExtFitItemsFiltersVO extends FitItemsFiltersVO
    {

        private static const ITEM_TYPES_FIELD_NAME:String = "itemTypes";

        public var itemTypes:Vector.<String> = null;

        public function ExtFitItemsFiltersVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == ITEM_TYPES_FIELD_NAME && param2 != null)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + typeof this.itemTypes);
                this.itemTypes = new Vector.<String>(0);
                for each(_loc4_ in _loc3_)
                {
                    this.itemTypes.push(_loc4_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDataRead(param1:String, param2:Object) : Boolean
        {
            if(param1 == ITEM_TYPES_FIELD_NAME && this.itemTypes != null)
            {
                param2[param1] = App.utils.data.vectorToArray(this.itemTypes);
                return false;
            }
            return super.onDataRead(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.itemTypes != null)
            {
                this.itemTypes.splice(0,this.itemTypes.length);
                this.itemTypes = null;
            }
            super.onDispose();
        }
    }
}
