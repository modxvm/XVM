package net.wg.data.components 
{
    import __AS3__.vec.*;
    import net.wg.data.constants.*;
    import net.wg.data.daapi.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.*;
    
    public class AbstractContextItemGenerator extends Object implements net.wg.infrastructure.interfaces.IUserContextMenuGenerator
    {
        public function AbstractContextItemGenerator()
        {
            super();
            return;
        }

        public function generateData(arg1:net.wg.data.daapi.PlayerInfo, arg2:Number=NaN):__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>
        {
            return this.getContextItems(arg1, this.getSimpleDataIDs);
        }

        protected function getDenunciationsSubmenu(arg1:Number, arg2:net.wg.data.daapi.PlayerInfo, arg3:Boolean=false):net.wg.infrastructure.interfaces.IContextItem
        {
            var loc1:*="appeal";
            var loc2:*=App.utils.locale.makeString(MENU.CONTEXTMENU_APPEAL) + " (" + arg1 + ")";
            var loc3:*=!(arg1 == 0 || arg3);
            var loc4:*=this.getContextItems(arg2, this.getDenunciationsIDs);
            var loc5:*;
            return loc5 = new net.wg.data.components.ContextItem(loc1, loc2, {"enabled":loc3}, loc4);
        }

        protected function getContextItems(arg1:net.wg.data.daapi.PlayerInfo, arg2:Function):__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>
        {
            var loc3:*=null;
            var loc1:*=new Vector.<net.wg.infrastructure.interfaces.IContextItem>();
            var loc2:*=arg2(arg1);
            var loc4:*=0;
            var loc5:*=loc2.keySet().toArray();
            for each (loc3 in loc5) 
            {
                if (loc3 == net.wg.data.constants.Values.EMPTY_STR) 
                {
                    continue;
                }
                loc1.push(new net.wg.data.components.UserContextItem(loc3, loc2.get(loc3)));
            }
            return loc1;
        }

        protected function getDenunciationsIDs(arg1:net.wg.data.daapi.PlayerInfo):org.idmedia.as3commons.util.Map
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("getDenunciationsIDs" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getSimpleDataIDs(arg1:net.wg.data.daapi.PlayerInfo):org.idmedia.as3commons.util.Map
        {
            var loc1:*=arg1.isFriend ? "removeFromFriends" : "addToFriends";
            var loc2:*=arg1.isIgnored ? "removeFromIgnored" : "addToIgnored";
            var loc3:*=arg1.isFriend ? "createPrivateChannel" : net.wg.data.constants.Values.EMPTY_STR;
            var loc4:*=net.wg.data.constants.Values.EMPTY_STR;
            if (App.voiceChatMgr.isVOIPEnabledS()) 
            {
                loc4 = arg1.isMuted ? "unsetMuted" : "setMuted";
            }
            return this.createSimpleDataIDs(loc3, loc1, loc2, loc4);
        }

        protected function createSimpleDataIDs(arg1:String, arg2:String, arg3:String, arg4:String):org.idmedia.as3commons.util.Map
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("createSimpleDataIDs" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }
    }
}
