package net.wg.gui.lobby.store.actions.cards
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class StoreActionCardHeader extends Sprite implements IDisposable
    {

        private static const TEXT_FIELD_PADDING:Number = 4;

        public var header:TextField = null;

        private var _headerText:String = "";

        public function StoreActionCardHeader()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setText(param1:String) : void
        {
            var _loc2_:* = !this.header.multiline;
            this._headerText = App.utils.commons.truncateTextFieldText(this.header,param1,_loc2_,true);
            this.header.height = this.header.textHeight + TEXT_FIELD_PADDING;
        }

        protected function onDispose() : void
        {
            this.header = null;
        }

        public function get headerText() : String
        {
            return this._headerText;
        }
    }
}
