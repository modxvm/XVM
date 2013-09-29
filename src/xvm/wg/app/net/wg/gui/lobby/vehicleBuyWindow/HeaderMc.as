package net.wg.gui.lobby.vehicleBuyWindow 
{
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class HeaderMc extends scaleform.clik.core.UIComponent
    {
        public function HeaderMc()
        {
            super();
            return;
        }

        public var tankName:flash.text.TextField;

        public var icon:net.wg.gui.components.advanced.TankIcon;

        public var tankDescr:net.wg.gui.components.advanced.TextAreaSimple;

        public var tankPriceLabel:flash.text.TextField;

        public var tankPrice:net.wg.gui.components.controls.IconText;

        public var descriptionScrollBar:net.wg.gui.components.controls.ScrollBar;
    }
}
