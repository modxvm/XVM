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

      function onSlotsHighlihgtingNeedS() : Array;

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
   }

}