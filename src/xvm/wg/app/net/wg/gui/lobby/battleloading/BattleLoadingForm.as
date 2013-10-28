package net.wg.gui.lobby.battleloading
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import scaleform.clik.controls.StatusIndicator;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import net.wg.gui.components.controls.ReadOnlyScrollingList;
   import scaleform.clik.data.DataProvider;


   public class BattleLoadingForm extends UIComponent
   {
          
      public function BattleLoadingForm() {
         super();
      }

      public var mapText:TextField;

      public var battleText:TextField;

      public var winText:TextField;

      public var team1Text:TextField;

      public var team2Text:TextField;

      public var helpTip:TextField;

      public var tipText:TextField;

      public var loadingBar:StatusIndicator;

      public var battleIcon:BattleTypeIcon;

      public var team1List:ReadOnlyScrollingList;

      public var team2List:ReadOnlyScrollingList;

      private const TEAM1:String = "team1";

      private const TEAM2:String = "team2";

      override protected function configUI() : void {
         super.configUI();
      }

      public function updateProgress(param1:Number) : void {
         this.loadingBar.position = param1;
      }

      public function updateMapName(param1:String) : void {
         this.mapText.text = param1;
         this.mapText.text = this.mapText.text.toUpperCase();
      }

      public function setBattleTypeName(param1:String) : void {
         this.battleText.text = param1;
      }

      public function setBattleTypeFrameNum(param1:Number) : void {
         this.battleIcon.typeByNumber = param1;
      }

      public function setBattleTypeFrameName(param1:String) : void {
         this.battleIcon.type = param1;
      }

      public function updateWinText(param1:String) : void {
         this.winText.htmlText = param1;
         this.winText.y = 128 + (40 - this.winText.textHeight >> 1) ^ 0;
      }

      public function updateTeamsHeaders(param1:String, param2:String) : void {
         this.team1Text.text = param1;
         this.team2Text.text = param2;
      }

      public function updateTip(param1:String) : void {
         this.helpTip.text = MENU.LOADING_HELPTIP;
         this.tipText.htmlText = param1;
      }

      public function updateTeamValues(param1:Object) : void {
         var _loc4_:Object = null;
         var _loc2_:Number = param1.playerID;
         var _loc3_:Number = param1.squadID;
         var _loc5_:uint = 0;
         _loc4_ = this.normalizeData(param1.team1,_loc2_,_loc3_,this.TEAM1);
         this.team1List.dataProvider = new DataProvider(_loc4_.team);
         this.team1List.selectedIndex = _loc4_.selected;
         _loc4_ = this.normalizeData(param1.team2,_loc2_,_loc3_,this.TEAM2);
         this.team2List.dataProvider = new DataProvider(_loc4_.team);
         this.team2List.selectedIndex = _loc4_.selected;
      }

      private function normalizeData(param1:Array, param2:Number, param3:Number, param4:String) : Object {
         var _loc5_:Object = new Object();
         _loc5_.selected = -1;
         var _loc6_:uint = 0;
         while(_loc6_ < param1.length)
         {
            param1[_loc6_].position = _loc6_ + 1;
            if(param1[_loc6_].playerID == param2)
            {
               _loc5_.selected = _loc6_;
            }
            if(param3 > 0 && param1[_loc6_].squad == param3 && param4 == this.TEAM1)
            {
               param1[_loc6_].squad = param1[_loc6_].squad + 10;
            }
            param1[_loc6_].team = param4;
            _loc6_++;
         }
         _loc5_.team = param1;
         return _loc5_;
      }

      public function onDispose() : void {
         this.team1List.disposeRenderers();
         this.team2List.disposeRenderers();
      }

      override public function toString() : String {
         return "[WG BattleLoadingForm " + name + "]";
      }
   }

}