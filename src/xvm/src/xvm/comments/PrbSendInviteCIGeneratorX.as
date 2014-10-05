package xvm.comments
{
    import com.xvm.*;
    import net.wg.data.components.*;
    import net.wg.data.daapi.*;
    import net.wg.gui.prebattle.invites.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.*;

    public class PrbSendInviteCIGeneratorX extends PrbSendInviteCIGenerator
    {
        public static const M_ADDGROUP:String = "xvm:addGroup";
        public static const M_EDITGROUP:String = "xvm:editGroup";
        public static const M_ADDCOMMENT:String = "xvm:addComment";
        public static const M_EDITCOMMENT:String = "xvm:editComment";

        public function PrbSendInviteCIGeneratorX()
        {
            super();
        }

        override protected function createSimpleDataIDs(param1:PlayerInfo, param2:String, param3:String, param4:String, param5:String, param6:Boolean = false):Map
        {
            var map:Map = super.createSimpleDataIDs(param1, param2, param3, param4, param5, param6);
            var res:Map = new HashMap();
            var entry:Entry = null;
            var it:Iterator = map.entrySet().iterator();
            while(it.hasNext())
            {
                entry = it.next() as Entry;
                if (entry.getKey() === "copyToClipBoard")
                {
                    // TODO
                    //var group:String = CommentsGlobalData.getGroup(param1.dbID);
                    //res.put((group == null) ? M_ADDGROUP : M_EDITGROUP, { "enabled": CommentsGlobalData.isAvailable() } );

                    var comment:String = CommentsGlobalData.instance.getComment(param1.dbID);
                    res.put((comment == null) ? M_ADDCOMMENT : M_EDITCOMMENT, { "enabled": CommentsGlobalData.instance.isAvailable() } );
                }
                res.put(entry.getKey(), entry.getValue());
            }
            return res;
        }

        override public function generateData(param1:PlayerInfo, param2:Number = undefined):Vector.<IContextItem>
        {
            //Logger.addObject(super.generateData(param1, param2));
            var data:Vector.<IContextItem> = super.generateData(param1, param2);
            for each (var item:ContextItem in data)
            {
                switch (item.id)
                {
                    case M_ADDGROUP:
                        item.label = Locale.get("Add group");
                        break;
                    case M_EDITGROUP:
                        item.label = Locale.get("Edit group");
                        break;
                    case M_ADDCOMMENT:
                        item.label = Locale.get("Add comment");
                        break;
                    case M_EDITCOMMENT:
                        item.label = Locale.get("Edit comment");
                        break;
                }
            }
            return data;
        }
    }
}
