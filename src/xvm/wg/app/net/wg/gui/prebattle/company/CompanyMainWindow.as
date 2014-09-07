package net.wg.gui.prebattle.company
{
    import net.wg.gui.prebattle.meta.impl.CompanyMainWindowMeta;
    import net.wg.gui.prebattle.meta.ICompanyMainWindowMeta;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.data.constants.generated.PREBATTLE_ALIASES;
    import scaleform.clik.events.InputEvent;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    
    public class CompanyMainWindow extends CompanyMainWindowMeta implements ICompanyMainWindowMeta
    {
        
        public function CompanyMainWindow()
        {
            super();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            canMinimize = true;
            showWindowBgForm = false;
        }
        
        override public function as_loadView(param1:String, param2:String) : void
        {
            super.as_loadView(param1,param2);
            setFocus(this);
        }
        
        override protected function onViewLoadRequest(param1:RallyViewsEvent) : void
        {
            switch(param1.data.alias)
            {
                case PREBATTLE_ALIASES.COMPANY_LIST_VIEW_UI:
                    onBrowseRalliesS();
                    break;
                case PREBATTLE_ALIASES.COMPANY_ROOM_VIEW_UI:
                    if(param1.data.itemId)
                    {
                        onJoinRallyS(param1.data.itemId,param1.data.slotIndex,param1.data.peripheryID);
                    }
                    else
                    {
                        onCreateRallyS();
                    }
                    break;
            }
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            super.handleInput(param1);
            if(param1.handled)
            {
                return;
            }
            if(param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP)
            {
                showFAQWindowS();
                param1.handled = true;
            }
        }
        
        public function as_setWindowTitle(param1:String, param2:String) : void
        {
            window.setTitleIcon(param2);
            window.title = param1;
        }
    }
}
