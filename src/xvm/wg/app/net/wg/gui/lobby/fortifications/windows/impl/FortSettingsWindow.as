package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortSettingsWindowMeta;
    import net.wg.infrastructure.base.meta.IFortSettingsWindowMeta;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.settings.IFortSettingsContainer;
    import flash.display.MovieClip;
    import net.wg.gui.components.advanced.ViewStack;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsActivatedViewVO;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsNotActivatedViewVO;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsClanInfoVO;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.fortifications.events.FortSettingsEvent;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.gui.lobby.fortifications.settings.IFortSettingsActivatedContainer;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import flash.text.TextFormatAlign;
    import scaleform.gfx.TextFieldEx;
    
    public class FortSettingsWindow extends FortSettingsWindowMeta implements IFortSettingsWindowMeta
    {
        
        public function FortSettingsWindow()
        {
            super();
            this.tableShadow.mouseEnabled = false;
            isModal = false;
            isCentered = true;
            this.mainStatusTitle.autoSize = TextFormatAlign.LEFT;
            this.mainStatusMsg.autoSize = TextFormatAlign.LEFT;
            TextFieldEx.setVerticalAlign(this.mainStatusMsg,TextFieldEx.VALIGN_CENTER);
        }
        
        private static var STATUS_PADDING:int = 2;
        
        public var mainStatusTitle:TextField = null;
        
        public var mainStatusMsg:TextField = null;
        
        public var clanInfo:IFortSettingsContainer = null;
        
        public var tableShadow:MovieClip = null;
        
        public var viewStack:ViewStack = null;
        
        private var activeModel:FortSettingsActivatedViewVO = null;
        
        private var notActiveModel:FortSettingsNotActivatedViewVO = null;
        
        private var statusMsgTooltip:String = "";
        
        public function as_setView(param1:String) : void
        {
            if(this.viewStack.currentLinkage != param1)
            {
                setFocus(this);
                this.viewStack.show(param1);
            }
        }
        
        public function as_setMainStatus(param1:String, param2:String, param3:String) : void
        {
            if(this.mainStatusTitle.htmlText != param1)
            {
                this.mainStatusTitle.htmlText = param1;
            }
            if(this.mainStatusMsg.htmlText != param2)
            {
                this.mainStatusMsg.htmlText = param2;
            }
            this.mainStatusMsg.x = this.mainStatusTitle.x + this.mainStatusTitle.width + STATUS_PADDING ^ 0;
            this.statusMsgTooltip = param3;
        }
        
        public function as_setCanDisableDefencePeriod(param1:Boolean) : void
        {
            if((this.activeModel) && (this.viewStack.currentView))
            {
                this.callAdditionalUpdate(param1);
            }
        }
        
        override protected function setDataForActivated(param1:FortSettingsActivatedViewVO) : void
        {
            var _loc2_:* = !(this.activeModel == null);
            this.activeModel = param1;
            if((_loc2_) && !(this.viewStack.currentView == null))
            {
                this.updateView();
            }
        }
        
        override protected function setDataForNotActivated(param1:FortSettingsNotActivatedViewVO) : void
        {
            var _loc2_:* = !(this.notActiveModel == null);
            this.notActiveModel = param1;
            if((_loc2_) && !(this.viewStack.currentView == null))
            {
                this.updateView();
            }
        }
        
        override protected function setFortClanInfo(param1:FortSettingsClanInfoVO) : void
        {
            this.clanInfo.update(param1);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.mainStatusMsg.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverStatusStringHandler);
            this.mainStatusMsg.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutStatusStringHandler);
            this.addEventListener(FortSettingsEvent.ACTIVATE_DEFENCE_PERIOD,this.activateDefencePeriodHandler);
            this.addEventListener(FortSettingsEvent.DISABLE_DEFENCE_PERIOD,this.disableDefencePeriodHandler);
            this.addEventListener(FortSettingsEvent.CANCEL_DISABLE_DEFENCE_PERIOD,this.cancelDisableDefencePeriodHandler);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.viewStackUpdateHandler);
            window.title = FORTIFICATIONS.SETTINGSWINDOW_WINDOWTITLE;
        }
        
        override protected function onDispose() : void
        {
            this.removeEventListener(FortSettingsEvent.ACTIVATE_DEFENCE_PERIOD,this.activateDefencePeriodHandler);
            this.removeEventListener(FortSettingsEvent.DISABLE_DEFENCE_PERIOD,this.disableDefencePeriodHandler);
            this.removeEventListener(FortSettingsEvent.CANCEL_DISABLE_DEFENCE_PERIOD,this.cancelDisableDefencePeriodHandler);
            this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.viewStackUpdateHandler);
            this.viewStack.dispose();
            this.viewStack = null;
            this.clanInfo.dispose();
            this.clanInfo = null;
            this.tableShadow = null;
            this.mainStatusTitle = null;
            this.mainStatusMsg.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverStatusStringHandler);
            this.mainStatusMsg.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutStatusStringHandler);
            this.mainStatusMsg = null;
            this.statusMsgTooltip = null;
            if(this.notActiveModel)
            {
                this.notActiveModel.dispose();
                this.notActiveModel = null;
            }
            if(this.activeModel)
            {
                this.activeModel.dispose();
                this.activeModel = null;
            }
            super.onDispose();
        }
        
        private function callAdditionalUpdate(param1:Boolean) : void
        {
            if(this.viewStack.currentLinkage == FORTIFICATION_ALIASES.FORT_SETTINGS_ACTIVATED_VIEW)
            {
                IFortSettingsActivatedContainer(this.viewStack.currentView).canDisableDefHour(param1);
            }
        }
        
        private function updateView() : void
        {
            if(this.viewStack.currentLinkage == FORTIFICATION_ALIASES.FORT_SETTINGS_NOTACTIVATED_VIEW)
            {
                IViewStackContent(this.viewStack.currentView).update(this.notActiveModel);
            }
            else if(this.viewStack.currentLinkage == FORTIFICATION_ALIASES.FORT_SETTINGS_ACTIVATED_VIEW)
            {
                IViewStackContent(this.viewStack.currentView).update(this.activeModel);
            }
            
        }
        
        private function viewStackUpdateHandler(param1:ViewStackEvent) : void
        {
            if(param1.linkage == FORTIFICATION_ALIASES.FORT_SETTINGS_NOTACTIVATED_VIEW)
            {
                IViewStackContent(param1.view).update(this.notActiveModel);
            }
            else if(param1.linkage == FORTIFICATION_ALIASES.FORT_SETTINGS_ACTIVATED_VIEW)
            {
                IViewStackContent(param1.view).update(this.activeModel);
            }
            
        }
        
        private function onRollOverStatusStringHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(this.statusMsgTooltip);
        }
        
        private function onRollOutStatusStringHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function activateDefencePeriodHandler(param1:FortSettingsEvent) : void
        {
            activateDefencePeriodS();
        }
        
        private function disableDefencePeriodHandler(param1:FortSettingsEvent) : void
        {
            disableDefencePeriodS();
        }
        
        private function cancelDisableDefencePeriodHandler(param1:FortSettingsEvent) : void
        {
            cancelDisableDefencePeriodS();
        }
    }
}
