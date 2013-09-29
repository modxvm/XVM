package net.wg.gui.components.controls 
{
    import net.wg.data.components.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class AccordionSoundRenderer extends net.wg.gui.components.controls.SoundListItemRenderer implements net.wg.infrastructure.interfaces.IAccordionItemRenderer
    {
        public function AccordionSoundRenderer()
        {
            super();
            focusable = false;
            toggle = false;
            return;
        }

        public function set enableConstraints(arg1:Boolean):void
        {
            this._enableConstraints = arg1;
            return;
        }

        protected override function configUI():void
        {
            soundType = net.wg.data.constants.SoundTypes.ACCORDION;
            constraintsDisabled = !this._enableConstraints;
            super.configUI();
            return;
        }

        public override function set data(arg1:Object):void
        {
            var loc1:*=arg1 as net.wg.data.components.AccordionRendererData;
            if (loc1) 
            {
                enabled = loc1.enabled;
                label = loc1.label;
            }
            super.data = arg1;
            return;
        }

        internal var _enableConstraints:Boolean=false;
    }
}
