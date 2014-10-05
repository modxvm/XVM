package xvm.comments
{
    import com.xvm.*;
    import com.xvm.io.*;
    import flash.events.*;

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

        public function setData(json_str:String):void
        {
            data = CommentsData.fromJsonString(json_str);
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

        public function setPlayerData(playerId:Number):PlayerCommentData
        {
            return isAvailable() ? data.players[playerId] : null;
        }

        public function getComment(playerId:Number):String
        {
            var pd:PlayerCommentData = getPlayerData(playerId);
            return pd == null ? null : pd.comment;
        }

        public function setComment(playerId:Number, comment:String):void
        {
            if (!isAvailable())
                throw new Error("Comments is not available (network error?)");

            if (isNaN(playerId) || playerId < 0)
                throw new Error("Comments is not available (network error?)");

            var pd:PlayerCommentData = getPlayerData(playerId);
            if (pd == null)
                pd = new PlayerCommentData();

            pd.comment = comment;

            if (pd.isEmpty())
                delete data.players[playerId];
            else
                data.players[playerId] = pd;

            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}

import com.xvm.*;
import com.xvm.io.*;
import flash.utils.*;

class CommentsData extends Object
{
    public var ver:String = "1.0";
    public var players:Object;

    public function CommentsData()
    {
        players = { };
    }

    public static function fromJsonString(json_str:String):CommentsData
    {
        var res:CommentsData = new CommentsData();
        try
        {
            var d:Object = JSONx.parse(json_str);

            if (d.ver == null)
                throw new Error();

            // TODO: version control

            if (d.players != null)
            {
                for (var id:String in d.players)
                {
                    var dd:Object = d.players[id];
                    var pd:PlayerCommentData = new PlayerCommentData();
                    pd.comment = dd.comment;
                    pd.group = dd.group;
                    res.players[id] = pd;
                }
            }
        }
        catch (ex:Error)
        {
            res = new CommentsData();
        }

        return res;
    }
}

class PlayerCommentData
{
    public var comment:String;
    public var group:String;

    public function isEmpty():Boolean
    {
        return (comment == null || comment == "") && (group == null || group == "");
    }
}
