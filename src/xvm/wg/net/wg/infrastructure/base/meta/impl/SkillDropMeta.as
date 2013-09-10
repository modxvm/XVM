package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class SkillDropMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function SkillDropMeta()
        {
            super();
            return;
        }

        public function calcDropSkillsParamsS(arg1:String, arg2:Number):Array
        {
            App.utils.asserter.assertNotNull(this.calcDropSkillsParams, "calcDropSkillsParams" + net.wg.data.constants.Errors.CANT_NULL);
            return this.calcDropSkillsParams(arg1, arg2);
        }

        public function dropSkillsS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.dropSkills, "dropSkills" + net.wg.data.constants.Errors.CANT_NULL);
            this.dropSkills(arg1);
            return;
        }

        public var calcDropSkillsParams:Function=null;

        public var dropSkills:Function=null;
    }
}
