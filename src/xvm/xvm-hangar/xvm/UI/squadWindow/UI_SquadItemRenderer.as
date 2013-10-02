package xvm.UI.squadWindow
{
    import xvm.hangar.components.Squad.SquadItemRenderer;

    public dynamic class UI_SquadItemRenderer extends squadItemRendererUI
    {
        private var worker:SquadItemRenderer;

        public function UI_SquadItemRenderer():void
        {
            super();
            worker = new SquadItemRenderer(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            worker.setUIConfigured();
        }

        override protected function afterSetData():void
        {
            super.afterSetData();
            worker.displayVehicleTier();
        }

        override protected function getToolTipData():String
        {
            var data:String = worker.getToolTipData();
            return (data != null ? data : super.getToolTipData());
        }
    }

}
