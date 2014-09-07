package net.wg.gui.lobby.fortifications.settings.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.fortifications.settings.IFortSettingsContainer;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.ButtonDnmIcon;
    import net.wg.gui.lobby.fortifications.data.settings.PeripheryContainerVO;
    import flash.display.DisplayObject;
    import scaleform.clik.events.ButtonEvent;
    import flash.geom.Point;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import flash.text.TextFieldAutoSize;
    
    public class FortSettingPeripheryContainer extends UIComponent implements IFortSettingsContainer, IPopOverCaller
    {
        
        public function FortSettingPeripheryContainer()
        {
            super();
            this.scaleX = this.scaleY = 1;
            this.changePeriphery.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SETTINGS;
            this.changePeriphery.tooltip = TOOLTIPS.FORTIFICATION_FORTSETTINGSWINDOW_PEREPHERYBTN;
            this.peripheryName.autoSize = TextFieldAutoSize.CENTER;
            this.peripheryTitle.autoSize = TextFieldAutoSize.CENTER;
        }
        
        private static var TEXT_PADDING:int = 4;
        
        public var peripheryName:TextField = null;
        
        public var peripheryTitle:TextField = null;
        
        public var changePeriphery:ButtonDnmIcon = null;
        
        public function update(param1:Object) : void
        {
            var _loc2_:PeripheryContainerVO = PeripheryContainerVO(param1);
            this.peripheryTitle.htmlText = _loc2_.peripheryTitle;
            this.peripheryName.htmlText = _loc2_.peripheryName;
            this.peripheryName.x = Math.round(this.changePeriphery.x - this.peripheryName.width - TEXT_PADDING);
            this.peripheryTitle.x = Math.round(this.peripheryName.x - this.peripheryTitle.width - TEXT_PADDING);
        }
        
        public function getTargetButton() : DisplayObject
        {
            return this.changePeriphery;
        }
        
        public function getHitArea() : DisplayObject
        {
            return this.changePeriphery;
        }
        
        override protected function configUI() : void
        {
            this.changePeriphery.addEventListener(ButtonEvent.CLICK,this.onClickChangePeriphery);
        }
        
        override protected function onDispose() : void
        {
            this.changePeriphery.removeEventListener(ButtonEvent.CLICK,this.onClickChangePeriphery);
            this.changePeriphery.dispose();
            this.changePeriphery = null;
            this.peripheryName = null;
            this.peripheryTitle = null;
            super.onDispose();
        }
        
        private function onClickChangePeriphery(param1:ButtonEvent) : void
        {
            var _loc2_:Number = Math.round(this.changePeriphery.x);
            var _loc3_:Number = Math.round(this.changePeriphery.y);
            var _loc4_:Point = localToGlobal(new Point(_loc2_,_loc3_));
            App.popoverMgr.show(this,FORTIFICATION_ALIASES.FORT_SETTINGS_PERIPHERY_POPOVER_ALIAS);
        }
    }
}
