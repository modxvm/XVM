package net.wg.gui.lobby.eventShopTab.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventShopTab.events.ShopTabEvent;

    public class ShopMainBanner extends SoundButtonEx
    {

        public var titleTF:AnimatedTextContainer = null;

        public var descriptionTF:AnimatedTextContainer = null;

        public var descriptionFullTF:AnimatedTextContainer = null;

        public var emptyFocusIndicator:MovieClip = null;

        public var bg:MovieClip = null;

        public function ShopMainBanner()
        {
            super();
            preventAutosizing = true;
        }

        override protected function configUI() : void
        {
            super.configUI();
            focusIndicator = this.emptyFocusIndicator;
            this.titleTF.text = EVENT.SHOP_MAINBANNER_TITLE;
            this.descriptionTF.text = EVENT.SHOP_MAINBANNER_DESCRIPTION;
            this.descriptionFullTF.text = EVENT.SHOP_MAINBANNER_DESCRIPTIONFULL;
        }

        override protected function onDispose() : void
        {
            this.titleTF.dispose();
            this.titleTF = null;
            this.descriptionTF.dispose();
            this.descriptionTF = null;
            this.descriptionFullTF.dispose();
            this.descriptionFullTF = null;
            this.bg = null;
            this.emptyFocusIndicator = null;
            super.onDispose();
        }

        override protected function handleClick(param1:uint = 0) : void
        {
            super.handleClick(param1);
            dispatchEvent(new ShopTabEvent(ShopTabEvent.MAINBANNER_CLICK));
        }
    }
}
