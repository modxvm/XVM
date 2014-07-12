package net.wg.gui.lobby.store.views.base
{
    import net.wg.gui.components.controls.RadioButton;
    import net.wg.gui.components.controls.CheckBox;
    import flash.text.TextField;
    
    public class SimpleStoreMenuView extends FitsSelectableStoreMenuView
    {
        
        public function SimpleStoreMenuView() {
            super();
        }
        
        public var myVehiclesRadioBtn:RadioButton = null;
        
        public var otherVehiclesRadioBtn:RadioButton = null;
        
        public var onVehicleChkBx:CheckBox = null;
        
        public var vehChBxHeader:TextField;
        
        override protected function onTagsArrayRequest() : Array {
            return [new ViewUIElementVO("onVehicle",this.onVehicleChkBx)];
        }
        
        override protected function onFitsArrayRequest() : Array {
            return [new ViewUIElementVO("myVehicle",myVehicleRadioBtn),new ViewUIElementVO("myVehicles",this.myVehiclesRadioBtn),new ViewUIElementVO("otherVehicles",this.otherVehiclesRadioBtn)];
        }
        
        override protected function getTagsName() : String {
            return "extra";
        }
    }
}
