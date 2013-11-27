package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public dynamic class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        private var masteryTF:TextField;

        public function UI_TankCarouselItemRenderer()
        {
            super();
            createControls();
        }

        override protected function draw():void
        {
            super.draw();

            if (!masteryTF)
                return;

            var masteryStr:String = "";
            try
            {
                if (!data || !data.hasOwnProperty("compactDescr"))
                    return;

                var id:Number = data.compactDescr;
                if (AccountData.vehicles.hasOwnProperty(id))
                {
                    var vdata:TechniqueListVehicleVO = AccountData.vehicles[id];
                    masteryStr = "<img src='img://gui/maps/icons/library/proficiency/class_icons_" + vdata.markOfMastery + ".png' width='23' height='23'>";
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            finally
            {
                masteryTF.htmlText = masteryStr;
            }
        }

        // PRIVATE

        private function createControls():void
        {
            masteryTF = null;
            if (!vehicleIcon)
                return;
            masteryTF = new TextField();
            masteryTF.x = 0;
            masteryTF.y = 13;
            masteryTF.width = 32;
            masteryTF.height = 32;
            vehicleIcon.addChild(masteryTF);
        }

    }
}
