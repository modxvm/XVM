/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.techtree
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import flash.text.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.techtree.data.state.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    import net.wg.gui.lobby.techtree.math.*;
    import scaleform.gfx.*;

    public class UI_NationTreeNodeSkinned extends NationTreeNodeSkinned
    {
        private var masteryTF:TextField;

        public function UI_NationTreeNodeSkinned()
        {
            //Logger.add("UI_NationTreeNodeSkinned()");
            super();
            createControls();
        }

        override protected function validateData():void
        {
            if (Config.config.hangar.hidePricesInTechTree)
            {
                if (stateProps)
                {
                    switch (stateProps.state)
                    {
                        case "locked":
                        case "inventory":
                        case "inventory_premium":
                            break;
                        default:
                            stateProps.visible = false;
                            stateProps.animation = new AnimationProperties(150, { alpha: 0 }, { alpha: 1 } );
                            break;
                    }
                }
            }
            super.validateData();
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
                    if (dossier)
                    {
                        var vdata:VehicleDossierCut = dossier.getVehicleDossierCut(id);
                        if (!isNaN(vdata.mastery) && vdata.mastery != 0)
                        {
                            masteryStr = "<img src='img://gui/maps/icons/library/proficiency/class_icons_" + vdata.mastery + ".png' width='23' height='23'>";
                        }
                    }
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
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
            masteryTF.mouseEnabled = false;
            masteryTF.selectable = false;
            TextFieldEx.setNoTranslate(masteryTF, true);
            masteryTF.antiAliasType = AntiAliasType.ADVANCED;
            masteryTF.x = -1;
            masteryTF.y = 11;
            masteryTF.width = 32;
            masteryTF.height = 32;
            this.addChild(masteryTF);
        }
    }
}
