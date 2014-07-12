package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.BaseRallyView;
    import net.wg.data.constants.Errors;
    
    public class BaseRallyRoomViewMeta extends BaseRallyView
    {
        
        public function BaseRallyRoomViewMeta() {
            super();
        }
        
        public var assignSlotRequest:Function = null;
        
        public var leaveSlotRequest:Function = null;
        
        public var onSlotsHighlihgtingNeed:Function = null;
        
        public var chooseVehicleRequest:Function = null;
        
        public var inviteFriendRequest:Function = null;
        
        public var toggleReadyStateRequest:Function = null;
        
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
        
        public function onSlotsHighlihgtingNeedS(param1:Number) : Array {
            App.utils.asserter.assertNotNull(this.onSlotsHighlihgtingNeed,"onSlotsHighlihgtingNeed" + Errors.CANT_NULL);
            return this.onSlotsHighlihgtingNeed(param1);
        }
        
        public function chooseVehicleRequestS() : void {
            App.utils.asserter.assertNotNull(this.chooseVehicleRequest,"chooseVehicleRequest" + Errors.CANT_NULL);
            this.chooseVehicleRequest();
        }
        
        public function inviteFriendRequestS() : void {
            App.utils.asserter.assertNotNull(this.inviteFriendRequest,"inviteFriendRequest" + Errors.CANT_NULL);
            this.inviteFriendRequest();
        }
        
        public function toggleReadyStateRequestS() : void {
            App.utils.asserter.assertNotNull(this.toggleReadyStateRequest,"toggleReadyStateRequest" + Errors.CANT_NULL);
            this.toggleReadyStateRequest();
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
