package xvm.techtree
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.dossier.*;
    import flash.text.*;
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
                var dossier:AccountDossier = Dossier.get();
                if (dossier != null && dossier.vehicles.hasOwnProperty(id))
                {
                    var vdata:VehicleDossierItem = dossier.vehicles[id];
                    masteryStr = "<img src='img://gui/maps/icons/library/proficiency/class_icons_" + vdata.mastery + ".png' width='23' height='23'>";
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
            masteryTF = new TextField();
            masteryTF.x = 3;
            masteryTF.y = 13;
            masteryTF.width = 32;
            masteryTF.height = 32;
            this.addChild(masteryTF);
        }

    }
}
