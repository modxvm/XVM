/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CExportFps extends Object implements ICloneable
    {
        public var enabled:*;
        public var interval:*;
        public var outputDir:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
