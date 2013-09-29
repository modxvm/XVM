package net.wg.gui.lobby.store 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class NationFilter extends scaleform.clik.core.UIComponent
    {
        public function NationFilter()
        {
            super();
            return;
        }

        public var nation:net.wg.gui.components.controls.NationDropDownMenu=null;

        public var textField:flash.text.TextField=null;
    }
}
