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

        override public function setup(index:uint, nodeData:NodeData, entityType:uint = 0, matrixPosition:MatrixPosition = null):void
        {
            //Logger.add("0x" + StringUtils.leftPad(nodeData.state.toString(16), 8, "0") + " " + nodeData.nameString);
            if (Config.config.hangar.hidePricesInTechTree)
            {
                // TODO:1.4.1
                /*
                if (nodeData.shopPrice.gold == 0)
                {
                    if ((nodeData.state & NODE_STATE_FLAGS.UNLOCKED) != 0)
                        nodeData.state |= NODE_STATE_FLAGS.WAS_IN_BATTLE;
                }
                */
            }
            super.setup(index, nodeData, entityType, matrixPosition);
        }

        // TODO:1.4.1
        /*
        override public function populateUI():void
        {
            if (Config.config.hangar.hidePricesInTechTree)
            {
                if (stateProps)
                {
                    if (stateProps.visible)
                    {
                        if (stateProps.animation == null)
                        {
                            if (stateProps.label == "goldPriceLabel" || stateProps.label == "creditsPriceLabel")
                            {
                                stateProps.animation = new AnimationProperties(150, { alpha:0 }, { alpha:1 } );
                            }
                        }
                    }
                }
            }

            super.populateUI();
        }
        */

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
                        masteryStr = "<img src='img://gui/maps/icons/library/proficiency/class_icons_" + vdata.mastery + ".png' width='23' height='23'>";
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
            masteryTF.x = 3;
            masteryTF.y = 14;
            masteryTF.width = 32;
            masteryTF.height = 32;
            masteryTF.selectable = false;
            // TODO:1.4.1
            /*
            this.nameAndXp.addChild(masteryTF);
            */
        }

    }
}
