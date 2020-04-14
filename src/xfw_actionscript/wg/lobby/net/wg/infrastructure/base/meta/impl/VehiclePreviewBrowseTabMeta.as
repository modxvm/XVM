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

        public final function as_setData(param1:String, param2:Boolean, param3:int, param4:Array) : void
        {
            var _loc5_:Array = this._array;
            this._array = param4;
            this.setData(param1,param2,param3,this._array);
            if(_loc5_)
            {
                _loc5_.splice(0,_loc5_.length);
            }
        }

        protected function setData(param1:String, param2:Boolean, param3:int, param4:Array) : void
        {
            var _loc5_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc5_);
            throw new AbstractException(_loc5_);
        }
    }
}
