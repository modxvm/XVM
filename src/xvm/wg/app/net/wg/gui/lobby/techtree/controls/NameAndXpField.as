package net.wg.gui.lobby.techtree.controls 
{
    import flash.text.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import scaleform.clik.constants.*;
    
    public class NameAndXpField extends net.wg.gui.lobby.techtree.controls.NodeComponent
    {
        public function NameAndXpField()
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
            var loc2:*=null;
            if (!(_owner == null) && isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                loc1 = this.xpLabel.length > 0 ? _owner.getNamedLabel(this.xpLabel) : "";
                loc2 = statesMap[state][loc1.length > 0 ? 1 : 0];
                if (!(currentFrameLabel == loc2) && _labelHash[loc2]) 
                {
                    gotoAndStop(loc2);
                }
                this.setNameField(_owner.getItemName());
                this.setXpField(loc1);
                if (this.changeXpIconToElite) 
                {
                    if (_owner.isElite()) 
                    {
                        this.setXpIcon(net.wg.gui.lobby.techtree.constants.XpTypeStrings.ELITE_XP_TYPE);
                    }
                    else 
                    {
                        this.setXpIcon(net.wg.gui.lobby.techtree.constants.XpTypeStrings.EARNED_XP_TYPE);
                    }
                }
            }
            super.draw();
            return;
        }

        internal function setNameField(arg1:String):void
        {
            if (!(this.nameField == null) && !(arg1 == null)) 
            {
                this.nameField.text = arg1;
            }
            return;
        }

        internal function setXpField(arg1:String):void
        {
            if (!(this.xpField == null) && !(arg1 == null)) 
            {
                this.xpField.text = arg1;
            }
            return;
        }

        internal function setXpIcon(arg1:String):void
        {
            if (this.xpIcon != null) 
            {
                this.xpIcon.type = arg1;
                this.xpIcon.validateNow();
            }
            return;
        }

        internal static const statesMap:Object={"locked":["locked", "locked"], "normal":["normal_name", "normal_name_and_xp"], "premium":["premium_name", "premium_name_and_xp"]};

        public var xpLabel:String="earnedXPLabel";

        public var changeXpIconToElite:Boolean=false;

        public var nameField:flash.text.TextField;

        public var xpField:flash.text.TextField;

        public var xpIcon:net.wg.gui.lobby.techtree.controls.XPIcon;
    }
}
