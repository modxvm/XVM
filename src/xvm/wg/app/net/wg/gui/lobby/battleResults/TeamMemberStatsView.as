package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.MovieClip;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.infrastructure.interfaces.IUserProps;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.Errors;


   public class TeamMemberStatsView extends UIComponent
   {
          
      public function TeamMemberStatsView() {
         super();
      }

      public var list:ScrollingListEx;

      public var tankIcon:UILoaderAlt;

      public var playerName:TextField;

      public var vehicleName:TextField;

      public var vehicleStateLbl:TextField;

      public var vehicleStats:VehicleDetails;

      public var closeBtn:SoundButtonEx;

      public var myArea:MovieClip;

      public var deadBg:MovieClip;

      public var medalBg:MovieClip;

      public var achievements:MedalsList;

      private const STATS_DY:Number = 48;

      private var initialStatsY:Number = 0;

      private var initialCloseBtnY:Number = 0;

      private var _data:Object;

      private var _dataDirty:Boolean;

      public function get data() : Object {
         return this._data;
      }

      public function set data(param1:Object) : void {
         this._data = param1;
         this._dataDirty = true;
         invalidate();
      }

      override protected function configUI() : void {
         super.configUI();
         this.initialStatsY = this.vehicleStats.y;
         this.initialCloseBtnY = this.closeBtn.y;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseClick);
      }

      override protected function draw() : void {
         var _loc1_:IUserProps = null;
         super.draw();
         if(this._dataDirty)
         {
            this.vehicleStats.state = VehicleDetails.STATE_WIDE;
            this.vehicleStats.y = this.initialStatsY;
            this.closeBtn.y = this.initialCloseBtnY;
            this.achievements.visible = false;
            if(this.data)
            {
               this.tankIcon.source = this.data.bigTankIcon;
               App.utils.commons.formatPlayerName(this.playerName,App.utils.commons.getUserProps(this.data.playerName,this.data.playerClan,this.data.playerRegion));
               this.vehicleName.text = this.data.vehicleFullName;
               this.vehicleStateLbl.text = this.data.vehicleStateStr;
               if((this.data.isPrematureLeave) || this.data.killerID <= 0)
               {
                  this.vehicleStateLbl.text = this.data.vehicleStateStr;
               }
               else
               {
                  if(this.data.killerID > 0)
                  {
                     _loc1_ = App.utils.commons.getUserProps(this.data.killerNameStr,this.data.killerClanNameStr,this.data.killerRegionNameStr);
                     _loc1_.prefix = this.data.vehicleStatePrefixStr;
                     _loc1_.suffix = this.data.vehicleStateSuffixStr;
                     App.utils.commons.formatPlayerName(this.vehicleStateLbl,_loc1_);
                  }
               }
               this.vehicleStats.data = this.data.statValues;
               this.deadBg.visible = this.data.killerID > 0;
               this.medalBg.visible = this.data.medalsCount > 0;
               if(this.data.medalsCount > 0)
               {
                  this.vehicleStats.y = this.vehicleStats.y + this.STATS_DY;
                  this.closeBtn.y = this.initialCloseBtnY;
                  this.achievements.visible = true;
                  this.achievements.dataProvider = new DataProvider(this.data.achievements);
                  this.achievements.validateNow();
               }
            }
            else
            {
               this.tankIcon.source = "";
               this.playerName.text = "";
               this.vehicleName.text = "";
               this.vehicleStateLbl.text = "";
               this.vehicleStats.data = [];
               this.deadBg.visible = false;
               this.medalBg.visible = false;
            }
            this._dataDirty = false;
         }
      }

      private function onCloseClick(param1:ButtonEvent) : void {
         TeamStats(this.parent).changeIndexOnFocus = false;
         this.list.selectedIndex = -1;
         DebugUtils.LOG_WARNING(Errors.INVALID_FOCUS_USING);
         App.utils.focusHandler.setFocus(this.list);
      }
   }

}