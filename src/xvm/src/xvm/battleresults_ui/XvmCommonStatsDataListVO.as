/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleresults_ui
{
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;

    public dynamic class XvmCommonStatsDataListVO extends DAAPIDataClass
    {
        public var __xvm:Boolean = false; // XVM data marker
        public var damageDealtNames:String = Values.EMPTY_STR;
        public var damageAssistedNames:String = Values.EMPTY_STR;
        public var armorNames:String = Values.EMPTY_STR;
        public var data:Array = null;

        public function XvmCommonStatsDataListVO(data:Object)
        {
            this.data = [];
            var d:Array = data.data;
            for (var i:int = 0; i < d.length; ++i)
            {
                this.data.push(new XvmCommonStatsDataVO(d[i]));
            }
            delete data.data;

            super(data);
        }
    }
}
