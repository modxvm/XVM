/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.misc
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.UILoaderAlt;
    import com.xvm.*;

    public class IconLoader extends UILoaderAlt
    {
        private static var s_failIcons:Vector.<String> = new Vector.<String>();

        private var m_altIcons:Vector.<String>;
        private var m_currentIndex: Number;

        public function IconLoader()
        {
            this.background = new Sprite();
            super();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
        }

        public function get loader():Loader
        {
            for (var i:int = 0; i < numChildren; ++i)
            {
                var ldr:Loader = getChildAt(i) as Loader;
                if (ldr != null)
                    return ldr;
            }
            throw new UninitializedError("cannot find loader item");
        }

        public function setSources(altIcons:Vector.<String>):void
        {
            m_altIcons = new Vector.<String>();

            var len:int = altIcons.length;
            for (var i:int = 0; i < len; ++i)
            {
                var ic:String = altIcons[i];
                if (s_failIcons.indexOf(ic) < 0)
                    m_altIcons.push(ic);
            }

            if (sourceAlt != "")
            {
                if (s_failIcons.indexOf(sourceAlt) < 0)
                    m_altIcons.push(sourceAlt);
                sourceAlt = "";
            }

            m_currentIndex = 0;

            source = currentIcon;
        }

        public function get currentIcon():String
        {
            return (m_currentIndex < m_altIcons.length) ? m_altIcons[m_currentIndex] : "";
        }

        protected function onIOError(e:IOErrorEvent):void
        {
            m_currentIndex++;
            var next:String = currentIcon;
            s_failIcons.push(source);
            source = next;
            if (next == "")
            {
                source = "";
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }

        protected function onLoadComplete(e:Event):void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
