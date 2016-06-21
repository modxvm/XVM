package com.xvm.vo
{
    import com.xfw.*;
    import com.xvm.*;

    public class VOBase extends Object
    {
        public function VOBase(data:Object = null)
        {
            if (data)
                update(data);
        }

        public function update(data:Object):void
        {
            for (var key:String in data)
            {
                this[key] = data[key];
            }
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
