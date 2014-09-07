package net.wg.gui.prebattle.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class AbstractRallyWindowMeta extends AbstractWindowView
    {
        
        public function AbstractRallyWindowMeta()
        {
            super();
        }
        
        public var canGoBack:Function = null;
        
        public var onBrowseRallies:Function = null;
        
        public var onCreateRally:Function = null;
        
        public var onJoinRally:Function = null;
        
        public function canGoBackS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.canGoBack,"canGoBack" + Errors.CANT_NULL);
            return this.canGoBack();
        }
        
        public function onBrowseRalliesS() : void
        {
            App.utils.asserter.assertNotNull(this.onBrowseRallies,"onBrowseRallies" + Errors.CANT_NULL);
            this.onBrowseRallies();
        }
        
        public function onCreateRallyS() : void
        {
            App.utils.asserter.assertNotNull(this.onCreateRally,"onCreateRally" + Errors.CANT_NULL);
            this.onCreateRally();
        }
        
        public function onJoinRallyS(param1:Number, param2:int, param3:Number) : void
        {
            App.utils.asserter.assertNotNull(this.onJoinRally,"onJoinRally" + Errors.CANT_NULL);
            this.onJoinRally(param1,param2,param3);
        }
    }
}
