/**
 * XVM - comments
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.comments
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;

    public class CommentsXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:COMMENTS]";
        }

        private static const _views:Object =
        {
            "ContactsPopover": CommentsXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
