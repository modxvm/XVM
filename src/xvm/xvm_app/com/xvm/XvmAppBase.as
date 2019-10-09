/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    /**
     *  Link additional classes into xvm_app.swc
     */

    // extraFields
    import com.xvm.extraFields.ImageExtraField; ImageExtraField;

    // infrastructure
    import com.xvm.infrastructure.XvmModBase; XvmModBase;
    import com.xvm.infrastructure.XvmViewBase; XvmViewBase;

    // wg
    import com.xvm.wg.ImageXVM; ImageXVM;

    public class XvmAppBase extends Xvm
    {
        public function XvmAppBase(appType:int)
        {
            super(appType);
        }
    }
}
