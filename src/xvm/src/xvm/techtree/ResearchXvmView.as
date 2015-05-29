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

    public class ResearchXvmView extends XvmViewBase
    {
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
            init();
        }

        // PRIVATE

        private function init():void
        {
            page.researchItems.itemNodeName = "xvm.techtree_ui::UI_ResearchItemNode";
            page.researchItems.vehicleNodeName = "xvm.techtree_ui::UI_NationTreeNodeSkinned";
        }
    }
}
