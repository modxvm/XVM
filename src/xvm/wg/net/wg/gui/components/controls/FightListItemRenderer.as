package net.wg.gui.components.controls 
{
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.events.*;
    import scaleform.clik.events.*;
    
    public class FightListItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function FightListItemRenderer()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            return;
        }

        internal function setup():void
        {
            this.textField.text = data.label;
            this.enabled = !data.disabled;
            invalidateData();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onMousePress, false, 0, true);
            return;
        }

        internal function onMouseOverHdlr(arg1:flash.events.MouseEvent):void
        {
            return;
        }

        protected function onMouseOver(arg1:flash.events.MouseEvent):void
        {
            if (data.tooltip) 
                App.toolTipMgr.showComplex(this.data.tooltip);
            return;
        }

        protected function onMouseOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        protected function onMousePress(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            this.setup();
            return;
        }

        protected override function updateAfterStateChange():void
        {
            if (!initialized) 
                return;
            this.setup();
            dispatchEvent(new net.wg.gui.events.StateManagerEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE, state));
            return;
        }
    }
}
