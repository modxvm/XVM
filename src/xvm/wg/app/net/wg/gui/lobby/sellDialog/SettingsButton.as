package net.wg.gui.lobby.sellDialog 
{
    import flash.display.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class SettingsButton extends scaleform.clik.core.UIComponent
    {
        public function SettingsButton()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=App.utils.locale.makeString(DIALOGS.BUYVEHICLEDIALOG_EXPANDBTNLABEL);
            loc1 = loc1.toUpperCase();
            this.setingsDropBtn.label = loc1;
            this.creditsIT.textFieldYOffset = net.wg.gui.lobby.sellDialog.VehicleSellDialog.ICONS_TEXT_OFFSET;
            return;
        }

        public var setingsDropBtn:net.wg.gui.components.controls.CheckBox;

        public var creditsIT:net.wg.gui.components.controls.IconText;

        public var ddLine:flash.display.MovieClip;
    }
}
