package net.wg.gui.events 
{
    import flash.events.*;
    
    public class PersonalCaseEvent extends flash.events.Event
    {
        public function PersonalCaseEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            this.newTankmanFirstName = {};
            this.newTankmanLastName = {};
            this.newIcon = {};
            super(arg1, arg2, arg3);
            return;
        }

        public static const APPLY_RETRAINING:String="applyRetraining";

        public static const TRAINING_SKILL:String="trainingSkill";

        public static const CHANGE_PASSPORT:String="changePassport";

        public static const CHANGE_TAB_ON_TWO:String="changeTabToTwo";

        public static const GET_TANKMAN_ID:String="getTankmanID";

        public var tankmanIdDelegate:Function;

        public var retrainingTankmanData:Object;

        public var trainingSkillName:String;

        public var newTankmanFirstName:Object;

        public var newTankmanLastName:Object;

        public var newIcon:Object;
    }
}
