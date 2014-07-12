package net.wg.gui.lobby.sellDialog
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.IconText;
    import flash.display.MovieClip;
    
    public class SettingsButton extends UIComponent
    {
        
        public function SettingsButton() {
            super();
        }
        
        public var setingsDropBtn:CheckBox;
        
        public var creditsIT:IconText;
        
        public var ddLine:MovieClip;
        
        override protected function configUI() : void {
            super.configUI();
            var _loc1_:String = App.utils.locale.makeString(DIALOGS.BUYVEHICLEDIALOG_EXPANDBTNLABEL);
            _loc1_ = App.utils.toUpperOrLowerCase(_loc1_,true);
            this.setingsDropBtn.label = _loc1_;
            this.creditsIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        }
    }
}
