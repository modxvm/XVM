package net.wg.gui.lobby.customization 
{
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class CamoDropButton extends scaleform.clik.controls.Button
    {
        public function CamoDropButton()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClick, false, 0, true);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClick);
            return;
        }

        internal function onClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=new net.wg.gui.lobby.customization.CustomizationEvent(net.wg.gui.lobby.customization.CustomizationEvent.DROP_ITEM);
            loc1.kind = this.kind;
            dispatchEvent(loc1);
            return;
        }

        public var kind:int=-1;
    }
}
