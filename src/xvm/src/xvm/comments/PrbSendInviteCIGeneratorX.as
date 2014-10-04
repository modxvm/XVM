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
                    //res.put((group == null) ? "xvm:addGroup" : "xvm:editGroup", { "enabled": CommentsGlobalData.isAvailable() } );

                    var comment:String = CommentsGlobalData.getComment(param1.dbID);
                    res.put((comment == null) ? "xvm:addComment" : "xvm:editComment", { "enabled": CommentsGlobalData.isAvailable() } );
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
                switch (item.label)
                {
                    case "#menu:contextMenu/xvm:addGroup":
                        item.label = Locale.get("Add group");
                        break;
                    case "#menu:contextMenu/xvm:editGroup":
                        item.label = Locale.get("Edit group");
                        break;
                    case "#menu:contextMenu/xvm:addComment":
                        item.label = Locale.get("Add comment");
                        break;
                    case "#menu:contextMenu/xvm:editComment":
                        item.label = Locale.get("Edit comment");
                        break;
                }
            }
            return data;
        }
    }
}
