package net.wg.gui.lobby.recruitWindow 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class RecruitWindow extends net.wg.infrastructure.base.meta.impl.RecruitWindowMeta implements net.wg.infrastructure.base.meta.IRecruitWindowMeta
    {
        public function RecruitWindow()
        {
            super();
            isModal = false;
            canResize = false;
            canMinimize = false;
            isCentered = true;
            return;
        }

        public function as_setVehicleTypeDropdown(arg1:Array):void
        {
            var loc1:*=null;
            this.vehicleTypeDropdown.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.vehicleTypeDropdown.selectedIndex = 0;
            if (this.vehicleTypeDropdown.selectedIndex == 0) 
                this.roleDropdown.selectedIndex = 0;
            this.roleDropdown.enabled = !(this.vehicleTypeDropdown.selectedIndex == 0);
            if (!this.data.menuEnabled) 
            {
                var loc2:*=0;
                var loc3:*=this.vehicleTypeDropdown.dataProvider;
                for (loc1 in loc3) 
                {
                    if (this.vehicleTypeDropdown.dataProvider[loc1].id != this.data.data.typeID) 
                        continue;
                    this.vehicleTypeDropdown.selectedIndex = Number(loc1);
                    break;
                }
                this.vehicleTypeDropdown.enabled = false;
            }
            return;
        }

        public function as_setRoleDropdown(arg1:Array):void
        {
            var loc1:*=null;
            this.roleDropdown.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.roleDropdown.selectedIndex = 0;
            if (!this.menuEnabled) 
            {
                var loc2:*=0;
                var loc3:*=this.roleDropdown.dataProvider;
                for (loc1 in loc3) 
                {
                    if (this.roleDropdown.dataProvider[loc1].id != this.data.data.roleType) 
                        continue;
                    this.roleDropdown.selectedIndex = Number(loc1);
                    break;
                }
                this.roleDropdown.enabled = false;
            }
            return;
        }

        public function as_setCreditsChanged(arg1:Number):void
        {
            this.btnScool.enabled = arg1 > this.data.schoolUpgrade;
            return;
        }

        public function as_setGoldChanged(arg1:Number):void
        {
            this.btnAcademy.enabled = arg1 > this.data.academyUpgrade;
            return;
        }

        internal function setDefaultSelection():void
        {
            var loc1:*=App.utils.focusHandler;
            if (this.nationDropdown.enabled && this.nationDropdown.visible) 
                loc1.setFocus(this.nationDropdown);
            else if (this.vehicleClassDropdown.enabled && this.vehicleClassDropdown.visible) 
                loc1.setFocus(this.vehicleClassDropdown);
            else if (this.vehicleTypeDropdown.enabled && this.vehicleTypeDropdown.visible) 
                loc1.setFocus(this.vehicleTypeDropdown);
            else if (this.roleDropdown.enabled && this.roleDropdown.visible) 
                loc1.setFocus(this.roleDropdown);
            else 
                loc1.setFocus(this.btnCourses);
            return;
        }

        public function onButtonStudyTypeClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=arg1.target;
            switch (loc1) 
            {
                case this.btnAcademy:
                    this.studyType = 2;
                    break;
                case this.btnScool:
                    this.studyType = 1;
                    break;
                case this.btnCourses:
                    this.studyType = 0;
                    break;
                default:
                    this.studyType = 0;
            }
            return;
        }

        public function onButtonStudyTypeDoubleClick(arg1:flash.events.MouseEvent):void
        {
            (arg1.target as flash.events.IEventDispatcher).dispatchEvent(new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.CLICK));
            this.onRecruitTankman(arg1);
            return;
        }

        internal function onChangeNation(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
            this.vehicleClassDropdown.enabled = !(isNaN(loc1) || !this.menuEnabled);
            var loc2:*;
            this.btnCourses.nation = loc2 = loc1;
            this.btnScool.nation = loc2 = loc2;
            this.btnAcademy.nation = loc2;
            this.updateVehicleClassDropdownS(loc1);
            return;
        }

        internal function onChangeVehicleClass(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
            var loc2:*=this.vehicleClassDropdown.dataProvider[this.vehicleClassDropdown.selectedIndex].id;
            this.vehicleTypeDropdown.enabled = !(!this.vehicleClassDropdown.enabled || loc2 == null || !loc2);
            if (!this.vehicleClassDropdown.enabled || loc2 == null || !loc2) 
                this.vehicleTypeDropdown.selectedIndex = 0;
            this.updateVehicleTypeDropdownS(loc1, loc2);
            return;
        }

        internal function onChangeVehicleType(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
            var loc2:*=this.vehicleClassDropdown.dataProvider[this.vehicleClassDropdown.selectedIndex].id;
            var loc3:*=this.vehicleTypeDropdown.dataProvider[this.vehicleTypeDropdown.selectedIndex].id;
            this.roleDropdown.enabled = !(!this.vehicleTypeDropdown.enabled || isNaN(loc3));
            if (!this.vehicleTypeDropdown.enabled || isNaN(loc3) || !loc3) 
                this.roleDropdown.selectedIndex = 0;
            this.updateRoleDropdownS(loc1, loc2, loc3);
            return;
        }

        internal function onClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        internal function onRecruitTankman(arg1:flash.events.Event):void
        {
            var loc1:*=this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
            var loc2:*=this.vehicleTypeDropdown.dataProvider[this.vehicleTypeDropdown.selectedIndex].id;
            var loc3:*=this.roleDropdown.dataProvider[this.roleDropdown.selectedIndex].id;
            var loc4:*=this.data.data ? this.data.data.slot : -1;
            if (!isNaN(loc1) && !isNaN(loc2) && !isNaN(loc4) && loc3) 
                buyTankmanS(loc1, loc2, loc3, this.studyType, loc4);
            return;
        }

        internal function recruitButtonCheck(arg1:scaleform.clik.events.ListEvent):void
        {
            this.btnRecruit.enabled = !(this.nationDropdown.selectedIndex == 0 || this.vehicleClassDropdown.selectedIndex == 0 || this.vehicleTypeDropdown.selectedIndex == 0 || this.roleDropdown.selectedIndex == 0);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.btnGroup = new scaleform.clik.controls.ButtonGroup("group1", this);
            this.btnGroup.addButton(this.btnAcademy);
            this.btnGroup.addButton(this.btnScool);
            this.btnGroup.addButton(this.btnCourses);
            this.btnAcademy.doubleClickEnabled = true;
            this.btnAcademy.allowDeselect = false;
            this.btnAcademy.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonStudyTypeClick);
            this.btnAcademy.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onButtonStudyTypeDoubleClick);
            this.btnScool.doubleClickEnabled = true;
            this.btnScool.allowDeselect = false;
            this.btnScool.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonStudyTypeClick);
            this.btnScool.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onButtonStudyTypeDoubleClick);
            this.btnCourses.doubleClickEnabled = true;
            this.btnCourses.allowDeselect = false;
            this.btnCourses.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonStudyTypeClick);
            this.btnCourses.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onButtonStudyTypeDoubleClick);
            this.btnCourses.selected = true;
            this.btnCancel.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.btnRecruit.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onRecruitTankman);
            this.nationDropdown.dataProvider = new scaleform.clik.data.DataProvider([{"label":MENU.NATIONS_ALL, "data":null}]);
            this.vehicleClassDropdown.dataProvider = new scaleform.clik.data.DataProvider([{"label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW, "data":null}]);
            this.vehicleTypeDropdown.dataProvider = new scaleform.clik.data.DataProvider([{"label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW, "data":null}]);
            this.roleDropdown.dataProvider = new scaleform.clik.data.DataProvider([{"label":DIALOGS.RECRUITWINDOW_MENUEMPTYROW, "data":null}]);
            this.nationDropdown.selectedIndex = 0;
            this.vehicleClassDropdown.selectedIndex = 0;
            this.vehicleTypeDropdown.selectedIndex = 0;
            this.roleDropdown.selectedIndex = 0;
            this.nationDropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.recruitButtonCheck);
            this.vehicleClassDropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.recruitButtonCheck);
            this.vehicleTypeDropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.recruitButtonCheck);
            this.roleDropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.recruitButtonCheck);
            this.setDefaultSelection();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.data) 
            {
                this.nationDropdown.validateNow();
                this.vehicleClassDropdown.validateNow();
                this.vehicleTypeDropdown.validateNow();
                this.roleDropdown.validateNow();
                this.btnAcademy.price = String(this.data.academyUpgrade);
                if (this.data.gold < this.data.academyUpgrade) 
                    this.btnAcademy.enabled = false;
                this.btnScool.price = String(this.data.schoolUpgrade);
                if (this.data.credits < this.data.schoolUpgrade) 
                    this.btnScool.enabled = false;
                if (this.menuEnabled) 
                {
                    this.nationDropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChangeNation);
                    this.vehicleClassDropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChangeVehicleClass);
                    this.vehicleTypeDropdown.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChangeVehicleType);
                    updateNationDropdownS();
                    this.btnRecruit.enabled = false;
                }
                else 
                {
                    this.btnAcademy.nation = this.data.data.nationID;
                    this.btnScool.nation = this.data.data.nationID;
                    this.btnCourses.nation = this.data.data.nationID;
                    this.btnAcademy.validateNow();
                    this.btnCourses.validateNow();
                    this.btnScool.validateNow();
                    updateAllDropdownsS(this.data.data.nationID, this.data.data.tankType, this.data.data.typeID, this.data.data.roleType);
                }
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            this.window.title = DIALOGS.RECRUITWINDOW_TITLE;
            return;
        }

        protected override function preInitialize():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.btnAcademy.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonStudyTypeClick);
            this.btnAcademy.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onButtonStudyTypeDoubleClick);
            this.btnScool.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonStudyTypeClick);
            this.btnScool.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onButtonStudyTypeDoubleClick);
            this.btnCourses.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonStudyTypeClick);
            this.btnCourses.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onButtonStudyTypeDoubleClick);
            this.nationDropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.recruitButtonCheck);
            this.vehicleClassDropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.recruitButtonCheck);
            this.vehicleTypeDropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.recruitButtonCheck);
            this.roleDropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.recruitButtonCheck);
            if (this.vehicleTypeDropdown.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                this.vehicleTypeDropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChangeVehicleType);
            if (this.vehicleClassDropdown.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                this.vehicleClassDropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChangeVehicleClass);
            if (this.nationDropdown.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                this.nationDropdown.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChangeNation);
            this.btnCancel.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            this.btnRecruit.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onRecruitTankman);
            return;
        }

        public function as_setAllDropdowns(arg1:Array, arg2:Array, arg3:Array, arg4:Array):void
        {
            this.as_setNations(arg1);
            this.as_setVehicleClassDropdown(arg2);
            this.as_setVehicleTypeDropdown(arg3);
            this.as_setRoleDropdown(arg4);
            return;
        }

        public function as_initData(arg1:Object):void
        {
            this.data = arg1;
            this.menuEnabled = arg1.menuEnabled;
            invalidateData();
            return;
        }

        public function as_setNations(arg1:Array):void
        {
            var loc1:*=null;
            this.nationDropdown.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.nationDropdown.selectedIndex = 0;
            if (this.menuEnabled) 
            {
                this.vehicleClassDropdown.enabled = false;
                this.vehicleTypeDropdown.enabled = false;
                this.roleDropdown.enabled = false;
            }
            else 
            {
                this.nationDropdown.enabled = false;
                var loc2:*=0;
                var loc3:*=this.nationDropdown.dataProvider;
                for (loc1 in loc3) 
                {
                    if (this.nationDropdown.dataProvider[loc1].id != this.data.data.nationID) 
                        continue;
                    this.nationDropdown.selectedIndex = Number(loc1);
                    break;
                }
                App.utils.focusHandler.setFocus(this.btnRecruit);
            }
            return;
        }

        public function as_setVehicleClassDropdown(arg1:Array):void
        {
            var loc1:*=null;
            this.vehicleClassDropdown.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.vehicleClassDropdown.selectedIndex = 0;
            if (this.vehicleClassDropdown.selectedIndex == 0) 
            {
                this.vehicleTypeDropdown.selectedIndex = 0;
                this.roleDropdown.selectedIndex = 0;
            }
            this.vehicleTypeDropdown.enabled = !(this.vehicleClassDropdown.selectedIndex == 0);
            this.roleDropdown.enabled = !(this.vehicleClassDropdown.selectedIndex == 0);
            if (!this.menuEnabled) 
            {
                var loc2:*=0;
                var loc3:*=this.vehicleClassDropdown.dataProvider;
                for (loc1 in loc3) 
                {
                    if (this.vehicleClassDropdown.dataProvider[loc1].id != this.data.data.tankType) 
                        continue;
                    this.vehicleClassDropdown.selectedIndex = Number(loc1);
                    break;
                }
                this.vehicleClassDropdown.enabled = false;
            }
            return;
        }

        public var nationDropdown:net.wg.gui.components.controls.DropdownMenu;

        public var roleDropdown:net.wg.gui.components.controls.DropdownMenu;

        public var vehicleClassDropdown:net.wg.gui.components.controls.DropdownMenu;

        public var vehicleTypeDropdown:net.wg.gui.components.controls.DropdownMenu;

        public var btnRecruit:net.wg.gui.components.controls.SoundButtonEx;

        public var btnCancel:net.wg.gui.components.controls.SoundButtonEx;

        public var btnAcademy:net.wg.gui.components.controls.TankmanTrainingButton;

        public var btnScool:net.wg.gui.components.controls.TankmanTrainingButton;

        public var btnCourses:net.wg.gui.components.controls.TankmanTrainingButton;

        protected var btnGroup:scaleform.clik.controls.ButtonGroup;

        internal var data:Object;

        internal var studyType:Number=0;

        internal var menuEnabled:Boolean=false;
    }
}
