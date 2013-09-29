package net.wg.gui.lobby.store.views 
{
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.store.views.base.*;
    import scaleform.clik.data.*;
    
    public class ShellView extends net.wg.gui.lobby.store.views.base.FitsSelectableStoreMenuView
    {
        public function ShellView()
        {
            super();
            return;
        }

        public override function resetTemporaryHandlers():void
        {
            resetHandlers(getTagsArray(), null);
            return;
        }

        public override function getFilter():Array
        {
            var loc1:*=getSelectedFilters(getTagsArray(), true, null);
            loc1.push(myVehicleRadioBtn.group.data);
            loc1.push(getFilterData().current);
            return loc1;
        }

        public override function setViewData(arg1:Array):void
        {
            super.setViewData(arg1);
            var loc1:*=Number(arg1.shift());
            var loc2:*=arg1.splice(0, loc1);
            var loc3:*=String(arg1.shift());
            selectFilterSimple(getFitsArray(), loc3, true);
            setCurrentVehicle(arg1.shift());
            updateSubFilter(getNation());
            selectFilter(getTagsArray(), loc2, true, false);
            dispatchViewChange();
            return;
        }

        protected override function onTagsArrayRequest():Array
        {
            return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("ARMOR_PIERCING", this.armorPiercingChkBox), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("ARMOR_PIERCING_CR", this.armorPiercingCRChkBox), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("HOLLOW_CHARGE", this.hollowChargeChkBox), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("HIGH_EXPLOSIVE", this.highExplosiveChkBox)];
        }

        protected override function onFitsArrayRequest():Array
        {
            return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("myVehicleGun", myVehicleRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("myInventoryGuns", this.myInventoryGunsRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("myVehiclesInventoryGuns", this.myVehiclesInventoryGunsRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("otherGuns", this.otherGunsRadioBtn)];
        }

        protected override function getTagsName():String
        {
            return "kinds";
        }

        protected override function onVehicleFilterUpdated(arg1:scaleform.clik.data.DataProvider, arg2:Number, arg3:int):void
        {
            super.onVehicleFilterUpdated(arg1, arg2, arg3);
            if (arg1.length != 0) 
            {
                getFilterData().current = arg1[arg2].data;
                this.myInventoryGunsRadioBtn.enabled = true;
                this.myVehiclesInventoryGunsRadioBtn.enabled = true;
            }
            else 
            {
                this.otherGunsRadioBtn.selected = true;
                this.myInventoryGunsRadioBtn.enabled = false;
                this.myVehiclesInventoryGunsRadioBtn.enabled = false;
            }
            return;
        }

        public var armorPiercingChkBox:net.wg.gui.components.controls.CheckBox=null;

        public var armorPiercingCRChkBox:net.wg.gui.components.controls.CheckBox=null;

        public var hollowChargeChkBox:net.wg.gui.components.controls.CheckBox=null;

        public var highExplosiveChkBox:net.wg.gui.components.controls.CheckBox=null;

        public var myVehiclesInventoryGunsRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var myInventoryGunsRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var otherGunsRadioBtn:net.wg.gui.components.controls.RadioButton=null;
    }
}
