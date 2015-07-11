/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.techtree
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.events.*;

    public class TechTreeXvmView extends XvmViewBase
    {
        //private static const _name:String = "xvm_techtree";
        //private static const _ui_name:String = _name + "_ui.swf";

        public function TechTreeXvmView(view:IView)
        {
            super(view);

            //Xfw.try_load_ui_swf(_name, _ui_name);
        }

        public function get page():TechTreePage
        {
            return super.view as TechTreePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        // PRIVATE

        private function init():void
        {
            Dossier.requestAccountDossier(page.nationTree, page.nationTree.invalidateData, PROFILE_DROPDOWN_KEYS.ALL);

            page.nationsBar.addEventListener(IndexEvent.INDEX_CHANGE, this.handleIndexChange);
            handleIndexChange();
        }

        private function handleIndexChange(e:IndexEvent = null) : void
        {
            page.nationTree.dataProvider.displaySettings.fromObject( {
                nodeRendererName:"xvm.techtree_ui::UI_NationTreeNodeSkinned",
                isLevelDisplayed:page.nationTree.dataProvider.displaySettings.isLevelDisplayed
            }, null);
            page.nationTree.invalidateData();
        }
    }
}
