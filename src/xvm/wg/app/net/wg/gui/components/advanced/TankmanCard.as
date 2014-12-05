package net.wg.gui.components.advanced
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.data.VO.TankmanCardVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    
    public class TankmanCard extends UIComponentEx
    {
        
        public function TankmanCard()
        {
            super();
        }
        
        public var backFlag:MovieClip;
        
        public var faceIcon:UILoaderAlt;
        
        public var rankIcon:UILoaderAlt;
        
        public var rankLabelTF:TextField;
        
        public var nameLabelTF:TextField;
        
        public var vehicleLabelTF:TextField;
        
        public var rankTF:TextField;
        
        public var nameTF:TextField;
        
        public var vehicleTF:TextField;
        
        private var _model:TankmanCardVO;
        
        public function get model() : TankmanCardVO
        {
            return this._model;
        }
        
        public function set model(param1:TankmanCardVO) : void
        {
            this._model = param1;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.rankLabelTF.htmlText = MENU.TANKMANPERSONALCASE_RANK;
            this.nameLabelTF.htmlText = MENU.TANKMANPERSONALCASE_NAME;
            this.vehicleLabelTF.htmlText = MENU.TANKMANPERSONALCASE_CREW;
        }
        
        override protected function onDispose() : void
        {
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            this.faceIcon.dispose();
            this.faceIcon = null;
            this.rankIcon.dispose();
            this.rankIcon = null;
            this.rankLabelTF = null;
            this.nameLabelTF = null;
            this.vehicleLabelTF = null;
            this.rankTF = null;
            this.nameTF = null;
            this.vehicleTF = null;
            this.backFlag = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._model)
                {
                    this.rankTF.htmlText = this._model.rank;
                    this.nameTF.htmlText = this._model.name;
                    if(!(this._model.vehicle == null) && !(this._model.vehicle == Values.EMPTY_STR))
                    {
                        this.vehicleTF.htmlText = this._model.vehicle;
                        this.vehicleLabelTF.visible = this.vehicleTF.visible = true;
                    }
                    else
                    {
                        this.vehicleLabelTF.visible = this.vehicleTF.visible = false;
                    }
                    this.backFlag.gotoAndPlay(this._model.nation);
                    this.faceIcon.source = this._model.faceIcon;
                    this.rankIcon.source = this._model.rankIcon;
                }
            }
        }
    }
}
