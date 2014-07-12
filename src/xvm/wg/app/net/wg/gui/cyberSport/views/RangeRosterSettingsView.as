package net.wg.gui.cyberSport.views
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.gui.components.advanced.FieldSet;
    import net.wg.gui.components.advanced.ToggleButton;
    import net.wg.gui.cyberSport.controls.DoubleSlider;
    import net.wg.gui.cyberSport.controls.RosterButtonGroup;
    import net.wg.gui.rally.vo.SettingRosterVO;
    import flash.events.Event;
    import scaleform.clik.events.SliderEvent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.controls.Button;
    import net.wg.gui.cyberSport.views.events.RosterSettingsEvent;
    import flash.display.InteractiveObject;
    
    public class RangeRosterSettingsView extends UIComponent implements IViewStackContent
    {
        
        public function RangeRosterSettingsView() {
            this.selectedNations = [];
            this.selectedTypes = [];
            this.guiNations = [];
            super();
            this.guiNations = App.utils.nations.getNations();
        }
        
        private static var NATION_TYPE_GROUP:String = "rosterGroup";
        
        private static var VEHICLE_TYPE_GROUP:String = "vehicleTypeGroup";
        
        private static var UPDATE_ROSTER_DATA:String = "updateRosterData";
        
        public var flagsField:FieldSet;
        
        public var vTypeField:FieldSet;
        
        public var sliderField:FieldSet;
        
        public var usaFlag:ToggleButton;
        
        public var japanFlag:ToggleButton;
        
        public var germanyFlag:ToggleButton;
        
        public var ukFlag:ToggleButton;
        
        public var franceFlag:ToggleButton;
        
        public var chinaFlag:ToggleButton;
        
        public var ussrFlag:ToggleButton;
        
        public var heavyBtn:ToggleButton;
        
        public var mediumBtn:ToggleButton;
        
        public var lightBtn:ToggleButton;
        
        public var atSpgBtn:ToggleButton;
        
        public var spgBtn:ToggleButton;
        
        public var doubleSlider:DoubleSlider;
        
        private var nationButtonGroup:RosterButtonGroup;
        
        private var vTypeButtonGroup:RosterButtonGroup;
        
        private var flagsButtons:Array;
        
        private var vTypesButtons:Array;
        
        private var model:SettingRosterVO;
        
        private var selectedNations:Array;
        
        private var selectedTypes:Array;
        
        private var guiNations:Array;
        
        public function update(param1:Object) : void {
            if(param1 == null)
            {
                return;
            }
            this.model = param1 as SettingRosterVO;
            invalidate(UPDATE_ROSTER_DATA);
        }
        
        private function addListeners() : void {
            this.nationButtonGroup.addEventListener(Event.CHANGE,this.nationButtonGroup_changeHandler);
            this.doubleSlider.addEventListener(SliderEvent.FIRST_VALUE_CHANGE,this.doubleSlider_firstValueChangeHandler);
            this.doubleSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.doubleSlider_firstValueChangeHandler);
            this.vTypeButtonGroup.addEventListener(Event.CHANGE,this.vTypeButtonGroup_changeHandler);
        }
        
        public function removeListeners() : void {
            this.nationButtonGroup.removeEventListener(Event.CHANGE,this.nationButtonGroup_changeHandler);
            this.doubleSlider.removeEventListener(SliderEvent.FIRST_VALUE_CHANGE,this.doubleSlider_firstValueChangeHandler);
            this.doubleSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.doubleSlider_firstValueChangeHandler);
            this.vTypeButtonGroup.removeEventListener(Event.CHANGE,this.vTypeButtonGroup_changeHandler);
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.nationButtonGroup = RosterButtonGroup.getGroup(NATION_TYPE_GROUP,this);
            this.vTypeButtonGroup = RosterButtonGroup.getGroup(VEHICLE_TYPE_GROUP,this);
            this.flagsField.label = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_NATIONFIELDSET;
            this.vTypeField.label = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_VEHICLETYPE;
            this.sliderField.label = CYBERSPORT.WINDOW_ROSTERSLOTSETTINGS_VEHICLETAB_VEHICLELEVEL;
            this.flagsButtons = [this.usaFlag,this.japanFlag,this.germanyFlag,this.ukFlag,this.franceFlag,this.chinaFlag,this.ussrFlag];
            this.updateGroups(this.flagsButtons,NATION_TYPE_GROUP);
            this.vTypesButtons = [this.heavyBtn,this.mediumBtn,this.lightBtn,this.atSpgBtn,this.spgBtn];
            this.updateGroups(this.vTypesButtons,VEHICLE_TYPE_GROUP);
            this.addListeners();
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            this.removeListeners();
            this.doubleSlider.dispose();
            this.nationButtonGroup.dispose();
            this.vTypeButtonGroup.dispose();
            this.selectedNations.splice(0,this.selectedNations.length);
            this.selectedTypes.splice(0,this.selectedTypes.length);
            this.model = null;
            this.disposeItems(this.flagsButtons);
            this.flagsButtons.splice(0,this.flagsButtons.length);
            this.disposeItems(this.vTypesButtons);
            this.vTypesButtons.splice(0,this.vTypesButtons.length);
            this.guiNations.splice(0,this.guiNations.length);
        }
        
        private function disposeItems(param1:Array) : void {
            var _loc2_:uint = param1.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                IDisposable(param1[_loc3_]).dispose();
                _loc3_++;
            }
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(UPDATE_ROSTER_DATA)) && (this.model))
            {
                this.autoSelect();
            }
        }
        
        private function updateGroups(param1:Array, param2:String) : void {
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                Button(param1[_loc4_]).groupName = param2;
                if(param2 == NATION_TYPE_GROUP)
                {
                    ToggleButton(param1[_loc4_]).nationFlag = this.guiNations[_loc4_];
                }
                _loc4_++;
            }
        }
        
        private function autoSelect() : void {
            var _loc3_:Array = null;
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            var _loc1_:Array = this.model.nationIDRange;
            var _loc2_:Array = this.model.vTypeRange;
            _loc3_ = this.model.vLevelRange;
            if(_loc1_.length == 0 && _loc2_.length == 0 && _loc3_.length == 0)
            {
                this.setDefaultState();
                return;
            }
            this.removeListeners();
            var _loc4_:int = this.flagsButtons.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                _loc8_ = 0;
                while(_loc8_ < _loc1_.length)
                {
                    if(this.flagsButtons[_loc5_].data == _loc1_[_loc8_])
                    {
                        this.flagsButtons[_loc5_].selected = true;
                    }
                    _loc8_++;
                }
                _loc5_++;
            }
            var _loc6_:int = this.vTypesButtons.length;
            var _loc7_:* = 0;
            while(_loc7_ < _loc6_)
            {
                _loc9_ = 0;
                while(_loc9_ < _loc2_.length)
                {
                    if(this.vTypesButtons[_loc7_].data == _loc2_[_loc9_])
                    {
                        this.vTypesButtons[_loc7_].selected = true;
                    }
                    _loc9_++;
                }
                _loc7_++;
            }
            if(_loc3_.length > 1)
            {
                this.doubleSlider.leftValue = _loc3_[0] - 1;
                this.doubleSlider.value = _loc3_[1] - 1;
            }
            else if(_loc3_.length == 0)
            {
                this.doubleSlider.leftValue = 0;
                this.doubleSlider.value = 7;
            }
            
            this.addListeners();
            this.dispatchChangeRoster();
        }
        
        public function setDefaultState(param1:Boolean = true) : void {
            this.removeListeners();
            var _loc2_:int = this.flagsButtons.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                this.flagsButtons[_loc3_].selected = false;
                _loc3_++;
            }
            var _loc4_:int = this.vTypesButtons.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                this.vTypesButtons[_loc5_].selected = false;
                _loc5_++;
            }
            this.doubleSlider.leftValue = 0;
            this.doubleSlider.value = 7;
            this.addListeners();
            if(param1)
            {
                this.dispatchChangeRoster();
            }
        }
        
        private function nationButtonGroup_changeHandler(param1:Event) : void {
            this.selectedNations = this.nationButtonGroup.rangeData;
            this.model.nationIDRange = this.selectedNations;
            this.dispatchChangeRoster();
        }
        
        private function vTypeButtonGroup_changeHandler(param1:Event) : void {
            this.selectedTypes = this.vTypeButtonGroup.rangeData;
            this.model.vTypeRange = this.selectedTypes;
            this.dispatchChangeRoster();
        }
        
        private function doubleSlider_firstValueChangeHandler(param1:SliderEvent) : void {
            if(param1.type == SliderEvent.FIRST_VALUE_CHANGE)
            {
                this.model.vLevelRange[0] = param1.value + 1;
                if(this.model.vLevelRange[1] == null)
                {
                    this.model.vLevelRange[1] = 8;
                }
            }
            else if(param1.type == SliderEvent.VALUE_CHANGE)
            {
                this.model.vLevelRange[1] = param1.value + 1;
                if(this.model.vLevelRange[0] == null)
                {
                    this.model.vLevelRange[0] = 1;
                }
            }
            
            this.dispatchChangeRoster();
        }
        
        private function checkSliderValues() : void {
            var _loc1_:int = this.doubleSlider.leftValue + 1;
            var _loc2_:int = this.doubleSlider.value + 1;
            if(_loc1_ == 1 && _loc2_ == 8)
            {
                this.model.vLevelRange = [];
            }
        }
        
        private function dispatchChangeRoster() : void {
            this.checkSliderValues();
            dispatchEvent(new RosterSettingsEvent(RosterSettingsEvent.RANGE_ROSTER_CHANGED,this.model));
        }
        
        public function getComponentForFocus() : InteractiveObject {
            return null;
        }
        
        public function canShowAutomatically() : Boolean {
            return true;
        }
    }
}
