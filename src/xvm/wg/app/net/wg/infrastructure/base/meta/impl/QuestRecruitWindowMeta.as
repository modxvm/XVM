package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class QuestRecruitWindowMeta extends AbstractWindowView
    {
        
        public function QuestRecruitWindowMeta()
        {
            super();
        }
        
        public var onApply:Function = null;
        
        public function onApplyS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.onApply,"onApply" + Errors.CANT_NULL);
            this.onApply(param1);
        }
    }
}
