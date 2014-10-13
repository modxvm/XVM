package xvm.comments
{
    import com.xvm.*;
    import com.xvm.io.*;
    import flash.events.*;
    import xvm.comments.data.*;

    public class CommentsGlobalData extends EventDispatcher
    {
        // singleton
        private static var _instance:CommentsGlobalData = null;

        public static function get instance():CommentsGlobalData
        {
            if (_instance == null)
                _instance = new CommentsGlobalData();
            return _instance;
        }

        private var data:CommentsData;

        public function clearData():void
        {
            data = null;
        }

        public function setData(data:Object):void
        {
            this.data = CommentsData.fromObject(data);
        }

        public function toJson():String
        {
            return JSONx.stringify(data, '', true);
        }

        public function isAvailable():Boolean
        {
            return data != null;
        }

        public function getPlayerData(playerId:Number):PlayerCommentData
        {
            return isAvailable() ? data.players[playerId] : null;
        }

        public function setPlayerData(playerId:Number, value:PlayerCommentData):void
        {
            if (!isAvailable())
                throw new Error("Comments are not available (network error?)");

            if (isNaN(playerId) || playerId < 0)
                throw new Error("Invalid Player ID");

            if (value.isEmpty())
                delete data.players[playerId];
            else
                data.players[playerId] = value;

            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}
