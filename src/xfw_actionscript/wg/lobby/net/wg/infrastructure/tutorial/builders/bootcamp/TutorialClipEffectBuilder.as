package net.wg.infrastructure.tutorial.builders.bootcamp
{
    import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
    import net.wg.gui.components.advanced.vo.TutorialClipEffectVO;
    import net.wg.gui.bootcamp.controls.BCHighlightRendererBase;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import net.wg.data.constants.generated.TUTORIAL_EFFECT_TYPES;

    public class TutorialClipEffectBuilder extends TutorialEffectBuilder
    {

        private var _model:TutorialClipEffectVO = null;

        private var _clip:BCHighlightRendererBase = null;

        public function TutorialClipEffectBuilder()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.disposeModel();
            this.disposeClip();
            super.onDispose();
        }

        override protected function createEffect(param1:Object) : void
        {
            var _loc2_:Rectangle = null;
            this.disposeModel();
            this.disposeClip();
            this._model = new TutorialClipEffectVO(param1);
            this._clip = App.utils.classFactory.getComponent(this._model.linkage,BCHighlightRendererBase);
            _loc2_ = component.getRect(DisplayObject(view));
            this._clip.x = _loc2_.x + (_loc2_.width >> 1) + this._model.offsetX | 0;
            this._clip.y = _loc2_.y + (_loc2_.height >> 1) + this._model.offsetY | 0;
            view.addChild(this._clip);
            this._clip.addEventListener(Event.COMPLETE,this.onClipCompleteHandler);
        }

        private function disposeModel() : void
        {
            if(this._model != null)
            {
                this._model.dispose();
                this._model = null;
            }
        }

        private function disposeClip() : void
        {
            if(this._clip != null)
            {
                this._clip.stop();
                view.removeChild(this._clip);
                this._clip.removeEventListener(Event.COMPLETE,this.onClipCompleteHandler);
                this._clip.dispose();
                this._clip = null;
            }
        }

        private function onClipCompleteHandler(param1:Event) : void
        {
            this.disposeClip();
            App.tutorialMgr.onEffectComplete(component,TUTORIAL_EFFECT_TYPES.CLIP);
        }
    }
}
