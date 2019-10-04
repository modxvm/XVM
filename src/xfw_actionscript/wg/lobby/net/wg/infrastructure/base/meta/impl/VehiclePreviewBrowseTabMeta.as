package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class VehiclePreviewBrowseTabMeta extends BaseDAAPIComponent
    {

        public var setActiveState:Function;

        private var _array:Array;

        public function VehiclePreviewBrowseTabMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._array)
            {
                this._array.splice(0,this._array.length);
                this._array = null;
            }
            super.onDispose();
        }

        public function setActiveStateS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setActiveState,"setActiveState" + Errors.CANT_NULL);
            this.setActiveState(param1);
        }

        public final function as_setData(param1:String, param2:Boolean, param3:Array) : void
        {
            var _loc4_:Array = this._array;
            this._array = param3;
            this.setData(param1,param2,this._array);
            if(_loc4_)
            {
                _loc4_.splice(0,_loc4_.length);
            }
        }

        protected function setData(param1:String, param2:Boolean, param3:Array) : void
        {
            var _loc4_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc4_);
            throw new AbstractException(_loc4_);
        }
    }
}
