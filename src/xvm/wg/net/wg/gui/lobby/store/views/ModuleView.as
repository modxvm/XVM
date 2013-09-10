package net.wg.gui.lobby.store.views 
{
    import net.wg.data.constants.generated.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.store.views.base.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;
    
    public class ModuleView extends net.wg.gui.lobby.store.views.base.SimpleStoreMenuView
    {
        public function ModuleView()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.inHangarChkBx.enableDynamicFrameUpdating();
            this.lockedChkBx.enableDynamicFrameUpdating();
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            super.dispose();
            if (this._kindsArr != null) 
            {
                var loc2:*=0;
                var loc3:*=this._kindsArr;
                for each (loc1 in loc3) 
                    loc1.dispose();
                this._kindsArr.splice(0, this._kindsArr.length);
                this._kindsArr = null;
            }
            return;
        }

        public override function resetTemporaryHandlers():void
        {
            resetHandlers(this.getKindsArray(), null);
            resetHandlers(getTagsArray(), null);
            return;
        }

        public override function setViewData(arg1:Array):void
        {
            var loc1:*=NaN;
            var loc2:*=null;
            var loc3:*=null;
            super.setViewData(arg1);
            if (App.instance) 
            {
                loc1 = Number(arg1.shift());
                loc2 = arg1.splice(0, loc1);
                selectFilter(this.getKindsArray(), loc2, true, false);
                loc3 = String(arg1.shift());
                selectFilterSimple(getFitsArray(), loc3, true);
                setCurrentVehicle(arg1.shift());
                updateSubFilter(getNation());
                selectFilter(getTagsArray(), arg1, true, false);
                this.dispatchViewChange();
            }
            return;
        }

        public override function getFilter():Array
        {
            var loc2:*=null;
            var loc1:*=getSelectedFilters(this.getKindsArray(), true, null);
            loc1.push(myVehicleRadioBtn.group.data);
            if (App.instance) 
            {
                loc2 = App.utils.asserter;
                loc2.assertNotNull(getFilterData(), "filter data in \'" + fittingType + "\' view must be initialized before getting!");
                loc2.assert(!(getFilterData().current == "0"), "invalid value in filter data!");
            }
            loc1.push(getFilterData().current);
            loc1 = loc1.concat(getSelectedFilters(getTagsArray(), true, null));
            return loc1;
        }

        protected override function onKindChanged():void
        {
            initializeControlsByHash(fittingType, this.getKindsArray(), "kindsMap", "types");
            super.onKindChanged();
            return;
        }

        protected override function onTagsArrayRequest():Array
        {
            if (getUIName() == net.wg.data.constants.generated.STORE_TYPES.SHOP) 
                return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("locked", this.lockedChkBx), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("onVehicle", onVehicleChkBx), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("inHangar", this.inHangarChkBx)];
            return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("onVehicle", onVehicleChkBx)];
        }

        protected override function onVehicleFilterUpdated(arg1:scaleform.clik.data.DataProvider, arg2:Number, arg3:int):void
        {
            super.onVehicleFilterUpdated(arg1, arg2, arg3);
            if (arg1.length != 0) 
            {
                getFilterData().current = arg1[arg2].data;
                myVehiclesRadioBtn.enabled = true;
            }
            else 
            {
                otherVehiclesRadioBtn.selected = true;
                myVehiclesRadioBtn.enabled = false;
            }
            return;
        }

        internal function getKindsArray():Array
        {
            if (this._kindsArr == null) 
                this._kindsArr = [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("vehicleGun", this.vehicleGunChkBx), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("vehicleTurret", this.vehicleTurretChkBx), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("vehicleEngine", this.vehicleEngineChkBx), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("vehicleChassis", this.vehicleChassisChkBx), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("vehicleRadio", this.vehicleRadioChkBx)];
            return this._kindsArr;
        }

        public var vehicleGunChkBx:net.wg.gui.components.controls.CheckBox=null;

        public var vehicleTurretChkBx:net.wg.gui.components.controls.CheckBox=null;

        public var vehicleEngineChkBx:net.wg.gui.components.controls.CheckBox=null;

        public var vehicleChassisChkBx:net.wg.gui.components.controls.CheckBox=null;

        public var vehicleRadioChkBx:net.wg.gui.components.controls.CheckBox=null;

        public var lockedChkBx:net.wg.gui.components.controls.CheckBox=null;

        public var inHangarChkBx:net.wg.gui.components.controls.CheckBox=null;

        internal var _kindsArr:Array=null;
    }
}
