package net.wg.gui.lobby.quests.components
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.BackButton;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewHeaderVO;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.quests.events.QuestsTileChainViewHeaderEvent;
    import scaleform.clik.constants.InvalidationType;
    
    public class QuestsTileChainsViewHeader extends UIComponent
    {
        
        public function QuestsTileChainsViewHeader()
        {
            super();
            this.backBtn.addEventListener(ButtonEvent.PRESS,this.onBackButtonPress);
        }
        
        public var titleTf:TextField;
        
        public var backBtn:BackButton;
        
        public var backgroundLoader:UILoaderAlt;
        
        private var _data:QuestsTileChainsViewHeaderVO;
        
        private function onBackButtonPress(param1:ButtonEvent) : void
        {
            dispatchEvent(new QuestsTileChainViewHeaderEvent(QuestsTileChainViewHeaderEvent.BACK_BUTTON_PRESS));
        }
        
        public function setData(param1:QuestsTileChainsViewHeaderVO) : void
        {
            this._data = param1;
            this.backBtn.label = param1.backBtnText;
            this.backBtn.tooltip = param1.backBtnTooltip;
            this.backgroundLoader.source = param1.backgroundImagePath;
            invalidateData();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && !(this._data == null))
            {
                this.titleTf.htmlText = this._data.titleText;
            }
        }
        
        override protected function onDispose() : void
        {
            this.backBtn.removeEventListener(ButtonEvent.PRESS,this.onBackButtonPress);
            this.backBtn.dispose();
            this.backgroundLoader.dispose();
            this.backgroundLoader = null;
            this.backBtn = null;
            this.titleTf = null;
            this._data = null;
            super.onDispose();
        }
    }
}
