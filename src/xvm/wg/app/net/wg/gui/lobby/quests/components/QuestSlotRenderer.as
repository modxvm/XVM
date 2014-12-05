package net.wg.gui.lobby.quests.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.quests.data.QuestSlotVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.quests.events.PersonalQuestEvent;
    
    public class QuestSlotRenderer extends SoundButtonEx
    {
        
        public function QuestSlotRenderer()
        {
            super();
        }
        
        private static var TEXT_HEIGHT_CORRECTION:Number = 5;
        
        private static var DESCRIPTION_OFFSET:Number = 2;
        
        private static var MAX_LINES:Number = 4;
        
        private static var CUT_SYMBOLS_STR:String = " ...";
        
        public var titleTF:TextField;
        
        public var descriptionTF:TextField;
        
        public var noDataTF:TextField;
        
        public var separator:MovieClip;
        
        private var _model:QuestSlotVO;
        
        public function get showSeparator() : Boolean
        {
            return this.separator.visible;
        }
        
        public function set showSeparator(param1:Boolean) : void
        {
            this.separator.visible = param1;
        }
        
        public function get model() : QuestSlotVO
        {
            return this._model;
        }
        
        public function set model(param1:QuestSlotVO) : void
        {
            this._model = param1;
            enabled = (this._model) && !this._model.isEmpty;
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            focusable = false;
            mouseEnabledOnDisabled = true;
            addEventListener(ButtonEvent.CLICK,this.clickHandler);
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(ButtonEvent.CLICK,this.clickHandler);
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            this.titleTF = null;
            this.descriptionTF = null;
            this.noDataTF = null;
            this.separator = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._model)
                {
                    if(this._model.isEmpty)
                    {
                        this.noDataTF.htmlText = this._model.description;
                        this.noDataTF.height = this.noDataTF.textHeight + TEXT_HEIGHT_CORRECTION;
                        this.noDataTF.y = height - this.noDataTF.textHeight >> 1;
                        this.noDataTF.visible = true;
                        this.titleTF.visible = false;
                        this.descriptionTF.visible = false;
                    }
                    else
                    {
                        this.titleTF.htmlText = this._model.title;
                        this.descriptionTF.htmlText = this._model.description;
                        this.titleTF.height = this.titleTF.textHeight + TEXT_HEIGHT_CORRECTION;
                        if(this._model.inProgress)
                        {
                            this.descriptionTF.y = this.titleTF.y + this.titleTF.height + DESCRIPTION_OFFSET;
                            this.cutDescription();
                        }
                        else
                        {
                            _loc1_ = this.titleTF.y + this.titleTF.textHeight - TEXT_HEIGHT_CORRECTION;
                            _loc2_ = height - _loc1_;
                            this.descriptionTF.y = _loc1_ + (_loc2_ - this.descriptionTF.textHeight) / 2 ^ 0;
                        }
                        this.descriptionTF.height = this.descriptionTF.textHeight + TEXT_HEIGHT_CORRECTION;
                        this.noDataTF.visible = false;
                        this.titleTF.visible = true;
                        this.descriptionTF.visible = true;
                    }
                }
            }
        }
        
        private function cutDescription() : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc1_:int = this.titleTF.numLines + this.descriptionTF.numLines;
            if(_loc1_ > MAX_LINES)
            {
                _loc2_ = MAX_LINES - this.titleTF.numLines;
                _loc3_ = this.descriptionTF.getLineOffset(_loc2_);
                this.descriptionTF.text = this.descriptionTF.text.substring(0,_loc3_) + CUT_SYMBOLS_STR;
                _loc4_ = 1;
                while(this.descriptionTF.numLines > _loc2_)
                {
                    this.descriptionTF.text = this.descriptionTF.text.substring(0,_loc3_ - _loc4_) + CUT_SYMBOLS_STR;
                    _loc4_++;
                }
            }
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            super.handleMouseRollOver(param1);
            if(this._model)
            {
                _loc2_ = new ComplexTooltipHelper().addHeader(this._model.ttHeader).addBody(this._model.ttBody).addNote(this._model.ttNote).addAttention(this._model.ttAttention).make();
                if(_loc2_.length > 0)
                {
                    App.toolTipMgr.showComplex(_loc2_);
                }
            }
        }
        
        private function clickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:int = this._model?this._model.id:Values.DEFAULT_INT;
            dispatchEvent(new PersonalQuestEvent(PersonalQuestEvent.SLOT_CLICK,_loc2_));
        }
    }
}
