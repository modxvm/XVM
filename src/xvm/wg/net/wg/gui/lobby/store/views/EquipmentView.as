package net.wg.gui.lobby.store.views 
{
    import net.wg.gui.lobby.store.views.base.*;
    import scaleform.clik.data.*;
    
    public class EquipmentView extends net.wg.gui.lobby.store.views.base.SimpleStoreMenuView
    {
        public function EquipmentView()
        {
            super();
            return;
        }

        public override function resetTemporaryHandlers():void
        {
            resetHandlers(getTagsArray(), myVehicleRadioBtn);
            return;
        }

        protected override function specialKindForTags():String
        {
            return "optionalDevice";
        }

        public override function setViewData(arg1:Array):void
        {
            super.setViewData(arg1);
            var loc1:*=String(arg1.shift());
            selectFilterSimple(getFitsArray(), loc1, true);
            setCurrentVehicle(arg1.shift());
            updateSubFilter(getNation());
            selectFilter(getTagsArray(), arg1, true, false);
            dispatchViewChange();
            return;
        }

        public override function getFilter():Array
        {
            var loc1:*=[myVehicleRadioBtn.group.data];
            loc1.push(getFilterData().current);
            loc1 = loc1.concat(getSelectedFilters(getTagsArray(), false, null));
            return loc1;
        }

        protected override function onVehicleFilterUpdated(arg1:scaleform.clik.data.DataProvider, arg2:Number, arg3:int):void
        {
            super.onVehicleFilterUpdated(arg1, arg2, arg3);
            if (arg1.length != 0) 
            {
                getFilterData().current = arg1[arg2].data;
                fitsSelectDropDn.enabled = true;
                myVehiclesRadioBtn.enabled = true;
            }
            else 
            {
                otherVehiclesRadioBtn.selected = true;
                myVehiclesRadioBtn.enabled = false;
            }
            otherVehiclesRadioBtn.enabled = arg3 == -1;
            return;
        }
    }
}
