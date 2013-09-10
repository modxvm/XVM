package net.wg.gui.lobby.vehicleBuyWindow 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.utils.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    
    public class BodyMc extends scaleform.clik.core.UIComponent
    {
        public function BodyMc()
        {
            super();
            return;
        }

        public function get selectedPrice():Number
        {
            if (this.btnGroup && this.btnGroup.selectedButton) 
                return Number(net.wg.gui.components.controls.TankmanTrainingButton(this.btnGroup.selectedButton).data);
            return NaN;
        }

        public function get isGoldPriceSelected():Boolean
        {
            if (this.btnGroup && this.btnGroup.selectedButton) 
                return net.wg.gui.components.controls.TankmanTrainingButton(this.btnGroup.selectedButton).type == "academy";
            return false;
        }

        public function get groupEnabled():Boolean
        {
            if (this.lastSelectedButton) 
                return this.lastSelectedButton.selected;
            return false;
        }

        public function set groupEnabled(arg1:Boolean):void
        {
            if (this.groupEnabled == arg1) 
                return;
            if (this.lastSelectedButton) 
                this.lastSelectedButton.selected = arg1;
            if (!arg1) 
                this.btnGroup.selectedButton = null;
            return;
        }

        public function get crewType():int
        {
            var loc1:*=null;
            if (this.btnGroup && this.btnGroup.selectedButton) 
            {
                loc1 = net.wg.gui.components.controls.TankmanTrainingButton(this.btnGroup.selectedButton);
                if (loc1.type == "academy") 
                    return 2;
                if (loc1.type == "scool") 
                    return 1;
                if (loc1.type == "free") 
                    return 0;
            }
            return -1;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.btnGroup = new scaleform.clik.controls.ButtonGroup("group1", this);
            this.btnGroup.addButton(this.academyBtn);
            this.btnGroup.addButton(this.scoolBtn);
            this.btnGroup.addButton(this.freeBtn);
            this.btnGroup.addEventListener(flash.events.Event.CHANGE, this.groupChangeHandler, false, 0, true);
            var loc1:*=App.utils.locale;
            this.slotCheckbox.label = loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_SLOTCHECKBOX);
            this.ammoCheckbox.label = loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_AMMOCHECKBOX);
            this.crewCheckbox.label = loc1.makeString(DIALOGS.BUYVEHICLEDIALOG_TANKMENCHECKBOX);
            this.academyBtn.toggle = true;
            this.academyBtn.allowDeselect = false;
            this.scoolBtn.toggle = true;
            this.scoolBtn.allowDeselect = false;
            this.freeBtn.toggle = true;
            this.freeBtn.allowDeselect = false;
            this.freeBtn.selected = true;
            return;
        }

        internal function groupChangeHandler(arg1:flash.events.Event):void
        {
            if (this.btnGroup.selectedButton) 
                this.lastSelectedButton = this.btnGroup.selectedButton;
            dispatchEvent(new flash.events.Event(BUTTONS_GROUP_SELECTION_CHANGED));
            return;
        }

        public static const BUTTONS_GROUP_SELECTION_CHANGED:String="selChanged";

        public var slotCheckbox:net.wg.gui.components.controls.CheckBox;

        public var ammoCheckbox:net.wg.gui.components.controls.CheckBox;

        public var crewCheckbox:net.wg.gui.components.controls.CheckBox;

        public var tankmenLabel:flash.text.TextField;

        public var slotPrice:net.wg.gui.components.controls.IconText;

        public var ammoPrice:net.wg.gui.components.controls.IconText;

        public var academyBtn:net.wg.gui.components.controls.TankmanTrainingButton;

        public var scoolBtn:net.wg.gui.components.controls.TankmanTrainingButton;

        public var freeBtn:net.wg.gui.components.controls.TankmanTrainingButton;

        internal var btnGroup:scaleform.clik.controls.ButtonGroup;

        internal var lastSelectedButton:scaleform.clik.controls.Button;
    }
}
