package xvm.comments
{
    import com.xvm.*;
    import net.wg.data.components.*;
    import net.wg.data.daapi.*;
    import net.wg.gui.prebattle.invites.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.*;

    public class PrbSendInviteCIGeneratorX // TODO:0.9.6 extends PrbSendInviteCIGenerator
    {
        public static const M_EDITDATA:String = "xvm:editData";

        public function PrbSendInviteCIGeneratorX()
        {
            super();
        }

        /* TODO:0.9.6
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
                    res.put(M_EDITDATA, { "enabled": CommentsGlobalData.instance.isAvailable() } );
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
                    case M_EDITDATA:
                        item.label = Locale.get("Edit data");
                        break;
                }
            }
            return data;
        }*/
    }
}
