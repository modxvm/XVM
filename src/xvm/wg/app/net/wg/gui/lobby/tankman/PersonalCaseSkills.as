package net.wg.gui.lobby.tankman
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.data.DataProvider;
    import flash.events.Event;
    import net.wg.gui.events.PersonalCaseEvent;
    import flash.display.InteractiveObject;
    
    public class PersonalCaseSkills extends UIComponent implements IViewStackContent
    {
        
        public function PersonalCaseSkills()
        {
            super();
        }
        
        private var UPDATE_DATA_PROVIDER:String = "updateDataProvider";
        
        public var windowDescr:TextField;
        
        public var modifiers:ScrollingListEx;
        
        public var scrollBar:ScrollBar;
        
        public var selectBtn:SoundButtonEx;
        
        public var emptySkillsBG:MovieClip;
        
        public var emptySkillsMessage:TextField;
        
        private var model:Array;
        
        private var hasNewSkill:Boolean = false;
        
        private var selectedSkillName:String = null;
        
        private var lastSelectedIndex:int = -1;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            if(this.modifiers)
            {
                this.modifiers.removeEventListener(ListEvent.INDEX_CHANGE,this.modifiers_listIndexChangeHandler);
                this.modifiers.removeEventListener(ListEvent.ITEM_PRESS,this.modifiers_itemPressHandler);
                this.modifiers.removeEventListener(PersonalCaseSkillsItemRenderer.SKILL_DOUBLE_CLICK,this.modifiers_eventHandler);
                this.modifiers.disposeRenderers();
                this.modifiers = null;
            }
            if(this.selectBtn.visible)
            {
                this.selectBtn.removeEventListener(ButtonEvent.CLICK,this.selectBtn_buttonClickHandler);
            }
            this.model = null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.modifiers.addEventListener(ListEvent.INDEX_CHANGE,this.modifiers_listIndexChangeHandler);
            this.modifiers.addEventListener(ListEvent.ITEM_PRESS,this.modifiers_itemPressHandler);
            this.modifiers.addEventListener(PersonalCaseSkillsItemRenderer.SKILL_DOUBLE_CLICK,this.modifiers_eventHandler);
            this.emptySkillsMessage.text = MENU.TANKMSNPERSONALCASE_LACKOFSKILLSFORLEARN;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(this.UPDATE_DATA_PROVIDER)) && (this.model))
            {
                if(this.model.length > 0)
                {
                    this.emptySkillsBG.visible = this.emptySkillsMessage.visible = false;
                    this.modifiers.dataProvider = new DataProvider(this.model);
                    if(this.model.length > 0)
                    {
                        this.autoSelectIndex();
                    }
                    this.modifiers.validateNow();
                    this.selectBtn.visible = this.checkForNewSkills();
                    if(this.selectBtn.visible)
                    {
                        this.selectBtn.addEventListener(ButtonEvent.CLICK,this.selectBtn_buttonClickHandler);
                    }
                    this.updateSelectBtn();
                }
                else
                {
                    this.emptySkillsBG.visible = this.emptySkillsMessage.visible = true;
                }
            }
        }
        
        private function autoSelectIndex() : void
        {
            if(this.lastSelectedIndex == -1)
            {
                this.lastSelectedIndex = 1;
            }
            var _loc1_:int = Math.min(this.lastSelectedIndex,this.model.length - 1);
            if(this.model[_loc1_].isHeader)
            {
                _loc1_--;
            }
            this.updateIndexies(_loc1_);
        }
        
        private function updateIndexies(param1:int) : void
        {
            this.modifiers.selectedIndex = param1;
            this.modifiers.invalidateSelectedIndex();
            this.selectedSkillName = this.model[param1].title;
            this.updateSelectBtn();
        }
        
        private function updateSelectBtn() : void
        {
            this.selectBtn.enabled = !(this.selectedSkillName == null);
        }
        
        private function checkForNewSkills() : Boolean
        {
            if(!this.model)
            {
                return false;
            }
            var _loc1_:* = 0;
            while(_loc1_ < this.model.length)
            {
                if(this.model[_loc1_].hasNewSkills)
                {
                    this.hasNewSkill = true;
                    return true;
                }
                _loc1_++;
            }
            return false;
        }
        
        public function update(param1:Object) : void
        {
            this.model = param1 as Array;
            this.hasNewSkill = false;
            invalidate(this.UPDATE_DATA_PROVIDER);
        }
        
        private function modifiers_itemPressHandler(param1:ListEvent) : void
        {
            if(!param1.itemData)
            {
                return;
            }
            this.selectedSkillName = param1.itemData.title;
            this.lastSelectedIndex = param1.index;
            this.updateSelectBtn();
        }
        
        private function modifiers_listIndexChangeHandler(param1:ListEvent) : void
        {
            if(!param1.itemData)
            {
                return;
            }
            this.selectedSkillName = param1.itemData.title;
            this.lastSelectedIndex = param1.index;
            this.updateSelectBtn();
        }
        
        private function modifiers_eventHandler(param1:Event) : void
        {
            this.learnSkillDispatchEvent();
        }
        
        private function selectBtn_buttonClickHandler(param1:ButtonEvent) : void
        {
            this.learnSkillDispatchEvent();
        }
        
        private function learnSkillDispatchEvent() : void
        {
            if(!this.hasNewSkill)
            {
                return;
            }
            if(this.selectedSkillName == null)
            {
                return;
            }
            var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.TRAINING_SKILL,true);
            _loc1_.trainingSkillName = this.selectedSkillName;
            dispatchEvent(_loc1_);
            this.selectedSkillName = null;
            this.updateSelectBtn();
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
    }
}
