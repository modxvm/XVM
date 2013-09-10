package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class InfoDataVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function InfoDataVO(arg1:Object)
        {
            this._subtasks = [];
            this._conditions = [];
            super(arg1);
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "descr":
                    this._descr = arg2 ? new net.wg.gui.lobby.questsWindow.data.DescriptionVO(arg2) : null;
                    return false;
                default:
                    return true;
            }
        }

        public function get descr():net.wg.gui.lobby.questsWindow.data.DescriptionVO
        {
            return this._descr;
        }

        public function set descr(arg1:net.wg.gui.lobby.questsWindow.data.DescriptionVO):void
        {
            this._descr = arg1;
            return;
        }

        public function get subtasks():Array
        {
            return this._subtasks;
        }

        public function set subtasks(arg1:Array):void
        {
            this._subtasks = arg1;
            return;
        }

        public function get conditions():Array
        {
            return this._conditions;
        }

        public function set conditions(arg1:Array):void
        {
            this._conditions = arg1;
            return;
        }

        internal var _descr:net.wg.gui.lobby.questsWindow.data.DescriptionVO=null;

        internal var _subtasks:Array;

        internal var _conditions:Array;
    }
}
