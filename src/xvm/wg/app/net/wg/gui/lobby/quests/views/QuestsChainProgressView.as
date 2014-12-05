package net.wg.gui.lobby.quests.views
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.infrastructure.interfaces.IFocusChainContainer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.common.containers.GroupEx;
    import net.wg.gui.lobby.quests.data.ChainProgressVO;
    import flash.display.InteractiveObject;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.events.FocusChainChangeEvent;
    import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.quests.events.ChainProgressEvent;
    import net.wg.data.constants.Values;
    import flash.text.TextFieldAutoSize;
    
    public class QuestsChainProgressView extends UIComponent implements IViewStackContent, IFocusChainContainer
    {
        
        public function QuestsChainProgressView()
        {
            super();
            this.progressTF.autoSize = TextFieldAutoSize.RIGHT;
        }
        
        private static var BLOCKS_VERTICAL_SPACING:int = 45;
        
        private static var BUTTONS_HORIZONTAL_SPACING:int = 14;
        
        private static var CHAINS_PROGRESS_GROUP_V_OFFSET:int = 25;
        
        private static var CHAINS_PROGRESS_GROUP_WIDTH:int = 401;
        
        private static var CHAINS_PROGRESS_DASH_LINE_TEXT_LINKAGE:String = "ChainProgressDashLineTextItemUI";
        
        public var headerTF:TextField = null;
        
        public var mainAwardTF:TextField = null;
        
        public var progressTF:TextField = null;
        
        public var awardNameTF:TextField = null;
        
        public var chainsProgressTF:TextField = null;
        
        public var awardIcon:UILoaderAlt = null;
        
        public var blackBtn:SoundButtonEx = null;
        
        public var normalBtn:SoundButtonEx = null;
        
        public var chainsProgressGroup:GroupEx = null;
        
        private var model:ChainProgressVO = null;
        
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
            if(this.model != param1)
            {
                this.model = ChainProgressVO(param1);
                invalidateData();
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.model)
                {
                    this.headerTF.htmlText = this.model.headerText;
                    this.mainAwardTF.htmlText = this.model.mainAwardText;
                    this.chainsProgressTF.htmlText = this.model.chainsProgressText;
                    this.awardIcon.source = this.model.awardIconSource;
                    this.progressTF.visible = !this.model.isAlreadyCompleted;
                    this.awardNameTF.visible = !this.model.isAlreadyCompleted;
                    this.blackBtn.visible = this.model.isAlreadyCompleted;
                    this.chainsProgressGroup.dataProvider = new DataProvider(this.model.progressItems);
                    this.chainsProgressGroup.width = CHAINS_PROGRESS_GROUP_WIDTH;
                    if(this.model.isAlreadyCompleted)
                    {
                        this.blackBtn.label = this.model.aboutTankBtnLabel;
                        this.normalBtn.label = this.model.showInHangarBtnLabel;
                        this.blackBtn.x = width - this.blackBtn.width - this.normalBtn.width - BUTTONS_HORIZONTAL_SPACING >> 1;
                        this.normalBtn.x = this.blackBtn.x + this.blackBtn.width + BUTTONS_HORIZONTAL_SPACING;
                        this.normalBtn.y = this.blackBtn.y;
                    }
                    else
                    {
                        this.awardNameTF.htmlText = this.model.awardNameText;
                        this.progressTF.htmlText = this.model.progressText;
                        this.normalBtn.label = this.model.aboutTankBtnLabel;
                        this.normalBtn.x = width - this.normalBtn.width >> 1;
                        this.normalBtn.y = this.blackBtn.y + BLOCKS_VERTICAL_SPACING;
                    }
                    this.chainsProgressTF.y = this.normalBtn.y + BLOCKS_VERTICAL_SPACING;
                    this.chainsProgressGroup.y = this.chainsProgressTF.y + CHAINS_PROGRESS_GROUP_V_OFFSET;
                }
                dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.awardIcon.autoSize = false;
            this.chainsProgressGroup.itemRendererClass = App.utils.classFactory.getClass(CHAINS_PROGRESS_DASH_LINE_TEXT_LINKAGE);
            this.chainsProgressGroup.layout = new Vertical100PercWidthLayout();
            this.chainsProgressGroup.width = CHAINS_PROGRESS_GROUP_WIDTH;
            this.awardIcon.addEventListener(UILoaderEvent.COMPLETE,this.awardIconLoadedHandler);
            this.normalBtn.addEventListener(ButtonEvent.CLICK,this.onNormalBtnClickHandler);
            this.blackBtn.addEventListener(ButtonEvent.CLICK,this.onBlackBtnClickHandler);
            this.normalBtn.addEventListener(MouseEvent.ROLL_OVER,this.onNormalBtnRollOverHandler);
            this.normalBtn.addEventListener(MouseEvent.ROLL_OUT,this.onElementRollOutHandler);
            this.blackBtn.addEventListener(MouseEvent.ROLL_OVER,this.onBlackBtnRollOverHandler);
            this.blackBtn.addEventListener(MouseEvent.ROLL_OUT,this.onElementRollOutHandler);
            this.progressTF.addEventListener(MouseEvent.ROLL_OVER,this.onProgressTFRollOverHandler);
            this.progressTF.addEventListener(MouseEvent.ROLL_OUT,this.onElementRollOutHandler);
        }
        
        override protected function onDispose() : void
        {
            this.awardIcon.removeEventListener(UILoaderEvent.COMPLETE,this.awardIconLoadedHandler);
            this.normalBtn.removeEventListener(ButtonEvent.CLICK,this.onNormalBtnClickHandler);
            this.blackBtn.removeEventListener(ButtonEvent.CLICK,this.onBlackBtnClickHandler);
            this.normalBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onNormalBtnRollOverHandler);
            this.normalBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onElementRollOutHandler);
            this.blackBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onBlackBtnRollOverHandler);
            this.blackBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onElementRollOutHandler);
            this.progressTF.removeEventListener(MouseEvent.ROLL_OVER,this.onProgressTFRollOverHandler);
            this.progressTF.removeEventListener(MouseEvent.ROLL_OUT,this.onElementRollOutHandler);
            this.headerTF = null;
            this.mainAwardTF = null;
            this.progressTF = null;
            this.awardNameTF = null;
            this.chainsProgressTF = null;
            this.awardIcon.dispose();
            this.awardIcon = null;
            this.blackBtn.dispose();
            this.blackBtn = null;
            this.normalBtn.dispose();
            this.normalBtn = null;
            this.chainsProgressGroup.dispose();
            this.chainsProgressGroup = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            super.onDispose();
        }
        
        private function awardIconLoadedHandler(param1:UILoaderEvent) : void
        {
            this.awardIcon.x = width - this.awardIcon.width >> 1;
        }
        
        private function onNormalBtnClickHandler(param1:ButtonEvent) : void
        {
            if(this.model.isAlreadyCompleted)
            {
                dispatchEvent(new ChainProgressEvent(ChainProgressEvent.SHOW_VEHICLE_IN_HANGAR,this.model.awardVehicleID));
            }
            else
            {
                dispatchEvent(new ChainProgressEvent(ChainProgressEvent.SHOW_VEHICLE_INFO,this.model.awardVehicleID));
            }
        }
        
        private function onBlackBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new ChainProgressEvent(ChainProgressEvent.SHOW_VEHICLE_INFO,this.model.awardVehicleID));
        }
        
        private function onProgressTFRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(this.model.progressTFToolTip);
        }
        
        private function onElementRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onNormalBtnRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = Values.EMPTY_STR;
            if(!this.model.isAlreadyCompleted)
            {
                _loc2_ = this.model.aboutVehicleToolTip;
            }
            else
            {
                _loc2_ = this.model.showVehicleToolTip;
            }
            App.toolTipMgr.showComplex(_loc2_);
        }
        
        private function onBlackBtnRollOverHandler(param1:MouseEvent) : void
        {
            if(this.model.isAlreadyCompleted)
            {
                App.toolTipMgr.showComplex(this.model.aboutVehicleToolTip);
            }
        }
        
        public function getFocusChain() : Array
        {
            var _loc1_:Array = [];
            if(this.blackBtn.visible)
            {
                _loc1_.push(this.blackBtn);
            }
            if(this.normalBtn.visible)
            {
                _loc1_.push(this.normalBtn);
            }
            return _loc1_;
        }
    }
}
