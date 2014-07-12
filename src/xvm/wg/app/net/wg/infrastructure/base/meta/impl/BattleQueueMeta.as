package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;
    
    public class BattleQueueMeta extends AbstractView
    {
        
        public function BattleQueueMeta() {
            super();
        }
        
        public var startClick:Function = null;
        
        public var exitClick:Function = null;
        
        public var onEscape:Function = null;
        
        public function startClickS() : void {
            App.utils.asserter.assertNotNull(this.startClick,"startClick" + Errors.CANT_NULL);
            this.startClick();
        }
        
        public function exitClickS() : void {
            App.utils.asserter.assertNotNull(this.exitClick,"exitClick" + Errors.CANT_NULL);
            this.exitClick();
        }
        
        public function onEscapeS() : void {
            App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
            this.onEscape();
        }
    }
}
