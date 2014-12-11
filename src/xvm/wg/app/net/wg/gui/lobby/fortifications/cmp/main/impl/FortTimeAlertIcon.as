package net.wg.gui.lobby.fortifications.cmp.main.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    
    public class FortTimeAlertIcon extends MovieClip implements IDisposable
    {
        
        public function FortTimeAlertIcon()
        {
            super();
            this.alertIcon.addEventListener(MouseEvent.ROLL_OVER,onAlertIconRollOverHandler);
            this.alertIcon.addEventListener(MouseEvent.ROLL_OUT,onAlertIconRollOutHandler);
        }
        
        private static function onAlertIconRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(Tooltips.FORT_WRONG_TIME,null);
        }
        
        private static function onAlertIconRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var alertIcon:MovieClip = null;
        
        public function dispose() : void
        {
            this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER,onAlertIconRollOverHandler);
            this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT,onAlertIconRollOutHandler);
            this.alertIcon = null;
        }
        
        public function showAlert(param1:Boolean) : void
        {
            this.alertIcon.visible = param1;
        }
    }
}
