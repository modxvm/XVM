package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class PersonalCaseMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function PersonalCaseMeta()
        {
            super();
            return;
        }

        public function dismissTankmanS(arg1:int):void
        {
            App.utils.asserter.assertNotNull(this.dismissTankman, "dismissTankman" + net.wg.data.constants.Errors.CANT_NULL);
            this.dismissTankman(arg1);
            return;
        }

        public function unloadTankmanS(arg1:int, arg2:int):void
        {
            App.utils.asserter.assertNotNull(this.unloadTankman, "unloadTankman" + net.wg.data.constants.Errors.CANT_NULL);
            this.unloadTankman(arg1, arg2);
            return;
        }

        public function getCommonDataS():void
        {
            App.utils.asserter.assertNotNull(this.getCommonData, "getCommonData" + net.wg.data.constants.Errors.CANT_NULL);
            this.getCommonData();
            return;
        }

        public function getDossierDataS():void
        {
            App.utils.asserter.assertNotNull(this.getDossierData, "getDossierData" + net.wg.data.constants.Errors.CANT_NULL);
            this.getDossierData();
            return;
        }

        public function getRetrainingDataS():void
        {
            App.utils.asserter.assertNotNull(this.getRetrainingData, "getRetrainingData" + net.wg.data.constants.Errors.CANT_NULL);
            this.getRetrainingData();
            return;
        }

        public function retrainingTankmanS(arg1:int, arg2:int, arg3:int):void
        {
            App.utils.asserter.assertNotNull(this.retrainingTankman, "retrainingTankman" + net.wg.data.constants.Errors.CANT_NULL);
            this.retrainingTankman(arg1, arg2, arg3);
            return;
        }

        public function getSkillsDataS():void
        {
            App.utils.asserter.assertNotNull(this.getSkillsData, "getSkillsData" + net.wg.data.constants.Errors.CANT_NULL);
            this.getSkillsData();
            return;
        }

        public function getDocumentsDataS():void
        {
            App.utils.asserter.assertNotNull(this.getDocumentsData, "getDocumentsData" + net.wg.data.constants.Errors.CANT_NULL);
            this.getDocumentsData();
            return;
        }

        public function addTankmanSkillS(arg1:int, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.addTankmanSkill, "addTankmanSkill" + net.wg.data.constants.Errors.CANT_NULL);
            this.addTankmanSkill(arg1, arg2);
            return;
        }

        public function dropSkillsS():void
        {
            App.utils.asserter.assertNotNull(this.dropSkills, "dropSkills" + net.wg.data.constants.Errors.CANT_NULL);
            this.dropSkills();
            return;
        }

        public function changeTankmanPassportS(arg1:int, arg2:int, arg3:int, arg4:int):void
        {
            App.utils.asserter.assertNotNull(this.changeTankmanPassport, "changeTankmanPassport" + net.wg.data.constants.Errors.CANT_NULL);
            this.changeTankmanPassport(arg1, arg2, arg3, arg4);
            return;
        }

        public function openExchangeFreeToTankmanXpWindowS():void
        {
            App.utils.asserter.assertNotNull(this.openExchangeFreeToTankmanXpWindow, "openExchangeFreeToTankmanXpWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.openExchangeFreeToTankmanXpWindow();
            return;
        }

        public var dismissTankman:Function=null;

        public var unloadTankman:Function=null;

        public var getCommonData:Function=null;

        public var getDossierData:Function=null;

        public var getRetrainingData:Function=null;

        public var retrainingTankman:Function=null;

        public var getSkillsData:Function=null;

        public var getDocumentsData:Function=null;

        public var addTankmanSkill:Function=null;

        public var dropSkills:Function=null;

        public var changeTankmanPassport:Function=null;

        public var openExchangeFreeToTankmanXpWindow:Function=null;
    }
}
