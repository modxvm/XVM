package net.wg.gui.lobby.quests.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.quests.data.SeasonTileVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.ComponentState;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.quests.events.PersonalQuestEvent;
    
    public class QuestTileRenderer extends SoundButtonEx
    {
        
        public function QuestTileRenderer()
        {
            super();
            visible = false;
            this.newIndicator.visible = false;
            this.completedIndicator.visible = false;
            this.disableIcon.visible = false;
            preventAutosizing = true;
        }
        
        public static var CONTENT_WIDTH:Number = 307;
        
        public static var CONTENT_HEIGHT:Number = 192;
        
        public var image:UILoaderAlt;
        
        public var imageOver:UILoaderAlt;
        
        public var newIndicator:MovieClip;
        
        public var completedIndicator:UILoaderAlt;
        
        public var disableIcon:UILoaderAlt;
        
        public var labelTF:TextField;
        
        public var progressTF:TextField;
        
        private var _model:SeasonTileVO;
        
        private var _animationMode:Boolean = false;
        
        public function get model() : SeasonTileVO
        {
            return this._model;
        }
        
        public function set model(param1:SeasonTileVO) : void
        {
            this._model = param1;
            enabled = this._model.enabled;
            this.disableIcon.visible = !enabled;
            if(this.model.animation)
            {
                this.image.source = this.model.animation;
                this._animationMode = true;
            }
            else
            {
                this.image.source = this._model.image;
                this.imageOver.source = this._model.imageOver;
                this._animationMode = false;
            }
            invalidateData();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(ButtonEvent.CLICK,this.clickHandler);
            mouseEnabledOnDisabled = true;
            focusable = false;
            this.completedIndicator.source = RES_ICONS.MAPS_ICONS_LIBRARY_COMPLETEDINDICATOR;
            this.disableIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_LOCKED;
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(ButtonEvent.CLICK,this.clickHandler);
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            this.image.dispose();
            this.image = null;
            this.imageOver.dispose();
            this.imageOver = null;
            this.disableIcon.dispose();
            this.disableIcon = null;
            this.completedIndicator.dispose();
            this.completedIndicator = null;
            this.newIndicator = null;
            this.labelTF = null;
            this.progressTF = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.STATE)) && !this._animationMode)
            {
                if(state == ComponentState.OVER || state == ComponentState.RELEASE)
                {
                    this.imageOver.visible = true;
                    this.image.visible = false;
                }
                else
                {
                    this.imageOver.visible = false;
                    this.image.visible = true;
                }
            }
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._model)
                {
                    this.updateNewIndicator();
                    this.labelTF.htmlText = this._model.label;
                    this.progressTF.htmlText = this._model.progress;
                    this.completedIndicator.visible = this._model.isCompleted;
                    visible = true;
                }
                else
                {
                    visible = false;
                }
            }
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            if(this._model)
            {
                App.toolTipMgr.showSpecial(Tooltips.PRIVATE_QUESTS_TILE,null,this._model.id);
            }
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            App.toolTipMgr.hide();
        }
        
        private function updateNewIndicator() : void
        {
            var _loc1_:Boolean = this._model.isNew;
            if(this.newIndicator.visible != _loc1_)
            {
                this.newIndicator.visible = _loc1_;
                if(_loc1_)
                {
                    this.newIndicator.gotoAndPlay("shine");
                }
            }
        }
        
        private function clickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:int = this._model?this._model.id:Values.DEFAULT_INT;
            dispatchEvent(new PersonalQuestEvent(PersonalQuestEvent.TILE_CLICK,_loc2_));
        }
    }
}
