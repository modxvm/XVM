package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class RadialMenuMeta extends BattleDisplayable
    {

        public var onSelect:Function;

        public var onAction:Function;

        public var onHideCompleted:Function;

        private var _array:Array;

        private var _array1:Array;

        private var _array2:Array;

        public function RadialMenuMeta()
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
            if(this._array1)
            {
                this._array1.splice(0,this._array1.length);
                this._array1 = null;
            }
            if(this._array2)
            {
                this._array2.splice(0,this._array2.length);
                this._array2 = null;
            }
            super.onDispose();
        }

        public function onSelectS() : void
        {
            App.utils.asserter.assertNotNull(this.onSelect,"onSelect" + Errors.CANT_NULL);
            this.onSelect();
        }

        public function onActionS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onAction,"onAction" + Errors.CANT_NULL);
            this.onAction(param1);
        }

        public function onHideCompletedS() : void
        {
            App.utils.asserter.assertNotNull(this.onHideCompleted,"onHideCompleted" + Errors.CANT_NULL);
            this.onHideCompleted();
        }

        public final function as_buildData(param1:Array) : void
        {
            var _loc2_:Array = this._array;
            this._array = param1;
            this.buildData(this._array);
            if(_loc2_)
            {
                _loc2_.splice(0,_loc2_.length);
            }
        }

        public final function as_show(param1:String, param2:Array, param3:Array) : void
        {
            var _loc4_:Array = this._array1;
            this._array1 = param2;
            var _loc5_:Array = this._array2;
            this._array2 = param3;
            this.show(param1,this._array1,this._array2);
            if(_loc4_)
            {
                _loc4_.splice(0,_loc4_.length);
            }
            if(_loc5_)
            {
                _loc5_.splice(0,_loc5_.length);
            }
        }

        protected function buildData(param1:Array) : void
        {
            var _loc2_:String = "as_buildData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function show(param1:String, param2:Array, param3:Array) : void
        {
            var _loc4_:String = "as_show" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc4_);
            throw new AbstractException(_loc4_);
        }
    }
}
