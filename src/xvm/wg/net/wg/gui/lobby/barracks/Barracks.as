package net.wg.gui.lobby.barracks 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.exceptions.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class Barracks extends net.wg.infrastructure.base.meta.impl.BarracksMeta implements net.wg.infrastructure.base.meta.IBarracksMeta
    {
        public function Barracks()
        {
            super();
            return;
        }

        public override function setViewSize(arg1:Number, arg2:Number):void
        {
            this.myWidth = arg1;
            this.myHeight = arg2;
            invalidateSize();
            return;
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            closeBarracksS();
            return;
        }

        public function as_setTankmen(arg1:Number, arg2:Number, arg3:Number, arg4:String, arg5:Number, arg6:Array):void
        {
            this.tankmenCountTF.text = MENU.BARRACKS_TANKMENCOUNT;
            this.tankmenCountTF.replaceText(this.tankmenCountTF.text.indexOf("{"), this.tankmenCountTF.text.indexOf("}") + 1, String(arg6.length));
            this.tankmenCountTF.replaceText(this.tankmenCountTF.text.indexOf("{"), this.tankmenCountTF.text.indexOf("}") + 1, String(arg1));
            var loc1:*=arg3;
            while (loc1 < arg2) 
            {
                arg6.push({"empty":true});
                ++loc1;
            }
            arg6.push({"buy":true, "price":arg4, "count":arg5});
            this.tankmenTileList.dataProvider = new scaleform.clik.data.DataProvider(arg6);
            this.tankmenTileList.validateNow();
            this.tankmenTileList.selectedIndex = -1;
            this.placesCountTF.text = MENU.BARRACKS_PLACESCOUNT;
            this.placesCountTF.replaceText(this.placesCountTF.text.indexOf("{"), this.placesCountTF.text.indexOf("}") + 1, String(Math.max(arg2 - arg3, 0)));
            this.placesCountTF.replaceText(this.placesCountTF.text.indexOf("{"), this.placesCountTF.text.indexOf("}") + 1, String(arg2));
            return;
        }

        public function as_updateTanksList(arg1:Array):void
        {
            this.tank.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.tank.selectedIndex = 0;
            if (arg1.length > 0) 
                this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
            else 
                this.locationButtonBar.dataProvider[0].data = "";
            this.tank.validateNow();
            this.tank.enabled = arg1.length > 0;
            return;
        }

        public function as_setTankmenFilter(arg1:Number, arg2:String, arg3:String, arg4:String, arg5:String):void
        {
            this._nation = arg1;
            this._role = arg2;
            this._tankType = arg3;
            this._location = arg4;
            this._nationID = arg5;
            invalidate(INVALIDATE_TANKMEN_FILTRER);
            return;
        }

        protected override function onPopulate():void
        {
            this.nationDDM.dataProvider = new scaleform.clik.data.DataProvider([{"label":MENU.NATIONS_ALL, "data":-1}].concat(App.utils.nations.getNationsData()));
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.roleTF.text = MENU.BARRACKS_MENU_ROLEFILTER_TEXTFIELD;
            this.roleButtonBar.dataProvider = new scaleform.clik.data.DataProvider([{"label":MENU.BARRACKS_MENU_ROLEFILTER_ALL, "data":net.wg.data.constants.RolesState.ALL}, {"label":MENU.BARRACKS_MENU_ROLEFILTER_COMMANDER, "data":net.wg.data.constants.RolesState.COMANDER}, {"label":MENU.BARRACKS_MENU_ROLEFILTER_GUNNER, "data":net.wg.data.constants.RolesState.GUNNER}, {"label":MENU.BARRACKS_MENU_ROLEFILTER_LOADER, "data":net.wg.data.constants.RolesState.LOADER}, {"label":MENU.BARRACKS_MENU_ROLEFILTER_DRIVER, "data":net.wg.data.constants.RolesState.DRIVER}, {"label":MENU.BARRACKS_MENU_ROLEFILTER_RADIOMAN, "data":net.wg.data.constants.RolesState.RADIOMAN}]);
            this.tankTypeTF.text = MENU.BARRACKS_MENU_TANKTYPEFILTER_TEXTFIELD;
            this.tankTypeButtonBar.dataProvider = new scaleform.clik.data.DataProvider([{"label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_ALL, "data":net.wg.data.constants.VehicleTypes.ALL}, {"label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_LIGHTTANK, "data":net.wg.data.constants.VehicleTypes.LIGHT_TANK}, {"label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_MEDIUMTANK, "data":net.wg.data.constants.VehicleTypes.MEDIUM_TANK}, {"label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_HEAVYTANK, "data":net.wg.data.constants.VehicleTypes.HEAVY_TANK}, {"label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_AT_SPG, "data":net.wg.data.constants.VehicleTypes.AT_SPG}, {"label":DIALOGS.RECRUITWINDOW_VEHICLECLASSDROPDOWN_SPG, "data":net.wg.data.constants.VehicleTypes.SPG}]);
            this.locationTF.text = MENU.BARRACKS_MENU_LOCATIONFILTER_TEXTFIELD;
            this.locationButtonBar.dataProvider = new scaleform.clik.data.DataProvider([{"label":"", "data":""}, {"label":MENU.BARRACKS_MENU_LOCATIONFILTER_TANKS, "data":LOCATIONFILTER_TANKS}, {"label":MENU.BARRACKS_MENU_LOCATIONFILTER_BARRACKS, "data":LOCATIONFILTER_BARRACKS}, {"label":MENU.BARRACKS_MENU_LOCATIONFILTER_ALL, "data":LOCATIONFILTER_ALL}]);
            this.tankmenTileList.addEventListener(scaleform.clik.events.ListEvent.ITEM_ROLL_OVER, showTooltip);
            this.tankmenTileList.addEventListener(scaleform.clik.events.ListEvent.ITEM_ROLL_OUT, hideTooltip);
            this.tankmenTileList.addEventListener(scaleform.clik.events.ListEvent.ITEM_PRESS, hideTooltip);
            this.tankmenTileList.addEventListener(net.wg.gui.events.CrewEvent.SHOW_RECRUIT_WINDOW, this.onShowRecruitWindow);
            this.tankmenTileList.addEventListener(net.wg.gui.events.CrewEvent.UNLOAD_TANKMAN, this.onUnloadTankman);
            this.tankmenTileList.addEventListener(net.wg.gui.events.CrewEvent.DISMISS_TANKMAN, this.showDismissDialog);
            this.tankmenTileList.addEventListener(net.wg.gui.events.CrewEvent.SHOW_BERTH_BUY_DIALOG, this.onBuyBerth);
            this.tankmenTileList.addEventListener(net.wg.gui.events.CrewEvent.OPEN_PERSONAL_CASE, this.openPersonalCaseHandler);
            this.closeButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onBarracksClose);
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            return;
        }

        protected override function onDispose():void
        {
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            App.toolTipMgr.hide();
            this.tankmenTileList.removeEventListener(scaleform.clik.events.ListEvent.ITEM_ROLL_OVER, showTooltip);
            this.tankmenTileList.removeEventListener(scaleform.clik.events.ListEvent.ITEM_ROLL_OUT, hideTooltip);
            this.tankmenTileList.removeEventListener(scaleform.clik.events.ListEvent.ITEM_PRESS, hideTooltip);
            this.tankmenTileList.removeEventListener(net.wg.gui.events.CrewEvent.SHOW_RECRUIT_WINDOW, this.onShowRecruitWindow);
            this.tankmenTileList.removeEventListener(net.wg.gui.events.CrewEvent.UNLOAD_TANKMAN, this.onUnloadTankman);
            this.tankmenTileList.removeEventListener(net.wg.gui.events.CrewEvent.DISMISS_TANKMAN, this.showDismissDialog);
            this.tankmenTileList.removeEventListener(net.wg.gui.events.CrewEvent.SHOW_BERTH_BUY_DIALOG, this.onBuyBerth);
            this.tankmenTileList.removeEventListener(net.wg.gui.events.CrewEvent.OPEN_PERSONAL_CASE, this.openPersonalCaseHandler);
            this.closeButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onBarracksClose);
            this.roleButtonBar.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onFilterChange);
            this.tankTypeButtonBar.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.tankListInvalidate);
            this.tank.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onFilterTankChange);
            this.locationButtonBar.removeEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onFilterChange);
            this.nationDDM.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.tankListInvalidate);
            this.roleButtonBar.dispose();
            this.tankTypeButtonBar.dispose();
            this.locationButtonBar.dispose();
            this.tankmenTileList.dispose();
            this.closeButton.dispose();
            this.nationDDM.dispose();
            this.tank.dispose();
            this.scrollBar.dispose();
            this.titleBtn.dispose();
            this.scrollBar = null;
            this.titleBtn = null;
            this.closeButton = null;
            this.tankmenTileList = null;
            this.background = null;
            this.tank = null;
            this.nationDDM = null;
            this.roleButtonBar = null;
            this.tankTypeButtonBar = null;
            this.locationButtonBar = null;
            this.roleTF = null;
            this.tankTypeTF = null;
            this.locationTF = null;
            this.nationTF = null;
            this.tankmenCountTF = null;
            this.placesCountTF = null;
            this._nation = 0;
            this._role = null;
            this._tankType = null;
            this._location = null;
            this._nationID = null;
            this.myWidth = 0;
            this.myHeight = 0;
            super.onDispose();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=0;
            var loc3:*=NaN;
            var loc4:*=0;
            var loc5:*=NaN;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                this.x = this.myWidth - _originalWidth >> 1;
                this.y = this.myHeight - _originalHeight >> 1;
            }
            if (isInvalid(INVALIDATE_TANKMEN_FILTRER)) 
            {
                this.updateSelectedIndex(this.nationDDM, this._nation);
                this.updateSelectedIndex(this.roleButtonBar, this._role);
                this.updateSelectedIndex(this.tankTypeButtonBar, this._tankType);
                invalidateTanksListS();
                if (this._nationID) 
                {
                    this.locationButtonBar.selectedIndex = 0;
                    loc1 = 0;
                    loc2 = this.tank.dataProvider.length;
                    loc3 = 0;
                    while (loc3 < loc2) 
                    {
                        if (this.tank.dataProvider[loc3].data.typeID == this._location && this.tank.dataProvider[loc3].data.nationID == this._nationID) 
                        {
                            loc1 = loc3;
                            break;
                        }
                        ++loc3;
                    }
                    this.tank.selectedIndex = loc1;
                }
                else 
                {
                    loc1 = 3;
                    loc4 = this.locationButtonBar.dataProvider.length;
                    loc5 = 1;
                    while (loc5 < loc4) 
                    {
                        if (this.locationButtonBar.dataProvider[loc5].data == this._location) 
                        {
                            loc1 = loc5;
                            break;
                        }
                        ++loc5;
                    }
                    this.locationButtonBar.selectedIndex = loc1;
                }
                if (!this.roleButtonBar.hasEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE)) 
                    this.roleButtonBar.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onFilterChange);
                if (!this.tankTypeButtonBar.hasEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE)) 
                    this.tankTypeButtonBar.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.tankListInvalidate);
                if (!this.tank.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                    this.tank.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onFilterTankChange);
                if (!this.tank.hasEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE)) 
                    this.locationButtonBar.addEventListener(scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onFilterChange);
                if (!this.nationDDM.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                    this.nationDDM.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.tankListInvalidate);
                this.checkFilters();
            }
            return;
        }

        internal function updateSelectedIndex(arg1:Object, arg2:Object):void
        {
            var loc1:*=arg1 is scaleform.clik.controls.ButtonBar || arg1 is net.wg.gui.components.controls.DropdownMenu;
            var loc2:*="object in ... must be ButtonBar or DropdownMenu";
            assert(loc1, loc2, net.wg.infrastructure.exceptions.TypeCastException);
            var loc3:*=arg1.dataProvider.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                if (arg1.dataProvider[loc4].data == arg2) 
                {
                    arg1.selectedIndex = loc4;
                    return;
                }
                ++loc4;
            }
            return;
        }

        internal function onBarracksClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            closeBarracksS();
            return;
        }

        internal function openPersonalCaseHandler(arg1:net.wg.gui.events.CrewEvent):void
        {
            openPersonalCaseS(arg1.initProp.tankmanID.toString(), arg1.selectedTab);
            return;
        }

        internal function onShowRecruitWindow(arg1:net.wg.gui.events.CrewEvent):void
        {
            onShowRecruitWindowClickS(arg1.initProp, arg1.menuEnabled);
            return;
        }

        internal function onUnloadTankman(arg1:net.wg.gui.events.CrewEvent):void
        {
            unloadTankmanS(arg1.initProp.compact);
            return;
        }

        internal function showDismissDialog(arg1:net.wg.gui.events.CrewEvent):void
        {
            dismissTankmanS(arg1.initProp.compact);
            return;
        }

        internal function onBuyBerth(arg1:net.wg.gui.events.CrewEvent):void
        {
            buyBerthsS();
            return;
        }

        internal function onFilterChange(arg1:flash.events.Event):void
        {
            this.checkFilters();
            return;
        }

        internal function checkFilters():void
        {
            var loc1:*=this.nationDDM.dataProvider[this.nationDDM.selectedIndex].data;
            var loc2:*=this.roleButtonBar.dataProvider[this.roleButtonBar.selectedIndex].data;
            var loc3:*=this.tankTypeButtonBar.dataProvider[this.tankTypeButtonBar.selectedIndex].data;
            var loc4:*;
            if ((loc4 = this.locationButtonBar.dataProvider[this.locationButtonBar.selectedIndex].data) is String || loc4 == null) 
                setFilterS(loc1, loc2, loc3, loc4.toString(), null);
            else 
                setFilterS(loc1, loc2, loc3, loc4.typeID, loc4.nationID);
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            this.setViewSize(arg1, arg2);
            return;
        }

        internal function tankListInvalidate(arg1:flash.events.Event):void
        {
            this.checkFilters();
            invalidateTanksListS();
            this.checkFilters();
            return;
        }

        internal function onFilterTankChange(arg1:flash.events.Event):void
        {
            this.locationButtonBar.selectedIndex = 0;
            this.locationButtonBar.dataProvider[0].data = this.tank.dataProvider[this.tank.selectedIndex].data;
            this.checkFilters();
            return;
        }

        internal static function showTooltip(arg1:scaleform.clik.events.ListEvent):void
        {
            App.toolTipMgr.hide();
            if (arg1.itemData.empty) 
                App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_ITEM_EMPTY);
            else if (arg1.itemData.buy) 
                App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_ITEM_BUY);
            else 
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TANKMAN, null, arg1.itemData.tankmanID, false);
            return;
        }

        internal static function hideTooltip(arg1:scaleform.clik.events.ListEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal static const INVALIDATE_TANKMEN_FILTRER:String="TankmenFilter";

        internal static const LOCATIONFILTER_TANKS:String="tanks";

        internal static const LOCATIONFILTER_BARRACKS:String="barracks";

        internal static const LOCATIONFILTER_ALL:String="None";

        public var tankmenCountTF:flash.text.TextField=null;

        public var placesCountTF:flash.text.TextField=null;

        public var roleTF:flash.text.TextField=null;

        public var tankTypeTF:flash.text.TextField=null;

        public var locationTF:flash.text.TextField=null;

        public var titleBtn:net.wg.gui.components.controls.TextFieldShort=null;

        public var closeButton:net.wg.gui.components.controls.CloseButton=null;

        public var scrollBar:net.wg.gui.components.controls.ScrollBar=null;

        public var tankmenTileList:net.wg.gui.components.controls.TileList=null;

        public var background:flash.display.MovieClip=null;

        public var tank:net.wg.gui.components.controls.DropdownMenu=null;

        public var nationDDM:net.wg.gui.components.controls.DropdownMenu=null;

        public var roleButtonBar:net.wg.gui.components.advanced.ButtonBarEx=null;

        public var tankTypeButtonBar:net.wg.gui.components.advanced.ButtonBarEx=null;

        public var locationButtonBar:net.wg.gui.components.advanced.ButtonBarEx=null;

        internal var _nation:Number=0;

        internal var _role:String="";

        internal var _location:String="";

        internal var _nationID:String="";

        internal var myWidth:Number=0;

        internal var myHeight:Number=0;

        internal var _tankType:String="";

        public var nationTF:flash.text.TextField=null;
    }
}
