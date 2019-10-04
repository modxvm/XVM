package net.wg.gui.messenger.meta.impl
{
    import net.wg.gui.messenger.windows.ChannelWindow;
    import net.wg.data.constants.Errors;

    public class LobbyChannelWindowMeta extends ChannelWindow
    {

        public var onWarningClose:Function;

        public function LobbyChannelWindowMeta()
        {
            super();
        }

        public function onWarningCloseS() : void
        {
            App.utils.asserter.assertNotNull(this.onWarningClose,"onWarningClose" + Errors.CANT_NULL);
            this.onWarningClose();
        }
    }
}
