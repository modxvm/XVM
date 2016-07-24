/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHpLeft implements ICloneable
    {
        public var header:String;
        public var format:String;

        public function clone():*
        {
            var result:CHpLeft = new CHpLeft();
            result.header = header;
            result.format = format;
            return result;
        }
    }
}
