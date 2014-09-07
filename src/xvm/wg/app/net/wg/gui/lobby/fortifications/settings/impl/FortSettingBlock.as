package net.wg.gui.lobby.fortifications.settings.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.fortifications.settings.IFortSettingsContainer;
    import net.wg.gui.components.advanced.ButtonDnmIcon;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsBlockVO;
    import net.wg.data.constants.Values;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.gui.lobby.fortifications.events.FortSettingsEvent;
    
    public class FortSettingBlock extends UIComponent implements IFortSettingsContainer
    {
        
        public function FortSettingBlock()
        {
            super();
            this.blockButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SETTINGS;
            this.scaleX = this.scaleY = 1;
        }
        
        public var blockButton:ButtonDnmIcon = null;
        
        public var blockCondition:TextField = null;
        
        public var alertMessage:TextField = null;
        
        public var blockDescr:TextField = null;
        
        public function update(param1:Object) : void
        {
            var _loc2_:FortSettingsBlockVO = null;
            _loc2_ = FortSettingsBlockVO(param1);
            this.blockButton.enabled = _loc2_.blockBtnEnabled;
            if(_loc2_.dayAfterVacation != Values.DEFAULT_INT)
            {
                this.blockButton.tooltip = this.getToolTip(_loc2_.dayAfterVacation);
            }
            else if(_loc2_.blockBtnToolTip != Values.EMPTY_STR)
            {
                this.blockButton.tooltip = _loc2_.blockBtnToolTip;
            }
            
            this.blockCondition.htmlText = _loc2_.blockCondition;
            this.alertMessage.htmlText = _loc2_.alertMessage;
            this.blockDescr.htmlText = _loc2_.blockDescr;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.blockButton.mouseEnabledOnDisabled = true;
            this.blockButton.addEventListener(ButtonEvent.CLICK,this.onBlockBtnClickHandler);
        }
        
        override protected function onDispose() : void
        {
            this.blockButton.removeEventListener(ButtonEvent.CLICK,this.onBlockBtnClickHandler);
            this.blockButton.dispose();
            this.blockButton = null;
            this.blockCondition = null;
            this.alertMessage = null;
            this.blockDescr = null;
            super.onDispose();
        }
        
        private function getToolTip(param1:int) : String
        {
            var _loc2_:String = new ComplexTooltipHelper().addHeader(App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_FORTSETTINGSWINDOW_VACATIONBTNDISABLEDNOTPLANNED_HEADER)).addBody(App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_FORTSETTINGSWINDOW_VACATIONBTNDISABLEDNOTPLANNED_BODY,{"days":param1.toString()})).addNote("",false).make();
            return _loc2_;
        }
        
        private function onBlockBtnClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:FortSettingsEvent = new FortSettingsEvent(FortSettingsEvent.CLICK_BLOCK_BUTTON);
            _loc2_.blockButtonPoints = this.blockButton;
            dispatchEvent(_loc2_);
        }
    }
}
