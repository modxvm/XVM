package xvm.UI.squadWindow

    import com.xvm.*;

    public class UI_SquadItemRenderer extends squadItemRendererUI
	{
        private var worker:SquadItemRenderer;

        public function UI_SquadItemRenderer():void
        {
            super();
            worker = new SquadItemRenderer(this);
        }

        override protected function configUI():void
        {
            Logger.add("squad: configUI");
            super.configUI();
            //worker.setUIConfigured();
        }

		override protected function afterSetData():void
        {
            Logger.add("squad: afterSetData");
            super.afterSetData();
            //worker.displayVehicleTier();
        }

        override protected function getToolTipData():String
        {
            Logger.add("squad: getToolTipData");
            return super.getToolTipData();
            //return worker.getToolTipData();
        }
    }

}