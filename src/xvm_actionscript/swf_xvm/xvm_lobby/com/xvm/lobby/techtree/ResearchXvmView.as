/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.techtree
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
            super.onAfterPopulate(e);
            init();
        }

        // PRIVATE

        private function init():void
        {
            page.researchItems.vehicleNodeClass = App.utils.classFactory.getClass("com.xvm.lobby.ui.techtree::UI_NationTreeNodeSkinned");
        }
    }
}
