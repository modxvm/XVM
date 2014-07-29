package net.wg.gui.components.controls
{
    import flash.display.MovieClip;
    import flash.geom.Point;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    import net.wg.data.constants.SoundTypes;
    
    public class DropDownListItemRendererSound extends SoundListItemRenderer
    {
        
        public function DropDownListItemRendererSound()
        {
            super();
            soundType = SoundTypes.DROPDN_ITEM_RNDR;
        }
        
        public var focusElement:MovieClip;
        
        override public function toString() : String
        {
            return "[WG DropDownListItemRendererSound " + name + "]";
        }
        
        override protected function updateText() : void
        {
            if(!(_label == null) && !(textField == null))
            {
                textField.htmlText = _label;
            }
        }
        
        override protected function draw() : void
        {
            var _loc1_:Point = null;
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
            }
            super.draw();
        }
        
        override protected function configUI() : void
        {
            if(this.focusElement)
            {
                focusIndicator = this.focusElement;
            }
            buttonMode = true;
            super.configUI();
        }
    }
}
