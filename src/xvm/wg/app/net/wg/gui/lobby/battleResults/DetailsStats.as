package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.utils.IUtils;
   import net.wg.utils.ICommons;
   import net.wg.utils.IClassFactory;


   public class DetailsStats extends UIComponent implements IViewStackContent
   {
          
      public function DetailsStats() {
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
      }

      public var vehicleStats:VehicleDetails;

      public var vehicleTimeStats:VehicleDetails;

      public var creditsLbl:TextField;

      public var creditsValuesLbl:TextField;

      public var goldValuesLbl:TextField;

      public var creditsPremValuesLbl:TextField;

      public var goldPremValuesLbl:TextField;

      public var creditsSplitLine:MovieClip;

      public var statsTitle:TextField;

      public var creditsTitle:TextField;

      public var timeTitle:TextField;

      public var xpTitle:TextField;

      public var premLbl:TextField;

      public var xpLbl:TextField;

      public var xpValuesLbl:TextField;

      public var freeXpValuesLbl:TextField;

      public var xpPremValuesLbl:TextField;

      public var freeXpPremValuesLbl:TextField;

      public var xpSplitLine:MovieClip;

      private const FADED_ALPHA:Number = 0.25;

      private const FULL_ALPHA:Number = 1;

      override protected function configUI() : void {
         super.configUI();
         this.statsTitle.text = BATTLE_RESULTS.DETAILS_STATS;
         this.creditsTitle.text = BATTLE_RESULTS.DETAILS_CREDITS;
         this.timeTitle.text = BATTLE_RESULTS.DETAILS_TIME;
         this.xpTitle.text = BATTLE_RESULTS.DETAILS_XP;
         this.premLbl.text = BATTLE_RESULTS.DETAILS_PREM;
         var _loc1_:Object = this.myParent.data;
         this.vehicleStats.state = VehicleDetails.STATE_NORMAL;
         this.vehicleStats.data = _loc1_.personal.statValues;
         this.vehicleTimeStats.state = VehicleDetails.STATE_TIME;
         this.vehicleTimeStats.data = _loc1_.common.timeStats;
         var _loc2_:Boolean = _loc1_.personal.isPremium;
         var _loc3_:Number = _loc2_?this.FADED_ALPHA:this.FULL_ALPHA;
         var _loc4_:Number = _loc2_?this.FULL_ALPHA:this.FADED_ALPHA;
         this.creditsValuesLbl.alpha = _loc3_;
         this.goldValuesLbl.alpha = _loc3_;
         this.xpValuesLbl.alpha = _loc3_;
         this.freeXpValuesLbl.alpha = _loc3_;
         this.premLbl.alpha = _loc4_;
         this.creditsPremValuesLbl.alpha = _loc4_;
         this.goldPremValuesLbl.alpha = _loc4_;
         this.xpPremValuesLbl.alpha = _loc4_;
         this.freeXpPremValuesLbl.alpha = _loc4_;
         this.populateCredits(_loc1_.personal.creditsData);
         this.populateXp(_loc1_.personal.xpData);
      }

      private function populateCredits(param1:Array) : void {
         var _loc4_:Object = null;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         this.creditsLbl.htmlText = "";
         this.creditsValuesLbl.htmlText = "";
         this.goldValuesLbl.htmlText = "";
         this.creditsPremValuesLbl.htmlText = "";
         this.goldPremValuesLbl.htmlText = "";
         var _loc2_:Number = 0;
         var _loc3_:Number = param1.length;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1[_loc2_];
            App.utils.commons.addBlankLines(_loc4_.label,this.creditsLbl,Vector.<TextField>([this.creditsValuesLbl,this.goldValuesLbl,this.creditsPremValuesLbl,this.goldPremValuesLbl]));
            this.creditsLbl.htmlText = this.creditsLbl.htmlText + _loc4_.label;
            this.creditsValuesLbl.htmlText = this.creditsValuesLbl.htmlText + _loc4_.col1;
            this.goldValuesLbl.htmlText = this.goldValuesLbl.htmlText + _loc4_.col2;
            this.creditsPremValuesLbl.htmlText = this.creditsPremValuesLbl.htmlText + _loc4_.col3;
            this.goldPremValuesLbl.htmlText = this.goldPremValuesLbl.htmlText + _loc4_.col4;
            if(_loc4_.lineType)
            {
               _loc5_ = this.creditsLbl.x + 3;
               _loc6_ = Math.floor(this.creditsLbl.y + this.creditsLbl.textHeight) + 3;
               addChild(App.utils.classFactory.getComponent(_loc4_.lineType,MovieClip,
                  {
                     "x":_loc5_,
                     "y":_loc6_
                  }
               ));
            }
            _loc2_++;
         }
         this.creditsSplitLine.height = this.creditsLbl.textHeight + 5;
      }

      private function populateXp(param1:Array) : void {
         var _loc4_:Object = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         this.xpLbl.htmlText = "";
         this.xpValuesLbl.htmlText = "";
         this.freeXpValuesLbl.htmlText = "";
         this.xpPremValuesLbl.htmlText = "";
         this.freeXpPremValuesLbl.htmlText = "";
         var _loc2_:Number = 0;
         var _loc3_:Number = param1.length;
         var _loc5_:IUtils = App.utils;
         var _loc6_:ICommons = _loc5_.commons;
         var _loc7_:IClassFactory = _loc5_.classFactory;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1[_loc2_];
            _loc6_.addBlankLines(_loc4_.labelStripped,this.creditsLbl,Vector.<TextField>([this.xpValuesLbl,this.freeXpValuesLbl,this.xpPremValuesLbl,this.freeXpPremValuesLbl]));
            this.xpLbl.htmlText = this.xpLbl.htmlText + _loc4_.label;
            this.xpValuesLbl.htmlText = this.xpValuesLbl.htmlText + _loc4_.col1;
            this.freeXpValuesLbl.htmlText = this.freeXpValuesLbl.htmlText + _loc4_.col2;
            this.xpPremValuesLbl.htmlText = this.xpPremValuesLbl.htmlText + _loc4_.col3;
            this.freeXpPremValuesLbl.htmlText = this.freeXpPremValuesLbl.htmlText + _loc4_.col4;
            if(_loc4_.lineType)
            {
               _loc8_ = this.xpLbl.x + 3;
               _loc9_ = Math.floor(this.xpLbl.y + this.xpLbl.textHeight) + 3;
               addChild(_loc7_.getComponent(_loc4_.lineType,MovieClip,
                  {
                     "x":_loc8_,
                     "y":_loc9_
                  }
               ));
            }
            _loc2_++;
         }
         this.xpSplitLine.height = this.xpLbl.textHeight + 5;
      }

      public function get myParent() : BattleResults {
         return BattleResults(parent.parent.parent);
      }

      override public function dispose() : void {
         super.dispose();
      }

      public function update(param1:Object) : void {
          
      }
   }

}