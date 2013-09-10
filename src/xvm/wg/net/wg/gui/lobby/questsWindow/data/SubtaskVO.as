package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class SubtaskVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function SubtaskVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "questInfo":
                {
                    this._questInfo = new net.wg.gui.lobby.questsWindow.data.QuestRendererVO(arg2 ? arg2 : {});
                    return false;
                }
                default:
                {
                    return true;
                }
            }
        }

        public function get title():String
        {
            return this._title;
        }

        public function set title(arg1:String):void
        {
            this._title = arg1;
            return;
        }

        public function get questInfo():net.wg.gui.lobby.questsWindow.data.QuestRendererVO
        {
            return this._questInfo;
        }

        public function set questInfo(arg1:net.wg.gui.lobby.questsWindow.data.QuestRendererVO):void
        {
            this._questInfo = arg1;
            return;
        }

        internal var _title:String="";

        internal var _questInfo:net.wg.gui.lobby.questsWindow.data.QuestRendererVO=null;
    }
}
