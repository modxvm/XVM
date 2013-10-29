package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;


   public class CyberSportUnitMeta extends CyberSportBaseViewMeta
   {
          
      public function CyberSportUnitMeta() {
         super();
      }

      public var assignSlotRequest:Function = null;

      public var leaveSlotRequest:Function = null;

      public var toggleFreezeRequest:Function = null;

      public var toggleStatusRequest:Function = null;

      public var inviteFriendRequest:Function = null;

      public var chooseVehicleRequest:Function = null;

      public var showSettingsRoster:Function = null;

      public var resultRosterSlotsSettings:Function = null;

      public var cancelRosterSlotsSettings:Function = null;

      public var toggleReadyStateRequest:Function = null;

      public var onSlotsHighlihgtingNeed:Function = null;

      public var lockSlotRequest:Function = null;

      public var ignoreUserRequest:Function = null;

      public var editDescriptionRequest:Function = null;

      public var showFAQWindow:Function = null;

      public function assignSlotRequestS(param1:int, param2:Number) : void {
         App.utils.asserter.assertNotNull(this.assignSlotRequest,"assignSlotRequest" + Errors.CANT_NULL);
         this.assignSlotRequest(param1,param2);
      }

      public function leaveSlotRequestS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.leaveSlotRequest,"leaveSlotRequest" + Errors.CANT_NULL);
         this.leaveSlotRequest(param1);
      }

      public function toggleFreezeRequestS() : void {
         App.utils.asserter.assertNotNull(this.toggleFreezeRequest,"toggleFreezeRequest" + Errors.CANT_NULL);
         this.toggleFreezeRequest();
      }

      public function toggleStatusRequestS() : void {
         App.utils.asserter.assertNotNull(this.toggleStatusRequest,"toggleStatusRequest" + Errors.CANT_NULL);
         this.toggleStatusRequest();
      }

      public function inviteFriendRequestS() : void {
         App.utils.asserter.assertNotNull(this.inviteFriendRequest,"inviteFriendRequest" + Errors.CANT_NULL);
         this.inviteFriendRequest();
      }

      public function chooseVehicleRequestS() : void {
         App.utils.asserter.assertNotNull(this.chooseVehicleRequest,"chooseVehicleRequest" + Errors.CANT_NULL);
         this.chooseVehicleRequest();
      }

      public function showSettingsRosterS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.showSettingsRoster,"showSettingsRoster" + Errors.CANT_NULL);
         this.showSettingsRoster(param1);
      }

      public function resultRosterSlotsSettingsS(param1:Array) : void {
         App.utils.asserter.assertNotNull(this.resultRosterSlotsSettings,"resultRosterSlotsSettings" + Errors.CANT_NULL);
         this.resultRosterSlotsSettings(param1);
      }

      public function cancelRosterSlotsSettingsS() : void {
         App.utils.asserter.assertNotNull(this.cancelRosterSlotsSettings,"cancelRosterSlotsSettings" + Errors.CANT_NULL);
         this.cancelRosterSlotsSettings();
      }

      public function toggleReadyStateRequestS() : void {
         App.utils.asserter.assertNotNull(this.toggleReadyStateRequest,"toggleReadyStateRequest" + Errors.CANT_NULL);
         this.toggleReadyStateRequest();
      }

      public function onSlotsHighlihgtingNeedS(param1:Number) : Array {
         App.utils.asserter.assertNotNull(this.onSlotsHighlihgtingNeed,"onSlotsHighlihgtingNeed" + Errors.CANT_NULL);
         return this.onSlotsHighlihgtingNeed(param1);
      }

      public function lockSlotRequestS(param1:int) : void {
         App.utils.asserter.assertNotNull(this.lockSlotRequest,"lockSlotRequest" + Errors.CANT_NULL);
         this.lockSlotRequest(param1);
      }

      public function ignoreUserRequestS(param1:int) : void {
         App.utils.asserter.assertNotNull(this.ignoreUserRequest,"ignoreUserRequest" + Errors.CANT_NULL);
         this.ignoreUserRequest(param1);
      }

      public function editDescriptionRequestS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.editDescriptionRequest,"editDescriptionRequest" + Errors.CANT_NULL);
         this.editDescriptionRequest(param1);
      }

      public function showFAQWindowS() : void {
         App.utils.asserter.assertNotNull(this.showFAQWindow,"showFAQWindow" + Errors.CANT_NULL);
         this.showFAQWindow();
      }
   }

}