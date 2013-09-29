package net.wg.gui.lobby.messengerBar.carousel 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class ChannelButton extends net.wg.gui.components.advanced.BlinkingButton implements net.wg.infrastructure.interfaces.IDynamicContent
    {
        public function ChannelButton()
        {
            super();
            constraintsDisabled = true;
            _iconOffsetLeft = 1;
            _iconOffsetTop = 1;
            return;
        }

        public override function set label(arg1:String):void
        {
            super.label = arg1;
            tooltip = "";
            return;
        }

        public override function set iconSource(arg1:String):void
        {
            if (iconSource != arg1) 
            {
                super.iconSource = arg1;
                setState(state);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            var loc1:*=iconSource ? "icon_" : "";
            if (blinking) 
            {
                return Vector.<String>(_selected ? ["selected_", loc1 + "blinking_"] : [loc1 + "blinking_"]);
            }
            return Vector.<String>(_selected ? ["selected_", loc1] : [loc1]);
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            if (tooltip) 
            {
                App.toolTipMgr.show(tooltip);
            }
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            App.toolTipMgr.hide();
            return;
        }

        protected override function updateText():void
        {
            if (!(_label == null) && !(textField == null)) 
            {
                textField.text = _label;
                this.truncateText();
            }
            return;
        }

        internal function truncateText():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            if (textField.textWidth > textField.width) 
            {
                tooltip = _label;
                loc1 = textField.text.length > 0 ? textField.text : _label;
                loc2 = loc1;
                loc3 = 1;
                while (loc2.length > 0 && loc3 > 0) 
                {
                    loc2 = loc1.substring(0, loc1.length - loc3) + "..";
                    textField.text = loc2;
                    if (textField.textWidth > textField.width) 
                    {
                        ++loc3;
                        continue;
                    }
                    loc3 = 0;
                }
            }
            return;
        }
    }
}
