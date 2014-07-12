package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class PersonalCaseMeta extends AbstractWindowView
    {
        
        public function PersonalCaseMeta() {
            super();
        }
        
        public var dismissTankman:Function = null;
        
        public var unloadTankman:Function = null;
        
        public var getCommonData:Function = null;
        
        public var getDossierData:Function = null;
        
        public var getRetrainingData:Function = null;
        
        public var retrainingTankman:Function = null;
        
        public var getSkillsData:Function = null;
        
        public var getDocumentsData:Function = null;
        
        public var addTankmanSkill:Function = null;
        
        public var dropSkills:Function = null;
        
        public var changeTankmanPassport:Function = null;
        
        public var openExchangeFreeToTankmanXpWindow:Function = null;
        
        public function dismissTankmanS(param1:int) : void {
            App.utils.asserter.assertNotNull(this.dismissTankman,"dismissTankman" + Errors.CANT_NULL);
            this.dismissTankman(param1);
        }
        
        public function unloadTankmanS(param1:int, param2:int) : void {
            App.utils.asserter.assertNotNull(this.unloadTankman,"unloadTankman" + Errors.CANT_NULL);
            this.unloadTankman(param1,param2);
        }
        
        public function getCommonDataS() : void {
            App.utils.asserter.assertNotNull(this.getCommonData,"getCommonData" + Errors.CANT_NULL);
            this.getCommonData();
        }
        
        public function getDossierDataS() : void {
            App.utils.asserter.assertNotNull(this.getDossierData,"getDossierData" + Errors.CANT_NULL);
            this.getDossierData();
        }
        
        public function getRetrainingDataS() : void {
            App.utils.asserter.assertNotNull(this.getRetrainingData,"getRetrainingData" + Errors.CANT_NULL);
            this.getRetrainingData();
        }
        
        public function retrainingTankmanS(param1:int, param2:int, param3:int) : void {
            App.utils.asserter.assertNotNull(this.retrainingTankman,"retrainingTankman" + Errors.CANT_NULL);
            this.retrainingTankman(param1,param2,param3);
        }
        
        public function getSkillsDataS() : void {
            App.utils.asserter.assertNotNull(this.getSkillsData,"getSkillsData" + Errors.CANT_NULL);
            this.getSkillsData();
        }
        
        public function getDocumentsDataS() : void {
            App.utils.asserter.assertNotNull(this.getDocumentsData,"getDocumentsData" + Errors.CANT_NULL);
            this.getDocumentsData();
        }
        
        public function addTankmanSkillS(param1:int, param2:String) : void {
            App.utils.asserter.assertNotNull(this.addTankmanSkill,"addTankmanSkill" + Errors.CANT_NULL);
            this.addTankmanSkill(param1,param2);
        }
        
        public function dropSkillsS() : void {
            App.utils.asserter.assertNotNull(this.dropSkills,"dropSkills" + Errors.CANT_NULL);
            this.dropSkills();
        }
        
        public function changeTankmanPassportS(param1:int, param2:int, param3:int, param4:int) : void {
            App.utils.asserter.assertNotNull(this.changeTankmanPassport,"changeTankmanPassport" + Errors.CANT_NULL);
            this.changeTankmanPassport(param1,param2,param3,param4);
        }
        
        public function openExchangeFreeToTankmanXpWindowS() : void {
            App.utils.asserter.assertNotNull(this.openExchangeFreeToTankmanXpWindow,"openExchangeFreeToTankmanXpWindow" + Errors.CANT_NULL);
            this.openExchangeFreeToTankmanXpWindow();
        }
    }
}
