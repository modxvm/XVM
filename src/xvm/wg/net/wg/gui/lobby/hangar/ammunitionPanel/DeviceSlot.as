package net.wg.gui.lobby.hangar.ammunitionPanel 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.data.managers.*;
    import net.wg.data.managers.impl.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class DeviceSlot extends scaleform.clik.core.UIComponent
    {
        public function DeviceSlot()
        {
            this.dataValues = [];
            super();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=false;
            var loc4:*=undefined;
            var loc5:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.selectedIndex = -1;
                this.id = null;
                loc1 = 0;
                loc2 = this.dataValues.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if ((loc5 = this.dataValues[loc1]).isSelected) 
                    {
                        this.selectedIndex = loc1;
                        this.id = loc5.id;
                        break;
                    }
                    ++loc1;
                }
                loc3 = this.select.enabled;
                this.select.enabled = false;
                this.select.dataProvider = new scaleform.clik.data.DataProvider(this.dataValues);
                this.select.selectedIndex = this.selectedIndex;
                if (this.selectedIndex >= 0) 
                    if ((loc4 = this.dataValues[this.selectedIndex]).hasOwnProperty(net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon.EXTRA_ICON_PROP_NAME)) 
                    {
                        if (!this.extraIcon) 
                            this.createExtraIcon();
                        this.extraIcon.setSource(loc4[net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon.EXTRA_ICON_PROP_NAME]);
                    }
                    else if (this.extraIcon) 
                        this.extraIcon.clear();
                else if (this.extraIcon) 
                    this.extraIcon.clear();
                this.applyIconData(loc4);
                this.select.enabled = loc3;
            }
            return;
        }

        protected function applyIconData(arg1:*):void
        {
            return;
        }

        protected function createExtraIcon():void
        {
            this.extraIcon = new net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon();
            App.utils.events.addEvent(this.extraIcon, net.wg.gui.lobby.profile.components.SimpleLoader.LOADED, this.onExtraIconLoaded, false, 0, true);
            this.extraIcon.mouseChildren = false;
            this.extraIcon.mouseEnabled = false;
            addChild(this.extraIcon);
            return;
        }

        internal function onExtraIconLoaded(arg1:flash.events.Event):void
        {
            var loc1:*=2;
            this.extraIcon.x = width - this.extraIcon.width - loc1;
            this.extraIcon.y = height - this.extraIcon.height - loc1;
            return;
        }

        internal function onOver(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this.selectedIndex > -1) 
            {
                loc1 = this.dataValues[this.selectedIndex];
                loc2 = [0, 0];
                loc2[loc1.currency != net.wg.data.constants.Currencies.CREDITS ? 1 : 0] = loc1.price;
                loc3 = new net.wg.data.managers.impl.TooltipProps("", stage.mouseX, stage.mouseY);
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.HANGAR_MODULE, null, loc1.id, loc2, loc1.inventoryCount, loc1.vehicleCount, loc1.slotIndex ? loc1.slotIndex : 0);
            }
            else 
                App.toolTipMgr.showComplex(this.tooltip);
            return;
        }

        internal function onOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function onChange(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.select.enabled && !(this.selectedIndex == this.select.selectedIndex)) 
            {
                loc1 = null;
                loc2 = null;
                if (this.selectedIndex > -1) 
                    loc1 = this.dataValues[this.selectedIndex];
                if (this.select.selectedIndex > -1) 
                    loc2 = this.dataValues[this.select.selectedIndex];
                dispatchEvent(new net.wg.gui.events.DeviceEvent(net.wg.gui.events.DeviceEvent.DEVICE_CHANGE, loc2, loc1));
                this.select.selectedIndex = this.selectedIndex;
            }
            return;
        }

        internal function highlightParams(arg1:flash.events.Event):void
        {
            dispatchEvent(new net.wg.gui.events.ParamsEvent(net.wg.gui.events.ParamsEvent.HIGHLIGHT_PARAMS, this.select.selected ? this.type : "empty"));
            return;
        }

        internal function onMouseDown(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (arg1 is scaleform.gfx.MouseEventEx) 
            {
                loc1 = arg1 as scaleform.gfx.MouseEventEx;
                if (loc1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
                    this.select.close();
            }
            return;
        }

        public function get tooltip():String
        {
            return this._tooltip;
        }

        public function set tooltip(arg1:String):void
        {
            this._tooltip = arg1;
            return;
        }

        public function selectItem(arg1:Object):void
        {
            this.select.selectedIndex = this.dataValues.indexOf(arg1);
            return;
        }

        public function setValues(arg1:Array):void
        {
            this.dataValues = arg1;
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        public function updateStage(arg1:Number, arg2:Number):void
        {
            this.select.updateAvailableSize(arg1, arg2 - _originalHeight);
            if (this.select.selected) 
            {
                this.select.close();
                this.select.open();
            }
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            this.select.enabled = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        public function get slotIndex():Number
        {
            return this._slotIndex;
        }

        public function set slotIndex(arg1:Number):void
        {
            this._slotIndex = arg1;
            return;
        }

        public function get iconType():int
        {
            return this._iconType;
        }

        public function set iconType(arg1:int):void
        {
            this._iconType = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            buttonMode = true;
            if (this.levelMC) 
            {
                var loc2:*;
                this.levelMC.mouseChildren = loc2 = false;
                this.levelMC.mouseEnabled = loc2;
            }
            if (this.locked) 
            {
                this.locked.mouseChildren = loc2 = false;
                this.locked.mouseEnabled = loc2;
            }
            var loc1:*=App.utils.events;
            loc1.addEvent(this.select, flash.events.MouseEvent.ROLL_OVER, this.onOver, false, 0, true);
            loc1.addEvent(this.select, flash.events.MouseEvent.ROLL_OUT, this.onOut, false, 0, true);
            loc1.addEvent(this.select, flash.events.MouseEvent.CLICK, this.onOut, false, 0, true);
            loc1.addEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChange, false, 0, true);
            loc1.addEvent(this.select, flash.events.Event.SELECT, this.highlightParams, false, 0, true);
            loc1.addEvent(this, flash.events.MouseEvent.MOUSE_DOWN, this.onMouseDown, false, 0, true);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=App.utils.events;
            loc1.removeEvent(this.select, flash.events.MouseEvent.ROLL_OVER, this.onOver);
            loc1.removeEvent(this.select, flash.events.MouseEvent.ROLL_OUT, this.onOut);
            loc1.removeEvent(this.select, flash.events.MouseEvent.CLICK, this.onOut);
            loc1.removeEvent(this.select, scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChange);
            loc1.removeEvent(this.select, flash.events.Event.SELECT, this.highlightParams);
            loc1.removeEvent(this, flash.events.MouseEvent.MOUSE_DOWN, this.onMouseDown);
            if (this.extraIcon) 
            {
                loc1.removeEvent(this.extraIcon, net.wg.gui.lobby.profile.components.SimpleLoader.LOADED, this.onExtraIconLoaded);
                this.extraIcon.dispose();
                removeChild(this.extraIcon);
            }
            this.select.dataProvider = null;
            this.select.dispose();
            this.dataValues.splice(0);
            this.dataValues = null;
            super.dispose();
            return;
        }

        public var select:net.wg.gui.lobby.hangar.ammunitionPanel.FittingSelect;

        public var levelMC:flash.display.MovieClip;

        public var locked:flash.display.MovieClip;

        public var id:String;

        internal var extraIcon:net.wg.gui.lobby.hangar.ammunitionPanel.ExtraIcon;

        internal var selectedIndex:Number=-1;

        internal var dataValues:Array;

        internal var _type:String;

        internal var _slotIndex:Number=0;

        internal var _iconType:int=0;

        internal var _tooltip:String;
    }
}
