package net.wg.gui.lobby.vehiclePreview.events
{
    import flash.events.Event;

    public class VehPreviewInfoPanelEvent extends Event
    {

        public static const INFO_TAB_CHANGED:String = "infoTabChanged";

        private var _selectedTabIndex:int;

        public function VehPreviewInfoPanelEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this._selectedTabIndex = param2;
        }

        override public function clone() : Event
        {
            return new VehPreviewInfoPanelEvent(type,this._selectedTabIndex,bubbles,cancelable);
        }

        public function get selectedTabIndex() : int
        {
            return this._selectedTabIndex;
        }
    }
}
