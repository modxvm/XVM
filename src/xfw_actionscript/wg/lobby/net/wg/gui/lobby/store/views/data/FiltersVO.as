package net.wg.gui.lobby.store.views.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.constants.Errors;

    public class FiltersVO extends DAAPIDataClass
    {

        private static const EXTRA_FIELD_NAME:String = "extra";

        public var extra:Vector.<String> = null;

        public function FiltersVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == EXTRA_FIELD_NAME && param2 != null)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + typeof this.extra);
                this.extra = new Vector.<String>(0);
                for each(_loc4_ in _loc3_)
                {
                    this.extra.push(_loc4_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDataRead(param1:String, param2:Object) : Boolean
        {
            if(param1 == EXTRA_FIELD_NAME && this.extra != null)
            {
                param2[param1] = App.utils.data.vectorToArray(this.extra);
                return false;
            }
            return super.onDataRead(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.extra != null)
            {
                this.extra.splice(0,this.extra.length);
                this.extra = null;
            }
            super.onDispose();
        }
    }
}
