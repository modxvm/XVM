package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.rally.views.room.BaseRallyRoomView;
   import net.wg.data.constants.Errors;
   
   public class CyberSportUnitMeta extends BaseRallyRoomView
   {
      
      public function CyberSportUnitMeta() {
         super();
      }
      
      public var toggleFreezeRequest:Function = null;
      
      public var toggleStatusRequest:Function = null;
      
      public var showSettingsRoster:Function = null;
      
      public var resultRosterSlotsSettings:Function = null;
      
      public var cancelRosterSlotsSettings:Function = null;
      
      public var lockSlotRequest:Function = null;
      
      public function toggleFreezeRequestS() : void {
         App.utils.asserter.assertNotNull(this.toggleFreezeRequest,"toggleFreezeRequest" + Errors.CANT_NULL);
         this.toggleFreezeRequest();
      }
      
      public function toggleStatusRequestS() : void {
         App.utils.asserter.assertNotNull(this.toggleStatusRequest,"toggleStatusRequest" + Errors.CANT_NULL);
         this.toggleStatusRequest();
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
      
      public function lockSlotRequestS(param1:int) : void {
         App.utils.asserter.assertNotNull(this.lockSlotRequest,"lockSlotRequest" + Errors.CANT_NULL);
         this.lockSlotRequest(param1);
      }
   }
}
