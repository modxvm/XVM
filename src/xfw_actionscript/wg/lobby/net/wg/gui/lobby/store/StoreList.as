package net.wg.gui.lobby.store
{
    import net.wg.gui.components.controls.ScrollingListEx;

    public class StoreList extends ScrollingListEx
    {

        private var _isViewVisible:Boolean = true;

        public function StoreList()
        {
            super();
        }

        override public function set selectedIndex(param1:int) : void
        {
        }

        public function get isViewVisible() : Boolean
        {
            return this._isViewVisible;
        }

        public function set isViewVisible(param1:Boolean) : void
        {
            this._isViewVisible = param1;
        }
    }
}
