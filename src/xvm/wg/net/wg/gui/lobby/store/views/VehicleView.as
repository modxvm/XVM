package net.wg.gui.lobby.store.views 
{
    import net.wg.data.VO.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.store.views.base.*;
    
    public class VehicleView extends net.wg.gui.lobby.store.views.base.BaseStoreMenuView
    {
        public function VehicleView()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.inHangarChkBx.enableDynamicFrameUpdating();
            this.brockenChckBx.enableDynamicFrameUpdating();
            return;
        }

        public override function resetTemporaryHandlers():void
        {
            resetHandlers(getFitsArray(), this.allRadioBtn);
            return;
        }

        protected override function onTagsArrayRequest():Array
        {
            return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("lightTank", this.lightTankRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("mediumTank", this.mediumTankRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("heavyTank", this.heavyTankRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("at-spg", this.at_spgRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("spg", this.spgRadioBtn), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("all", this.allRadioBtn)];
        }

        protected override function onFitsArrayRequest():Array
        {
            if (getUIName() == net.wg.data.constants.generated.STORE_TYPES.SHOP) 
                return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("locked", this.lockedChkBx), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("inHangar", this.inHangarChkBx)];
            return [new net.wg.gui.lobby.store.views.base.ViewUIElementVO("locked", this.lockedChkBx), new net.wg.gui.lobby.store.views.base.ViewUIElementVO("brocken", this.brockenChckBx)];
        }

        protected override function getFitsName():String
        {
            return "extra";
        }

        public override function setViewData(arg1:Array):void
        {
            var loc1:*=Number(arg1.shift());
            var loc2:*=arg1.splice(0, loc1);
            if (loc2.length > 4) 
            {
                this.allRadioBtn.selected = true;
                addHandlerToGroup(this.allRadioBtn);
            }
            else 
                selectFilter(getTagsArray(), loc2, false, true);
            selectFilter(getFitsArray(), arg1, true, false);
            return;
        }

        public override function getFilter():Array
        {
            var loc1:*=getSelectedFilters(getTagsArray(), true, this.allRadioBtn);
            loc1 = loc1.concat(getSelectedFilters(getFitsArray(), false, null));
            return loc1;
        }

        public override function setSubFilterData(arg1:int, arg2:net.wg.data.VO.ShopSubFilterData):void
        {
            return;
        }

        public override function updateSubFilter(arg1:int):void
        {
            return;
        }

        public var allRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var lightTankRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var mediumTankRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var heavyTankRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var at_spgRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var spgRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var lockedChkBx:net.wg.gui.components.controls.CheckBox=null;

        public var inHangarChkBx:net.wg.gui.components.controls.CheckBox=null;

        public var brockenChckBx:net.wg.gui.components.controls.CheckBox=null;
    }
}
