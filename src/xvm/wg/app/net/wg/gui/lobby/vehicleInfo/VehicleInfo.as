package net.wg.gui.lobby.vehicleInfo 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class VehicleInfo extends net.wg.infrastructure.base.meta.impl.VehicleInfoMeta implements net.wg.infrastructure.base.meta.IVehicleInfoMeta
    {
        public function VehicleInfo()
        {
            super();
            isModal = false;
            canResize = false;
            canMinimize = false;
            isCentered = false;
            showWindowBg = false;
            return;
        }

        public function as_setVehicleInfo(arg1:Object):void
        {
            var loc1:*=arg1.vehicleName;
            this.window.title = loc1;
            this.moduleName.text = loc1;
            this.descriptionField.text = arg1.vehicleDiscription;
            this.vehicleIcon.image = arg1.vehicleImage;
            this.vehicleIcon.level = arg1.vehicleLevel;
            this.vehicleIcon.nation = arg1.vehicleNation;
            this.vehicleIcon.isElite = arg1.vehicleElite;
            this.vehicleIcon.tankType = arg1.vehicleType;
            this.VehicleInfoPropsData = arg1.VehicleInfoPropsData;
            this.VehicleInfoBaseData = arg1.VehicleInfoBaseData;
            this.VehicleInfoCrewData = arg1.VehicleInfoCrewData;
            this.initUI();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            if (this.tabs.selectedIndex == -1 && this.uiInited) 
            {
                this.tabs.selectedIndex = 0;
            }
            super.draw();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            getVehicleInfoS();
            var loc1:*=new scaleform.clik.utils.Padding(window.formBgPadding.top, window.formBgPadding.right, window.formBgPadding.bottom + 1, window.formBgPadding.left);
            window.contentPadding = loc1;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.view.removeEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdate);
            this.closeBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.tabs.dispose();
            this.tabs = null;
            this.view.dispose();
            this.view = null;
            return;
        }

        internal function initUI():void
        {
            this.view.addEventListener(net.wg.gui.events.ViewStackEvent.NEED_UPDATE, this.onViewNeedUpdate);
            this.tabs.dataProvider = new scaleform.clik.data.DataProvider([{"label":MENU.VEHICLEINFO_TABS_PROPERTIES, "linkage":"VehicleInfoProps"}, {"label":MENU.VEHICLEINFO_TABS_BASE, "linkage":"VehicleInfoBase"}, {"label":MENU.VEHICLEINFO_TABS_CREW, "linkage":"VehicleInfoCrew"}]);
            App.utils.focusHandler.setFocus(this.closeBtn);
            this.closeBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.uiInited = true;
            invalidate();
            return;
        }

        internal function onViewNeedUpdate(arg1:net.wg.gui.events.ViewStackEvent):void
        {
            var loc1:*=arg1.view;
            var loc2:*=arg1.linkage;
            loc1.update(this[loc2 + "Data"]);
            return;
        }

        internal function onClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onCancelClickS();
            return;
        }

        public var vehicleIcon:net.wg.gui.components.advanced.TankIcon;

        public var moduleName:flash.text.TextField;

        public var descriptionField:net.wg.gui.components.advanced.TextAreaSimple;

        public var descriptionScrollBar:net.wg.gui.components.controls.ScrollBar;

        public var tabs:net.wg.gui.components.advanced.ButtonBarEx;

        public var tabsUnderline:flash.display.Sprite;

        public var view:net.wg.gui.components.advanced.ViewStack;

        public var closeBtn:net.wg.gui.components.controls.SoundButtonEx;

        internal var VehicleInfoPropsData:Object=null;

        internal var VehicleInfoBaseData:Object=null;

        internal var VehicleInfoCrewData:Object=null;

        internal var uiInited:Boolean=false;
    }
}
