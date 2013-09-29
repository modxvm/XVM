package net.wg.gui.lobby.store.views.base 
{
    import net.wg.gui.components.controls.*;
    
    public class SimpleStoreMenuView extends net.wg.gui.lobby.store.views.base.FitsSelectableStoreMenuView
    {
        public function SimpleStoreMenuView()
        {
            super();
            return;
        }

        protected override function onTagsArrayRequest():Array
        {
            return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("onVehicle", this.onVehicleChkBx)];
        }

        protected override function onFitsArrayRequest():Array
        {
            return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("myVehicle", myVehicleRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("myVehicles", this.myVehiclesRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("otherVehicles", this.otherVehiclesRadioBtn)];
        }

        protected override function getTagsName():String
        {
            return "extra";
        }

        public var myVehiclesRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var otherVehiclesRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var onVehicleChkBx:net.wg.gui.components.controls.CheckBox=null;
    }
}
