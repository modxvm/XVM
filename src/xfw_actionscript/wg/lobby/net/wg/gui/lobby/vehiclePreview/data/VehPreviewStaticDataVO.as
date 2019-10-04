package net.wg.gui.lobby.vehiclePreview.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Errors;
    import net.wg.gui.data.ButtonBarItemVO;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class VehPreviewStaticDataVO extends DAAPIDataClass
    {

        private static const HEADER_FIELD_NAME:String = "header";

        private static const BOTTOM_PANEL_FIELD_NAME:String = "bottomPanel";

        private static const CREW_PANEL_FIELD_NAME:String = "crewPanel";

        public var header:VehPreviewHeaderVO = null;

        public var crewPanel:DataProvider = null;

        public var bottomPanel:VehPreviewBottomPanelVO = null;

        public function VehPreviewStaticDataVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == HEADER_FIELD_NAME)
            {
                this.header = new VehPreviewHeaderVO(param2);
                return false;
            }
            if(param1 == BOTTOM_PANEL_FIELD_NAME)
            {
                this.bottomPanel = new VehPreviewBottomPanelVO(param2);
                return false;
            }
            if(param1 == CREW_PANEL_FIELD_NAME)
            {
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,_loc3_ + Errors.CANT_NULL);
                this.crewPanel = new DataProvider();
                for each(_loc4_ in param2)
                {
                    this.crewPanel.push(new ButtonBarItemVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            this.header.dispose();
            this.header = null;
            this.bottomPanel.dispose();
            this.bottomPanel = null;
            for each(_loc1_ in this.crewPanel)
            {
                _loc1_.dispose();
            }
            this.crewPanel.cleanUp();
            this.crewPanel = null;
            super.onDispose();
        }
    }
}
