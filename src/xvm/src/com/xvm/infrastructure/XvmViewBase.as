/**
 * XVM mod base class
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.infrastructure
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.events.LifeCycleEvent;

    public class XvmViewBase implements IXvmView
    {
        private var _view:IView;
        public function get view():IView
        {
            return _view;
        }

        private var _viewAlias:String;

        public function XvmViewBase(view:IView)
        {
            _view = view;
            _viewAlias = view.as_alias;
            view.addEventListener(LifeCycleEvent.ON_BEFORE_POPULATE, _onBeforePopulate);
            view.addEventListener(LifeCycleEvent.ON_AFTER_POPULATE, _onAfterPopulate);
            view.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE, _onBeforeDispose);
            view.addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE, _onAfterDispose);
        }

        public virtual function onBeforePopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforePopulate: " + _viewAlias);
        }

        public virtual function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + _viewAlias);
        }

        public virtual function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + _viewAlias);
        }

        public virtual function onAfterDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterDispose: " + _viewAlias);
        }

        // PRIVATE

        private function _onBeforePopulate(e:LifeCycleEvent):void
        {
            Utils.safeCall(this, onBeforePopulate, [e]);
        }

        private function _onAfterPopulate(e:LifeCycleEvent):void
        {
            Utils.safeCall(this, onAfterPopulate, [e]);
        }

        private function _onBeforeDispose(e:LifeCycleEvent):void
        {
            Utils.safeCall(this, onBeforeDispose, [e]);
        }

        private function _onAfterDispose(e:LifeCycleEvent):void
        {
            Utils.safeCall(this, onAfterDispose, [e]);
        }
    }
}
