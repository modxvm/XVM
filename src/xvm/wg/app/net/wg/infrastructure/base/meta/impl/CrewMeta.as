package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class CrewMeta extends BaseDAAPIComponent
    {
        
        public function CrewMeta()
        {
            super();
        }
        
        public var onShowRecruitWindowClick:Function = null;
        
        public var unloadAllTankman:Function = null;
        
        public var equipTankman:Function = null;
        
        public var updateTankmen:Function = null;
        
        public var openPersonalCase:Function = null;
        
        public function onShowRecruitWindowClickS(param1:Object, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.onShowRecruitWindowClick,"onShowRecruitWindowClick" + Errors.CANT_NULL);
            this.onShowRecruitWindowClick(param1,param2);
        }
        
        public function unloadAllTankmanS() : void
        {
            App.utils.asserter.assertNotNull(this.unloadAllTankman,"unloadAllTankman" + Errors.CANT_NULL);
            this.unloadAllTankman();
        }
        
        public function equipTankmanS(param1:String, param2:Number) : void
        {
            App.utils.asserter.assertNotNull(this.equipTankman,"equipTankman" + Errors.CANT_NULL);
            this.equipTankman(param1,param2);
        }
        
        public function updateTankmenS() : void
        {
            App.utils.asserter.assertNotNull(this.updateTankmen,"updateTankmen" + Errors.CANT_NULL);
            this.updateTankmen();
        }
        
        public function openPersonalCaseS(param1:String, param2:uint) : void
        {
            App.utils.asserter.assertNotNull(this.openPersonalCase,"openPersonalCase" + Errors.CANT_NULL);
            this.openPersonalCase(param1,param2);
        }
    }
}
