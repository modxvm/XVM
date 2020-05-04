package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.components.BaseMissionDetailsContainerView;
    import net.wg.data.constants.Errors;

    public class MissionDetailsContainerViewMeta extends BaseMissionDetailsContainerView
    {

        public var onTokenBuyClick:Function;

        public var onToEventClick:Function;

        public function MissionDetailsContainerViewMeta()
        {
            super();
        }

        public function onTokenBuyClickS(param1:String, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.onTokenBuyClick,"onTokenBuyClick" + Errors.CANT_NULL);
            this.onTokenBuyClick(param1,param2);
        }

        public function onToEventClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onToEventClick,"onToEventClick" + Errors.CANT_NULL);
            this.onToEventClick();
        }
    }
}
