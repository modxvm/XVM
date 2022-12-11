/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.widgets
{
    import com.xfw.*;
    import com.xvm.Defines;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;

    public class WidgetsBaseXvmView extends XvmViewBase
    {
        protected var cfg:Array = null;
        protected var extraFieldsWidgetsBottom:ExtraFieldsWidgets = null;
        protected var extraFieldsWidgetsNormal:ExtraFieldsWidgets = null;
        protected var extraFieldsWidgetsTop:ExtraFieldsWidgets = null;

        public function WidgetsBaseXvmView(view:IView)
        {
            super(view);
        }

        override public function onConfigLoaded(e:Event):void
        {
            super.onConfigLoaded(e);
            remove();
            init();
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
            remove();
            cfg = null;
        }

        // PROTECTED

        protected function init():void
        {
            throw new AbstractException(XfwUtils.stack() + " " + Errors.ABSTRACT_INVOKE);
        }

        protected function remove():void
        {
            var page:UIComponent = view as UIComponent;
            if (extraFieldsWidgetsBottom != null)
            {
                page.removeChild(extraFieldsWidgetsBottom);
                extraFieldsWidgetsBottom.dispose();
                extraFieldsWidgetsBottom = null;
            }
            if (extraFieldsWidgetsNormal != null)
            {
                page.removeChild(extraFieldsWidgetsNormal);
                extraFieldsWidgetsNormal.dispose();
                extraFieldsWidgetsNormal = null;
            }
            if (extraFieldsWidgetsTop != null)
            {
                page.removeChild(extraFieldsWidgetsTop);
                extraFieldsWidgetsTop.dispose();
                extraFieldsWidgetsTop = null;
            }
        }

        protected function filterWidgets(cfg:Array, type:String, layer:String):Array
        {
            var res:Array = [];
            var len:int = cfg.length;
            for (var i:int = 0; i < len; ++i)
            {
                var w:CWidget = ObjectConverter.convertData(cfg[i], CWidget);
                if (w != null)
                {
                    w.enabled = w.enabled == null ? true : w.enabled;
                    if (w.enabled)
                    {
                        w.type = w.type == null ? Defines.WIDGET_TYPE_EXTRAFIELD : w.type;
                        if (w.type == type)
                        {
                            w.layer = w.layer == null ? Defines.LAYER_NORMAL : w.layer;
                            if (w.layer.toLowerCase() == layer)
                            {
                                if (w.formats)
                                {
                                    if (w.formats.length > 0)
                                    {
                                        res.push.apply(this, w.clone().formats); // faster than Array.concat()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return res;
        }
    }
}
