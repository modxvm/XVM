/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.battleresults
{
    import net.wg.data.constants.*;
    import net.wg.data.daapi.base.*;

    public class XvmCommonStatsDataListVO extends DAAPIDataClass
    {
        public var __xvm:Boolean = false; // XVM data marker
        public var data:Array = null;
        public var regionNameStr:String = Values.EMPTY_STR;

        public function XvmCommonStatsDataListVO(data:Object)
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(data);
            super(data);
        }

        private function _init(data:Object):void
        {
            this.data = [];
            var d:Array = data.data;
            var len:int = d.length;
            for (var i:int = 0; i < len; ++i)
            {
                this.data.push(new XvmCommonStatsDataVO(d[i]));
            }
            delete data.data;
        }
    }
}
