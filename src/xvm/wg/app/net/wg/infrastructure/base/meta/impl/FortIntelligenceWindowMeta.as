package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class FortIntelligenceWindowMeta extends AbstractWindowView
    {
        
        public function FortIntelligenceWindowMeta()
        {
            super();
        }
        
        public var getLevelColumnIcons:Function = null;
        
        public var requestClanFortInfo:Function = null;
        
        public function getLevelColumnIconsS() : String
        {
            App.utils.asserter.assertNotNull(this.getLevelColumnIcons,"getLevelColumnIcons" + Errors.CANT_NULL);
            return this.getLevelColumnIcons();
        }
        
        public function requestClanFortInfoS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.requestClanFortInfo,"requestClanFortInfo" + Errors.CANT_NULL);
            this.requestClanFortInfo(param1);
        }
    }
}
