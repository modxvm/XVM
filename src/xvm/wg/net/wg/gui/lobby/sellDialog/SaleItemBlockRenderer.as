package net.wg.gui.lobby.sellDialog 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.data.managers.impl.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class SaleItemBlockRenderer extends scaleform.clik.controls.ListItemRenderer implements net.wg.infrastructure.interfaces.ISaleItemBlockRenderer
    {
        public function SaleItemBlockRenderer()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.alertIcon.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onAlertIconRollOverHdlr, false);
            this.alertIcon.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onAlertIconRollOutHdlr, false);
            this.alertIcon.dispose();
            this.clickArea.removeEventListener(flash.events.MouseEvent.ROLL_OVER, handleMouseRollOver, false);
            this.clickArea.removeEventListener(flash.events.MouseEvent.ROLL_OUT, handleMouseRollOut, false);
            this.clickArea.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMousePress, false);
            this.clickArea.removeEventListener(flash.events.MouseEvent.CLICK, handleMouseRelease, false);
            this.clickArea.removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleMouseRelease);
            this.clickArea.dispose();
            if (this.ddm) 
            {
                this.ddm.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChangeHandler);
                this.ddm.dispose();
            }
            this.tfShort.dispose();
            this.money.dispose();
            this.clickArea.dispose();
            if (this._dataInfo) 
                this._dataInfo = null;
            return;
        }

        protected override function configUI():void
        {
            this.buttonMode = false;
            this.money.textFieldYOffset = net.wg.gui.lobby.sellDialog.VehicleSellDialog.ICONS_TEXT_OFFSET;
            this.ddm.dataProvider = new scaleform.clik.data.DataProvider([{"label":DIALOGS.SELLCONFIRMATION_SUBMIT}, {"label":DIALOGS.VEHICLESELLDIALOG_UNLOAD}]);
            this.alertIcon.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onAlertIconRollOverHdlr, false, 0, true);
            this.alertIcon.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onAlertIconRollOutHdlr, false, 0, true);
            this.alertIcon.buttonMode = false;
            this.tfShort.buttonMode = false;
            if (this.clickArea) 
            {
                this.clickArea.addEventListener(flash.events.MouseEvent.ROLL_OVER, handleMouseRollOver, false, 0, true);
                this.clickArea.addEventListener(flash.events.MouseEvent.ROLL_OUT, handleMouseRollOut, false, 0, true);
                this.clickArea.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMousePress, false, 0, true);
                this.clickArea.addEventListener(flash.events.MouseEvent.CLICK, handleMouseRelease, false, 0, true);
                this.clickArea.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleMouseRelease, false, 0, true);
                this.clickArea.buttonMode = false;
            }
            if (!(_focusIndicator == null) && !_focused && _focusIndicator.totalFrames == 1) 
                focusIndicator.visible = false;
            return;
        }

        internal function onAlertIconRollOverHdlr(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=new net.wg.data.managers.impl.TooltipProps(net.wg.data.constants.Tooltips.TYPE_INFO, 0, 0, 0, -1, 0, 330);
            App.toolTipMgr.showComplex(TOOLTIPS.VEHICLESELLDIALOG_RENDERER_ALERTICON, loc1);
            return;
        }

        internal function onAlertIconRollOutHdlr(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public function setColor(arg1:Number):void
        {
            this.money.textColor = arg1;
            return;
        }

        public function get inInventory():Boolean
        {
            return this._inInventory;
        }

        public function get isRemovable():Boolean
        {
            return this._isRemovable;
        }

        public function get moneyValue():Number
        {
            return this._moneyValue;
        }

        public function get type():String
        {
            return this._type;
        }

        public function get dataInfo():Object
        {
            return this._dataInfo;
        }

        public override function setData(arg1:Object):void
        {
            this.data = arg1;
            var loc1:*=net.wg.data.VO.SellDialogElement(arg1);
            this._inInventory = loc1.inInventory;
            this._isRemovable = loc1.isRemovable;
            this._moneyValue = loc1.moneyValue;
            this._dataInfo = loc1.data;
            this._type = loc1.type;
            this._id = loc1.id;
            this._removePrice = loc1.removePrice;
            invalidateData();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && data) 
            {
                this.ddm.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onChangeHandler);
                if (this.inInventory) 
                    this.ddm.selectedIndex = 1;
                else 
                    this.ddm.selectedIndex = 0;
                if (this.ddm.selectedIndex != 1) 
                {
                    this.money.text = this.getCreditsString(this._moneyValue);
                    this.money.textColor = 13556185;
                    this.money.icon = net.wg.data.constants.Currencies.CREDITS;
                    this.alertIcon.visible = false;
                }
                else if (this.isRemovable) 
                {
                    this.money.text = "0";
                    this.money.textColor = 13556185;
                    this.money.icon = net.wg.data.constants.Currencies.CREDITS;
                    this.alertIcon.visible = false;
                }
                else 
                {
                    this.money.textColor = 16763253;
                    this.money.text = "- " + App.utils.locale.gold(this._removePrice);
                    this.money.icon = net.wg.data.constants.Currencies.GOLD;
                    this.alertIcon.visible = true;
                }
            }
            if (this._type == "shells" || this._type == "invShells") 
                if (this._dataInfo.hasOwnProperty("kind")) 
                {
                    loc1 = App.utils.locale.makeString(ITEM_TYPES.shell_kindsabbreviation(this._dataInfo.kind));
                    this.tfShort.label = loc1 + " " + this._id;
                    this.tfShort.altToolTip = App.utils.locale.makeString(ITEM_TYPES.shell_kinds(this._dataInfo.kind)) + " " + data.id;
                }
            else 
                this.tfShort.label = this._id;
            constraints.update(this._width, this._height);
            return;
        }

        public override function setSize(arg1:Number, arg2:Number):void
        {
            this.money.x = arg1 - this.money.width - RIGHT_MARGIN;
            this.itemUnderline.width = arg1;
            return;
        }

        internal function onChangeHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (arg1.index != 1) 
            {
                this._inInventory = false;
                this.money.text = this.getCreditsString(this.moneyValue);
                this.money.icon = net.wg.data.constants.Currencies.CREDITS;
                this.money.textColor = 13556185;
                this.alertIcon.visible = false;
            }
            else 
            {
                this._inInventory = true;
                if (this.isRemovable) 
                {
                    this.money.text = "0";
                    this.money.textColor = 13556185;
                    this.money.icon = net.wg.data.constants.Currencies.CREDITS;
                    this.alertIcon.visible = false;
                }
                else 
                {
                    this.money.text = "- " + App.utils.locale.gold(this._removePrice);
                    this.money.textColor = 16763253;
                    this.money.icon = net.wg.data.constants.Currencies.GOLD;
                    this.alertIcon.visible = true;
                }
            }
            dispatchEvent(new net.wg.gui.events.VehicleSellDialogEvent(net.wg.gui.events.VehicleSellDialogEvent.UPDATE_RESULT));
            return;
        }

        internal function getCreditsString(arg1:Number):String
        {
            return (arg1 == 0 ? "" : "+ ") + App.utils.locale.gold(arg1);
        }

        public function hideLine():void
        {
            this.itemUnderline.visible = false;
            return;
        }

        internal static const RIGHT_MARGIN:Number=7;

        public var tfShort:net.wg.gui.components.controls.TextFieldShort;

        public var alertIcon:scaleform.clik.controls.Button;

        public var ddm:net.wg.gui.components.controls.DropdownMenu;

        public var money:net.wg.gui.components.controls.IconText;

        public var clickArea:scaleform.clik.controls.Button;

        public var itemUnderline:flash.display.MovieClip;

        internal var _inInventory:Boolean;

        internal var _type:String;

        internal var _id:String;

        internal var _isRemovable:Boolean;

        internal var _moneyValue:Number=0;

        internal var _dataInfo:Object=null;

        internal var _removePrice:Number=0;
    }
}
