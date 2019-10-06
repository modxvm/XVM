package net.wg.gui.lobby.vehiclePreview.controls
{
    import flash.text.TextField;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewFactSheetVO;

    public class VehPreviewFactSheet extends VehPreviewInfoPanelTab
    {

        private static const BOTTOM_MARGIN:int = 27;

        public var historicReferenceTf:TextField;

        public function VehPreviewFactSheet()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.historicReferenceTf = null;
            super.onDispose();
        }

        override protected function onDataUpdated(param1:Object) : void
        {
            var _loc2_:VehPreviewFactSheetVO = VehPreviewFactSheetVO(param1);
            this.historicReferenceTf.htmlText = _loc2_.historicReferenceTxt;
            App.utils.commons.updateTextFieldSize(this.historicReferenceTf,false,true);
            height = actualHeight;
        }

        override public function get bottomMargin() : int
        {
            return BOTTOM_MARGIN;
        }
    }
}
