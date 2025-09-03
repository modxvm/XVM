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
