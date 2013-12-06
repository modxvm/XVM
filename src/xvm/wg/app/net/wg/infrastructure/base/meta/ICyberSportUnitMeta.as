package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ICyberSportUnitMeta extends IEventDispatcher
   {
          
      function assignSlotRequestS(param1:int, param2:Number) : void;

      function leaveSlotRequestS(param1:Number) : void;

      function toggleFreezeRequestS() : void;

      function toggleStatusRequestS() : void;

      function inviteFriendRequestS() : void;

      function chooseVehicleRequestS() : void;

      function showSettingsRosterS(param1:Object) : void;

      function resultRosterSlotsSettingsS(param1:Array) : void;

      function cancelRosterSlotsSettingsS() : void;

      function toggleReadyStateRequestS() : void;

      function onSlotsHighlihgtingNeedS(param1:Number) : Array;

      function lockSlotRequestS(param1:int) : void;

      function ignoreUserRequestS(param1:int) : void;

      function editDescriptionRequestS(param1:String) : void;

      function showFAQWindowS() : void;

      function as_updateUnit(param1:Object) : void;

      function as_setActionButtonState(param1:Object) : void;

      function as_highlightSlots(param1:Array) : void;

      function as_updateSlotSettings(param1:Array) : void;

      function as_setChangeStateCoolDown(param1:Number) : void;

      function as_setCoolDownForReadyButton(param1:Number) : void;

      function as_setComment(param1:String) : void;

      function as_closeSlot(param1:uint, param2:uint, param3:String) : void;

      function as_openSlot(param1:uint, param2:Boolean, param3:String, param4:uint) : void;

      function as_lockUnit(param1:Boolean, param2:Array) : void;

      function as_setOpened(param1:Boolean, param2:String) : void;

      function as_setMembers(param1:Boolean, param2:Array) : void;

      function as_setMemberStatus(param1:uint, param2:uint) : void;

      function as_setMemberOffline(param1:uint, param2:Boolean) : void;

      function as_setMemberVehicle(param1:uint, param2:uint, param3:Object) : void;

      function as_setTotalLabel(param1:Boolean, param2:String) : void;

      function as_getCandidatesDP() : Object;
   }

}