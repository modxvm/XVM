package net.wg.gui.lobby.messengerBar
{
    import net.wg.gui.lobby.messengerBar.carousel.BaseChannelCarouselItem;
    import net.wg.data.constants.generated.MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES;

    public class MessengerChannelCarouselItem extends BaseChannelCarouselItem
    {

        public function MessengerChannelCarouselItem()
        {
            super();
        }

        override public function getItemType() : String
        {
            return MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES.CHANNEL_CAROUSEL_ITEM_TYPE_MESSENGER;
        }
    }
}
