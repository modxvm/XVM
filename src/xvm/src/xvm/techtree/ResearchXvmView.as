/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.techtree
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;
    import flash.utils.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.events.*;
    import xvm.techtree.*;

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
            page.researchItems.itemNodeName = getQualifiedClassName(UI_ResearchItemNode);
        }
    }
}
