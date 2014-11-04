package net.wg.gui.lobby.referralSystem
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.lobby.referralSystem.data.ComplexProgressIndicatorVO;
    import scaleform.gfx.TextFieldEx;
    
    public class AwardReceivedBlock extends UIComponentEx
    {
        
        public function AwardReceivedBlock()
        {
            super();
        }
        
        public var awardImage:UILoaderAlt;
        
        public var completeIndicator:UILoaderAlt;
        
        public var textField:TextField;
        
        private var _model:ComplexProgressIndicatorVO;
        
        public function get model() : ComplexProgressIndicatorVO
        {
            return this._model;
        }
        
        public function set model(param1:ComplexProgressIndicatorVO) : void
        {
            this._model = param1;
            if(this._model)
            {
                this.awardImage.source = this._model.completedImage;
                this.textField.htmlText = this._model.completedText;
            }
        }
        
        override protected function configUI() : void
        {
            TextFieldEx.setVerticalAlign(this.textField,TextFieldEx.VALIGN_CENTER);
            this.completeIndicator.source = RES_ICONS.MAPS_ICONS_LIBRARY_DONE;
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            this.awardImage.dispose();
            this.awardImage = null;
            this.completeIndicator.dispose();
            this.completeIndicator = null;
            this.textField = null;
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }
    }
}
