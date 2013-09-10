package net.wg.gui.lobby.techtree.controls 
{
    import flash.text.*;
    import scaleform.clik.constants.*;
    
    public class ExperienceLabel extends net.wg.gui.lobby.techtree.controls.NodeComponent
    {
        public function ExperienceLabel()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            var loc1:*;
            mouseChildren = loc1 = false;
            mouseEnabled = loc1;
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (!(_owner == null) && isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                loc1 = this.xpLabel.length > 0 ? _owner.getNamedLabel(this.xpLabel) : "";
                this.setXpField(loc1);
                if (this.xpIcon != null) 
                    this.xpIcon.validateNow();
            }
            super.draw();
            return;
        }

        internal function setXpField(arg1:String):void
        {
            if (this.textField != null) 
                this.textField.text = arg1;
            return;
        }

        public var xpLabel:String="xpCostLabel";

        public var textField:flash.text.TextField;

        public var xpIcon:net.wg.gui.lobby.techtree.controls.XPIcon;
    }
}
