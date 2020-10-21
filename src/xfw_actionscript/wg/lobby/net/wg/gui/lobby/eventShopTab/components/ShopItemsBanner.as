package net.wg.gui.lobby.eventShopTab.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventShopTab.events.ShopTabEvent;

    public class ShopItemsBanner extends SoundButtonEx
    {

        public var titleTF:AnimatedTextContainer = null;

        public var descriptionTF:AnimatedTextContainer = null;

        public var emptyFocusIndicator:MovieClip = null;

        public var bg:MovieClip = null;

        public function ShopItemsBanner()
        {
            super();
            preventAutosizing = true;
        }

        override protected function configUI() : void
        {
            super.configUI();
            focusIndicator = this.emptyFocusIndicator;
            this.titleTF.text = EVENT.SHOP_ITEMSBANNER_TITLE;
            this.descriptionTF.text = EVENT.SHOP_ITEMSBANNER_DESCRIPTION;
        }

        override protected function onDispose() : void
        {
            this.titleTF.dispose();
            this.titleTF = null;
            this.descriptionTF.dispose();
            this.descriptionTF = null;
            this.emptyFocusIndicator = null;
            this.bg = null;
            super.onDispose();
        }

        override protected function handleClick(param1:uint = 0) : void
        {
            super.handleClick(param1);
            dispatchEvent(new ShopTabEvent(ShopTabEvent.ITEMSBANNER_CLICK));
        }
    }
}
