package xvm.techtree
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.data.state.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.math.*;

    public dynamic class UI_NationTreeNodeSkinned extends NationTreeNodeSkinned
    {
        private var masteryTF:TextField;

        public function UI_NationTreeNodeSkinned()
        {
            super();
            createControls();
        }

        override public function setup(index:uint, nodeData:NodeData, entityType:uint = 0, matrixPosition:MatrixPosition = null):void
        {
            if (Config.config.hangar.hidePricesInTechTree)
            {
                if (nodeData.shopPrice.gold == 0)
                {
                    // bits:
                    // 0x01 - 0-enabled, 1-disabled
                    // 0x02 - 0-opened, 1-closed
                    // ...
                    // 0x40 - 1-was bought
                    // 0x80 - 1-elite
                    // ...
                    //Logger.add(nodeData.state.toString());
                    if ((nodeData.state & 0x3) == 0)
                        nodeData.state |= 0x40;
                }
            }
            super.setup(index, nodeData, entityType, matrixPosition);
        }

        override public function populateUI():void
        {
            if (Config.config.hangar.hidePricesInTechTree)
            {
                if (stateProps != null && stateProps.visible && stateProps.animation == null)
                {
                    if (stateProps.label == "goldPriceLabel" || stateProps.label == "creditsPriceLabel")
                        stateProps.animation = new AnimationProperties(150, { alpha:0 }, { alpha:1 } );
                }
            }

            super.populateUI();
        }

        override protected function draw():void
        {
            super.draw();

            if (Config.config.hangar.masteryMarkInTechTree)
            {
                var masteryStr:String = "";
                try
                {
                    var id:Number = getID();
                    var dossier:AccountDossier = Dossier.getAccountDossier();
                    if (dossier != null && dossier.vehicles.hasOwnProperty(id))
                    {
                        var vdata:VehicleDossierCut = dossier.vehicles[id];
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
        }

        // PRIVATE

        private function createControls():void
        {
            masteryTF = new TextField();
            masteryTF.x = 3;
            masteryTF.y = 14;
            masteryTF.width = 32;
            masteryTF.height = 32;
            masteryTF.selectable = false;
            this.nameAndXp.addChild(masteryTF);
        }

    }
}
