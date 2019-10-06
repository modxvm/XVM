package net.wg.infrastructure.managers.pool
{
    import net.wg.utils.IAssertable;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Errors;

    public class ComponentsPool extends Pool
    {

        private var _linkage:String;

        private var _instanceClass:Class;

        public function ComponentsPool(param1:uint, param2:String, param3:Class, param4:Boolean = true)
        {
            var _loc5_:IAssertable = App.utils.asserter;
            _loc5_.assert(StringUtils.isNotEmpty(param2),"Tooltip block linkage" + Errors.CANT_EMPTY);
            this._linkage = param2;
            _loc5_.assert(param3 != null,"Instance class" + Errors.CANT_NULL);
            this._instanceClass = param3;
            super(param1,this.createBlock,param4);
        }

        override protected function onDispose() : void
        {
            this._instanceClass = null;
            super.onDispose();
        }

        private function createBlock() : *
        {
            return App.utils.classFactory.getComponent(this._linkage,this._instanceClass);
        }
    }
}
