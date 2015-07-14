/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.techtree
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.StringUtils;

    public class ResearchXvmView extends XvmViewBase
    {
        //private static const _name:String = "xvm_techtree";
        //private static const _ui_name:String = _name + "_ui.swf";

        public function ResearchXvmView(view:IView)
        {
            super(view);
        }

        public function get page():ResearchPage
        {
            return super.view as ResearchPage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);

            //if (Xfw.try_load_ui_swf(_name, _ui_name) != XfwConst.SWF_START_LOADING)
                init();
        }

        //override public function onBeforeDispose(e:LifeCycleEvent):void
        //{
        //    App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
        //}

        // PRIVATE

        //private function onLibLoaded(e:LibraryLoaderEvent):void
        //{
        //    if (StringUtils.endsWith(e.url.toLowerCase(), _ui_name))
        //    {
        //        init();
        //        page.researchItems.invalidateData();
        //    }
        //}

        private function init():void
        {
            page.researchItems.itemNodeName = "xvm.techtree_ui::UI_ResearchItemNode";
            page.researchItems.vehicleNodeName = "xvm.techtree_ui::UI_NationTreeNodeSkinned";
        }
    }
}
