package net.wg.gui.lobby.eventQuests.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class QuestsProgressVO extends DAAPIDataClass
    {

        private static const LEVELS:String = "levels";

        private var _levels:DataProvider;

        public function QuestsProgressVO(param1:Object)
        {
            this._levels = new DataProvider();
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == LEVELS)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,LEVELS + Errors.CANT_NULL);
                for each(_loc4_ in _loc3_)
                {
                    this._levels.push(new QuestsChainVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this._levels)
            {
                _loc1_.dispose();
            }
            this._levels.splice(0,this._levels.length);
            this._levels = null;
            super.onDispose();
        }

        public function get levels() : DataProvider
        {
            return this._levels;
        }
    }
}
