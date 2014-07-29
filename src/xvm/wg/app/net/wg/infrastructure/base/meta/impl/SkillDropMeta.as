package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class SkillDropMeta extends AbstractWindowView
    {
        
        public function SkillDropMeta()
        {
            super();
        }
        
        public var calcDropSkillsParams:Function = null;
        
        public var dropSkills:Function = null;
        
        public function calcDropSkillsParamsS(param1:String, param2:Number) : Array
        {
            App.utils.asserter.assertNotNull(this.calcDropSkillsParams,"calcDropSkillsParams" + Errors.CANT_NULL);
            return this.calcDropSkillsParams(param1,param2);
        }
        
        public function dropSkillsS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.dropSkills,"dropSkills" + Errors.CANT_NULL);
            this.dropSkills(param1);
        }
    }
}
