/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw.infrastructure
{
    import com.xfw.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;

    public class XfwViewBase implements IXfwView
    {
        private var _populated:Boolean;
        private var _disposed:Boolean;

        private var _view:IView;
        public function get view():IView
        {
            return _view;
        }

        public function XfwViewBase(view:IView)
        {
            _populated = false;
            _disposed = false;
            _view = view;
            view.addEventListener(LifeCycleEvent.ON_BEFORE_POPULATE, onBeforePopulatePrivate);
            view.addEventListener(LifeCycleEvent.ON_AFTER_POPULATE, onAfterPopulatePrivate);
            view.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE, onBeforeDisposePrivate);
            view.addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE, onAfterDisposePrivate);
        }

        public final function get isActive():Boolean
        {
            return isPopulated && !isDisposed;
        }

        public final function get isPopulated():Boolean
        {
            return _populated;
        }

        public final function get isDisposed():Boolean
        {
            return _disposed;
        }

        // virtual
        public function onBeforePopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforePopulate: " + view.as_alias);
        }

        // virtual
        public function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
        }

        // virtual
        public function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
        }

        // virtual
        public function onAfterDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterDispose: " + view.as_alias);
        }

        // PRIVATE

        private function onBeforePopulatePrivate(e:LifeCycleEvent):void
        {
            _populated = true;
            XfwUtils.safeCall(this, onBeforePopulate, [e]);
        }

        private function onAfterPopulatePrivate(e:LifeCycleEvent):void
        {
            XfwUtils.safeCall(this, onAfterPopulate, [e]);
        }

        private function onBeforeDisposePrivate(e:LifeCycleEvent):void
        {
            XfwUtils.safeCall(this, onBeforeDispose, [e]);
        }

        private function onAfterDisposePrivate(e:LifeCycleEvent):void
        {
            XfwUtils.safeCall(this, onAfterDispose, [e]);
            _populated = false;
            _disposed = true;
        }
    }
}
