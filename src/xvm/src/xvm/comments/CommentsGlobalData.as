package xvm.comments
{
    import com.xvm.*;

    public class CommentsGlobalData
    {
        private static var data:CommentsData;

        public static function clearData():void
        {
            data = null;
        }

        public static function setData(json_str:String):void
        {
            data = CommentsData.fromJsonString(json_str);
        }

        public static function isAvailable():Boolean
        {
            return data != null;
        }

        public static function getPlayerData(playerId:Number):PlayerCommentData
        {
            return isAvailable() ? data[playerId] : null;
        }

        public static function getComment(playerId:Number):String
        {
            var pd:PlayerCommentData = getPlayerData(playerId);
            return pd == null ? null : pd.comment;
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
}
