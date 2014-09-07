package net.wg.gui.lobby.fortifications.settings.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.fortifications.settings.IFortSettingsContainer;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.common.ArrowSeparator;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsNotActivatedViewVO;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.fortifications.events.FortSettingsEvent;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.Values;
    
    public class FortSettingsNotActivatedContainer extends UIComponent implements IFortSettingsContainer, IViewStackContent
    {
        
        public function FortSettingsNotActivatedContainer()
        {
            super();
            this.scaleX = this.scaleY = 1;
        }
        
        private static function activateDefenceTime_rollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var description:TextField = null;
        
        public var conditionTitle:TextField = null;
        
        public var firstCondition:TextField = null;
        
        public var secondCondition:TextField = null;
        
        public var firstStatus:TextField = null;
        
        public var secondStatus:TextField = null;
        
        public var activateDefenceTime:SoundButtonEx = null;
        
        public var separator:ArrowSeparator;
        
        private var applyBtnTooltip:String = "";
        
        public function update(param1:Object) : void
        {
            var _loc2_:FortSettingsNotActivatedViewVO = FortSettingsNotActivatedViewVO(param1);
            if(this.description.htmlText != _loc2_.description)
            {
                this.description.htmlText = _loc2_.description;
            }
            if(this.conditionTitle.htmlText != _loc2_.conditionTitle)
            {
                this.conditionTitle.htmlText = _loc2_.conditionTitle;
            }
            if(this.firstCondition.htmlText != _loc2_.firstCondition)
            {
                this.firstCondition.htmlText = _loc2_.firstCondition;
            }
            if(this.secondCondition.htmlText != _loc2_.secondCondition)
            {
                this.secondCondition.htmlText = _loc2_.secondCondition;
            }
            this.firstStatus.htmlText = _loc2_.firstStatus;
            this.secondStatus.htmlText = _loc2_.secondStatus;
            this.applyBtnTooltip = _loc2_.btnToolTipData;
            this.activateDefenceTime.enabled = _loc2_.isBtnEnabled;
            if(this.activateDefenceTime.enabled)
            {
                this.activateDefenceTime.addEventListener(ButtonEvent.CLICK,this.activateDefenceTime_buttonClickHandler);
            }
        }
        
        private function activateDefenceTime_buttonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new FortSettingsEvent(FortSettingsEvent.ACTIVATE_DEFENCE_PERIOD));
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        override protected function onDispose() : void
        {
            this.description = null;
            this.conditionTitle = null;
            this.firstCondition = null;
            this.secondCondition = null;
            this.firstStatus = null;
            this.secondStatus = null;
            this.activateDefenceTime.removeEventListener(ButtonEvent.CLICK,this.activateDefenceTime_buttonClickHandler);
            this.activateDefenceTime.removeEventListener(MouseEvent.ROLL_OUT,activateDefenceTime_rollOutHandler);
            this.activateDefenceTime.removeEventListener(MouseEvent.ROLL_OVER,this.activateDefenceTime_rollOverHandler);
            this.activateDefenceTime.dispose();
            this.activateDefenceTime = null;
            this.separator.dispose();
            this.separator = null;
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.activateDefenceTime.label = FORTIFICATIONS.SETTINGSWINDOW_MAINBUTTONLABEL;
            this.activateDefenceTime.mouseEnabledOnDisabled = true;
            this.activateDefenceTime.addEventListener(MouseEvent.ROLL_OUT,activateDefenceTime_rollOutHandler);
            this.activateDefenceTime.addEventListener(MouseEvent.ROLL_OVER,this.activateDefenceTime_rollOverHandler);
        }
        
        private function activateDefenceTime_rollOverHandler(param1:MouseEvent) : void
        {
            if(this.applyBtnTooltip == Values.EMPTY_STR)
            {
                return;
            }
            App.toolTipMgr.show(this.applyBtnTooltip);
        }
    }
}
