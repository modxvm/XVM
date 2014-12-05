package net.wg.gui.lobby.quests.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.IContentSize;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.lobby.quests.data.SeasonVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.quests.events.PersonalQuestEvent;
    
    public class SeasonViewRenderer extends UIComponentEx implements IContentSize
    {
        
        public function SeasonViewRenderer()
        {
            super();
        }
        
        private static var ITEMS_IN_ROW:uint = 3;
        
        private static var ITEMS_HORIZONTAL_GAP:uint = 20;
        
        private static var ITEMS_VERTICAL_GAP:uint = 20;
        
        public var titleTF:TextField;
        
        public var awardsButton:SoundButtonEx;
        
        public var separator:MovieClip;
        
        public var container:Sprite;
        
        private var _model:SeasonVO;
        
        public function get model() : SeasonVO
        {
            return this._model;
        }
        
        public function set model(param1:SeasonVO) : void
        {
            this._model = param1;
            invalidateData();
        }
        
        public function get contentWidth() : Number
        {
            return width;
        }
        
        public function get contentHeight() : Number
        {
            var _loc1_:* = 0;
            if((this._model) || (this._model.hasTiles()))
            {
                _loc1_ = this._model.tiles.length;
            }
            var _loc2_:int = Math.ceil(_loc1_ / ITEMS_IN_ROW);
            var _loc3_:Number = this.container.y + _loc2_ * (QuestTileRenderer.CONTENT_HEIGHT + ITEMS_VERTICAL_GAP);
            return _loc3_;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.awardsButton.focusable = false;
            this.awardsButton.autoSize = TextFieldAutoSize.RIGHT;
            this.awardsButton.label = QUESTS.PERSONAL_SEASONS_AWARDSBUTTON;
            this.awardsButton.tooltip = TOOLTIPS.PRIVATEQUESTS_AWARDSBUTTON;
            this.separator.mouseChildren = this.separator.mouseEnabled = false;
            this.awardsButton.addEventListener(ButtonEvent.CLICK,this.awardsButtonClickHandler);
        }
        
        override protected function onDispose() : void
        {
            this.awardsButton.removeEventListener(ButtonEvent.CLICK,this.awardsButtonClickHandler);
            this.awardsButton.dispose();
            this.awardsButton = null;
            this.clearItems();
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            this.titleTF = null;
            this.separator = null;
            this.container = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._model)
                {
                    this.redrawItems();
                    this.titleTF.htmlText = this._model.title;
                }
            }
        }
        
        private function redrawItems() : void
        {
            var _loc1_:QuestTileRenderer = null;
            this.clearItems();
            if(!this._model || !this._model.hasTiles())
            {
                return;
            }
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            while(_loc4_ < this._model.tiles.length)
            {
                _loc1_ = App.utils.classFactory.getComponent(Linkages.QUEST_TILE_RENDERER,QuestTileRenderer);
                _loc1_.model = this._model.tiles[_loc4_];
                _loc2_ = _loc4_ / ITEMS_IN_ROW;
                _loc3_ = _loc4_ % ITEMS_IN_ROW;
                _loc1_.x = _loc3_ * (QuestTileRenderer.CONTENT_WIDTH + ITEMS_HORIZONTAL_GAP);
                _loc1_.y = _loc2_ * (QuestTileRenderer.CONTENT_HEIGHT + ITEMS_VERTICAL_GAP);
                this.container.addChild(_loc1_);
                _loc4_++;
            }
        }
        
        private function clearItems() : void
        {
            var _loc1_:QuestTileRenderer = null;
            while(this.container.numChildren)
            {
                _loc1_ = this.container.getChildAt(0) as QuestTileRenderer;
                this.container.removeChild(_loc1_);
                _loc1_.dispose();
            }
        }
        
        private function awardsButtonClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:int = this._model?this._model.id:Values.DEFAULT_INT;
            dispatchEvent(new PersonalQuestEvent(PersonalQuestEvent.SHOW_SEASON_AWARDS,_loc2_));
        }
    }
}
