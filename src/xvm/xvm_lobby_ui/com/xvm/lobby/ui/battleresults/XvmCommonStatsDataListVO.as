/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby.ui.battleresults
{
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;

    public class XvmCommonStatsDataListVO extends DAAPIDataClass
    {
        public var __xvm:Boolean = false; // XVM data marker
        public var data:Array = null;
        public var regionNameStr:String = "";

        public function XvmCommonStatsDataListVO(data:Object)
        {
            this.data = [];
            var d:Array = data.data;
            var len:int = d.length;
            for (var i:int = 0; i < len; ++i)
            {
                this.data.push(new XvmCommonStatsDataVO(d[i]));
            }
            delete data.data;

            super(data);
        }
    }
}
