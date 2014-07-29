package net.wg.gui.lobby.window
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.IconText;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import net.wg.gui.events.UILoaderEvent;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.Errors;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import flash.ui.Keyboard;
    import flash.events.Event;
    import avmplus.getQualifiedClassName;
    
    public class ExchangeXPFromVehicleIR extends SoundListItemRenderer
    {
        
        public function ExchangeXPFromVehicleIR()
        {
            super();
        }
        
        private static var SELECTION_INVALIDATE:String = "selInv";
        
        private static var DATA_INVALIDATE:String = "dataInv";
        
        public static var SELECTION_CHANGED:String = "IrSelectionChanged";
        
        private static var MY_STATE_PREFIXES:Vector.<String> = Vector.<String>(["cbselection_",""]);
        
        public var vehicleIcon:UILoaderAlt;
        
        public var vehicleTypeIcon:UILoaderAlt;
        
        public var checkboxVehicle:CheckBox;
        
        public var xpLabel:IconText;
        
        public var vehicleName:TextField;
        
        public var vehicleNation:UILoaderAlt;
        
        public var background:MovieClip;
        
        public var clickArea:MovieClip;
        
        public var mcGreyAssets:MovieClip;
        
        private var vehicleData:ExchangeXPVehicleVO;
        
        override protected function preInitialize() : void
        {
            super.preInitialize();
            constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
            _toggle = false;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            constraints.addElement(focusIndicator.name,focusIndicator,Constraints.ALL);
            constraints.addElement(this.background.name,this.background,Constraints.ALL);
            constraints.addElement(this.xpLabel.name,this.xpLabel,Constraints.RIGHT);
            constraints.addElement(this.mcGreyAssets.name,this.mcGreyAssets,Constraints.LEFT);
            constraints.addElement(this.checkboxVehicle.name,this.checkboxVehicle,Constraints.LEFT);
            this.vehicleNation.addEventListener(UILoaderEvent.IOERROR,this.nationIconLoadingError,false,0,true);
            setState("up");
        }
        
        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            super.handleMouseRelease(param1);
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
            if(_loc3_ == MouseEventEx.LEFT_BUTTON)
            {
                if(App.utils)
                {
                    App.utils.asserter.assertNotNull("vehicleData in ExchangeXPFromVehicleIR" + Errors.CANT_NULL,this.toString());
                }
                this.toggleSelection();
            }
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            super.handleInput(param1);
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.value == InputValue.KEY_UP)
            {
                if(_loc2_.code == Keyboard.ENTER || _loc2_.code == Keyboard.SPACE)
                {
                    this.toggleSelection();
                }
                param1.handled = true;
            }
        }
        
        private function toggleSelection() : void
        {
            this.vehicleData.isSelectCandidate = !this.vehicleData.isSelectCandidate;
            invalidate(SELECTION_INVALIDATE);
            dispatchEvent(new Event(SELECTION_CHANGED,true));
        }
        
        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this.vehicleData = ExchangeXPVehicleVO(param1);
            invalidate(DATA_INVALIDATE);
        }
        
        override public function get data() : Object
        {
            return this.vehicleData;
        }
        
        override protected function draw() : void
        {
            if(isInvalid(DATA_INVALIDATE))
            {
                if(this.vehicleData)
                {
                    this.xpLabel.text = App.utils?App.utils.locale.integer(this.vehicleData.xp):this.vehicleData.xp.toString();
                    this.xpLabel.visible = true;
                    this.checkboxVehicle.visible = true;
                    this.checkboxVehicle.tabEnabled = false;
                    this.vehicleName.visible = true;
                    this.vehicleName.text = this.vehicleData.vehicleName;
                    this.mcGreyAssets.visible = true;
                    this.vehicleIcon.visible = true;
                    this.vehicleIcon.source = this.vehicleData.vehicleIco;
                    buttonMode = true;
                    this.vehicleTypeIcon.source = this.vehicleData.vehicleType;
                    this.vehicleNation.source = this.vehicleData.nationIco;
                    invalidate(SELECTION_INVALIDATE);
                }
                else
                {
                    buttonMode = false;
                    this.xpLabel.visible = false;
                    this.mcGreyAssets.visible = false;
                    this.checkboxVehicle.visible = false;
                    this.vehicleName.visible = false;
                    this.vehicleIcon.visible = false;
                    this.vehicleTypeIcon.source = null;
                    this.vehicleNation.source = null;
                }
            }
            if(isInvalid(SELECTION_INVALIDATE))
            {
                if(this.vehicleData)
                {
                    this.checkboxVehicle.selected = this.vehicleData.isSelectCandidate;
                    setState(state);
                }
            }
            super.draw();
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            return (this.vehicleData) && (this.vehicleData.isSelectCandidate)?MY_STATE_PREFIXES:statesDefault;
        }
        
        private function nationIconLoadingError(param1:UILoaderEvent) : void
        {
            var _loc2_:String = "Flash :: Couldn\'t Load Nations Icon, " + getQualifiedClassName(this) + ", Row Number = " + index;
            DebugUtils.LOG_ERROR(_loc2_);
        }
        
        override protected function updateAfterStateChange() : void
        {
            super.updateAfterStateChange();
            constraints.updateElement(focusIndicator.name,focusIndicator);
            constraints.updateElement(this.background.name,this.background);
            constraints.updateElement(this.xpLabel.name,this.xpLabel);
            constraints.updateElement(this.mcGreyAssets.name,this.mcGreyAssets);
            constraints.updateElement(this.checkboxVehicle.name,this.checkboxVehicle);
        }
    }
}
