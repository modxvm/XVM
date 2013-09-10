package net.wg.gui.lobby.hangar.maintenance 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.components.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.maintenance.data.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class EquipmentItem extends net.wg.gui.components.controls.SoundButtonEx
    {
        public function EquipmentItem()
        {
            super();
            this.select.handleScroll = false;
            return;
        }

        public function reset():void
        {
            this.clear();
            this.default_initialized = false;
            return;
        }

        public function toggleSelectChange(arg1:Boolean):void
        {
            if (arg1) 
                App.utils.events.addEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemRendererClick);
            else 
                App.utils.events.removeEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemRendererClick);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=App.utils.events;
            loc1.removeEvent(this.toBuyDropdown, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onModuleCurrencyChanged);
            loc1.removeEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemRendererClick);
            this.cleanupData();
            super.dispose();
            return;
        }

        public override function handleMouseDown(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            App.toolTipMgr.hide();
            if (this.selectedItem && arg1 is scaleform.gfx.MouseEventEx) 
            {
                loc1 = arg1 as scaleform.gfx.MouseEventEx;
                if (loc1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
                {
                    loc2 = this.changed && this.selectedItem.count == 0 && this.installedData.indexOf(this.selectedItem.compactDescr) == -1 ? CANCEL_BUY : UNLOAD;
                    App.contextMenuMgr.show(Vector.<net.wg.infrastructure.interfaces.IContextItem>([new net.wg.data.components.UserContextItem(MODULE_INFO), new net.wg.data.components.UserContextItem(loc2)]), this, this.onContextMenuAction);
                }
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            focusTarget = this.select;
            var loc2:*;
            mouseChildren = loc2 = true;
            tabChildren = loc2 = loc2;
            tabEnabled = loc2 = loc2;
            _focusable = loc2;
            this.slotBg.mouseChildren = loc2 = false;
            this.slotBg.mouseEnabled = loc2;
            this.icon.mouseChildren = loc2 = false;
            this.icon.mouseEnabled = loc2;
            this.title.mouseEnabled = false;
            this.descr.mouseEnabled = false;
            this.countLabel.mouseEnabled = false;
            this.toBuy.mouseChildren = loc2 = false;
            this.toBuy.mouseEnabled = loc2;
            this.price.mouseChildren = loc2 = false;
            this.price.mouseEnabled = loc2;
            var loc1:*=App.utils.events;
            loc1.addEvent(this.toBuyDropdown, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onModuleCurrencyChanged);
            return;
        }

        public override function showTooltip(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=this.selectedItem;
            if (loc1) 
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TECH_MAIN_MODULE, null, loc1.id, loc1.prices, loc1.inventoryCount, loc1.vehicleCount);
            else 
                App.toolTipMgr.showComplex(TOOLTIPS.EQUIPMENT_EMPTY, null);
            return;
        }

        internal function onContextMenuAction(arg1:net.wg.gui.events.ContextMenuEvent):void
        {
            var loc1:*=null;
            var loc2:*=arg1.id;
            switch (loc2) 
            {
                case MODULE_INFO:
                    dispatchEvent(new net.wg.gui.events.ModuleInfoEvent(net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, this.selectedItem.id));
                    break;
                case UNLOAD:
                case CANCEL_BUY:
                    loc1 = App.utils.events;
                    loc1.removeEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemRendererClick);
                    this.selectedIndexOld = -1;
                    this.select.selectedIndex = -1;
                    loc1.addEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemRendererClick);
                    dispatchEvent(new net.wg.gui.events.EquipmentEvent(net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE));
                    break;
            }
            return;
        }

        internal function onItemRendererClick(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=null;
            if (this.artifactsData[this.select.selectedIndex].target != 1) 
                loc1 = new net.wg.gui.events.EquipmentEvent(net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE);
            else 
                loc1 = new net.wg.gui.events.EquipmentEvent(net.wg.gui.events.EquipmentEvent.EQUIPMENT_CHANGE, this.selectedItem ? this.selectedItem.index : -1, this.selectedIndexOld, this.selectedIndexOld > -1 ? this.artifactsData[this.selectedIndexOld].currency : net.wg.data.constants.Values.EMPTY_STR);
            if (this.select.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) 
                this.showTooltip(null);
            dispatchEvent(loc1);
            return;
        }

        internal function onModuleCurrencyChanged(arg1:scaleform.clik.events.ListEvent):void
        {
            this.price.icon = this.toBuyDropdown.selectedIndex != 0 ? net.wg.data.constants.Currencies.GOLD : net.wg.data.constants.Currencies.CREDITS;
            this.selectedItem.currency = this.toBuyDropdown.selectedIndex != 0 ? net.wg.data.constants.Currencies.GOLD : net.wg.data.constants.Currencies.CREDITS;
            this.update();
            dispatchEvent(new net.wg.gui.events.EquipmentEvent(net.wg.gui.events.EquipmentEvent.TOTAL_PRICE_CHANGED));
            return;
        }

        internal function vectorToArray(arg1:__AS3__.vec.Vector.<net.wg.gui.lobby.hangar.maintenance.data.ModuleVO>):Array
        {
            var loc1:*=new Array(arg1.length);
            var loc2:*=arg1.length;
            while (loc2--) 
                loc1[loc2] = arg1[loc2];
            return loc1;
        }

        internal function updateModulePrice():void
        {
            var loc1:*=this.selectedItem;
            var loc6:*;
            this.toBuy.icon = loc6 = loc1.currency;
            this.price.icon = loc6;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*="";
            if (loc1.count == 0 && this.changed && this.installedData.indexOf(loc1.compactDescr) == -1) 
                loc2 = 1;
            if (this.toBuyDropdown.visible) 
                loc3 = loc1.prices[this.toBuyDropdown.selectedIndex];
            else 
                loc3 = loc1.prices[loc1.currency != net.wg.data.constants.Currencies.CREDITS ? 1 : 0];
            var loc5:*=App.utils.locale;
            loc4 = loc1.currency != net.wg.data.constants.Currencies.CREDITS ? loc5.gold(loc3 * loc2) : loc5.integer(loc3 * loc2);
            this.toBuy.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[loc1.currency];
            this.price.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[loc1.price <= this[loc1.currency] ? loc1.currency : "error"];
            this.price.text = loc4;
            this.toBuy.text = loc2 + MULTY_CHARS + this.price.text;
            this.toBuyTf.text = loc2 + MULTY_CHARS;
            this.price.enabled = loc6 = !(loc2 == 0);
            this.toBuy.enabled = loc6;
            this.toBuyTf.alpha = loc2 == 0 ? 0.3 : 1;
            return;
        }

        internal function clear():void
        {
            this.toBuyDropdown.visible = false;
            this.toBuyTf.visible = false;
            this.icon.source = EMPTY_ICON;
            this.title.text = "";
            this.descr.text = "";
            var loc1:*;
            this.price.visible = loc1 = false;
            this.toBuy.visible = loc1 = loc1;
            this.countLabel.visible = loc1;
            return;
        }

        internal function update():void
        {
            var loc3:*=null;
            var loc1:*=this.artifactsData[this.select.selectedIndex];
            this.toBuyDropdown.visible = false;
            this.toBuyTf.visible = false;
            this.icon.source = loc1.icon;
            this.title.text = loc1.name;
            this.descr.text = loc1.desc;
            var loc4:*;
            this.price.visible = loc4 = true;
            this.toBuy.visible = loc4 = loc4;
            this.countLabel.visible = loc4;
            this.countLabel.alpha = loc1.count > 0 ? 1 : 0.3;
            var loc2:*=App.utils.locale;
            this.countLabel.text = loc2.integer(loc1.count);
            if (loc1.prices[1] > 0 && loc1.prices[0] > 0 && loc1.goldEqsForCredits) 
            {
                this.toBuyTf.visible = loc1.goldEqsForCredits;
                this.toBuy.visible = !loc1.goldEqsForCredits;
                loc3 = App.utils.events;
                this.toBuyDropdown.visible = loc1.goldEqsForCredits;
                loc3.removeEvent(this.toBuyDropdown, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onModuleCurrencyChanged);
                this.toBuyDropdown.dataProvider = new scaleform.clik.data.DataProvider([loc2.htmlTextWithIcon(loc2.integer(loc1.prices[0]), net.wg.data.constants.Currencies.CREDITS), loc2.htmlTextWithIcon(loc2.gold(loc1.prices[1]), net.wg.data.constants.Currencies.GOLD)]);
                this.toBuyDropdown.selectedIndex = loc1.currency != net.wg.data.constants.Currencies.CREDITS ? 1 : 0;
                loc3.addEvent(this.toBuyDropdown, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onModuleCurrencyChanged);
                this.price.icon = loc1.currency;
            }
            else 
            {
                this.toBuyDropdown.visible = false;
                this.toBuyTf.visible = false;
                this.toBuy.visible = true;
            }
            this.updateModulePrice();
            return;
        }

        internal function cleanupData():void
        {
            if (this.artifactsData) 
            {
                this.artifactsData.splice(0, this.artifactsData.length);
                this.artifactsData = null;
            }
            if (this.setupData) 
            {
                this.setupData.splice(0);
                this.setupData = null;
            }
            if (this.installedData) 
            {
                this.installedData.splice(0);
                this.installedData = null;
            }
            return;
        }

        public function get selectedItem():net.wg.gui.lobby.hangar.maintenance.data.ModuleVO
        {
            return this.select.selectedIndex != -1 ? this.artifactsData[this.select.selectedIndex] : null;
        }

        public function setData(arg1:Array, arg2:int, arg3:Array, arg4:Array, arg5:int, arg6:int):void
        {
            var loc2:*=null;
            var loc3:*=0;
            if (arg1) 
            {
                this.select.dataProvider.cleanUp();
                this.cleanupData();
            }
            this.index = arg2;
            this.artifactsData = arg1;
            this.setupData = arg3;
            this.installedData = arg4;
            this.credits = arg5;
            this.gold = arg6;
            this.selectedIndexOld = -1;
            var loc1:*=-1;
            var loc4:*=arg1.length;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                if ((loc2 = arg1[loc3]).target == 1 && arg2 == loc2.index) 
                    this.selectedIndexOld = loc3;
                if (loc2.compactDescr == arg3[arg2]) 
                    loc1 = loc3;
                if (loc2.compactDescr == arg4[arg2]) 
                    this.initialId = loc2.id;
                ++loc3;
            }
            this.select.close();
            var loc5:*;
            (loc5 = App.utils.events).removeEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemRendererClick);
            this.select.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.select.menuRowCount = Math.min(SLOTS_MIN_COUNT, arg1.length);
            this.select.selectedIndex = this.selectedIndexOld;
            if (!(loc1 == -1) && !this.default_initialized) 
            {
                this.default_initialized = true;
                this.select.selectedIndex = loc1;
                dispatchEvent(new net.wg.gui.events.EquipmentEvent(net.wg.gui.events.EquipmentEvent.NEED_UPDATE));
            }
            this.select.scrollBar = arg1.length > this.select.menuRowCount ? "ScrollBar" : null;
            loc5.addEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onItemRendererClick);
            if (this.select.selectedIndex == -1) 
                this.clear();
            else 
                this.update();
            return;
        }

        public function get changed():Boolean
        {
            if (this.select.selectedIndex > -1) 
                return !(this.initialId == this.artifactsData[this.select.selectedIndex].id);
            return false;
        }

        internal static const SLOTS_MIN_COUNT:int=9;

        internal static const EMPTY_ICON:String="../maps/icons/artefact/empty.png";

        internal static const MULTY_CHARS:String=" x ";

        internal static const MODULE_INFO:String="moduleInfo";

        internal static const CANCEL_BUY:String="cancelBuy";

        internal static const UNLOAD:String="unload";

        public var slotBg:flash.display.MovieClip;

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var select:net.wg.gui.components.controls.DropdownMenu;

        internal var default_initialized:Boolean=false;

        internal var selectedIndexOld:int=-1;

        internal var initialId:String;

        public var index:int;

        public var toBuyDropdown:net.wg.gui.components.controls.DropdownMenu;

        public var toBuyTf:flash.text.TextField;

        public var price:net.wg.gui.components.controls.IconText;

        public var toBuy:net.wg.gui.components.controls.IconText;

        public var countLabel:flash.text.TextField;

        public var title:flash.text.TextField;

        public var descr:flash.text.TextField;

        internal var gold:int;

        internal var credits:int;

        internal var installedData:Array;

        internal var artifactsData:Array;

        internal var setupData:Array;
    }
}
