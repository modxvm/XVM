package net.wg.gui.cyberSport.views.unit
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.MovieClip;
   import net.wg.gui.cyberSport.controls.GrayButtonText;
   import net.wg.gui.cyberSport.controls.CSCandidatesScrollingList;
   import net.wg.gui.cyberSport.vo.UnitVO;
   import net.wg.gui.cyberSport.data.CandidatesDataProvider;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.ListEventEx;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.cyberSport.vo.UnitCandidateVO;
   import scaleform.gfx.MouseEventEx;
   import net.wg.gui.cyberSport.helpers.CSPlayerCIGenerator;
   import net.wg.gui.utils.ComplexTooltipHelper;


   public class WaitListSection extends UIComponent
   {
          
      public function WaitListSection() {
         this.candidatesDP = new CandidatesDataProvider();
         super();
      }

      private static const COMMANDER_STATE:Object;

      private static const CANDIDATE_STATE:Object;

      public var lblCandidatesHeader:TextField;

      public var btnInviteFriend:SoundButtonEx;

      public var candidatesListBg:MovieClip;

      public var lblTeamAvailability:TextField;

      public var btnCloseRoom:GrayButtonText;

      public var candidates:CSCandidatesScrollingList = null;

      private var _unitData:UnitVO;

      private var candidatesDP:CandidatesDataProvider;

      override public function dispose() : void {
         this.btnCloseRoom.removeEventListener(ButtonEvent.CLICK,this.onChangeStateClick);
         this.btnInviteFriend.removeEventListener(ButtonEvent.CLICK,this.onInviteFriendClick);
         this.candidates.removeEventListener(ListEventEx.ITEM_CLICK,this.onListItemClick);
         this.lblTeamAvailability.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.lblTeamAvailability.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.btnCloseRoom.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.btnCloseRoom.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.btnInviteFriend.dispose();
         this.candidates.dispose();
         this.candidatesDP = null;
         if(this._unitData)
         {
            this._unitData.dispose();
            this._unitData = null;
         }
         super.dispose();
      }

      public function updateUnitStatus(param1:Boolean, param2:String) : void {
         this._unitData.statusLbl = param2;
         this._unitData.statusValue = param1;
         this.upateUnitCloseButton();
      }

      public function get unitData() : UnitVO {
         return this._unitData;
      }

      public function set unitData(param1:UnitVO) : void {
         this._unitData = param1;
         invalidateData();
      }

      public function getCandidatesDP() : CandidatesDataProvider {
         return this.candidatesDP;
      }

      override protected function configUI() : void {
         super.configUI();
         if(this.candidates != null)
         {
            this.candidates.dataProvider = this.candidatesDP;
         }
         this.lblCandidatesHeader.text = CYBERSPORT.WINDOW_UNIT_CANDIDATES;
         this.lblTeamAvailability.text = Values.EMPTY_STR;
         this.btnCloseRoom.addEventListener(ButtonEvent.CLICK,this.onChangeStateClick);
         this.btnInviteFriend.addEventListener(ButtonEvent.CLICK,this.onInviteFriendClick);
         this.candidates.addEventListener(ListEventEx.ITEM_CLICK,this.onListItemClick);
         this.lblTeamAvailability.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.lblTeamAvailability.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
         this.btnCloseRoom.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.btnCloseRoom.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         var _loc2_:Padding = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._unitData?this._unitData.isCommander:false;
            this.btnInviteFriend.visible = this.btnCloseRoom.visible = this.candidatesListBg.visible = this.lblTeamAvailability.visible = _loc1_;
            if(_loc1_)
            {
               this.upateUnitCloseButton();
            }
            if(this._unitData)
            {
               _loc2_ = this.candidates.padding;
               if(_loc1_)
               {
                  _loc2_.top = COMMANDER_STATE.paddingTop;
                  this.candidates.height = COMMANDER_STATE.height;
               }
               else
               {
                  _loc2_.top = CANDIDATE_STATE.paddingTop;
                  this.candidates.height = CANDIDATE_STATE.height;
               }
            }
         }
      }

      private function upateUnitCloseButton() : void {
         this.lblTeamAvailability.htmlText = this._unitData?this._unitData.statusLbl:Values.EMPTY_STR;
         this.btnCloseRoom.label = (this._unitData) && (this._unitData.statusValue)?CYBERSPORT.WINDOW_UNIT_CLOSEROOM:CYBERSPORT.WINDOW_UNIT_OPENROOM;
      }

      public function enableCloseButton(param1:Boolean) : void {
         if(this.btnCloseRoom)
         {
            this.btnCloseRoom.enabled = param1;
         }
      }

      private function dispatchCSCmpntEvent(param1:String) : void {
         dispatchEvent(new CSComponentEvent(param1));
      }

      private function onChangeStateClick(param1:ButtonEvent) : void {
         this.dispatchCSCmpntEvent(CSComponentEvent.TOGGLE_STATUS_REQUEST);
      }

      private function onInviteFriendClick(param1:ButtonEvent) : void {
         this.dispatchCSCmpntEvent(CSComponentEvent.INVITE_FRIEND_REQUEST);
      }

      private function onListItemClick(param1:ListEventEx) : void {
         var _loc2_:UnitCandidateVO = param1.itemData as UnitCandidateVO;
         if((param1.buttonIdx == MouseEventEx.RIGHT_BUTTON) && (_loc2_) && !_loc2_.isSelf)
         {
            App.contextMenuMgr.showUserContextMenu(this,_loc2_,new CSPlayerCIGenerator(this._unitData.isCommander));
         }
      }

      private function onControlRollOver(param1:MouseEvent) : void {
         var _loc2_:String = TOOLTIPS.CYBERSPORT_UNIT_ACCESS_HEADER;
         var _loc3_:String = (this._unitData) && !this._unitData.statusValue?TOOLTIPS.CYBERSPORT_UNIT_ACCESS_BODYCLOSED:TOOLTIPS.CYBERSPORT_UNIT_ACCESS_BODYOPEN;
         this.showTooltip(_loc2_,_loc3_);
      }

      private function onControlRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function showTooltip(param1:String, param2:String) : void {
         var _loc3_:String = new ComplexTooltipHelper().addHeader(param1,true).addBody(param2,true).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }
   }

}