package net.wg.gui.lobby.premiumWindow.events
{
    import flash.events.Event;

    public class PremiumWindowEvent extends Event
    {

        public static const PREMIUM_RENDERER_DOUBLE_CLICK:String = "premiumRendererDoubleClick";

        public function PremiumWindowEvent(param1:String)
        {
            super(param1);
        }
    }
}
