/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    import net.wg.infrastructure.events.LifeCycleEvent;

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
            App.instance.loaderMgr.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE, onBeforeLibrariesDispose);
        }

        override protected function onDispose():void
        {
            App.instance.loaderMgr.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE, onBeforeLibrariesDispose);
            super.onDispose();
        }

        private function onBeforeLibrariesDispose(e:LifeCycleEvent):void
        {
            // Library unload order is unspecified; clean up while the app is still intact.
            dispose();
        }
    }
}
