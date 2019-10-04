package net.wg.data.generated.views
{
    import net.wg.infrastructure.base.ComponentWithModel;
    import net.wg.data.generated.models.TestViewModel;

    public class TestViewBase extends ComponentWithModel
    {

        protected var testViewModel:TestViewModel;

        public function TestViewBase()
        {
            super();
        }

        override protected function initialize() : void
        {
            this.testViewModel = new TestViewModel();
            viewModel = this.testViewModel;
        }
    }
}
