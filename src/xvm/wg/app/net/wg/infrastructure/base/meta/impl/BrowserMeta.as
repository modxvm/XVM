package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class BrowserMeta extends AbstractWindowView
    {
        
        public function BrowserMeta()
        {
            super();
        }
        
        public var browserAction:Function = null;
        
        public var browserMove:Function = null;
        
        public var browserDown:Function = null;
        
        public var browserUp:Function = null;
        
        public var browserFocusOut:Function = null;
        
        public var onBrowserShow:Function = null;
        
        public var onBrowserHide:Function = null;
        
        public function browserActionS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.browserAction,"browserAction" + Errors.CANT_NULL);
            this.browserAction(param1);
        }
        
        public function browserMoveS(param1:int, param2:int, param3:int) : void
        {
            App.utils.asserter.assertNotNull(this.browserMove,"browserMove" + Errors.CANT_NULL);
            this.browserMove(param1,param2,param3);
        }
        
        public function browserDownS(param1:int, param2:int, param3:int) : void
        {
            App.utils.asserter.assertNotNull(this.browserDown,"browserDown" + Errors.CANT_NULL);
            this.browserDown(param1,param2,param3);
        }
        
        public function browserUpS(param1:int, param2:int, param3:int) : void
        {
            App.utils.asserter.assertNotNull(this.browserUp,"browserUp" + Errors.CANT_NULL);
            this.browserUp(param1,param2,param3);
        }
        
        public function browserFocusOutS() : void
        {
            App.utils.asserter.assertNotNull(this.browserFocusOut,"browserFocusOut" + Errors.CANT_NULL);
            this.browserFocusOut();
        }
        
        public function onBrowserShowS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.onBrowserShow,"onBrowserShow" + Errors.CANT_NULL);
            this.onBrowserShow(param1);
        }
        
        public function onBrowserHideS() : void
        {
            App.utils.asserter.assertNotNull(this.onBrowserHide,"onBrowserHide" + Errors.CANT_NULL);
            this.onBrowserHide();
        }
    }
}
