package net.wg.gui.lobby.fortifications.settings.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.fortifications.settings.IFortSettingsActivatedContainer;
    import net.wg.gui.components.advanced.DashLine;
    import net.wg.gui.components.controls.InfoIcon;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.fortifications.settings.IFortSettingsContainer;
    import net.wg.gui.components.controls.ButtonIconTextTransparent;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsActivatedViewVO;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.fortifications.events.FortSettingsEvent;
    import net.wg.gui.events.ViewStackContentEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.geom.Point;
    import net.wg.infrastructure.managers.IPopoverManager;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    
    public class FortSettingsActivatedContainer extends UIComponent implements IFortSettingsActivatedContainer
    {
        
        public function FortSettingsActivatedContainer()
        {
            super();
            this.scaleX = this.scaleY = 1;
            this.blocks = Vector.<IFortSettingsContainer>([this.block1,this.block2,this.block3]);
            this.infoIcon.tooltip = TOOLTIPS.FORTIFICATION_FORTSETTINGSWINDOW_INFOICON;
            this.infoIcon.visible = false;
        }
        
        public var dashLine:DashLine = null;
        
        public var infoIcon:InfoIcon = null;
        
        public var cancelDisableBtn:SoundButtonEx = null;
        
        public var peripheryContainer:IFortSettingsContainer = null;
        
        public var block1:IFortSettingsContainer = null;
        
        public var block2:IFortSettingsContainer = null;
        
        public var block3:IFortSettingsContainer = null;
        
        public var disableDefenceTime:ButtonIconTextTransparent = null;
        
        private var popoverButton:DisplayObject = null;
        
        private var blocks:Vector.<IFortSettingsContainer> = null;
        
        public function canDisableDefHour(param1:Boolean) : void
        {
            this.updateButtons(param1);
        }
        
        public function update(param1:Object) : void
        {
            var _loc2_:FortSettingsActivatedViewVO = null;
            _loc2_ = FortSettingsActivatedViewVO(param1);
            this.updateButtons(_loc2_.canDisableDefencePeriod);
            this.disableDefenceTime.label = FORTIFICATIONS.SETTINGSWINDOW_DISABLEDEFENCEPERIODBTN_LBL;
            this.peripheryContainer.update(_loc2_.perepheryContainerVO);
            var _loc3_:int = _loc2_.settingsBlockVOs.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                IFortSettingsContainer(this.blocks[_loc4_]).update(_loc2_.settingsBlockVOs[_loc4_]);
                _loc4_++;
            }
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        public function getTargetButton() : DisplayObject
        {
            return this.popoverButton;
        }
        
        public function getHitArea() : DisplayObject
        {
            return this.popoverButton;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(FortSettingsEvent.CLICK_BLOCK_BUTTON,this.onBlockButtonClick);
            addEventListener(ViewStackContentEvent.VIEW_HIDE,this.onViewHide);
            this.dashLine.x = 0;
            this.dashLine.width = this.width;
            this.disableDefenceTime.tooltip = TOOLTIPS.FORTIFICATION_FORTSETTINGSWINDOW_DISABLEDEFENCEPERIOD;
            this.cancelDisableBtn.tooltip = TOOLTIPS.FORTIFICATION_FORTSETTINGSWINDOW_INFOICON;
            this.cancelDisableBtn.label = App.utils.locale.makeString(FORTIFICATIONS.SETTINGSWINDOW_CANCELDISABLEPERIOD_BTNLBL);
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(ViewStackContentEvent.VIEW_HIDE,this.onViewHide);
            this.hideAssociatedPopovers();
            removeEventListener(ViewStackContentEvent.VIEW_HIDE,this.onViewHide);
            removeEventListener(FortSettingsEvent.CLICK_BLOCK_BUTTON,this.onBlockButtonClick);
            this.cancelDisableBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelDisableHandler);
            this.cancelDisableBtn.dispose();
            this.cancelDisableBtn = null;
            this.infoIcon.dispose();
            this.infoIcon = null;
            this.disableDefenceTime.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
            this.disableDefenceTime.dispose();
            this.disableDefenceTime = null;
            this.dashLine = null;
            this.peripheryContainer.dispose();
            this.peripheryContainer = null;
            this.block1.dispose();
            this.block1 = null;
            this.block2.dispose();
            this.block2 = null;
            this.block3.dispose();
            this.block3 = null;
            this.popoverButton = null;
            super.onDispose();
        }
        
        private function updateButtons(param1:Boolean) : void
        {
            this.disableDefenceTime.visible = param1;
            this.infoIcon.visible = this.cancelDisableBtn.visible = !param1;
            if(this.disableDefenceTime.visible)
            {
                this.disableDefenceTime.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
                this.cancelDisableBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelDisableHandler);
            }
            else
            {
                this.disableDefenceTime.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
                this.cancelDisableBtn.addEventListener(ButtonEvent.CLICK,this.onCancelDisableHandler);
            }
        }
        
        private function showPopover(param1:String) : void
        {
            var _loc2_:Number = Math.round(this.popoverButton.x);
            var _loc3_:Number = Math.round(this.popoverButton.y);
            var _loc4_:Point = localToGlobal(new Point(_loc2_,_loc3_));
            App.popoverMgr.show(this,param1);
        }
        
        private function hideAssociatedPopovers() : void
        {
            var _loc1_:IPopoverManager = App.instance.popoverMgr;
            if(_loc1_.popoverCaller == this || _loc1_.popoverCaller == this.peripheryContainer)
            {
                _loc1_.hide();
            }
        }
        
        private function onCancelDisableHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new FortSettingsEvent(FortSettingsEvent.CANCEL_DISABLE_DEFENCE_PERIOD));
        }
        
        private function onBlockButtonClick(param1:FortSettingsEvent) : void
        {
            this.popoverButton = param1.blockButtonPoints;
            switch(param1.target)
            {
                case this.block1:
                    this.showPopover(FORTIFICATION_ALIASES.FORT_SETTINGS_DEFENCE_HOUR_POPOVER_ALIAS);
                    break;
                case this.block2:
                    this.showPopover(FORTIFICATION_ALIASES.FORT_SETTINGS_DAYOFF_POPOVER_ALIAS);
                    break;
                case this.block3:
                    this.showPopover(FORTIFICATION_ALIASES.FORT_SETTINGS_VACATION_POPOVER_ALIAS);
                    break;
            }
        }
        
        private function onBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new FortSettingsEvent(FortSettingsEvent.DISABLE_DEFENCE_PERIOD));
        }
        
        private function onViewHide(param1:ViewStackContentEvent) : void
        {
            this.hideAssociatedPopovers();
        }
    }
}
