package net.wg.gui.lobby.quests.views
{
    import net.wg.infrastructure.base.meta.impl.QuestsPersonalWelcomeViewMeta;
    import net.wg.infrastructure.base.meta.IQuestsPersonalWelcomeViewMeta;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.quests.components.interfaces.ITextBlockWelcomeView;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.quests.data.seasonAwards.QuestsPersonalWelcomeViewVO;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.infrastructure.events.FocusChainChangeEvent;
    import scaleform.gfx.TextFieldEx;
    
    public class QuestsPersonalWelcomeView extends QuestsPersonalWelcomeViewMeta implements IQuestsPersonalWelcomeViewMeta, IViewStackContent
    {
        
        public function QuestsPersonalWelcomeView()
        {
            super();
            this.textBlocks = new <ITextBlockWelcomeView>[this.textBlock1,this.textBlock2,this.textBlock3];
            this.bgLoader.autoSize = false;
            this.bgLoader.source = RES_ICONS.MAPS_ICONS_QUESTS_PROMOSCREEN;
            TextFieldEx.setVerticalAlign(this.titleText,TextFieldEx.VALIGN_CENTER);
        }
        
        public var titleText:TextField = null;
        
        public var bgLoader:UILoaderAlt = null;
        
        public var textBlock1:ITextBlockWelcomeView = null;
        
        public var textBlock2:ITextBlockWelcomeView = null;
        
        public var textBlock3:ITextBlockWelcomeView = null;
        
        public var textBlocks:Vector.<ITextBlockWelcomeView> = null;
        
        public var successBtn:SoundButtonEx = null;
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
        
        public function update(param1:Object) : void
        {
            var _loc2_:String = "update" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this.successBtn;
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:ITextBlockWelcomeView = null;
            this.titleText = null;
            this.bgLoader.dispose();
            this.bgLoader = null;
            this.successBtn.removeEventListener(ButtonEvent.CLICK,this.successBtn_buttonClickHandler);
            this.successBtn.dispose();
            this.successBtn = null;
            for each(_loc1_ in this.textBlocks)
            {
                _loc1_.dispose();
            }
            this.textBlocks.splice(0,this.textBlocks.length);
            this.textBlocks = null;
            this.textBlock1 = null;
            this.textBlock2 = null;
            this.textBlock3 = null;
            super.onDispose();
        }
        
        override protected function setData(param1:QuestsPersonalWelcomeViewVO) : void
        {
            var _loc4_:* = 0;
            var _loc2_:int = this.textBlocks.length;
            var _loc3_:int = param1.blockData.length;
            App.utils.asserter.assert(_loc2_ == _loc3_,"blocks data and  text blocks count doesn\'t correspond");
            this.titleText.htmlText = param1.titleText;
            this.successBtn.label = param1.buttonLbl;
            if(_loc3_ > 0)
            {
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    IUpdatable(this.textBlocks[_loc4_]).update(param1.blockData[_loc4_]);
                    _loc4_++;
                }
            }
            param1.dispose();
            var param1:QuestsPersonalWelcomeViewVO = null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.successBtn.addEventListener(ButtonEvent.CLICK,this.successBtn_buttonClickHandler);
            dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
        }
        
        private function successBtn_buttonClickHandler(param1:ButtonEvent) : void
        {
            successS();
        }
    }
}
