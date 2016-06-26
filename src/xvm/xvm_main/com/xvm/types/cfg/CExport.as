/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CExport extends Object implements ICloneable
    {
        public var fps:CExportFps;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
