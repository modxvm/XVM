package net.wg.gui.lobby.referralSystem
{
    import net.wg.infrastructure.base.UIComponentEx;
    import scaleform.clik.controls.StatusIndicator;
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.gui.lobby.referralSystem.data.ComplexProgressIndicatorVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Linkages;
    
    public class ComplexProgressIndicator extends UIComponentEx
    {
        
        public function ComplexProgressIndicator()
        {
            super();
        }
        
        public var progressBar:StatusIndicator;
        
        public var container:Sprite;
        
        public var textField:TextField;
        
        private var _model:ComplexProgressIndicatorVO;
        
        public function get model() : ComplexProgressIndicatorVO
        {
            return this._model;
        }
        
        public function set model(param1:ComplexProgressIndicatorVO) : void
        {
            this._model = param1;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.progressBar.minimum = 0;
            this.progressBar.maximum = 1;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._model))
            {
                this.progressBar.value = this._model.progress;
                this.textField.htmlText = this._model.text;
                this.redrawSteps();
            }
        }
        
        override protected function onDispose() : void
        {
            this.clearSteps();
            this.progressBar.dispose();
            this.progressBar = null;
            this.container = null;
            this.textField = null;
            super.onDispose();
        }
        
        private function redrawSteps() : void
        {
            var _loc2_:ProgressStepRenderer = null;
            var _loc5_:* = 0;
            this.clearSteps();
            var _loc1_:Class = App.utils.classFactory.getClass(Linkages.PROGRESS_STEP_RENDERER);
            var _loc3_:uint = this._model.steps.length;
            var _loc4_:Number = this.progressBar.width / _loc3_;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
                _loc2_ = new _loc1_();
                _loc2_.x = (_loc5_ + 1) * _loc4_;
                _loc2_.showLine = _loc5_ < _loc3_ - 1;
                _loc2_.model = this._model.steps[_loc5_];
                this.container.addChild(_loc2_);
                _loc5_++;
            }
        }
        
        private function clearSteps() : void
        {
            var _loc1_:ProgressStepRenderer = null;
            while(this.container.numChildren)
            {
                _loc1_ = this.container.getChildAt(0) as ProgressStepRenderer;
                this.container.removeChild(_loc1_);
                _loc1_.dispose();
            }
        }
    }
}
