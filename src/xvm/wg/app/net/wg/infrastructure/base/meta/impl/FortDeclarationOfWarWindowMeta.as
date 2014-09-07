package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class FortDeclarationOfWarWindowMeta extends AbstractWindowView
    {
        
        public function FortDeclarationOfWarWindowMeta()
        {
            super();
        }
        
        public var onDirectonChosen:Function = null;
        
        public var onDirectionSelected:Function = null;
        
        public function onDirectonChosenS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onDirectonChosen,"onDirectonChosen" + Errors.CANT_NULL);
            this.onDirectonChosen(param1);
        }
        
        public function onDirectionSelectedS() : void
        {
            App.utils.asserter.assertNotNull(this.onDirectionSelected,"onDirectionSelected" + Errors.CANT_NULL);
            this.onDirectionSelected();
        }
    }
}
