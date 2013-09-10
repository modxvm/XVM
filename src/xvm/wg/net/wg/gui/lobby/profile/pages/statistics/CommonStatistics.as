package net.wg.gui.lobby.profile.pages.statistics 
{
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.components.*;
    import scaleform.clik.core.*;
    
    public class CommonStatistics extends scaleform.clik.core.UIComponent
    {
        public function CommonStatistics()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*;
            this.ltDamageCoefficient.width = loc1 = TF_BLOCK1_WIDTH;
            this.ltReceivedDamage.width = loc1 = loc1;
            this.ltDealOutDamage.width = loc1 = loc1;
            this.ltDestructionCoefficient.width = loc1 = loc1;
            this.ltDestroyed.width = loc1 = loc1;
            this.ltKilled.width = loc1;
            this.ltAvgDetectedEnemies.width = loc1 = TF_BLOCK2_WIDTH;
            this.ltAvgReceivedDamage.width = loc1 = loc1;
            this.ltAvgDamage.width = loc1 = loc1;
            this.ltMaxDestroyedVehicles.width = loc1 = loc1;
            this.ltAvgDestroyedVehicles.width = loc1;
            this.ltDestructionCoefficient.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_DESTROYCOEFF;
            this.ltDamageCoefficient.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_DAMAGECOEFF;
            return;
        }

        public function setLabels(arg1:Object):void
        {
            applyLabelsText("killed", arg1, this.ltKilled);
            applyLabelsText("destroyed", arg1, this.ltDestroyed);
            applyLabelsText("destructionCoefficient", arg1, this.ltDestructionCoefficient);
            applyLabelsText("dealOutDamage", arg1, this.ltDealOutDamage);
            applyLabelsText("receivedDamage", arg1, this.ltReceivedDamage);
            applyLabelsText("damageCoefficient", arg1, this.ltDamageCoefficient);
            applyLabelsText("avgDestroyedVehicles", arg1, this.ltAvgDestroyedVehicles);
            applyLabelsText("maxDestroyedVehicles", arg1, this.ltMaxDestroyedVehicles);
            applyLabelsText("avgDamage", arg1, this.ltAvgDamage);
            applyLabelsText("avgReceivedDamage", arg1, this.ltAvgReceivedDamage);
            applyLabelsText("avgDetectedEnemies", arg1, this.ltAvgDetectedEnemies);
            return;
        }

        public function setDossierData(arg1:net.wg.data.gui_items.dossier.Dossier):void
        {
            this.ltKilled.value = arg1.getFragsCountStr();
            this.ltDestroyed.value = arg1.getDeathsCountStr();
            this.ltDestructionCoefficient.value = "<font color=\'#cbad78\'>" + arg1.getFragsEfficiencyStr() + "</font>";
            this.ltDealOutDamage.value = arg1.getDamageDealtStr();
            this.ltReceivedDamage.value = arg1.getDamageReceivedStr();
            this.ltDamageCoefficient.value = "<font color=\'#cbad78\'>" + arg1.getDamageEfficiencyStr() + "</font>";
            this.ltAvgDestroyedVehicles.value = arg1.getAvgFragsStr();
            this.ltMaxDestroyedVehicles.value = arg1.getMaxFragsStr();
            this.ltAvgDamage.value = arg1.getAvgDamageDealtStr();
            this.ltAvgReceivedDamage.value = arg1.getAvgDamageReceivedStr();
            this.ltAvgDetectedEnemies.value = arg1.getAvgEnemiesSpottedStr();
            return;
        }

        public function setViewSize(arg1:Number, arg2:Number):void
        {
            var loc1:*;
            this.ltDamageCoefficient.x = loc1 = SIDES_PADDING;
            this.ltReceivedDamage.x = loc1 = loc1;
            this.ltDealOutDamage.x = loc1 = loc1;
            this.ltDestructionCoefficient.x = loc1 = loc1;
            this.ltDestroyed.x = loc1 = loc1;
            this.ltKilled.x = loc1;
            this.ltAvgDetectedEnemies.x = loc1 = arg1 - TF_BLOCK2_WIDTH - SIDES_PADDING;
            this.ltAvgReceivedDamage.x = loc1 = loc1;
            this.ltAvgDamage.x = loc1 = loc1;
            this.ltMaxDestroyedVehicles.x = loc1 = loc1;
            this.ltAvgDestroyedVehicles.x = loc1;
            return;
        }

        internal static function applyLabelsText(arg1:String, arg2:Object, arg3:net.wg.gui.lobby.profile.components.DashLineTextItem):void
        {
            arg3.label = arg2[arg1];
            return;
        }

        internal static const TF_BLOCK2_WIDTH:int=544;

        internal static const TF_BLOCK1_WIDTH:int=338;

        internal static const SIDES_PADDING:int=30;

        internal static const CENTER_PADDING:int=50;

        public var ltKilled:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltDestroyed:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltDestructionCoefficient:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltDealOutDamage:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltReceivedDamage:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltDamageCoefficient:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltAvgDestroyedVehicles:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltMaxDestroyedVehicles:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltAvgDamage:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltAvgReceivedDamage:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var ltAvgDetectedEnemies:net.wg.gui.lobby.profile.components.DashLineTextItem;
    }
}
