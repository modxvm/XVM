package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.DAAPISimpleContainer;
    import net.wg.data.constants.Errors;

    public class CrosshairPanelContainerMeta extends DAAPISimpleContainer
    {

        public var as_playSound:Function;

        public function CrosshairPanelContainerMeta()
        {
            super();
        }

        public function as_playSoundS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.as_playSound,"as_playSound" + Errors.CANT_NULL);
            this.as_playSound(param1);
        }
    }
}
