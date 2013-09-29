package net.wg.gui.prebattle.controls 
{
    import flash.text.*;
    import net.wg.gui.prebattle.constants.*;
    import net.wg.gui.prebattle.data.*;
    import net.wg.gui.prebattle.squad.*;
    import scaleform.clik.core.*;
    import scaleform.gfx.*;
    
    public class TeamMemberRenderer extends net.wg.gui.prebattle.squad.SquadItemRenderer
    {
        public function TeamMemberRenderer()
        {
            useRightButton = true;
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.commander_icon.dispose();
            this.status_icon.dispose();
            this.wrong_limits.dispose();
            this.vehicle_type_icon.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 != null) 
            {
                arg1 = new net.wg.gui.prebattle.data.PlayerPrbInfoVO(arg1);
            }
            super.setData(arg1);
            return;
        }

        protected override function showToolTips():void
        {
            var loc1:*=model.accID != -1 ? this.isVehicleValid ? getToolTipData() : model.himself ? TOOLTIPS.MEMBERS_VEHICLELEVELLIMITS_BODY : getToolTipData() : MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_INVITE;
            if (loc1 && loc1.length > 0) 
            {
                App.toolTipMgr.show(loc1);
            }
            return;
        }

        protected override function afterSetData():void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc4:*;
            this.vehicle_type_icon.visible = loc4 = false;
            this.status_icon.visible = loc4 = loc4;
            this.commander_icon.visible = loc4;
            if (!model) 
            {
                return;
            }
            loc1 = model.getStateString();
            if (loc1 == net.wg.gui.prebattle.constants.PrebattleStateString.UNKNOWN) 
            {
                setSpeakers(false, true);
                status.gotoAndPlay("invite");
                loc1 = null;
            }
            else 
            {
                statusString = loc1;
                this.status_icon.visible = true;
                status.visible = true;
                status.gotoAndPlay(loc1);
                if (this.status_icon.currentLabels.indexOf(loc1, 0)) 
                {
                    this.status_icon.gotoAndPlay(loc1);
                }
                if (loc1 == net.wg.gui.prebattle.constants.PrebattleStateString.OFFLINE) 
                {
                    this.status_icon.gotoAndPlay(net.wg.gui.prebattle.constants.PrebattleStateString.NOT_READY);
                }
                if (this.hitTestPoint(mouseX, mouseY, true)) 
                {
                    loc3 = getToolTipData();
                    if (loc3.length > 0) 
                    {
                        App.toolTipMgr.showSpecial(loc3, null);
                    }
                }
                if (model.vType) 
                {
                    this.vehicle_type_icon.visible = true;
                    this.vehicle_type_icon.gotoAndPlay(model.vType);
                }
                else 
                {
                    this.vehicle_type_icon.visible = false;
                }
                if (model.isCreator) 
                {
                    this.commander_icon.visible = true;
                    this.status_icon.visible = false;
                }
            }
            updateVoiceWave();
            var loc2:*=model.getCurrentColor();
            if (!isNaN(loc2)) 
            {
                textField.textColor = loc2;
                vehicleNameField.textColor = loc2;
                this.numberField.textColor = loc2;
                this.vehicleLevelField.textColor = loc2;
            }
            vehicleNameField.text = model.vShortName;
            this.updateValidVehicleState(this.isVehicleValid);
            if (isNaN(model.orderNumber)) 
            {
                this.numberField.visible = false;
            }
            else 
            {
                this.numberField.text = String(model.orderNumber);
            }
            label = model.fullName;
            this.updateAfterStateChange();
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            if (!initialized || model == null) 
            {
                return;
            }
            if (model.isCreator) 
            {
                this.commander_icon.visible = true;
                this.status_icon.visible = false;
            }
            if (model.vType) 
            {
                this.vehicle_type_icon.visible = true;
                this.vehicle_type_icon.gotoAndPlay(model.vType);
            }
            else 
            {
                this.vehicle_type_icon.visible = false;
            }
            scaleform.gfx.TextFieldEx.setVerticalAlign(textField, scaleform.gfx.TextFieldEx.VALIGN_TOP);
            scaleform.gfx.TextFieldEx.setVerticalAlign(vehicleNameField, scaleform.gfx.TextFieldEx.VALIGN_TOP);
            scaleform.gfx.TextFieldEx.setVerticalAlign(this.numberField, scaleform.gfx.TextFieldEx.VALIGN_TOP);
            vehicleNameField.text = model.vShortName;
            this.numberField.text = String(model.orderNumber);
            var loc1:*=model.getCurrentColor();
            if (!isNaN(loc1)) 
            {
                textField.textColor = loc1;
                vehicleNameField.textColor = loc1;
                this.numberField.textColor = loc1;
                this.vehicleLevelField.textColor = loc1;
            }
            this.updateValidVehicleState(this._isVehicleValid && !(this.vehicleLevelField.text == null) && this.visible);
            constraints.updateElement("status", status);
            constraints.updateElement("vehicleNameField", vehicleNameField);
            return;
        }

        public function get isVehicleValid():Boolean
        {
            return this._isVehicleValid;
        }

        public function set isVehicleValid(arg1:Boolean):void
        {
            this._isVehicleValid = arg1;
            this.updateValidVehicleState(arg1);
            return;
        }

        internal function updateValidVehicleState(arg1:Boolean):void
        {
            if (isNaN(model.accID)) 
            {
                return;
            }
            this.wrong_limits.visible = !arg1;
            if (arg1) 
            {
                this.vehicleLevelField.htmlText = "";
                this.vehicleLevelField.text = model.vLevel;
            }
            else 
            {
                this.vehicleLevelField.text = "";
                this.vehicleLevelField.htmlText = "<font color=\"#ff0000\">" + model.vLevel + "</font>";
            }
            return;
        }

        public var vehicleLevelField:flash.text.TextField;

        public var numberField:flash.text.TextField;

        public var commander_icon:scaleform.clik.core.UIComponent;

        public var status_icon:scaleform.clik.core.UIComponent;

        public var wrong_limits:scaleform.clik.core.UIComponent;

        public var vehicle_type_icon:scaleform.clik.core.UIComponent;

        internal var _isVehicleValid:Boolean=true;
    }
}
