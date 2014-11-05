package net.wg.gui.cyberSport
{
    import net.wg.infrastructure.base.meta.impl.CyberSportMainWindowMeta;
    import net.wg.infrastructure.base.meta.ICyberSportMainWindowMeta;
    import net.wg.gui.cyberSport.views.UnitsListView;
    import net.wg.gui.cyberSport.views.IntroView;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import net.wg.gui.cyberSport.views.UnitView;
    
    public class CyberSportMainWindow extends CyberSportMainWindowMeta implements ICyberSportMainWindowMeta
    {
        
        public function CyberSportMainWindow()
        {
            super();
            showWindowBgForm = true;
            canMinimize = true;
            visible = true;
        }
        
        override protected function getWindowTitle() : String
        {
            return CYBERSPORT.WINDOW_TITLE;
        }
        
        override protected function updateFocus() : void
        {
            if(autoSearch.visible)
            {
                autoSearchUpdateFocus();
            }
            else if(getCurrentView() is UnitsListView)
            {
                setFocus((getCurrentView() as UnitsListView).rallyTable);
            }
            else if(getCurrentView() is IntroView)
            {
                setFocus((getCurrentView() as IntroView).autoMatchBtn);
            }
            else
            {
                super.updateFocus();
            }
            
            
        }
        
        override protected function onViewLoadRequest(param1:RallyViewsEvent) : void
        {
            if(!param1.data)
            {
                return;
            }
            switch(param1.data.alias)
            {
                case CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI:
                    onBrowseRalliesS();
                    break;
                case CYBER_SPORT_ALIASES.UNIT_VIEW_UI:
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
            if(param1.handled)
            {
                return;
            }
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
            {
                if(autoSearch.visible)
                {
                    autoSearch.handleInput(param1);
                }
                else if(canGoBackS())
                {
                    param1.handled = true;
                    if(getCurrentView() is UnitView && (UnitView(getCurrentView()).rosterTeamContext))
                    {
                        UnitView(getCurrentView()).preInitFadeAnimationCancel();
                    }
                    else
                    {
                        onBackClickS();
                    }
                }
                else if(window.getCloseBtn().enabled)
                {
                    param1.handled = true;
                    onWindowCloseS();
                }
                
                
            }
        }
    }
}
