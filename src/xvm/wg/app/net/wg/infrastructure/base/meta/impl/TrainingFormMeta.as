package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class TrainingFormMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function TrainingFormMeta()
        {
            super();
            return;
        }

        public function joinTrainingRequestS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.joinTrainingRequest, "joinTrainingRequest" + net.wg.data.constants.Errors.CANT_NULL);
            this.joinTrainingRequest(arg1);
            return;
        }

        public function createTrainingRequestS():void
        {
            App.utils.asserter.assertNotNull(this.createTrainingRequest, "createTrainingRequest" + net.wg.data.constants.Errors.CANT_NULL);
            this.createTrainingRequest();
            return;
        }

        public function onEscapeS():void
        {
            App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + net.wg.data.constants.Errors.CANT_NULL);
            this.onEscape();
            return;
        }

        public var joinTrainingRequest:Function=null;

        public var createTrainingRequest:Function=null;

        public var onEscape:Function=null;
    }
}
