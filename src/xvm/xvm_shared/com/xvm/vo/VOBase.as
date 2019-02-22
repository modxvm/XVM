/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vo
{
    public class VOBase
    {
        public function VOBase(data:Object = null)
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(data);
        }

        private function _init(data:Object):void
        {
            if (data)
                update(data);
        }

        public function update(data:Object):Boolean
        {
            var updated:Boolean = false;
            for (var key:String in data)
            {
                if (this[key] != data[key])
                {
                    updated = true;
                    this[key] = data[key];
                }
            }
            return updated;
        }

        protected function copyVector(src:*, dst:*, dstClass:Class):void
        {
            for each (var value:* in src)
            {
                dst.push(new dstClass(value));
            }
        }
    }
}
