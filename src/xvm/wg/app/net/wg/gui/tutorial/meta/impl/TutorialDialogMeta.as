package net.wg.gui.tutorial.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class TutorialDialogMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function TutorialDialogMeta()
        {
            super();
            return;
        }

        public function submitS():void
        {
            App.utils.asserter.assertNotNull(this.submit, "submit" + net.wg.data.constants.Errors.CANT_NULL);
            this.submit();
            return;
        }

        public function cancelS():void
        {
            App.utils.asserter.assertNotNull(this.cancel, "cancel" + net.wg.data.constants.Errors.CANT_NULL);
            this.cancel();
            return;
        }

        public var submit:Function=null;

        public var cancel:Function=null;
    }
}
