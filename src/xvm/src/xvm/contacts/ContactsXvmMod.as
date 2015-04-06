/**
 * XVM - contacts
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.contacts
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    public class ContactsXvmMod extends XvmModBase
    {
        public override function get logPrefix():String
        {
            return "[XVM:COMMENTS]";
        }

        private static const _views:Object =
        {
            "ContactsPopover": ContactsXvmView
        }

        public override function get views():Object
        {
            return _views;
        }
    }
}
