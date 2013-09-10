package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import scaleform.clik.constants.*;
    
    public class DropDownListItemRendererSound extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function DropDownListItemRendererSound()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.DROPDN_ITEM_RNDR;
            return;
        }

        public override function toString():String
        {
            return "[WG DropDownListItemRendererSound " + name + "]";
        }

        protected override function updateText():void
        {
            if (!(_label == null) && !(textField == null)) 
                textField.htmlText = _label;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
                if (enabled) 
                {
                    loc1 = new flash.geom.Point(mouseX, mouseY);
                    loc1 = this.localToGlobal(loc1);
                    if (this.hitTestPoint(loc1.x, loc1.y, true)) 
                    {
                        setState("over");
                        dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.ROLL_OVER));
                    }
                }
            super.draw();
            return;
        }

        protected override function configUI():void
        {
            if (this.focusElement) 
                focusIndicator = this.focusElement;
            buttonMode = true;
            super.configUI();
            return;
        }

        public var focusElement:flash.display.MovieClip;
    }
}
