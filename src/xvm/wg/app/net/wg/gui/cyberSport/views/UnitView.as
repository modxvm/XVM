package net.wg.gui.cyberSport.views
{
   import net.wg.infrastructure.base.meta.impl.CyberSportUnitMeta;
   import net.wg.infrastructure.base.meta.ICyberSportUnitMeta;
   import net.wg.infrastructure.base.meta.ICyberSportBaseViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
   import net.wg.gui.cyberSport.views.unit.WaitListSection;
   import net.wg.gui.cyberSport.views.unit.TeamSection;
   import net.wg.gui.cyberSport.views.unit.ChatSection;
   import __AS3__.vec.Vector;
   import scaleform.clik.motion.Tween;
   import net.wg.gui.cyberSport.vo.UnitVO;
   import net.wg.gui.cyberSport.vo.ActionButtonVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.gui.cyberSport.vo.VehicleVO;
   import net.wg.gui.cyberSport.CSInvalidationType;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.cyberSport.helpers.CSDragDropListDelegateController;
   import flash.display.InteractiveObject;
   import fl.transitions.easing.Strong;


   public class UnitView extends CyberSportUnitMeta implements ICyberSportUnitMeta, ICyberSportBaseViewMeta, IViewStackContent, IChannelComponentHolder
   {
          
      public function UnitView() {
         this.tweens = new Vector.<Tween>();
         super();
      }

      private static const ANIMATION_DELAY:uint = 700;

      public var waitingListSection:WaitListSection;

      public var teamSection:TeamSection;

      public var chatSection:ChatSection;

      public var rosterTeamSection:RosterSettingsView;

      private var tweens:Vector.<Tween>;

      private var _unitData:UnitVO;

      private var _actionButtonData:ActionButtonVO;

      private var _pyAlias:String;

      private var _dragDropListDelegateCtrlr:IDisposable = null;

      public function preInitFadeAnimationCancel() : void {
         this.initFadeAnimation();
         cancelRosterSlotsSettingsS();
      }

      public function update(param1:Object) : void {
          
      }

      public function as_setMembers(param1:Boolean, param2:Array) : void {
         if(this._unitData)
         {
            this.teamSection.updateMembers(param1,param2);
         }
      }

      public function as_setMemberStatus(param1:uint, param2:uint) : void {
         if(this._unitData)
         {
            this.teamSection.setMemberStatus(param1,param2);
         }
      }

      public function as_setMemberOffline(param1:uint, param2:Boolean) : void {
         if(this._unitData)
         {
            this.teamSection.setOfflineStatus(param1,param2);
         }
      }

      public function as_setMemberVehicle(param1:uint, param2:uint, param3:Object) : void {
         if(this._unitData)
         {
            this.teamSection.setMemberVehicle(param1,param2,param3?new VehicleVO(param3):null);
         }
      }

      public function as_setComment(param1:String) : void {
         if(this._unitData)
         {
            this._unitData.description = param1;
            invalidate(CSInvalidationType.UPDATE_COMMENTS);
         }
      }

      public function as_setOpened(param1:Boolean, param2:String) : void {
         if(this._unitData)
         {
            this.waitingListSection.updateUnitStatus(param1,param2);
         }
      }

      public function as_setTotalLabel(param1:Boolean, param2:String) : void {
         if(this._unitData)
         {
            this.teamSection.updateTotalLabel(param1,param2);
         }
      }

      public function as_closeSlot(param1:uint, param2:uint, param3:String) : void {
         if(this._unitData)
         {
            this.teamSection.closeSlot(param1,false,param2,param3,true,-1);
         }
      }

      public function as_openSlot(param1:uint, param2:Boolean, param3:String, param4:uint) : void {
         if(this._unitData)
         {
            this.teamSection.closeSlot(param1,param2,0,param3,false,param4);
         }
      }

      public function as_lockUnit(param1:Boolean, param2:Array) : void {
         if(this._unitData)
         {
            this.teamSection.updateLockedUnit(param1,param2);
         }
      }

      public function as_setChangeStateCoolDown(param1:Number) : void {
         this.mainCoolDownHandler(false);
         App.utils.scheduler.scheduleTask(this.mainCoolDownHandler,param1 * 1000,true);
      }

      public function as_setCoolDownForReadyButton(param1:Number) : void {
         this.readyButtonCoolDown(false);
         App.utils.scheduler.scheduleTask(this.readyButtonCoolDown,param1 * 1000,true);
      }

      public function as_getCandidatesDP() : Object {
         return this.waitingListSection.getCandidatesDP();
      }

      public function as_setPyAlias(param1:String) : void {
         this._pyAlias = param1;
      }

      public function as_getPyAlias() : String {
         return this._pyAlias;
      }

      public function as_updateUnit(param1:Object) : void {
         if(param1)
         {
            this._unitData = new UnitVO(param1);
            this.teamSection.unitData = this._unitData;
            invalidate(CSInvalidationType.UNIT_DATA);
         }
      }

      public function as_setActionButtonState(param1:Object) : void {
         if(param1)
         {
            this._actionButtonData = new ActionButtonVO(param1);
            invalidate(CSInvalidationType.ACTION_BUTTON_DATA);
         }
      }

      public function as_highlightSlots(param1:Array) : void {
         this.teamSection.highlightSlots(param1);
      }

      public function getChannelComponent() : ChannelComponent {
         return this.chatSection.unitChannelComponent;
      }

      public function as_updateSlotSettings(param1:Array) : void {
         this.rosterTeamSection.setSelectedSettings = param1;
      }

      override protected function configUI() : void {
         super.configUI();
         this.rosterTeamSection.alpha = 0;
         this.rosterTeamSectionMouseEnabled = false;
         addEventListener(CSComponentEvent.ASSIGN_SLOT_REQUEST,this.onAssignPlaceRequest);
         addEventListener(CSComponentEvent.LEAVE_SLOT_REQUEST,this.onRemoveRequest);
         addEventListener(CSComponentEvent.CHOOSE_VEHICLE,this.onChooseVehicleRequest);
         addEventListener(CSComponentEvent.TOGGLE_FREEZE_REQUEST,this.onToggleFreezeRequest);
         addEventListener(CSComponentEvent.TOGGLE_STATUS_REQUEST,this.onToggleStatusRequest);
         addEventListener(CSComponentEvent.INVITE_FRIEND_REQUEST,this.onInviteFriendRequest);
         addEventListener(CSComponentEvent.CLICK_CONFIGURE_BUTTON,this.onConfigureClick);
         addEventListener(CSComponentEvent.SHOW_SETTINGS_ROSTER_WND,this.showSettingsRosterWndHandler);
         addEventListener(CSComponentEvent.APPLY_ROSTER_SETTINGS,this.applyRosterSettings);
         addEventListener(CSComponentEvent.CANCEL_ROSTER_SETTINGS,this.cancelRosterSettings);
         addEventListener(CSComponentEvent.TOGGLE_READY_STATE_REQUEST,this.onToggleReadyStateRequest);
         addEventListener(CSComponentEvent.LOCK_SLOT_REQUEST,this.onLockSlotRequest);
         addEventListener(CSComponentEvent.IGNORE_USER_REQUEST,this.onIgnoreUserRequest);
         addEventListener(CSComponentEvent.EDIT_UNIT_DESCRIPTION,this.onEditUnitDescription);
         addEventListener(CSComponentEvent.SHOW_FAQ_WINDOW,this.onShowFAQWindowRequest);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(CSInvalidationType.UNIT_DATA)) && (this._unitData))
         {
            this.waitingListSection.unitData = this._unitData;
            this.chatSection.unitData = this._unitData;
            if(this._unitData)
            {
               this.initializeDragDropSystem();
            }
         }
         if((isInvalid(CSInvalidationType.UPDATE_COMMENTS)) && (this._unitData))
         {
            this.chatSection.setDescription(this._unitData.description);
         }
         if(isInvalid(CSInvalidationType.ACTION_BUTTON_DATA))
         {
            this.teamSection.actionButtonData = this._actionButtonData;
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
      }

      override protected function onDispose() : void {
         removeEventListener(CSComponentEvent.ASSIGN_SLOT_REQUEST,this.onAssignPlaceRequest);
         removeEventListener(CSComponentEvent.LEAVE_SLOT_REQUEST,this.onRemoveRequest);
         removeEventListener(CSComponentEvent.CHOOSE_VEHICLE,this.onChooseVehicleRequest);
         removeEventListener(CSComponentEvent.TOGGLE_FREEZE_REQUEST,this.onToggleFreezeRequest);
         removeEventListener(CSComponentEvent.TOGGLE_STATUS_REQUEST,this.onToggleStatusRequest);
         removeEventListener(CSComponentEvent.INVITE_FRIEND_REQUEST,this.onInviteFriendRequest);
         removeEventListener(CSComponentEvent.CLICK_CONFIGURE_BUTTON,this.onConfigureClick);
         removeEventListener(CSComponentEvent.SHOW_SETTINGS_ROSTER_WND,this.showSettingsRosterWndHandler);
         removeEventListener(CSComponentEvent.APPLY_ROSTER_SETTINGS,this.applyRosterSettings);
         removeEventListener(CSComponentEvent.CANCEL_ROSTER_SETTINGS,this.cancelRosterSettings);
         removeEventListener(CSComponentEvent.TOGGLE_READY_STATE_REQUEST,this.onToggleReadyStateRequest);
         removeEventListener(CSComponentEvent.LOCK_SLOT_REQUEST,this.onLockSlotRequest);
         removeEventListener(CSComponentEvent.IGNORE_USER_REQUEST,this.onIgnoreUserRequest);
         removeEventListener(CSComponentEvent.EDIT_UNIT_DESCRIPTION,this.onEditUnitDescription);
         removeEventListener(CSComponentEvent.SHOW_FAQ_WINDOW,this.onShowFAQWindowRequest);
         App.utils.scheduler.cancelTask(this.readyButtonCoolDown);
         App.utils.scheduler.cancelTask(this.mainCoolDownHandler);
         this.waitingListSection.dispose();
         this.waitingListSection = null;
         this.teamSection.dispose();
         this.teamSection = null;
         this.chatSection.dispose();
         this.chatSection = null;
         this.rosterTeamSection.dispose();
         this.rosterTeamSection = null;
         if(this._dragDropListDelegateCtrlr)
         {
            this._dragDropListDelegateCtrlr.dispose();
            this._dragDropListDelegateCtrlr = null;
         }
         super.onDispose();
      }

      private function initializeDragDropSystem() : void {
         var _loc1_:Class = null;
         var _loc2_:Array = null;
         if(this._dragDropListDelegateCtrlr == null && (this._unitData.isCommander))
         {
            _loc1_ = App.utils.classFactory.getClass(Linkages.CS_DRAG_DROP_DELEGATE);
            _loc2_ = [this.waitingListSection.candidates,this.teamSection];
            this._dragDropListDelegateCtrlr = new CSDragDropListDelegateController(Vector.<InteractiveObject>(_loc2_),_loc1_,Linkages.CANDIDATE_LIST_ITEM_RENDERER_UI,onSlotsHighlihgtingNeedS,assignSlotRequestS,leaveSlotRequestS);
         }
      }

      private function initFadeAnimation() : void {
         if(this.rosterTeamSection.alpha == 0)
         {
            this.fadeIn();
         }
         else
         {
            this.fadeOut();
         }
      }

      public var rosterTeamContext:Boolean = false;

      private function fadeIn() : void {
         if(this._unitData.slots)
         {
            this.rosterTeamSection.setData(this._unitData.slots);
         }
         this.rosterTeamSection.animationIn();
         this.rosterTeamSectionMouseEnabled = true;
         this.playAnimation({"alpha":0});
      }

      private function fadeOut() : void {
         this.rosterTeamSection.animationOut();
         this.rosterTeamSectionMouseEnabled = false;
         this.playAnimation({"alpha":1});
      }

      private function set rosterTeamSectionMouseEnabled(param1:Boolean) : void {
         this.rosterTeamSection.mouseEnabled = param1;
         this.rosterTeamSection.mouseChildren = param1;
         this.teamSection.mouseEnabled = !param1;
         this.teamSection.mouseChildren = !param1;
         this.waitingListSection.mouseEnabled = !param1;
         this.waitingListSection.mouseChildren = !param1;
         this.chatSection.mouseEnabled = !param1;
         this.chatSection.mouseChildren = !param1;
         this.rosterTeamContext = param1;
      }

      private function playAnimation(param1:Object) : void {
         this.cleanTweens();
         this.tweens = Vector.<Tween>([new Tween(ANIMATION_DELAY,this.waitingListSection,param1,
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(ANIMATION_DELAY,this.teamSection,param1,
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         ),new Tween(ANIMATION_DELAY,this.chatSection,param1,
            {
               "paused":false,
               "ease":Strong.easeOut,
               "onComplete":null
            }
         )]);
      }

      private function cleanTweens() : void {
         var _loc1_:Tween = null;
         if(this.tweens)
         {
            for each (_loc1_ in this.tweens)
            {
               _loc1_.paused = true;
               _loc1_ = null;
            }
         }
      }

      private function onConfigureClick(param1:CSComponentEvent) : void {
         this.initFadeAnimation();
      }

      private function onAssignPlaceRequest(param1:CSComponentEvent) : void {
         assignSlotRequestS(param1.data,-1);
      }

      private function onRemoveRequest(param1:CSComponentEvent) : void {
         leaveSlotRequestS(param1.data);
      }

      private function onChooseVehicleRequest(param1:CSComponentEvent) : void {
         if(!this.rosterTeamContext)
         {
            chooseVehicleRequestS();
         }
      }

      private function onToggleFreezeRequest(param1:CSComponentEvent) : void {
         toggleFreezeRequestS();
      }

      private function onToggleStatusRequest(param1:CSComponentEvent) : void {
         toggleStatusRequestS();
      }

      private function onInviteFriendRequest(param1:CSComponentEvent) : void {
         inviteFriendRequestS();
      }

      private function onToggleReadyStateRequest(param1:CSComponentEvent) : void {
         toggleReadyStateRequestS();
      }

      private function applyRosterSettings(param1:CSComponentEvent) : void {
         resultRosterSlotsSettingsS(this.rosterTeamSection.getSettingsResults());
         this.initFadeAnimation();
      }

      private function cancelRosterSettings(param1:CSComponentEvent) : void {
         this.preInitFadeAnimationCancel();
      }

      private function showSettingsRosterWndHandler(param1:CSComponentEvent) : void {
         if(this.rosterTeamContext)
         {
            showSettingsRosterS(param1.data);
         }
      }

      private function onLockSlotRequest(param1:CSComponentEvent) : void {
         lockSlotRequestS(param1.data);
      }

      private function onIgnoreUserRequest(param1:CSComponentEvent) : void {
         ignoreUserRequestS(param1.data);
      }

      private function onEditUnitDescription(param1:CSComponentEvent) : void {
         editDescriptionRequestS(param1.data);
      }

      private function onShowFAQWindowRequest(param1:CSComponentEvent) : void {
         showFAQWindowS();
      }

      private function readyButtonCoolDown(param1:Boolean) : void {
         this.teamSection.enableFightButton(param1);
      }

      private function mainCoolDownHandler(param1:Boolean) : void {
         this.waitingListSection.enableCloseButton(param1);
         this.teamSection.enableFreezeButton(param1);
         this.chatSection.enableEditCommitButton(param1);
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
   }

}