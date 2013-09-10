package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class QuestsCurrentTabMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function QuestsCurrentTabMeta()
        {
            super();
            return;
        }

        public function sortS(arg1:int, arg2:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.sort, "sort" + net.wg.data.constants.Errors.CANT_NULL);
            this.sort(arg1, arg2);
            return;
        }

        public function getQuestInfoS(arg1:String):Object
        {
            App.utils.asserter.assertNotNull(this.getQuestInfo, "getQuestInfo" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getQuestInfo(arg1);
        }

        public var sort:Function=null;

        public var getQuestInfo:Function=null;
    }
}
