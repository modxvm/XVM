package net.wg.gui.battle.pveEvent.views.eventDeserterDialog
{
    import net.wg.infrastructure.base.meta.impl.EventDeserterDialogMeta;
    import flash.text.TextField;

    public class EventDeserterDialog extends EventDeserterDialogMeta
    {

        public var headerTF:TextField = null;

        public function EventDeserterDialog()
        {
            super();
        }

        public function as_setHeader(param1:String) : void
        {
            this.headerTF.text = param1;
        }

        override protected function onDispose() : void
        {
            this.headerTF = null;
            super.onDispose();
        }
    }
}
