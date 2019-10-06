package net.wg.gui.lobby.vehiclePreview.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class VehPreviewCrewInfoVO extends DAAPIDataClass
    {

        private static const CREW_LIST_FIELD_NAME:String = "crewList";

        public var listDesc:String = "";

        public var crewList:DataProvider = null;

        public function VehPreviewCrewInfoVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == CREW_LIST_FIELD_NAME)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
                this.crewList = new DataProvider();
                for each(_loc4_ in _loc3_)
                {
                    this.crewList.push(new VehPreviewCrewListRendererVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            this.listDesc = null;
            if(this.crewList != null)
            {
                for each(_loc1_ in this.crewList)
                {
                    _loc1_.dispose();
                }
                this.crewList.cleanUp();
                this.crewList = null;
            }
            super.onDispose();
        }
    }
}
