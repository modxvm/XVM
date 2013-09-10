package net.wg.gui.lobby.hangar.maintenance 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.maintenance.data.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class ShellItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function ShellItemRenderer()
        {
            super();
            this.select.handleScroll = false;
            soundType = "shellItemRenderer";
            this.initCounterBgWidth = this.countSliderBg.width;
            return;
        }

        public override function setData(arg1:Object):void
        {
            var loc1:*=App.utils.events;
            if (this.shell) 
                loc1.removeEvent(this.shell, net.wg.gui.events.ShellRendererEvent.USER_COUNT_CHANGED, this.onUserCountChange, false);
            super.setData(arg1);
            if (this.shell) 
                loc1.addEvent(this.shell, net.wg.gui.events.ShellRendererEvent.USER_COUNT_CHANGED, this.onUserCountChange, false, 0, true);
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=App.utils.events;
            loc1.addEvent(this.countSlider, scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChange);
            loc1.addEvent(this.countStepper, scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onStepperValueChange);
            loc1.addEvent(this.toBuyDropdown, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onShellCurrencyChanged);
            loc1.addEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onShellOrderChange);
            loc1.addEvent(this, flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            loc1.addEvent(this, flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            loc1.addEvent(this, flash.events.MouseEvent.CLICK, this.onClick);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=App.utils.events;
            loc1.removeEvent(this.countSlider, scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChange);
            loc1.removeEvent(this.countStepper, scaleform.clik.events.IndexEvent.INDEX_CHANGE, this.onStepperValueChange);
            loc1.removeEvent(this.toBuyDropdown, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onShellCurrencyChanged);
            loc1.removeEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onShellOrderChange);
            loc1.removeEvent(this, flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            loc1.removeEvent(this, flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            loc1.removeEvent(this, flash.events.MouseEvent.CLICK, this.onClick);
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.toBuyDropdown.visible = false;
                this.toBuyTf.visible = false;
                mouseChildren = true;
                this.icon.mouseEnabled = false;
                this.nameLbl.mouseEnabled = false;
                this.descrLbl.mouseEnabled = false;
                focusable = true;
                if (this.shell) 
                {
                    this.icon.source = this.shell.icon;
                    if (this.shell.prices[1] > 0 && this.shell.prices[0] > 0 && this.shell.goldShellsForCredits) 
                    {
                        this.toBuyDropdown.visible = this.shell.goldShellsForCredits;
                        this.toBuyTf.visible = this.shell.goldShellsForCredits;
                        this.toBuy.visible = !this.shell.goldShellsForCredits;
                        loc1 = App.utils.locale;
                        this.toBuyDropdown.dataProvider = new scaleform.clik.data.DataProvider([loc1.htmlTextWithIcon(loc1.integer(this.shell.prices[0]), net.wg.data.constants.Currencies.CREDITS), loc1.htmlTextWithIcon(loc1.gold(this.shell.prices[1]), net.wg.data.constants.Currencies.GOLD)]);
                        this.toBuyDropdown.selectedIndex = this.shell.currency != net.wg.data.constants.Currencies.CREDITS ? 1 : 0;
                        this.price.icon = this.shell.currency;
                    }
                    else 
                    {
                        this.toBuyDropdown.visible = false;
                        this.toBuyTf.visible = false;
                        this.toBuy.visible = true;
                    }
                    this.nameLbl.text = this.shell.ammoName;
                    this.descrLbl.text = this.shell.tableName;
                    this.onUserCountChange();
                    this.select.menuRowCount = data.list.length;
                    this.select.dataProvider = new scaleform.clik.data.DataProvider(data.list);
                    this.select.menuOffset.top = -RENDERER_HEIGHT - Math.round((data.list.length - 1) * RENDERER_HEIGHT / 2);
                    this.select.selectedIndex = -1;
                    visible = true;
                    if (this.select.isOpen()) 
                    {
                        this.select.close();
                        this.select.open();
                    }
                    if (this.select.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) 
                        this.onRollOver();
                }
                else 
                    visible = false;
            }
            return;
        }

        internal function get shell():net.wg.gui.lobby.hangar.maintenance.data.ShellVO
        {
            return data as net.wg.gui.lobby.hangar.maintenance.data.ShellVO;
        }

        internal function onSliderValueChange(arg1:scaleform.clik.events.SliderEvent):void
        {
            if (this.countStepper.value != this.countSlider.value) 
            {
                var loc1:*;
                this.countStepper.value = loc1 = this.countSlider.value;
                this.shell.userCount = loc1;
            }
            return;
        }

        internal function onStepperValueChange(arg1:scaleform.clik.events.IndexEvent):void
        {
            if (this.countStepper.value != this.countSlider.value) 
            {
                var loc1:*;
                this.countSlider.value = loc1 = this.countStepper.value;
                this.shell.userCount = loc1;
            }
            return;
        }

        internal function onShellCurrencyChanged(arg1:scaleform.clik.events.ListEvent):void
        {
            this.price.icon = this.toBuyDropdown.selectedIndex != 0 ? net.wg.data.constants.Currencies.GOLD : net.wg.data.constants.Currencies.CREDITS;
            this.shell.currency = this.toBuyDropdown.selectedIndex != 0 ? net.wg.data.constants.Currencies.GOLD : net.wg.data.constants.Currencies.CREDITS;
            this.onUserCountChange();
            return;
        }

        internal function onShellOrderChange(arg1:scaleform.clik.events.ListEvent):void
        {
            if (this.select.selectedIndex == -1 || this.shell.id == this.shell.list[this.select.selectedIndex].id) 
                return;
            dispatchEvent(new net.wg.gui.events.ShellRendererEvent(net.wg.gui.events.ShellRendererEvent.CHANGE_ORDER, this.shell, this.shell.list[this.select.selectedIndex]));
            return;
        }

        internal function updateShellsPrice():void
        {
            var loc1:*=this.shell.buyShellsCount;
            var loc2:*=0;
            var loc3:*="";
            var loc4:*=App.utils.locale;
            if (this.toBuyDropdown.visible) 
                loc2 = this.shell.prices[this.toBuyDropdown.selectedIndex];
            else 
            {
                loc2 = this.shell.prices[this.shell.currency != net.wg.data.constants.Currencies.CREDITS ? 1 : 0];
                loc3 = this.shell.currency != net.wg.data.constants.Currencies.CREDITS ? loc4.gold(loc2) : loc4.integer(loc2);
            }
            this.toBuy.icon = this.shell.currency;
            this.price.icon = this.shell.currency;
            this.toBuy.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[this.shell.currency];
            this.toBuyTf.text = loc1 + MULTY_CHARS;
            this.toBuy.text = loc1 + MULTY_CHARS + loc3;
            this.price.textColor = net.wg.data.constants.Currencies.TEXT_COLORS[this.shell.currency];
            this.price.text = this.shell.currency != net.wg.data.constants.Currencies.CREDITS ? loc4.gold(loc2 * loc1) : loc4.integer(loc2 * loc1);
            var loc5:*;
            this.price.enabled = loc5 = !(loc1 == 0);
            this.toBuy.enabled = loc5;
            this.toBuyTf.alpha = loc1 != 0 ? 1 : 0.3;
            dispatchEvent(new net.wg.gui.events.ShellRendererEvent(net.wg.gui.events.ShellRendererEvent.TOTAL_PRICE_CHANGED));
            return;
        }

        internal function onUserCountChange(arg1:net.wg.gui.events.ShellRendererEvent=null):void
        {
            var loc2:*;
            this.countStepper.maximum = loc2 = this.shell.maxAmmo;
            this.countSlider.maximum = loc2;
            this.countStepper.stepSize = loc2 = this.shell.step;
            this.countSlider.snapInterval = loc2;
            this.countSlider.value = this.shell.userCount;
            this.countSliderBg.width = this.initCounterBgWidth * this.shell.possibleMax / this.shell.maxAmmo;
            var loc1:*=data.count - this.countSlider.value + data.inventoryCount;
            this.countLabel.text = App.utils.locale.integer(loc1 > 0 ? loc1 : 0);
            this.countLabel.alpha = loc1 > 0 ? 1 : 0.3;
            this.updateShellsPrice();
            return;
        }

        internal function onRollOver(arg1:flash.events.MouseEvent=null):void
        {
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.TECH_MAIN_SHELL, null, data.id, data.prices, data.inventoryCount, data.count);
            return;
        }

        internal function onRollOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function onClick(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            App.toolTipMgr.hide();
            if (arg1 is scaleform.gfx.MouseEventEx) 
            {
                loc1 = arg1 as scaleform.gfx.MouseEventEx;
                if (loc1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
                    dispatchEvent(new net.wg.gui.events.ModuleInfoEvent(net.wg.gui.events.ModuleInfoEvent.SHOW_INFO, net.wg.gui.lobby.hangar.maintenance.data.ShellVO(data).id));
            }
            return;
        }

        internal static const RENDERER_HEIGHT:Number=45;

        internal static const MULTY_CHARS:String=" x ";

        public var initCounterBgWidth:int=0;

        public var select:net.wg.gui.components.controls.DropdownMenu;

        public var countLabel:flash.text.TextField;

        public var toBuy:net.wg.gui.components.controls.IconText;

        public var price:net.wg.gui.components.controls.IconText;

        public var toBuyTf:flash.text.TextField;

        public var toBuyDropdown:net.wg.gui.components.controls.DropdownMenu;

        public var countSliderBg:flash.display.MovieClip;

        public var countSlider:net.wg.gui.components.controls.Slider;

        public var countStepper:net.wg.gui.components.controls.NumericStepper;

        public var nameLbl:flash.text.TextField;

        public var descrLbl:flash.text.TextField;

        public var icon:net.wg.gui.components.controls.UILoaderAlt;
    }
}
