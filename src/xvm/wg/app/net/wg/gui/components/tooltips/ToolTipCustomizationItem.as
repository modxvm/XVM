package net.wg.gui.components.tooltips
{
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.tooltips.VO.CustomizationItemVO;
    
    public class ToolTipCustomizationItem extends ToolTipBase
    {
        
        public function ToolTipCustomizationItem()
        {
            super();
            this.headerTF = content.headerTF;
            this.kindTF = content.kindTF;
            this.descriptionTF = content.descriptionTF;
            this.timeLeftTF = content.timeLeftTF;
            this.vehicleTypeTF = content.vehicleTypeTF;
            this.init();
        }
        
        private static var TOP_PADDINGS_IDX:int = 0;
        
        private static var LEFT_PADDINGS_IDX:int = 1;
        
        private static var BOTTOM_PADDING:int = 20;
        
        private var headerTF:TextField = null;
        
        private var kindTF:TextField = null;
        
        private var descriptionTF:TextField = null;
        
        private var timeLeftTF:TextField = null;
        
        private var vehicleTypeTF:TextField = null;
        
        private var paddings:Object = null;
        
        private var displayedElements:Vector.<DisplayObject> = null;
        
        override protected function redraw() : void
        {
            super.redraw();
            this.updateTextFieldsFromData();
            this.updateSize();
        }
        
        override protected function onDispose() : void
        {
            this.headerTF = null;
            this.kindTF = null;
            this.descriptionTF = null;
            this.timeLeftTF = null;
            this.vehicleTypeTF = null;
            while(this.displayedElements.length > 0)
            {
                removeChild(this.displayedElements.pop());
            }
            this.displayedElements = null;
            this.paddings = App.utils.commons.cleanupDynamicObject(this.paddings);
            super.onDispose();
        }
        
        override protected function updateSize() : void
        {
            super.updateSize();
            var _loc1_:int = this.displayedElements.length;
            var _loc2_:int = _loc1_ - 1;
            while(_loc2_ > 0)
            {
                if(this.displayedElements[_loc2_].visible)
                {
                    background.height = this.displayedElements[_loc2_].y + this.displayedElements[_loc2_].height + BOTTOM_PADDING;
                    break;
                }
                _loc2_--;
            }
        }
        
        private function getNewSeparator() : Separator
        {
            return Utils.instance.createSeparate(content);
        }
        
        private function init() : void
        {
            var _loc1_:Separator = this.getNewSeparator();
            var _loc2_:Separator = this.getNewSeparator();
            var _loc3_:Separator = this.getNewSeparator();
            this.displayedElements = new <DisplayObject>[this.headerTF,this.kindTF,_loc1_,this.descriptionTF,_loc2_,this.timeLeftTF,_loc3_,this.vehicleTypeTF];
            this.paddings = {};
            this.paddings[this.headerTF.name] = [16,20];
            this.paddings[this.kindTF.name] = [-2,20];
            this.paddings[_loc1_.name] = [11,0];
            this.paddings[this.descriptionTF.name] = [8,20];
            this.paddings[_loc2_.name] = [14,0];
            this.paddings[this.timeLeftTF.name] = [7,20];
            this.paddings[_loc3_.name] = [10,0];
            this.paddings[this.vehicleTypeTF.name] = [7,20];
            this.customizeTextFields();
        }
        
        private function updatePositions() : void
        {
            var _loc4_:DisplayObject = null;
            var _loc1_:* = 0;
            var _loc2_:int = this.displayedElements.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = this.displayedElements[_loc3_];
                if(_loc4_.visible)
                {
                    _loc4_.x = this.getPaddingForElement(_loc4_,LEFT_PADDINGS_IDX);
                    _loc4_.y = this.getPaddingForElement(_loc4_,TOP_PADDINGS_IDX) + _loc1_;
                    _loc1_ = _loc4_.y + _loc4_.height;
                }
                _loc3_++;
            }
        }
        
        private function getPaddingForElement(param1:DisplayObject, param2:int) : int
        {
            return this.paddings[param1.name][param2];
        }
        
        private function customizeTextFields() : void
        {
            var _loc3_:TextField = null;
            var _loc1_:int = this.displayedElements.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = this.displayedElements[_loc2_] as TextField;
                if(_loc3_ != null)
                {
                    _loc3_.autoSize = TextFieldAutoSize.LEFT;
                    _loc3_.selectable = false;
                }
                _loc2_++;
            }
        }
        
        private function changeVisibility(param1:TextField, param2:Boolean) : void
        {
            var _loc3_:int = this.displayedElements.indexOf(param1);
            this.displayedElements[_loc3_].visible = param2;
            if(_loc3_ - 1 >= 0 && this.displayedElements[_loc3_ - 1] is Separator)
            {
                this.displayedElements[_loc3_ - 1].visible = param2;
            }
        }
        
        private function updateTextFieldsFromData() : void
        {
            var _loc1_:CustomizationItemVO = new CustomizationItemVO(_data);
            this.headerTF.htmlText = _loc1_.header;
            this.kindTF.htmlText = _loc1_.kind;
            this.descriptionTF.htmlText = _loc1_.description;
            this.changeVisibility(this.descriptionTF,_loc1_.description.length > 0);
            this.timeLeftTF.htmlText = _loc1_.timeLeft;
            this.changeVisibility(this.timeLeftTF,_loc1_.timeLeft.length > 0);
            this.vehicleTypeTF.htmlText = _loc1_.vehicleType;
            this.changeVisibility(this.vehicleTypeTF,_loc1_.vehicleType.length > 0);
            this.updatePositions();
        }
    }
}
