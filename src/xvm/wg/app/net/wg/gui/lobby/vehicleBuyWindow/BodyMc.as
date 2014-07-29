package net.wg.gui.lobby.vehicleBuyWindow
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.CheckBox;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.ActionPrice;
    import net.wg.gui.components.controls.TankmanTrainingButton;
    import scaleform.clik.controls.ButtonGroup;
    import scaleform.clik.controls.Button;
    import flash.events.Event;
    import net.wg.utils.ILocale;
    import net.wg.data.constants.SoundTypes;
    
    public class BodyMc extends UIComponent
    {
        
        public function BodyMc()
        {
            super();
        }
        
        public static var BUTTONS_GROUP_SELECTION_CHANGED:String = "selChanged";
        
        public var slotCheckbox:CheckBox;
        
        public var ammoCheckbox:CheckBox;
        
        public var crewCheckbox:CheckBox;
        
        public var tankmenLabel:TextField;
        
        public var slotPrice:IconText;
        
        public var ammoPrice:IconText;
        
        public var slotActionPrice:ActionPrice;
        
        public var ammoActionPrice:ActionPrice;
        
        public var academyBtn:TankmanTrainingButton;
        
        public var scoolBtn:TankmanTrainingButton;
        
        public var freeBtn:TankmanTrainingButton;
        
        private var btnGroup:ButtonGroup;
        
        private var lastSelectedButton:Button;
        
        public function get selectedPrice() : Number
        {
            if((this.btnGroup) && (this.btnGroup.selectedButton))
            {
                return Number(TankmanTrainingButton(this.btnGroup.selectedButton).data);
            }
            return NaN;
        }
        
        public function get isGoldPriceSelected() : Boolean
        {
            if((this.btnGroup) && (this.btnGroup.selectedButton))
            {
                return TankmanTrainingButton(this.btnGroup.selectedButton).type == "academy";
            }
            return false;
        }
        
        public function get groupEnabled() : Boolean
        {
            if(this.lastSelectedButton)
            {
                return this.lastSelectedButton.selected;
            }
            return false;
        }
        
        public function set groupEnabled(param1:Boolean) : void
        {
            if(this.groupEnabled == param1)
            {
                return;
            }
            if(this.lastSelectedButton)
            {
                this.lastSelectedButton.selected = param1;
            }
            if(!param1)
            {
                this.btnGroup.selectedButton = null;
            }
        }
        
        public function get crewType() : int
        {
            var _loc1_:TankmanTrainingButton = null;
            if((this.btnGroup) && (this.btnGroup.selectedButton))
            {
                _loc1_ = TankmanTrainingButton(this.btnGroup.selectedButton);
                if(_loc1_.type == "academy")
                {
                    return 2;
                }
                if(_loc1_.type == "scool")
                {
                    return 1;
                }
                if(_loc1_.type == "free")
                {
                    return 0;
                }
            }
            return -1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:* = "scoolGroup";
            this.btnGroup = new ButtonGroup(_loc1_,this);
            this.btnGroup.addButton(this.academyBtn);
            this.btnGroup.addButton(this.scoolBtn);
            this.btnGroup.addButton(this.freeBtn);
            this.academyBtn.groupName = _loc1_;
            this.scoolBtn.groupName = _loc1_;
            this.freeBtn.groupName = _loc1_;
            this.btnGroup.addEventListener(Event.CHANGE,this.groupChangeHandler,false,0,true);
            var _loc2_:ILocale = App.utils.locale;
            this.slotCheckbox.label = _loc2_.makeString(DIALOGS.BUYVEHICLEDIALOG_SLOTCHECKBOX);
            this.ammoCheckbox.label = _loc2_.makeString(DIALOGS.BUYVEHICLEDIALOG_AMMOCHECKBOX);
            this.crewCheckbox.label = _loc2_.makeString(DIALOGS.BUYVEHICLEDIALOG_TANKMENCHECKBOX);
            this.academyBtn.toggle = true;
            this.academyBtn.allowDeselect = false;
            this.scoolBtn.toggle = true;
            this.scoolBtn.allowDeselect = false;
            this.freeBtn.toggle = true;
            this.freeBtn.allowDeselect = false;
            this.freeBtn.selected = true;
            this.academyBtn.soundType = SoundTypes.RNDR_NORMAL;
            this.scoolBtn.soundType = SoundTypes.RNDR_NORMAL;
            this.freeBtn.soundType = SoundTypes.RNDR_NORMAL;
        }
        
        private function groupChangeHandler(param1:Event) : void
        {
            if(this.btnGroup.selectedButton)
            {
                this.lastSelectedButton = this.btnGroup.selectedButton;
            }
            dispatchEvent(new Event(BUTTONS_GROUP_SELECTION_CHANGED));
        }
        
        override protected function onDispose() : void
        {
            this.slotActionPrice.dispose();
            this.slotActionPrice = null;
            this.ammoActionPrice.dispose();
            this.ammoActionPrice = null;
            this.academyBtn.dispose();
            this.scoolBtn.dispose();
            this.freeBtn.dispose();
            super.onDispose();
        }
    }
}
