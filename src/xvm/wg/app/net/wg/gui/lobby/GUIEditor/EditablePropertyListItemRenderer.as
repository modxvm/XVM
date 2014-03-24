package net.wg.gui.lobby.GUIEditor
{
   import scaleform.clik.controls.ListItemRenderer;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.geom.Point;
   import net.wg.gui.lobby.GUIEditor.data.ComponentPropertyVO;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.GUIEditor.data.PropTypes;
   import flash.events.Event;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;


   public class EditablePropertyListItemRenderer extends ListItemRenderer
   {
          
      public function EditablePropertyListItemRenderer() {
         super();
      }

      public var valueField:TextField = null;

      public var flag:CheckBox = null;

      public var value:NumericStepper = null;

      public var valueSlider:NumericStepper = null;

      public var slider:Slider = null;

      public var statesDropDn:DropdownMenu = null;

      override public function setData(param1:Object) : void {
         super.setData(param1);
         invalidateData();
      }

      override protected function onDispose() : void {
         this.removeInputHandlers();
         if(this.valueField)
         {
            this.valueField = null;
         }
         textField = null;
         if(this.flag)
         {
            this.flag.dispose();
            this.flag = null;
         }
         if(this.value)
         {
            this.value.dispose();
            this.value = null;
         }
         if(this.slider)
         {
            this.slider.dispose();
            this.slider = null;
            this.valueSlider.dispose();
            this.valueSlider = null;
         }
         if(this.statesDropDn)
         {
            this.statesDropDn.dispose();
            this.statesDropDn = null;
         }
         super.onDispose();
      }

      override protected function draw() : void {
         var _loc1_:Point = null;
         var _loc2_:ComponentPropertyVO = null;
         var _loc3_:String = null;
         super.draw();
         _focusable = tabEnabled = tabChildren = mouseChildren = true;
         mouseEnabled = true;
         if(isInvalid(InvalidationType.DATA))
         {
            if(enabled)
            {
               _loc1_ = new Point(mouseX,mouseY);
               _loc1_ = this.localToGlobal(_loc1_);
               if(this.hitTestPoint(_loc1_.x,_loc1_.y,true))
               {
                  setState("over");
                  dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
               }
            }
            if(data != null)
            {
               _loc2_ = ComponentPropertyVO(data);
               if(textField != null)
               {
                  textField.text = _loc2_.name;
               }
               _loc3_ = _loc2_.canModify?"":"Disabled";
               this.removeInputHandlers();
               gotoAndStop(_loc2_.type + _loc3_);
               switch(_loc2_.type)
               {
                  case PropTypes.STRING:
                     this.customizeStringType(_loc2_);
                     break;
                  case PropTypes.FLAG:
                     this.customizeFlagType(_loc2_);
                     break;
                  case PropTypes.NUMBER:
                     this.customizeNumberType(_loc2_);
                     break;
                  case PropTypes.CONSTRAINED_NUMBER:
                     this.customizeConstrainedNumberType(_loc2_);
                     break;
                  case PropTypes.STATES:
                     this.customizeStateType(_loc2_);
                     break;
               }
            }
         }
      }

      private function customizeStringType(param1:ComponentPropertyVO) : void {
         this.valueField.text = param1.value;
         this.valueField.addEventListener(Event.CHANGE,this.onTextInputHandler);
      }

      private function customizeFlagType(param1:ComponentPropertyVO) : void {
         this.flag.selected = param1.value;
         this.flag.label = "";
         this.flag.addEventListener(Event.SELECT,this.onFlagChangedHandler);
      }

      private function customizeNumberType(param1:ComponentPropertyVO) : void {
         if(param1.allowedValues.length == 2)
         {
            this.value.minimum = param1.allowedValues[0];
            this.value.validateNow();
            this.value.maximum = param1.allowedValues[1];
            this.value.validateNow();
            this.value.stepSize = 1;
            this.value.validateNow();
         }
         this.value.value = param1.value;
         this.value.validateNow();
         this.value.addEventListener(IndexEvent.INDEX_CHANGE,this.onValueChangeHandler);
      }

      private function customizeConstrainedNumberType(param1:ComponentPropertyVO) : void {
         this.slider.minimum = param1.allowedValues[0];
         this.slider.maximum = param1.allowedValues[1];
         this.slider.snapInterval = (this.slider.maximum - this.slider.minimum) / this.slider.width;
         this.slider.value = param1.value;
         this.slider.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
         if(param1.allowedValues.length == 2)
         {
            this.valueSlider.minimum = param1.allowedValues[0];
            this.valueSlider.validateNow();
            this.valueSlider.maximum = param1.allowedValues[1];
            this.valueSlider.stepSize = (this.slider.maximum - this.slider.minimum) / 100;
            this.valueSlider.validateNow();
         }
         this.valueSlider.value = param1.value;
         this.valueSlider.validateNow();
         this.valueSlider.addEventListener(IndexEvent.INDEX_CHANGE,this.onValueForSliderChangeHandler);
      }

      private function customizeStateType(param1:ComponentPropertyVO) : void {
         this.statesDropDn.dataProvider = new DataProvider(param1.allowedValues);
         this.statesDropDn.selectedIndex = param1.allowedValues.indexOf(param1.value);
         this.statesDropDn.addEventListener(ListEvent.INDEX_CHANGE,this.onStateChangeHandler);
      }

      private function removeInputHandlers() : void {
         if(this.valueField)
         {
            this.valueField.removeEventListener(Event.CHANGE,this.onTextInputHandler);
         }
         if(this.flag)
         {
            this.flag.removeEventListener(Event.SELECT,this.onFlagChangedHandler);
         }
         if(this.value)
         {
            this.value.removeEventListener(IndexEvent.INDEX_CHANGE,this.onValueChangeHandler);
         }
         if(this.slider)
         {
            if(this.valueSlider != null)
            {
               this.valueSlider.removeEventListener(IndexEvent.INDEX_CHANGE,this.onValueForSliderChangeHandler);
            }
            this.slider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
         }
         if(this.statesDropDn)
         {
            this.statesDropDn.removeEventListener(ListEvent.INDEX_CHANGE,this.onStateChangeHandler);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         _focusable = tabEnabled = tabChildren = mouseChildren = true;
         mouseEnabled = true;
      }

      private function onTextInputHandler(param1:Event) : void {
         this.dispatchChangeProperty(this.valueField.text);
      }

      private function onFlagChangedHandler(param1:Event) : void {
         this.dispatchChangeProperty(this.flag.selected);
      }

      private function onValueForSliderChangeHandler(param1:Event) : void {
         this.slider.value = this.valueSlider.value;
         this.dispatchChangeProperty(this.slider.value);
      }

      private function onSliderValueChangeHandler(param1:SliderEvent) : void {
         if(this.valueSlider != null)
         {
            this.valueSlider.value = this.slider.value;
         }
         this.dispatchChangeProperty(this.slider.value);
      }

      private function onValueChangeHandler(param1:IndexEvent) : void {
         this.dispatchChangeProperty(this.value.value);
      }

      private function onStateChangeHandler(param1:ListEvent) : void {
         this.dispatchChangeProperty(this.statesDropDn.dataProvider[this.statesDropDn.selectedIndex]);
      }

      private function dispatchChangeProperty(param1:*) : void {
         dispatchEvent(new ChangePropertyEvent(ChangePropertyEvent.CHANGE_PROPERTY,ComponentPropertyVO(data),param1));
      }
   }

}