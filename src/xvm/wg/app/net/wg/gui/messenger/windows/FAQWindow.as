package net.wg.gui.messenger.windows 
{
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.messenger.meta.*;
    import net.wg.gui.messenger.meta.impl.*;
    import scaleform.clik.events.*;
    
    public class FAQWindow extends net.wg.gui.messenger.meta.impl.FAQWindowMeta implements net.wg.gui.messenger.meta.IFAQWindowMeta
    {
        public function FAQWindow()
        {
            super();
            isCentered = false;
            return;
        }

        public function as_appendText(arg1:String):void
        {
            this.textArea.appendHtml(arg1);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.closeButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCancelClick);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            window.title = MESSENGER.LOBBY_FAQ_TITLE;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.closeButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCancelClick);
            return;
        }

        internal function onCancelClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onWindowCloseS();
            return;
        }

        public var textArea:net.wg.gui.components.advanced.TextAreaSimple;

        public var closeButton:net.wg.gui.components.controls.SoundButtonEx;

        public var scrollBar:net.wg.gui.components.controls.ScrollBar;
    }
}
