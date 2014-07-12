package net.wg.gui.lobby.store
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IStoreTable;
    import net.wg.gui.components.advanced.Accordion;
    import net.wg.gui.components.controls.TextFieldShort;
    import net.wg.gui.components.controls.CloseButton;
    
    public class StoreForm extends UIComponent
    {
        
        public function StoreForm() {
            super();
        }
        
        public var storeTable:IStoreTable = null;
        
        public var menu:Accordion = null;
        
        public var title:TextFieldShort = null;
        
        public var nationFilter:NationFilter = null;
        
        public var closeButton:CloseButton = null;
    }
}
