package net.wg.gui.lobby.vehiclePreview.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VehPreviewCrewListRendererVO extends DAAPIDataClass
    {

        public var icon:String = "";

        public var name:String = "";

        public var tooltip:String = "";

        public var role:String = "";

        public function VehPreviewCrewListRendererVO(param1:Object)
        {
            super(param1);
        }
    }
}
