package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class BrowserMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function BrowserMeta()
        {
            super();
            return;
        }

        public function browserActionS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.browserAction, "browserAction" + net.wg.data.constants.Errors.CANT_NULL);
            this.browserAction(arg1);
            return;
        }

        public function browserMoveS(arg1:int, arg2:int, arg3:int):void
        {
            App.utils.asserter.assertNotNull(this.browserMove, "browserMove" + net.wg.data.constants.Errors.CANT_NULL);
            this.browserMove(arg1, arg2, arg3);
            return;
        }

        public function browserDownS(arg1:int, arg2:int, arg3:int):void
        {
            App.utils.asserter.assertNotNull(this.browserDown, "browserDown" + net.wg.data.constants.Errors.CANT_NULL);
            this.browserDown(arg1, arg2, arg3);
            return;
        }

        public function browserUpS(arg1:int, arg2:int, arg3:int):void
        {
            App.utils.asserter.assertNotNull(this.browserUp, "browserUp" + net.wg.data.constants.Errors.CANT_NULL);
            this.browserUp(arg1, arg2, arg3);
            return;
        }

        public function browserFocusOutS():void
        {
            App.utils.asserter.assertNotNull(this.browserFocusOut, "browserFocusOut" + net.wg.data.constants.Errors.CANT_NULL);
            this.browserFocusOut();
            return;
        }

        public function onBrowserShowS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.onBrowserShow, "onBrowserShow" + net.wg.data.constants.Errors.CANT_NULL);
            this.onBrowserShow(arg1);
            return;
        }

        public function onBrowserHideS():void
        {
            App.utils.asserter.assertNotNull(this.onBrowserHide, "onBrowserHide" + net.wg.data.constants.Errors.CANT_NULL);
            this.onBrowserHide();
            return;
        }

        public var browserAction:Function=null;

        public var browserMove:Function=null;

        public var browserDown:Function=null;

        public var browserUp:Function=null;

        public var browserFocusOut:Function=null;

        public var onBrowserShow:Function=null;

        public var onBrowserHide:Function=null;
    }
}
