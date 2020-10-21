package net.wg.gui.lobby.eventCrewPremiumInfo
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.Sprite;

    public class EventCrewPremiumInfo extends UIComponentEx
    {

        public var text:TextField = null;

        public var background:Sprite = null;

        public function EventCrewPremiumInfo()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.text.text = EVENT.HANGAR_CREW_PREMIUM_LABEL;
            App.utils.commons.setShadowFilterWithParams(this.text,0,0,5657586,1,15,15,2,2);
        }

        override protected function onDispose() : void
        {
            this.text = null;
            this.background = null;
            super.onDispose();
        }
    }
}
