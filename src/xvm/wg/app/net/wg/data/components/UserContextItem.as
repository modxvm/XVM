package net.wg.data.components
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.interfaces.IContextItem;

    public class UserContextItem extends net.wg.data.components.ContextItem
    {
        public function UserContextItem(arg1:String, arg2:Object=null, arg3:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>=null)
        {
            super(arg1, MENU.contextmenu(arg1), arg2, arg3);
            return;
        }
    }
}
