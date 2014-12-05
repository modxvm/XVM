package net.wg.gui.lobby.battleResults
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.interfaces.ISubtaskComponent;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.data.VO.BattleResultsQuestVO;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
    import net.wg.utils.IClassFactory;
    import net.wg.gui.lobby.questsWindow.data.PersonalInfoVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.constants.LayoutMode;
    import net.wg.data.constants.SoundTypes;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import flash.display.DisplayObjectContainer;
    import net.wg.gui.events.QuestEvent;
    import flash.text.TextFieldAutoSize;
    
    public class BattleResultsPersonalQuest extends UIComponent implements ISubtaskComponent
    {
        
        public function BattleResultsPersonalQuest()
        {
            super();
            this.questTitleTF.autoSize = TextFieldAutoSize.LEFT;
            this.factory = App.utils.classFactory;
        }
        
        private static var LINE_SEPARATOR_PADDING:int = 15;
        
        private static var LINK_BTN:String = "LinkBtn_UI";
        
        private static var STATUS:String = "StatusComponent_UI";
        
        private static var TEXT_PADDING:int = 5;
        
        private static var TEXT_HEIGHT:int = 6;
        
        public var questTitleTF:TextField = null;
        
        public var mainConditionTF:TextField = null;
        
        public var additionalConditionTF:TextField = null;
        
        public var lineMC:MovieClip = null;
        
        private var model:BattleResultsQuestVO = null;
        
        private var linkBtn:SoundButtonEx;
        
        private var additionalStatus:QuestStatusComponent = null;
        
        private var mainStatus:QuestStatusComponent = null;
        
        private var factory:IClassFactory = null;
        
        public function setData(param1:Object) : void
        {
            this.model = new BattleResultsQuestVO(param1);
            invalidateData();
        }
        
        public function disableLinkBtns(param1:Vector.<String>) : void
        {
            this.linkBtn.enabled = !(param1.indexOf(this.model.questInfo.questID) == -1);
            this.linkBtn.mouseEnabled = true;
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:PersonalInfoVO = null;
            var _loc3_:* = false;
            var _loc4_:PersonalInfoVO = null;
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.model))
            {
                this.questTitleTF.htmlText = this.model.title;
                this.linkBtn = SoundButtonEx(this.makeComponent(LINK_BTN));
                this.linkBtn.helpConnectorLength = 12;
                this.linkBtn.autoSize = LayoutMode.ALIGN_NONE;
                this.linkBtn.helpDirection = "T";
                this.linkBtn.paddingHorizontal = 5;
                this.linkBtn.soundType = SoundTypes.NORMAL_BTN;
                this.linkBtn.scaleX = this.linkBtn.scaleY = 1;
                this.addChild(this.linkBtn);
                this.linkBtn.x = this.questTitleTF.x + this.questTitleTF.width + TEXT_PADDING ^ 0;
                this.linkBtn.y = this.questTitleTF.y + (this.questTitleTF.height - this.linkBtn.height >> 1) + 3 ^ 0;
                this.addListeners();
                if(this.model.personalInfo)
                {
                    _loc1_ = this.model.personalInfo.length;
                    _loc2_ = PersonalInfoVO(this.model.personalInfo[0]);
                    this.mainConditionTF.htmlText = _loc2_.text;
                    this.mainConditionTF.y = this.questTitleTF.y + this.questTitleTF.height + 9 ^ 0;
                    this.mainConditionTF.height = this.mainConditionTF.textHeight + TEXT_HEIGHT;
                    this.mainStatus = QuestStatusComponent(this.makeComponent(STATUS));
                    this.addChild(this.mainStatus);
                    this.mainStatus.x = this.mainConditionTF.x + this.mainConditionTF.width + TEXT_PADDING;
                    this.mainStatus.y = this.mainConditionTF.y + 4 ^ 0;
                    this.mainStatus.setStatus(_loc2_.statusStr);
                    _loc3_ = _loc1_ == 2;
                    if(_loc3_)
                    {
                        _loc4_ = PersonalInfoVO(this.model.personalInfo[1]);
                        this.additionalConditionTF.visible = true;
                        this.additionalConditionTF.htmlText = _loc4_.text;
                        this.additionalConditionTF.y = this.mainConditionTF.y + this.mainConditionTF.height + 8 ^ 0;
                        this.additionalConditionTF.height = this.additionalConditionTF.textHeight + TEXT_HEIGHT;
                        this.additionalStatus = QuestStatusComponent(this.makeComponent(STATUS));
                        this.addChild(this.additionalStatus);
                        this.additionalStatus.x = this.additionalConditionTF.x + this.additionalConditionTF.width + TEXT_PADDING ^ 0;
                        this.additionalStatus.y = this.additionalConditionTF.y + 2 ^ 0;
                        this.additionalStatus.setStatus(_loc4_.statusStr);
                        this.lineMC.y = this.additionalConditionTF.y + this.additionalConditionTF.height + LINE_SEPARATOR_PADDING;
                    }
                    else
                    {
                        this.lineMC.y = this.mainConditionTF.y + this.mainConditionTF.height + LINE_SEPARATOR_PADDING;
                        this.additionalConditionTF.y = 0;
                        this.additionalConditionTF.visible = false;
                        this.additionalConditionTF.htmlText = null;
                    }
                }
                setSize(this.width,this.lineMC.y);
                dispatchEvent(new Event(Event.RESIZE,true));
            }
        }
        
        override protected function onDispose() : void
        {
            if(this.linkBtn)
            {
                this.removeListeners();
                this.linkBtn.dispose();
                this.removeChild(this.linkBtn);
                this.linkBtn = null;
            }
            if(this.additionalStatus)
            {
                this.additionalStatus.dispose();
                this.removeChild(this.additionalStatus);
                this.additionalStatus = null;
            }
            if(this.mainStatus)
            {
                this.mainStatus.dispose();
                this.removeChild(this.mainStatus);
                this.mainStatus = null;
            }
            this.factory = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            this.questTitleTF = null;
            this.mainConditionTF = null;
            this.additionalConditionTF = null;
            if(this.lineMC)
            {
                this.removeChild(this.lineMC);
                this.lineMC = null;
            }
            super.onDispose();
        }
        
        private function addListeners() : void
        {
            this.linkBtn.addEventListener(ButtonEvent.CLICK,this.linkBtnHandler);
            this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
            this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,this.showLinkBtnTooltip);
        }
        
        private function removeListeners() : void
        {
            this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.linkBtnHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.showLinkBtnTooltip);
        }
        
        private function makeComponent(param1:String) : DisplayObjectContainer
        {
            var _loc2_:DisplayObjectContainer = this.factory.getComponent(param1,DisplayObjectContainer);
            return _loc2_;
        }
        
        private function showLinkBtnTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(this.linkBtn.enabled?TOOLTIPS.QUESTS_LINKBTN_TASK:TOOLTIPS.QUESTS_DISABLELINKBTN_TASK);
        }
        
        private function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function linkBtnHandler(param1:ButtonEvent) : void
        {
            App.toolTipMgr.hide();
            var _loc2_:QuestEvent = new QuestEvent(QuestEvent.SELECT_QUEST,this.model.questInfo.questID);
            _loc2_.eventType = this.model.questInfo.eventType;
            dispatchEvent(_loc2_);
        }
    }
}
