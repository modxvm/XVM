package net.wg.gui.lobby.profile.pages.statistics 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class TfContainer extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function TfContainer()
        {
            super();
            addEventListener(flash.events.Event.RESIZE, this.resizeComponentsHandler, false, 0, true);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        internal function resizeComponentsHandler(arg1:flash.events.Event):void
        {
            arg1.stopImmediatePropagation();
            invalidate(LAYOUT_INVALID);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=0;
            super.draw();
            if (isInvalid(LAYOUT_INVALID, scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                loc1 = new Vector.<scaleform.clik.core.UIComponent>();
                loc1.push(this.tfTotalBattles);
                loc1.push(this.tfWins);
                loc1.push(this.tfHits);
                loc1.push(this.tfAvgExperience);
                loc1.push(this.tfMaxExperience);
                loc1.push(this.tfSurvival);
                loc1.push(this.tfMarksOfMastery);
                loc2 = 0;
                loc3 = loc1.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    if (loc5 = loc1[loc4]) 
                    {
                        loc2 = loc2 + loc5.width;
                    }
                    ++loc4;
                }
                loc7 = loc6 = (_width - loc2) / (loc3 + 1);
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    if (loc5 = loc1[loc4]) 
                    {
                        loc5.x = loc7;
                        loc7 = loc7 + (loc5.width + loc6);
                    }
                    ++loc4;
                }
            }
            return;
        }

        public function setDossierData(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            this.tfTotalBattles.text = arg1.getBattlesCountStr();
            this.tfWins.text = arg1.getWinsEfficiencyStr();
            this.tfSurvival.text = arg1.getSurvivalEfficiencyStr();
            this.tfHits.text = arg1.getHitsEfficiencyStr();
            this.tfMaxExperience.text = arg1.getMaxXPStr();
            this.tfMaxExperience.value = arg1.getMaxXPVehicleDescr();
            this.tfAvgExperience.text = arg1.getAvgXPStr();
            this.tfMarksOfMastery.text = arg1.getSpecifiedMarksOfMastery(net.wg.data.constants.MarksOfMastery.MASTER).toString();
            this.tfMarksOfMastery.totalCount = arg1.getVehiclesCount();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(flash.events.Event.RESIZE, this.resizeComponentsHandler);
            return;
        }

        public static const LAYOUT_INVALID:String="layoutInv";

        public var tfTotalBattles:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfWins:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfSurvival:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfHits:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfAvgExperience:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfMaxExperience:net.wg.gui.lobby.profile.components.LditValued;

        public var tfMarksOfMastery:net.wg.gui.lobby.profile.components.LditMarksOfMastery;
    }
}
