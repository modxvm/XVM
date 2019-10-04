package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;

    public class InputCheckerMeta extends BaseDAAPIComponent
    {

        public var sendUserInput:Function;

        public function InputCheckerMeta()
        {
            super();
        }

        public function sendUserInputS(param1:String, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.sendUserInput,"sendUserInput" + Errors.CANT_NULL);
            this.sendUserInput(param1,param2);
        }
    }
}
