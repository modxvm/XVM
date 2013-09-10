package net.wg.data.components 
{
    import net.wg.data.daapi.*;
    import org.idmedia.as3commons.util.*;
    
    public class ContextItemGenerator extends net.wg.data.components.AbstractContextItemGenerator
    {
        public function ContextItemGenerator()
        {
            super();
            return;
        }

        protected override function getDenunciationsIDs(arg1:net.wg.data.daapi.PlayerInfo):org.idmedia.as3commons.util.Map
        {
            return App.utils.commons.createMap(["offend", {}, "flood", {}, "openingOfAllyPos", {}, "allyEjection", {}, "notFairPlay", {}, "teamKill", {}, "bot", {}]);
        }

        protected override function createSimpleDataIDs(arg1:String, arg2:String, arg3:String, arg4:String):org.idmedia.as3commons.util.Map
        {
            return App.utils.commons.createMap(["userInfo", {}, arg1, {}, arg2, {}, arg3, {}, "copyToClipBoard", {}, arg4, {}]);
        }
    }
}
