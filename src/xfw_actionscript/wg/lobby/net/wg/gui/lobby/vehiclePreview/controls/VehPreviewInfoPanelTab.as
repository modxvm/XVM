package net.wg.gui.lobby.vehiclePreview.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanelTab;
    import flash.display.InteractiveObject;

    public class VehPreviewInfoPanelTab extends UIComponentEx implements IVehPreviewInfoPanelTab
    {

        private var _data:Object = null;

        public function VehPreviewInfoPanelTab()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this._data = null;
            super.onDispose();
        }

        public function canShowAutomatically() : Boolean
        {
            return true;
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }

        public final function update(param1:Object) : void
        {
            if(this._data != param1)
            {
                this._data = param1;
                this.onDataUpdated(this._data);
            }
        }

        protected function onDataUpdated(param1:Object) : void
        {
        }

        public function get bottomMargin() : int
        {
            return 0;
        }
    }
}
