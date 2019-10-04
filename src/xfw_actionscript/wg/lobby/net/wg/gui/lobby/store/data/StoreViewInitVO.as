package net.wg.gui.lobby.store.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class StoreViewInitVO extends DAAPIDataClass
    {

        private static const BUTTON_BAR_DATA_PROP:String = "buttonBarData";

        public var currentViewIdx:int = -1;

        public var buttonBarData:DataProvider;

        public var bgImageSrc:String = "";

        public function StoreViewInitVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == BUTTON_BAR_DATA_PROP)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
                this.buttonBarData = new DataProvider();
                for each(_loc4_ in _loc3_)
                {
                    this.buttonBarData.push(new ButtonBarVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this.buttonBarData)
            {
                _loc1_.dispose();
            }
            this.buttonBarData.cleanUp();
            this.buttonBarData = null;
            super.onDispose();
        }
    }
}
