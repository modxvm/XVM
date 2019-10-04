package net.wg.gui.messenger.data
{
    import net.wg.gui.lobby.questsWindow.data.TreeContentVO;

    public class ContactsListGroupVO extends TreeContentVO
    {

        private var _rules:GroupRulesVO = null;

        public var headerDisplayTitle:String = "";

        public function ContactsListGroupVO(param1:Object)
        {
            super(param1);
        }

        public function get rules() : int
        {
            return this._rules?this._rules.getBitMask():0;
        }

        public function set rules(param1:int) : void
        {
            this._rules = new GroupRulesVO(param1);
        }

        override public function get isResizable() : Boolean
        {
            return this._rules?this._rules.isResizable():false;
        }

        public function get isDropAllowed() : Boolean
        {
            return this._rules?this._rules.isDropAllowed():false;
        }

        public function get canBeManaged() : Boolean
        {
            return this._rules?this._rules.canBeManaged():false;
        }
    }
}
