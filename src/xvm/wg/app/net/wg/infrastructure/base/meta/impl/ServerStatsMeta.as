package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class ServerStatsMeta extends BaseDAAPIComponent
    {
        
        public function ServerStatsMeta()
        {
            super();
        }
        
        public var getServers:Function = null;
        
        public var relogin:Function = null;
        
        public var isCSISUpdateOnRequest:Function = null;
        
        public var startListenCsisUpdate:Function = null;
        
        public function getServersS() : Array
        {
            App.utils.asserter.assertNotNull(this.getServers,"getServers" + Errors.CANT_NULL);
            return this.getServers();
        }
        
        public function reloginS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.relogin,"relogin" + Errors.CANT_NULL);
            this.relogin(param1);
        }
        
        public function isCSISUpdateOnRequestS() : Boolean
        {
            App.utils.asserter.assertNotNull(this.isCSISUpdateOnRequest,"isCSISUpdateOnRequest" + Errors.CANT_NULL);
            return this.isCSISUpdateOnRequest();
        }
        
        public function startListenCsisUpdateS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.startListenCsisUpdate,"startListenCsisUpdate" + Errors.CANT_NULL);
            this.startListenCsisUpdate(param1);
        }
    }
}
