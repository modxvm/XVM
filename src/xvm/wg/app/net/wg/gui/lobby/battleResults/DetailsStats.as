package net.wg.gui.lobby.battleResults 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    
    public class DetailsStats extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function DetailsStats()
        {
            super();
            this.creditsLbl.mouseWheelEnabled = false;
            this.creditsValuesLbl.mouseWheelEnabled = false;
            this.goldValuesLbl.mouseWheelEnabled = false;
            this.creditsPremValuesLbl.mouseWheelEnabled = false;
            this.goldPremValuesLbl.mouseWheelEnabled = false;
            this.xpLbl.mouseWheelEnabled = false;
            this.xpValuesLbl.mouseWheelEnabled = false;
            this.freeXpValuesLbl.mouseWheelEnabled = false;
            this.xpPremValuesLbl.mouseWheelEnabled = false;
            this.freeXpPremValuesLbl.mouseWheelEnabled = false;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.statsTitle.text = BATTLE_RESULTS.DETAILS_STATS;
            this.creditsTitle.text = BATTLE_RESULTS.DETAILS_CREDITS;
            this.timeTitle.text = BATTLE_RESULTS.DETAILS_TIME;
            this.xpTitle.text = BATTLE_RESULTS.DETAILS_XP;
            this.premLbl.text = BATTLE_RESULTS.DETAILS_PREM;
            var loc1:*=this.myParent.data;
            this.vehicleStats.state = net.wg.gui.lobby.battleResults.VehicleDetails.STATE_NORMAL;
            this.vehicleStats.data = loc1.personal.statValues;
            this.vehicleTimeStats.state = net.wg.gui.lobby.battleResults.VehicleDetails.STATE_TIME;
            this.vehicleTimeStats.data = loc1.common.timeStats;
            var loc2:*=loc1.personal.isPremium;
            var loc3:*=loc2 ? this.FADED_ALPHA : this.FULL_ALPHA;
            var loc4:*=loc2 ? this.FULL_ALPHA : this.FADED_ALPHA;
            this.creditsValuesLbl.alpha = loc3;
            this.goldValuesLbl.alpha = loc3;
            this.xpValuesLbl.alpha = loc3;
            this.freeXpValuesLbl.alpha = loc3;
            this.premLbl.alpha = loc4;
            this.creditsPremValuesLbl.alpha = loc4;
            this.goldPremValuesLbl.alpha = loc4;
            this.xpPremValuesLbl.alpha = loc4;
            this.freeXpPremValuesLbl.alpha = loc4;
            this.populateCredits(loc1.personal.creditsData);
            this.populateXp(loc1.personal.xpData);
            return;
        }

        internal function populateCredits(arg1:Array):void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=NaN;
            this.creditsLbl.htmlText = "";
            this.creditsValuesLbl.htmlText = "";
            this.goldValuesLbl.htmlText = "";
            this.creditsPremValuesLbl.htmlText = "";
            this.goldPremValuesLbl.htmlText = "";
            var loc1:*=0;
            var loc2:*=arg1.length;
            while (loc1 < loc2) 
            {
                loc3 = arg1[loc1];
                App.utils.commons.addBlankLines(loc3.label, this.creditsLbl, Vector.<flash.text.TextField>([this.creditsValuesLbl, this.goldValuesLbl, this.creditsPremValuesLbl, this.goldPremValuesLbl]));
                this.creditsLbl.htmlText = this.creditsLbl.htmlText + loc3.label;
                this.creditsValuesLbl.htmlText = this.creditsValuesLbl.htmlText + loc3.col1;
                this.goldValuesLbl.htmlText = this.goldValuesLbl.htmlText + loc3.col2;
                this.creditsPremValuesLbl.htmlText = this.creditsPremValuesLbl.htmlText + loc3.col3;
                this.goldPremValuesLbl.htmlText = this.goldPremValuesLbl.htmlText + loc3.col4;
                if (loc3.lineType) 
                {
                    loc4 = this.creditsLbl.x + 3;
                    loc5 = Math.floor(this.creditsLbl.y + this.creditsLbl.textHeight) + 3;
                    addChild(App.utils.classFactory.getComponent(loc3.lineType, flash.display.MovieClip, {"x":loc4, "y":loc5}));
                }
                ++loc1;
            }
            this.creditsSplitLine.height = this.creditsLbl.textHeight + 5;
            return;
        }

        internal function populateXp(arg1:Array):void
        {
            var loc3:*=null;
            var loc7:*=NaN;
            var loc8:*=NaN;
            this.xpLbl.htmlText = "";
            this.xpValuesLbl.htmlText = "";
            this.freeXpValuesLbl.htmlText = "";
            this.xpPremValuesLbl.htmlText = "";
            this.freeXpPremValuesLbl.htmlText = "";
            var loc1:*=0;
            var loc2:*=arg1.length;
            var loc4:*;
            var loc5:*=(loc4 = App.utils).commons;
            var loc6:*=loc4.classFactory;
            while (loc1 < loc2) 
            {
                loc3 = arg1[loc1];
                loc5.addBlankLines(loc3.labelStripped, this.creditsLbl, Vector.<flash.text.TextField>([this.xpValuesLbl, this.freeXpValuesLbl, this.xpPremValuesLbl, this.freeXpPremValuesLbl]));
                this.xpLbl.htmlText = this.xpLbl.htmlText + loc3.label;
                this.xpValuesLbl.htmlText = this.xpValuesLbl.htmlText + loc3.col1;
                this.freeXpValuesLbl.htmlText = this.freeXpValuesLbl.htmlText + loc3.col2;
                this.xpPremValuesLbl.htmlText = this.xpPremValuesLbl.htmlText + loc3.col3;
                this.freeXpPremValuesLbl.htmlText = this.freeXpPremValuesLbl.htmlText + loc3.col4;
                if (loc3.lineType) 
                {
                    loc7 = this.xpLbl.x + 3;
                    loc8 = Math.floor(this.xpLbl.y + this.xpLbl.textHeight) + 3;
                    addChild(loc6.getComponent(loc3.lineType, flash.display.MovieClip, {"x":loc7, "y":loc8}));
                }
                ++loc1;
            }
            this.xpSplitLine.height = this.xpLbl.textHeight + 5;
            return;
        }

        public function get myParent():net.wg.gui.lobby.battleResults.BattleResults
        {
            return net.wg.gui.lobby.battleResults.BattleResults(parent.parent.parent);
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        public function update(arg1:Object):void
        {
            return;
        }

        internal const FADED_ALPHA:Number=0.25;

        internal const FULL_ALPHA:Number=1;

        public var vehicleStats:net.wg.gui.lobby.battleResults.VehicleDetails;

        public var vehicleTimeStats:net.wg.gui.lobby.battleResults.VehicleDetails;

        public var creditsLbl:flash.text.TextField;

        public var creditsValuesLbl:flash.text.TextField;

        public var goldValuesLbl:flash.text.TextField;

        public var creditsPremValuesLbl:flash.text.TextField;

        public var goldPremValuesLbl:flash.text.TextField;

        public var creditsSplitLine:flash.display.MovieClip;

        public var statsTitle:flash.text.TextField;

        public var creditsTitle:flash.text.TextField;

        public var timeTitle:flash.text.TextField;

        public var xpTitle:flash.text.TextField;

        public var premLbl:flash.text.TextField;

        public var xpLbl:flash.text.TextField;

        public var xpValuesLbl:flash.text.TextField;

        public var freeXpValuesLbl:flash.text.TextField;

        public var xpPremValuesLbl:flash.text.TextField;

        public var freeXpPremValuesLbl:flash.text.TextField;

        public var xpSplitLine:flash.display.MovieClip;
    }
}
