package net.wg.gui.lobby.store
{
    import net.wg.infrastructure.base.UIComponentEx;

    public class TableHeader extends UIComponentEx
    {

        public var headerInfo:TableHeaderInfo = null;

        public function TableHeader()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.headerInfo.dispose();
            this.headerInfo = null;
            super.onDispose();
        }
    }
}
