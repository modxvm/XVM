/**
 * XFW Entry Point
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;
    import flash.display.*;
    import net.wg.app.iml.base.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.interfaces.*;

    /**
     *  Link additional classes into xfw.swc
     */
    XfwModBase;
    XfwViewBase;

    [SWF(width="1", height="1", backgroundColor="#6D6178")]

    public class XfwView extends AbstractView
    {
        private var xfw:XfwComponent = null;

        public function XfwView()
        {
            focusable = false;
            mouseEnabled = false;
            visible = false;
        }

        public function as_inject():void
        {
            this.xfw = addChild(new XfwComponent()) as XfwComponent;
            this.registerFlashComponent(this.xfw, "xfw");
            var mainViewContainer:MainViewContainer = searchMainViewContainer();
            // Move component to the main view to fix ESC key
            mainViewContainer.addChildAt(this, 0);
            mainViewContainer.setFocusedView(mainViewContainer.getTopmostView());
            //XfwUtils.logChilds(App.instance as DisplayObject);
        }

        // PRIVATE

        private function searchMainViewContainer():MainViewContainer
        {
            var app:AbstractApplication = App.instance as AbstractApplication;
            var len:int = app.numChildren;
            var mainViewContainer:MainViewContainer = null;
            for (var i:int = 0; i < len; ++i)
            {
                mainViewContainer = app.getChildAt(i) as MainViewContainer;
                if (mainViewContainer != null)
                {
                    break;
                }
            }
            return mainViewContainer;
        }
    }
}
