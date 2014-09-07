package net.wg.gui.rally
{
    import net.wg.infrastructure.base.meta.impl.AbstractRallyViewMeta;
    import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import flash.display.InteractiveObject;
    
    public class AbstractRallyView extends AbstractRallyViewMeta implements IAbstractRallyViewMeta, IViewStackContent
    {
        
        public function AbstractRallyView()
        {
            super();
        }
        
        private var _pyAlias:String;
        
        public function as_setPyAlias(param1:String) : void
        {
            this._pyAlias = param1;
        }
        
        public function as_getPyAlias() : String
        {
            return this._pyAlias;
        }
        
        public function update(param1:Object) : void
        {
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
    }
}
