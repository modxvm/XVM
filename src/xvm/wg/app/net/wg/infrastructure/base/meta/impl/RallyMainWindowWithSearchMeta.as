package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.BaseRallyMainWindow;
    import net.wg.data.constants.Errors;
    
    public class RallyMainWindowWithSearchMeta extends BaseRallyMainWindow
    {
        
        public function RallyMainWindowWithSearchMeta()
        {
            super();
        }
        
        public var onAutoMatch:Function = null;
        
        public var autoSearchApply:Function = null;
        
        public var autoSearchCancel:Function = null;
        
        public function onAutoMatchS(param1:String, param2:Array) : void
        {
            App.utils.asserter.assertNotNull(this.onAutoMatch,"onAutoMatch" + Errors.CANT_NULL);
            this.onAutoMatch(param1,param2);
        }
        
        public function autoSearchApplyS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.autoSearchApply,"autoSearchApply" + Errors.CANT_NULL);
            this.autoSearchApply(param1);
        }
        
        public function autoSearchCancelS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.autoSearchCancel,"autoSearchCancel" + Errors.CANT_NULL);
            this.autoSearchCancel(param1);
        }
    }
}
