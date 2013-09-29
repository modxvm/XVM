package net.wg.gui.components.tooltips.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class IgrVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function IgrVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var title:String="";

        public var description:String="";

        public var progressHeader:String="";

        public var quests:Array=null;

        public var progress:Array=null;
    }
}
