package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class QuestDataVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function QuestDataVO(arg1:Object)
        {
            this._nextTasks = [];
            super(arg1);
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "header":
                {
                    this._header = arg2 ? new net.wg.gui.lobby.questsWindow.data.HeaderDataVO(arg2) : null;
                    return false;
                }
                case "info":
                {
                    this._info = arg2 ? new net.wg.gui.lobby.questsWindow.data.InfoDataVO(arg2) : null;
                    return false;
                }
                default:
                {
                    return true;
                }
            }
        }

        public function get header():net.wg.gui.lobby.questsWindow.data.HeaderDataVO
        {
            return this._header;
        }

        public function set header(arg1:net.wg.gui.lobby.questsWindow.data.HeaderDataVO):void
        {
            this._header = arg1;
            return;
        }

        public function get info():net.wg.gui.lobby.questsWindow.data.InfoDataVO
        {
            return this._info;
        }

        public function set info(arg1:net.wg.gui.lobby.questsWindow.data.InfoDataVO):void
        {
            this._info = arg1;
            return;
        }

        public function get award():String
        {
            return this._award;
        }

        public function set award(arg1:String):void
        {
            this._award = arg1;
            return;
        }

        public function get nextTasks():Array
        {
            return this._nextTasks;
        }

        public function set nextTasks(arg1:Array):void
        {
            this._nextTasks = arg1;
            return;
        }

        internal var _header:net.wg.gui.lobby.questsWindow.data.HeaderDataVO=null;

        internal var _info:net.wg.gui.lobby.questsWindow.data.InfoDataVO=null;

        internal var _award:String="";

        internal var _nextTasks:Array;
    }
}
