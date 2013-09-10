package net.wg.gui.lobby.battleResults 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;
    
    public class EfficiencyRenderer extends scaleform.clik.core.UIComponent implements scaleform.clik.interfaces.IListItemRenderer
    {
        public function EfficiencyRenderer()
        {
            super();
            return;
        }

        public function setListData(arg1:scaleform.clik.data.ListData):void
        {
            this.index = arg1.index;
            this.selected = arg1.selected;
            return;
        }

        public function setData(arg1:Object):void
        {
            this.data = arg1;
            if (arg1) 
                if (arg1.hoveredKind) 
                    arg1.hoveredKind = null;
            this._dataDirty = true;
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            var loc2:*=null;
            super.configUI();
            focusTarget = this.owner;
            var loc3:*;
            tabChildren = loc3 = false;
            tabEnabled = loc3 = loc3;
            _focusable = loc3;
            mouseChildren = true;
            this.icons = [this.killIcon, this.damageIcon, this.critsIcon, this.evilIcon, this.spottedIcon];
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < 5) 
            {
                loc2 = this.icons[loc1];
                if (loc2) 
                {
                    loc2.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleIconRoll);
                    loc2.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleIconRoll);
                }
                ++loc1;
            }
            return;
        }

        internal function handleIconRoll(arg1:flash.events.MouseEvent):void
        {
            if (arg1.type != flash.events.MouseEvent.ROLL_OVER) 
                dispatchEvent(new net.wg.gui.events.FinalStatisticEvent(net.wg.gui.events.FinalStatisticEvent.EFFENSY_ICON_ROLL_OUT));
            else 
            {
                this.data.isDisabled = !arg1.target.enabled;
                this.data.hoveredKind = arg1.target.kind;
                dispatchEvent(new net.wg.gui.events.FinalStatisticEvent(net.wg.gui.events.FinalStatisticEvent.EFFENSY_ICON_ROLL_OVER, this.data));
            }
            return;
        }

        internal function getDimmFilter():flash.filters.ColorMatrixFilter
        {
            var loc1:*=new flash.filters.ColorMatrixFilter();
            var loc2:*=[0.4, 0, 0, 0, 0];
            var loc3:*=[0, 0.4, 0, 0, 0];
            var loc4:*=[0, 0, 0.4, 0, 0];
            var loc5:*=[0, 0, 0, 1, 0];
            var loc6:*=(loc6 = (loc6 = (loc6 = (loc6 = new Array()).concat(loc2)).concat(loc3)).concat(loc4)).concat(loc5);
            loc1.matrix = loc6;
            return loc1;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (this._dataDirty) 
            {
                if (this.data == null) 
                    this.visible = false;
                else 
                {
                    this.playerName.textColor = 13224374;
                    this.vehicleName.textColor = 13224374;
                    this.vehicleIcon.visible = !this.data.isFake;
                    this.deadBg.visible = false;
                    this.fakeBg.visible = this.data.isFake;
                    this.vehicleName.visible = !this.data.isFake;
                    this.killIcon.visible = !this.data.isFake;
                    this.damageIcon.visible = !this.data.isFake && !this.data.isAlly;
                    this.critsIcon.visible = !this.data.isFake && !this.data.isAlly;
                    this.evilIcon.visible = !this.data.isFake && !this.data.isAlly;
                    this.spottedIcon.visible = !this.data.isFake && !this.data.isAlly;
                    this.playerName.text = this.data.playerName;
                    loc1 = this.playerName.getTextFormat();
                    if (this.data.isFake) 
                    {
                        loc1.align = "left";
                        loc1.leftMargin = 15;
                        this.playerName.setTextFormat(loc1);
                    }
                    else 
                    {
                        loc1.align = "right";
                        loc1.leftMargin = 0;
                        this.playerName.setTextFormat(loc1);
                        this.vehicleIcon.source = this.data.tankIcon;
                        this.vehicleName.text = this.data.vehicleName;
                        this.damageIcon.enabled = false;
                        this.critsIcon.enabled = false;
                        this.evilIcon.enabled = false;
                        this.spottedIcon.enabled = false;
                        this.killIcon.enabled = false;
                        this.killIcon.kind = this.data.isAlly ? net.wg.gui.lobby.battleResults.EfficiencyIconRenderer.TEAMKILL : net.wg.gui.lobby.battleResults.EfficiencyIconRenderer.KILL;
                        if (this.data.deathReason > -1) 
                            this.killIcon.enabled = true;
                        if (this.data.killed) 
                        {
                            this.playerName.textColor = 6381391;
                            this.vehicleName.textColor = 6381391;
                            this.deadBg.visible = true;
                            this.vehicleIcon.filters = [this.getDimmFilter()];
                        }
                        else 
                            this.vehicleIcon.filters = [];
                        if (this.data.damageDealt > 0) 
                        {
                            this.damageIcon.enabled = true;
                            this.damageIcon.value = this.data.pierced;
                        }
                        if (this.data.critsCount > 0) 
                        {
                            this.critsIcon.enabled = true;
                            this.critsIcon.value = this.data.critsCount;
                        }
                        if (this.data.damageAssisted > 0) 
                            this.evilIcon.enabled = true;
                        if (this.data.spotted > 0) 
                            this.spottedIcon.enabled = true;
                    }
                }
                this._dataDirty = false;
            }
            return;
        }

        public function get index():uint
        {
            return this._index;
        }

        public function set index(arg1:uint):void
        {
            this._index = arg1;
            return;
        }

        public function get owner():scaleform.clik.core.UIComponent
        {
            return this._owner;
        }

        public function set owner(arg1:scaleform.clik.core.UIComponent):void
        {
            this._owner = arg1;
            return;
        }

        public function get selectable():Boolean
        {
            return this._selectable;
        }

        public function set selectable(arg1:Boolean):void
        {
            this._selectable = arg1;
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            if (this._selected == arg1) 
                return;
            this._selected = arg1;
            return;
        }

        internal var _dataDirty:Boolean=false;

        internal var icons:Array;

        public var fakeBg:flash.display.MovieClip;

        protected var data:Object;

        protected var _owner:scaleform.clik.core.UIComponent=null;

        public var playerName:flash.text.TextField;

        public var vehicleIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var vehicleName:flash.text.TextField;

        public var killIcon:net.wg.gui.lobby.battleResults.EfficiencyIconRenderer;

        public var damageIcon:net.wg.gui.lobby.battleResults.EfficiencyIconRenderer;

        public var critsIcon:net.wg.gui.lobby.battleResults.EfficiencyIconRenderer;

        public var evilIcon:net.wg.gui.lobby.battleResults.EfficiencyIconRenderer;

        public var spottedIcon:net.wg.gui.lobby.battleResults.EfficiencyIconRenderer;

        public var deadBg:flash.display.MovieClip;

        protected var _index:uint=0;

        protected var _selectable:Boolean=false;

        protected var _selected:Boolean=false;
    }
}
