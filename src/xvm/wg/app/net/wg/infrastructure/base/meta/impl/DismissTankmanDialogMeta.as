package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.dialogs.*;
    
    public class DismissTankmanDialogMeta extends net.wg.gui.lobby.dialogs.SimpleDialog
    {
        public function DismissTankmanDialogMeta()
        {
            super();
            return;
        }

        public function sendControlNumberS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.sendControlNumber, "sendControlNumber" + net.wg.data.constants.Errors.CANT_NULL);
            this.sendControlNumber(arg1);
            return;
        }

        public var sendControlNumber:Function=null;
    }
}
