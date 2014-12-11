package net.wg.gui.lobby.quests.views
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.infrastructure.interfaces.IFocusChainContainer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ResizableScrollPane;
    import net.wg.gui.lobby.quests.components.QuestTaskDescription;
    import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskDetailsVO;
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import net.wg.gui.components.controls.events.ScrollPaneEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.events.FocusChainChangeEvent;
    import net.wg.gui.lobby.quests.events.QuestTaskDetailsViewEvent;
    
    public class QuestTaskDetailsView extends UIComponent implements IViewStackContent, IFocusChainContainer
    {
        
        public function QuestTaskDetailsView()
        {
            super();
        }
        
        private static var VERTICAL_OFFSET:int = 15;
        
        private static var SCROLLBAR_AWARD_GAP:int = 10;
        
        public var headerTF:TextField = null;
        
        public var scrollPane:ResizableScrollPane = null;
        
        public var descriptionBlock:QuestTaskDescription = null;
        
        public var awardsBlock:QuestAwardsBlock = null;
        
        public var scrollBar:ScrollBar = null;
        
        public var applyBtn:SoundButtonEx = null;
        
        public var cancelBtn:SoundButtonEx = null;
        
        public var taskDescriptionTF:TextField = null;
        
        private var _model:QuestTaskDetailsVO = null;
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this;
        }
        
        public function update(param1:Object) : void
        {
            if(this._model != param1)
            {
                this._model = QuestTaskDetailsVO(param1);
                invalidateData();
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.applyBtn.mouseEnabledOnDisabled = true;
            this.cancelBtn.mouseEnabledOnDisabled = true;
            this.scrollPane.scrollBar = this.scrollBar;
            this.awardsBlock.flagBottom.visible = false;
            this.descriptionBlock = QuestTaskDescription(this.scrollPane.target);
            this.descriptionBlock.addEventListener(Event.RESIZE,this.onResizeEvent);
            this.awardsBlock.addEventListener(Event.RESIZE,this.onResizeEvent);
            this.scrollBar.addEventListener(Event.RESIZE,this.onResizeEvent);
            this.scrollPane.addEventListener(ScrollPaneEvent.POSITION_CHANGED,this.onScrollBarPositionChangedHandler);
            this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
            this.taskDescriptionTF.wordWrap = true;
            this.taskDescriptionTF.multiline = true;
            this.taskDescriptionTF.mouseEnabled = false;
            this.awardsBlock.visible = false;
            this.awardsBlock.addEventListener(Event.RESIZE,this.onAwardsBlockResizeHandler);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this._model)
                {
                    this.visible = true;
                    this.headerTF.htmlText = this._model.headerText;
                    this.descriptionBlock.textField.htmlText = this._model.conditionsText;
                    this.applyBtn.visible = this._model.isApplyBtnVisible;
                    this.applyBtn.enabled = this._model.isApplyBtnEnabled;
                    this.cancelBtn.visible = this._model.isCancelBtnVisible;
                    this.awardsBlock.setData(this._model.awards);
                    if(this._model.isApplyBtnVisible)
                    {
                        this.applyBtn.label = this._model.btnLabel;
                        this.applyBtn.tooltip = this._model.btnToolTip?this._model.btnToolTip:Values.EMPTY_STR;
                    }
                    if(this._model.isCancelBtnVisible)
                    {
                        this.cancelBtn.label = this._model.btnLabel;
                        this.cancelBtn.tooltip = this._model.btnToolTip?this._model.btnToolTip:Values.EMPTY_STR;
                    }
                    this.taskDescriptionTF.htmlText = this._model.taskDescriptionText;
                    if(this._model.taskDescriptionText)
                    {
                        if((this.applyBtn.visible) || (this.cancelBtn.visible))
                        {
                            this.taskDescriptionTF.height = this.taskDescriptionTF.textHeight + 5;
                            this.taskDescriptionTF.y = this.applyBtn.y - VERTICAL_OFFSET - this.taskDescriptionTF.height;
                        }
                        else
                        {
                            this.taskDescriptionTF.y = this.applyBtn.y;
                        }
                    }
                    this.descriptionBlock.invalidateSize();
                    this.awardsBlock.invalidateSize();
                }
                else
                {
                    this.visible = false;
                }
                dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
            }
        }
        
        override protected function onDispose() : void
        {
            this.descriptionBlock.removeEventListener(Event.RESIZE,this.onResizeEvent);
            this.awardsBlock.removeEventListener(Event.RESIZE,this.onResizeEvent);
            this.scrollBar.removeEventListener(Event.RESIZE,this.onResizeEvent);
            this.scrollPane.removeEventListener(ScrollPaneEvent.POSITION_CHANGED,this.onScrollBarPositionChangedHandler);
            this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onApplyBtnClickHandler);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
            this.awardsBlock.removeEventListener(Event.RESIZE,this.onAwardsBlockResizeHandler);
            this.headerTF = null;
            this.scrollPane.dispose();
            this.scrollPane = null;
            this.awardsBlock.dispose();
            this.awardsBlock = null;
            this.scrollBar.dispose();
            this.scrollBar = null;
            this.applyBtn.dispose();
            this.applyBtn = null;
            this.cancelBtn.dispose();
            this.cancelBtn = null;
            this.taskDescriptionTF = null;
            if(this._model)
            {
                this._model.dispose();
                this._model = null;
            }
            super.onDispose();
        }
        
        private function showAwardsBlock() : void
        {
            this.awardsBlock.visible = true;
        }
        
        private function onResizeEvent(param1:Event) : void
        {
            var _loc2_:int = this.awardsBlock.y;
            if(this.taskDescriptionTF.htmlText)
            {
                _loc2_ = this.taskDescriptionTF.y - VERTICAL_OFFSET - this.awardsBlock.height;
            }
            else if(this.applyBtn.visible)
            {
                _loc2_ = this.applyBtn.y - VERTICAL_OFFSET - this.awardsBlock.height;
            }
            else if(this.cancelBtn.visible)
            {
                _loc2_ = this.cancelBtn.y - VERTICAL_OFFSET - this.awardsBlock.height;
            }
            
            
            this.awardsBlock.y = _loc2_;
            this.scrollPane.height = this.awardsBlock.y - this.scrollPane.y - SCROLLBAR_AWARD_GAP;
            this.scrollBar.height = this.scrollPane.height;
            this.scrollPane.invalidateSize();
        }
        
        private function onScrollBarPositionChangedHandler(param1:ScrollPaneEvent) : void
        {
            this.scrollBar.height = this.scrollPane.height;
        }
        
        public function getFocusChain() : Array
        {
            var _loc1_:Array = [];
            if(this.cancelBtn.visible)
            {
                _loc1_[0] = this.cancelBtn;
            }
            else if(this.applyBtn.visible)
            {
                _loc1_[0] = this.applyBtn;
            }
            
            return _loc1_;
        }
        
        private function onApplyBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new QuestTaskDetailsViewEvent(QuestTaskDetailsViewEvent.SELECT_TASK,this._model.taskID));
        }
        
        private function onCancelBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new QuestTaskDetailsViewEvent(QuestTaskDetailsViewEvent.CANCEL_TASK,this._model.taskID));
        }
        
        private function onAwardsBlockResizeHandler(param1:Event) : void
        {
            this.awardsBlock.removeEventListener(Event.RESIZE,this.onAwardsBlockResizeHandler);
            App.utils.scheduler.envokeInNextFrame(this.showAwardsBlock);
        }
    }
}
