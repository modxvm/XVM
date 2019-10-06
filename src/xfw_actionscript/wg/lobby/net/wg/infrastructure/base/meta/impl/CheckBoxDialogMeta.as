package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.dialogs.SimpleDialog;
    import net.wg.data.constants.Errors;

    public class CheckBoxDialogMeta extends SimpleDialog
    {

        public var onCheckBoxChange:Function;

        public function CheckBoxDialogMeta()
        {
            super();
        }

        public function onCheckBoxChangeS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.onCheckBoxChange,"onCheckBoxChange" + Errors.CANT_NULL);
            this.onCheckBoxChange(param1);
        }
    }
}
