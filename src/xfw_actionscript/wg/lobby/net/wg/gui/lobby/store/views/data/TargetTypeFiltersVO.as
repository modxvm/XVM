package net.wg.gui.lobby.store.views.data
{
    public class TargetTypeFiltersVO extends FiltersVO
    {

        private static const FIELD_TARGET_TYPE:String = "targetType";

        public var targetType:String = "";

        public function TargetTypeFiltersVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataRead(param1:String, param2:Object) : Boolean
        {
            if(param1 == FIELD_TARGET_TYPE)
            {
                param2[param1] = this.targetType;
                return false;
            }
            return super.onDataRead(param1,param2);
        }
    }
}
