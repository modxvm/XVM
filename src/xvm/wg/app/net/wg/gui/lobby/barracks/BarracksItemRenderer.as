package net.wg.gui.lobby.barracks 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.utils.*;
    import scaleform.clik.events.*;
    
    public class BarracksItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function BarracksItemRenderer()
        {
            super();
            buttonMode = true;
            this.soundType = net.wg.data.constants.SoundTypes.BARRACKS_TANKMAN_SOUND_TYPE;
            this.useRightButton = true;
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (!arg1) 
            {
                return;
            }
            this.btnDissmiss.focusTarget = this;
            this.data = arg1;
            this.empty = arg1.empty;
            this.buy = arg1.buy;
            if (arg1.iconFile && !(arg1.iconFile == this.icon.source)) 
            {
                this.icon.source = "../maps/icons/tankmen/icons/barracks/" + arg1.iconFile;
            }
            if (arg1.rankIconFile && !(arg1.rankIconFile == this.iconRank.source)) 
            {
                this.iconRank.source = "../maps/icons/tankmen/ranks/small/" + arg1.rankIconFile;
            }
            if (arg1.roleIconFile && !(arg1.roleIconFile == this.iconRole.source)) 
            {
                this.iconRole.source = arg1.roleIconFile;
            }
            this.inCurrentTank = arg1.inCurrentTank;
            if (!this.inCurrentTank) 
            {
                this.inTank = arg1.inTank;
            }
            this.btnDissmiss.enabled = !(arg1.locked || arg1.vehicleBroken);
            this.btnDissmiss.label = MENU.BARRACKS_BTNDISSMISS;
            this.btnDissmiss.soundId = "btnDissmiss";
            if (this.inTank || this.inCurrentTank) 
            {
                this.btnDissmiss.label = MENU.BARRACKS_BTNUNLOAD;
                this.btnDissmiss.soundId = "btnUnload";
                this.btnDissmiss.enabled = !arg1.locked;
            }
            this.btnDissmiss.validateNow();
            invalidate(INVALIDATE_PARAMS);
            validateNow();
            return;
        }

        public function onBtnDissmissClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (this._inTank || this._inCurrentTank) 
            {
                dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.UNLOAD_TANKMAN, data));
            }
            else 
            {
                dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.DISMISS_TANKMAN, data));
            }
            return;
        }

        public function onBarracksItemRendererClick(arg1:flash.events.MouseEvent):void
        {
            if (arg1.target == this.btnDissmiss) 
            {
                return;
            }
            var loc1:*=App.utils.commons;
            if (loc1.isLeftButton(arg1)) 
            {
                if (this._empty) 
                {
                    dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.SHOW_RECRUIT_WINDOW, null, true));
                }
                else if (this._buy) 
                {
                    dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.SHOW_BERTH_BUY_DIALOG));
                }
            }
            if (loc1.isRightButton(arg1) && !this._buy && !this._empty) 
            {
                dispatchEvent(new net.wg.gui.events.CrewEvent(net.wg.gui.events.CrewEvent.OPEN_PERSONAL_CASE, data, false, 0));
            }
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent):void
        {
            setState("out");
            if (this._inTank || this._inCurrentTank) 
            {
                App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_TANKMEN_UNLOAD);
            }
            else 
            {
                App.toolTipMgr.showComplex(TOOLTIPS.BARRACKS_TANKMEN_DISMISS);
            }
            return;
        }

        internal function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            setState("over");
            App.toolTipMgr.hide();
            dispatchEvent(new scaleform.clik.events.ListEvent(scaleform.clik.events.ListEvent.ITEM_ROLL_OVER, true, true, -1, -1, -1, null, data));
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            if (this._empty) 
            {
                return Vector.<String>(["empty_"]);
            }
            if (this._buy) 
            {
                return Vector.<String>(["buy_"]);
            }
            if (_selected) 
            {
                return Vector.<String>(["selected_", ""]);
            }
            return Vector.<String>([""]);
        }

        public function get inTank():Boolean
        {
            return this._inTank;
        }

        public function set inTank(arg1:Boolean):void
        {
            if (this._inTank == arg1) 
            {
                return;
            }
            this._inTank = arg1;
            invalidate(INVALIDATE_IN_TANK);
            return;
        }

        public function get inCurrentTank():Boolean
        {
            return this._inCurrentTank;
        }

        public function set inCurrentTank(arg1:Boolean):void
        {
            if (this._inCurrentTank == arg1) 
            {
                return;
            }
            this._inCurrentTank = arg1;
            invalidate(INVALIDATE_IN_TANK);
            return;
        }

        public function get buy():Boolean
        {
            return this._buy;
        }

        public function set buy(arg1:Boolean):void
        {
            this._buy = arg1;
            this.updateControlsState();
            setState("up");
            return;
        }

        public function get empty():Boolean
        {
            return this._empty;
        }

        public function set empty(arg1:Boolean):void
        {
            this._empty = arg1;
            this.updateControlsState();
            setState("up");
            return;
        }

        internal function updateControlsState():void
        {
            var loc1:*=!(this._buy || this._empty);
            var loc2:*;
            this.iconRole.visible = loc2 = loc1;
            this.iconRank.visible = loc2 = loc2;
            this.icon.visible = loc2;
            this.btnDissmiss.visible = loc1;
            if (this.buy) 
            {
                soundType = net.wg.data.constants.SoundTypes.BARRACKS_BUY_SOUND_TYPE;
            }
            else if (this.empty) 
            {
                soundType = net.wg.data.constants.SoundTypes.BARRACKS_EMPTY_SOUND_TYPE;
            }
            else 
            {
                soundType = net.wg.data.constants.SoundTypes.BARRACKS_TANKMAN_SOUND_TYPE;
            }
            return;
        }

        public override function toString():String
        {
            return "[Scaleform BarracksItemRenderer " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            tabChildren = false;
            this.btnDissmiss.focusTarget = this;
            this.btnDissmiss.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onBtnDissmissClick);
            var loc1:*;
            this.iconRank.mouseEnabled = loc1 = false;
            this.iconRole.mouseEnabled = loc1 = loc1;
            this.icon.mouseEnabled = loc1;
            this.iconRank.mouseChildren = loc1 = false;
            this.iconRole.mouseChildren = loc1 = loc1;
            this.icon.mouseChildren = loc1;
            addEventListener(flash.events.MouseEvent.CLICK, this.onBarracksItemRendererClick, false, 0, true);
            this.btnDissmiss.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip, false, 0, true);
            this.btnDissmiss.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip, false, 0, true);
            this.btnDissmiss.addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip, false, 0, true);
            mouseChildren = true;
            this.clickArea.buttonMode = true;
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            mouseChildren = arg1;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            super.draw();
            if (!_baseDisposed) 
            {
                if (isInvalid(INVALIDATE_IN_TANK) && this.selection) 
                {
                    loc1 = "barracks";
                    if (this._inTank) 
                    {
                        loc1 = "tank";
                    }
                    if (this._inCurrentTank) 
                    {
                        loc1 = "current_tank";
                    }
                    this.selection.gotoAndPlay(loc1);
                }
                if (isInvalid(INVALIDATE_PARAMS) && data) 
                {
                    loc2 = new flash.geom.Point(mouseX, mouseY);
                    loc2 = this.localToGlobal(loc2);
                    if (this.hitTestPoint(loc2.x, loc2.y, true)) 
                    {
                        if (this.btnDissmiss.hitTestPoint(loc2.x, loc2.y, true) && !(this._buy || this.empty)) 
                        {
                            this.showTooltip(null);
                        }
                        else 
                        {
                            dispatchEvent(new scaleform.clik.events.ListEvent(scaleform.clik.events.ListEvent.ITEM_ROLL_OVER, true, true, -1, -1, -1, null, data));
                        }
                    }
                    this.countField.text = "";
                    if (this._buy) 
                    {
                        this.price.text = data.price;
                        this.countField.text = "+" + data.count;
                        this.descrField.text = App.utils.locale.makeString(MENU.BARRACKS_BTNBUYBERTHDECS);
                        this.descrField.replaceText(this.descrField.text.indexOf("{"), this.descrField.text.indexOf("}") + 1, String(data.count));
                    }
                    if (this.role) 
                    {
                        this.role.htmlText = data.role;
                    }
                    if (!(this._buy || this.empty)) 
                    {
                        loc3 = data.specializationLevel + "%";
                        loc4 = App.utils.locale.makeString(MENU.tankmen(data.tankType));
                        if (data.isInSelfVehicleClass) 
                        {
                            if (data.isInSelfVehicleType) 
                            {
                                this.levelSpecializationMain.htmlText = loc3;
                                this.role.htmlText = this.role.htmlText + (", " + loc4 + " " + data.vehicleType);
                            }
                            else 
                            {
                                this.levelSpecializationMain.htmlText = " <font color=\'" + DEBUFF + "\'>" + loc3 + "</font>";
                                this.role.htmlText = this.role.htmlText + (", " + loc4 + " <font color=\'" + DEBUFF + "\'> " + data.vehicleType + "</font>");
                            }
                        }
                        else 
                        {
                            this.levelSpecializationMain.htmlText = " <font color=\'" + DEBUFF + "\'>" + loc3 + "</font>";
                            this.role.htmlText = this.role.htmlText + (", <font color=\'" + DEBUFF + "\'>" + loc4 + " " + data.vehicleType + "</font>");
                        }
                        this.tankmanName.text = data.firstname + " " + data.lastname;
                        this.rank.text = data.rank;
                        this.lockMsg.text = data.lockMessage;
                    }
                }
            }
            return;
        }

        public function set useHandCursorOnClickArea(arg1:Boolean):void
        {
            if (this.clickArea) 
            {
                this.useHandCursor = arg1;
                this.tabEnabled = arg1;
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.CLICK, this.onBarracksItemRendererClick, false);
            this.btnDissmiss.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onBtnDissmissClick);
            this.btnDissmiss.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip, false);
            this.btnDissmiss.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip, false);
            this.btnDissmiss.removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip, false);
            this.btnDissmiss.focusTarget = null;
            if (this.icon) 
            {
                this.icon.dispose();
                this.icon = null;
            }
            if (this.iconRole) 
            {
                this.iconRole.dispose();
                this.iconRole = null;
            }
            if (this.iconRank) 
            {
                this.iconRank.dispose();
                this.iconRank = null;
            }
            this.btnDissmiss.dispose();
            _data = null;
            this.countField = null;
            this.clickArea = null;
            this.selection = null;
            this.levelSpecializationMain = null;
            this.tankmanName = null;
            this.rank = null;
            this.role = null;
            this.lockMsg = null;
            this.vehicleType = null;
            this.price = null;
            this.descrField = null;
            super.dispose();
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        internal static const INVALIDATE_PARAMS:String="params";

        internal static const INVALIDATE_IN_TANK:String="inTank";

        internal static const DEBUFF:String="#FF0000";

        public var countField:flash.text.TextField=null;

        public var btnDissmiss:net.wg.gui.components.controls.SoundButtonEx;

        public var icon:net.wg.gui.components.controls.UILoaderAlt;

        public var iconRole:net.wg.gui.components.controls.UILoaderAlt;

        public var clickArea:flash.display.MovieClip=null;

        public var selection:flash.display.MovieClip=null;

        public var levelSpecializationMain:flash.text.TextField=null;

        public var tankmanName:flash.text.TextField=null;

        public var rank:flash.text.TextField=null;

        public var role:flash.text.TextField=null;

        public var lockMsg:flash.text.TextField=null;

        public var vehicleType:flash.text.TextField=null;

        public var price:flash.text.TextField=null;

        public var descrField:flash.text.TextField=null;

        internal var _inTank:Boolean=false;

        internal var _empty:Boolean=false;

        internal var _buy:Boolean=false;

        internal var _inCurrentTank:Boolean=false;

        public var iconRank:net.wg.gui.components.controls.UILoaderAlt;
    }
}
