package xvm.comments.data
{
    public class PlayerCommentData
    {
        public var nick:String;
        public var comment:String;

        public function PlayerCommentData(nick:String, comment:String):void
        {
            this.nick = nick == null || nick == "" ? null : nick;
            this.comment = comment == null || comment == "" ? null : comment;
        }

        public function isEmpty():Boolean
        {
            return (nick == null || nick == "") && (comment == null || comment == "");
        }
    }
}
