package net.wg.gui.cyberSport.views.unit
{
   import scaleform.clik.core.UIComponent;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.controls.GrayButtonText;
   import flash.display.MovieClip;
   import net.wg.gui.cyberSport.vo.UnitShortVO;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.cyberSport.vo.UnitCandidateVO;
   import __AS3__.vec.Vector;
   import net.wg.gui.cyberSport.vo.UnitSlotVO;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;


   public class JoinUnitSection extends UIComponent
   {
          
      public function JoinUnitSection() {
         super();
         this.initSlots();
      }

      public var noUnitScreen:Sprite;

      public var headerTF:TextField;

      public var descriptionTF:TextField;

      public var teamInfoTF:TextField;

      public var vehiclesInfoTF:TextField;

      public var joinInfoTF:TextField;

      public var joinButton:GrayButtonText;

      public var freezeIcon:MovieClip;

      public var restrictionIcon:MovieClip;

      public var slot0:SimpleSlotRenderer;

      public var slot1:SimpleSlotRenderer;

      public var slot2:SimpleSlotRenderer;

      public var slot3:SimpleSlotRenderer;

      public var slot4:SimpleSlotRenderer;

      public var slot5:SimpleSlotRenderer;

      public var slot6:SimpleSlotRenderer;

      protected var model:UnitShortVO;

      private var slots:Array;

      private function initSlots() : void {
         this.slots = [this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6];
      }

      public function setData(param1:UnitShortVO) : void {
         this.model = param1;
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.noUnitScreen.visible = false;
         this.headerTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_SELECTEDTEAM;
         this.descriptionTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_TEAMDESCRIPTION;
         this.teamInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_TEAM;
         this.vehiclesInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_VEHICLES;
         this.joinInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_ENTERTEXT;
         this.joinButton.addEventListener(ButtonEvent.CLICK,this.onJoinClick);
         this.joinButton.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.joinButton.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.freezeIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.freezeIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.restrictionIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.restrictionIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.headerTF.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.headerTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
      }

      override protected function draw() : void {
         var _loc1_:UnitCandidateVO = null;
         var _loc2_:Vector.<UnitSlotVO> = null;
         var _loc3_:SimpleSlotRenderer = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if((this.model) && (this.model.isAvailable()))
            {
               _loc1_ = this.model.commander;
               if(_loc1_)
               {
                  App.utils.commons.formatPlayerName(this.headerTF,App.utils.commons.getUserProps(App.utils.locale.makeString(CYBERSPORT.WINDOW_UNITLISTVIEW_SELECTEDTEAM) + " " + _loc1_.userName,_loc1_.clanAbbrev,_loc1_.region));
               }
               else
               {
                  this.headerTF.text = "";
               }
               this.descriptionTF.text = this.model.description;
               this.freezeIcon.visible = this.model.isFreezed;
               this.restrictionIcon.visible = this.model.hasRestrictions;
               _loc2_ = this.model.slots;
               for each (_loc3_ in this.slots)
               {
                  _loc3_.slotData = _loc2_[this.slots.indexOf(_loc3_)];
               }
               this.noUnitScreen.visible = false;
            }
            else
            {
               this.noUnitScreen.visible = true;
            }
         }
      }

      private function onControlRollOver(param1:MouseEvent) : void {
         switch(param1.currentTarget)
         {
            case this.freezeIcon:
               App.toolTipMgr.showComplex(TOOLTIPS.SETTINGSICON_FREEZED);
               break;
            case this.restrictionIcon:
               App.toolTipMgr.showComplex(TOOLTIPS.SETTINGSICON_CONDITIONS);
               break;
            case this.joinButton:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNITLIST_JOIN);
               break;
            case this.headerTF:
               App.toolTipMgr.show(App.utils.locale.makeString(CYBERSPORT.WINDOW_UNITLISTVIEW_SELECTEDTEAM) + " " + this.model.commander.getToolTip());
               break;
         }
      }

      private function onControlRollOut(param1:MouseEvent=null) : void {
         App.toolTipMgr.hide();
      }

      private function onJoinClick(param1:ButtonEvent) : void {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.JOIN_UNIT_REQUEST));
      }

      override protected function onDispose() : void {
         var _loc1_:SimpleSlotRenderer = null;
         this.joinButton.removeEventListener(ButtonEvent.CLICK,this.onJoinClick);
         this.joinButton.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.joinButton.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.freezeIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.freezeIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.headerTF.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.headerTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         for each (_loc1_ in this.slots)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.joinButton.dispose();
         this.joinButton = null;
         this.model = null;
         super.onDispose();
      }
   }

}