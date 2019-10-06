package net.wg.infrastructure.tutorial.builders.bootcamp
{
    import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
    import net.wg.gui.components.advanced.vo.TutorialEnabledEffectVO;
    import flash.display.DisplayObject;
    import scaleform.clik.events.ComponentEvent;
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.events.TutorialUbComponentEvent;
    import flash.events.Event;

    public class TutorialEnabledEffectBuilder extends TutorialEffectBuilder
    {

        private var _model:TutorialEnabledEffectVO = null;

        public function TutorialEnabledEffectBuilder()
        {
            super();
        }

        override public function set component(param1:DisplayObject) : void
        {
            super.component = param1;
            param1.addEventListener(ComponentEvent.STATE_CHANGE,this.onComponentStateChangeHandler);
        }

        override protected function onDispose() : void
        {
            this.disposeModel();
            component.removeEventListener(ComponentEvent.STATE_CHANGE,this.onComponentStateChangeHandler);
            super.onDispose();
        }

        override protected function createEffect(param1:Object) : void
        {
            if(this._model != null)
            {
                this.disposeModel();
            }
            this._model = new TutorialEnabledEffectVO(param1);
            this.updateComponent();
        }

        private function disposeModel() : void
        {
            if(this._model != null)
            {
                this._model.dispose();
                this._model = null;
            }
        }

        private function updateComponent() : void
        {
            var _loc1_:UIComponent = null;
            if(this._model)
            {
                _loc1_ = component as UIComponent;
                if(_loc1_ && _loc1_.enabled != this._model.enabled)
                {
                    _loc1_.enabled = this._model.enabled;
                    _loc1_.validateNow();
                }
                else
                {
                    component.dispatchEvent(new TutorialUbComponentEvent(TutorialUbComponentEvent.ENABLED,this._model.enabled));
                }
            }
        }

        private function onComponentStateChangeHandler(param1:Event) : void
        {
            this.updateComponent();
        }
    }
}
