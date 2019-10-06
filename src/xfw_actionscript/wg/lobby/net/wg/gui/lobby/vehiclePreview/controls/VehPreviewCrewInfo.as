package net.wg.gui.lobby.vehiclePreview.controls
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewCrewInfoVO;

    public class VehPreviewCrewInfo extends VehPreviewInfoPanelTab
    {

        private static const GAP:int = 14;

        private static const BOTTOM_MARGIN:int = 0;

        public var crewListLabelTf:TextField;

        public var crewList:ScrollingListEx;

        public var separator:DisplayObject;

        private var _separatorListGap:int = 0;

        public function VehPreviewCrewInfo()
        {
            super();
            this._separatorListGap = this.separator.y - this.crewList.y;
        }

        override protected function onDispose() : void
        {
            this.crewListLabelTf = null;
            this.crewList.dispose();
            this.crewList = null;
            this.separator = null;
            super.onDispose();
        }

        override protected function onDataUpdated(param1:Object) : void
        {
            var _loc2_:VehPreviewCrewInfoVO = null;
            _loc2_ = VehPreviewCrewInfoVO(param1);
            this.crewListLabelTf.htmlText = _loc2_.listDesc;
            App.utils.commons.updateTextFieldSize(this.crewListLabelTf,false,true);
            this.crewList.y = this.crewListLabelTf.y + this.crewListLabelTf.height + GAP | 0;
            this.separator.y = this.crewList.y + this._separatorListGap | 0;
            this.crewList.height = this.crewList.rowHeight * _loc2_.crewList.length;
            this.crewList.dataProvider = _loc2_.crewList;
            height = this.crewList.y + this.crewList.height + BOTTOM_MARGIN;
        }
    }
}
