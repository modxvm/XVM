package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UserNameField;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.MovieClip;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.data.VO.UserVO;
   import scaleform.clik.data.DataProvider;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import flash.display.InteractiveObject;


   public class TeamMemberStatsView extends UIComponent implements IFocusContainer
   {
          
      public function TeamMemberStatsView() {
         super();
      }

      public var list:ScrollingListEx;

      public var tankIcon:UILoaderAlt;

      public var playerNameLbl:UserNameField;

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

      private var _toolTip:String = null;

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

      override protected function onDispose() : void {
         this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver);
         this.vehicleStateLbl.removeEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut);
         super.onDispose();
      }

      override protected function draw() : void {
         var _loc1_:IUserProps = null;
         var _loc2_:* = false;
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
               this.playerNameLbl.userVO = new UserVO(
                  {
                     "fullName":this.data.playerFullName,
                     "userName":this.data.playerName,
                     "clanAbbrev":this.data.playerClan,
                     "region":this.data.playerRegion
                  }
               );
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
                     _loc2_ = App.utils.commons.formatPlayerName(this.vehicleStateLbl,_loc1_);
                     if(_loc2_)
                     {
                        this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver);
                        this.vehicleStateLbl.addEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut);
                        this._toolTip = _loc1_.prefix + this.data.killerFullNameStr + _loc1_.suffix;
                     }
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
               this.playerNameLbl.userVO = null;
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
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
      }

      protected function handleMouseRollOver(param1:MouseEvent) : void {
         App.toolTipMgr.show(this._toolTip);
      }

      protected function handleMouseRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      public function getComponentForFocus() : InteractiveObject {
         return this.list;
      }
   }

}