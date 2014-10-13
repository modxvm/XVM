package xvm.comments.data
{
    public class CommentsData extends Object
    {
        public var ver:String = "1.0";
        public var players:Object;

        public function CommentsData()
        {
            players = { };
        }

        public static function fromObject(obj:Object):CommentsData
        {
            var res:CommentsData = new CommentsData();
            try
            {
                if (obj.ver == null)
                    throw new Error();

                // TODO: version control

                if (obj.players != null)
                {
                    for (var id:String in obj.players)
                    {
                        var d:Object = obj.players[id];
                        res.players[id] = new PlayerCommentData(d.nick, d.group, d.comment);
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
}

