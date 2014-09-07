package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.PunishmentDialogMeta;
    import net.wg.infrastructure.base.meta.IPunishmentDialogMeta;
    import flash.text.TextField;
    
    public class PunishmentDialog extends PunishmentDialogMeta implements IPunishmentDialogMeta
    {
        
        public function PunishmentDialog()
        {
            super();
        }
        
        public var msgTitle:TextField;
        
        public function as_setMsgTitle(param1:String) : void
        {
            this.msgTitle.text = param1;
        }
    }
}
