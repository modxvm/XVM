package xvm.comments.data
{
    public class PlayerCommentData
    {
        public var nick:String;
        public var group:String;
        public var comment:String;

        public function PlayerCommentData(nick:String, group:String, comment:String):void
        {
            this.nick = nick == null || nick == "" ? null : nick;
            this.group = group == null || group == "" ? null : group;
            this.comment = comment == null || comment == "" ? null : comment;
        }

        public function isEmpty():Boolean
        {
            return (nick == null || nick == "") && (group == null || group == "") && (comment == null || comment == "");
        }
    }
}
