package xvm.techtree
{
    import com.xvm.*;
    import flash.text.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public dynamic class UI_NationTreeNodeSkinned extends NationTreeNodeSkinned
    {
        private var masteryTF:TextField;

        public function UI_NationTreeNodeSkinned()
        {
            super();
            createControls();
        }

        override protected function draw():void
        {
            super.draw();

            var masteryStr:String = "";
            try
            {
                var id:Number = getID();
                if (TechTreeXvmView.vehiclesData.hasOwnProperty(id))
                {
                    var data:TechniqueListVehicleVO = TechTreeXvmView.vehiclesData[id];
                    masteryStr = "<img src='img://gui/maps/icons/library/proficiency/class_icons_" + data.markOfMastery + ".png' width='24' height='24'>";
                }
            }
            finally
            {
                masteryTF.htmlText = masteryStr;
            }
        }

        // PRIVATE

        private function createControls():void
        {
            masteryTF = new TextField();
            masteryTF.x = 2;
            masteryTF.y = 13;
            masteryTF.width = 32;
            masteryTF.height = 32;
            this.addChild(masteryTF);
        }

    }
}
