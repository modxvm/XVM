package net.wg.data.constants 
{
    public class KeyProps extends Object
    {
        public function KeyProps(arg1:String="", arg2:String="")
        {
            super();
            this.keyCommand = arg1;
            this.keyName = arg2;
            return;
        }

        public function set keyCommand(arg1:String):void
        {
            this._keyCommand = arg1;
            return;
        }

        public function get keyCommand():String
        {
            return this._keyCommand;
        }

        public function set keyName(arg1:String):void
        {
            this._keyName = arg1;
            return;
        }

        public function get keyName():String
        {
            return this._keyName;
        }

        internal var _keyCommand:String;

        internal var _keyName:String;
    }
}
