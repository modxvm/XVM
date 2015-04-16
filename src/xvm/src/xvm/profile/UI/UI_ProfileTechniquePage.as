/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.UI
{
    import com.xfw.*;
    import com.xvm.*;
    import xvm.profile.components.*;

    public dynamic class UI_ProfileTechniquePage extends ProfileTechniquePage_UI
    {
        public function UI_ProfileTechniquePage()
        {
            super();
        }

        override protected function onPopulate():void
        {
            super.onPopulate();
            addChild(new TechniquePage(this, XvmGlobals[XvmGlobals.CURRENT_USER_NAME]));
        }
    }
}
