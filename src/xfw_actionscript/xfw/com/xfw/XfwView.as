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
	import net.wg.data.constants.generated.LAYER_NAMES;
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
            var viewContainer:MainViewContainer = _getContainer(LAYER_NAMES.VIEWS) as MainViewContainer;
            if (viewContainer != null)
            {
                var topmostView:IManagedContent = viewContainer.getTopmostView();
                if (topmostView)
                    viewContainer.setFocusedView(topmostView);
            }
        }

        // this needs for valid Focus in Login Window 
        override protected function nextFrameAfterPopulateHandler() : void 
        {
            super.nextFrameAfterPopulateHandler();
            if (parent != App.instance)
            {
                (App.instance as MovieClip).addChild(this);
            }
        }

        private function _getContainer(containerName:String) : ISimpleManagedContainer
        {
            return App.containerMgr.getContainer(LAYER_NAMES.LAYER_ORDER.indexOf(containerName))
        }
    }
}
