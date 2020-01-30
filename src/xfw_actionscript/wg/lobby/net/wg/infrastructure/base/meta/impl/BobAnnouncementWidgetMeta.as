package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;

    public class BobAnnouncementWidgetMeta extends BaseDAAPIComponent
    {

        public var onClick:Function;

        public var playSound:Function;

        public function BobAnnouncementWidgetMeta()
        {
            super();
        }

        public function onClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
            this.onClick();
        }

        public function playSoundS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.playSound,"playSound" + Errors.CANT_NULL);
            this.playSound(param1);
        }
    }
}
