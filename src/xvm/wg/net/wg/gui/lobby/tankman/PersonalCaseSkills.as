package net.wg.gui.lobby.tankman 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class PersonalCaseSkills extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function PersonalCaseSkills()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.modifiers) 
            {
                this.modifiers.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.modifiers_listIndexChangeHandler);
                this.modifiers.removeEventListener(scaleform.clik.events.ListEvent.ITEM_PRESS, this.modifiers_itemPressHandler);
                this.modifiers.removeEventListener(net.wg.gui.lobby.tankman.PersonalCaseSkillsItemRenderer.SKILL_DOUBLE_CLICK, this.modifiers_eventHandler);
                this.modifiers.disposeRenderers();
                this.modifiers = null;
            }
            if (this.selectBtn.visible) 
                this.selectBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.selectBtn_buttonClickHandler);
            this.model = null;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.modifiers.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.modifiers_listIndexChangeHandler);
            this.modifiers.addEventListener(scaleform.clik.events.ListEvent.ITEM_PRESS, this.modifiers_itemPressHandler);
            this.modifiers.addEventListener(net.wg.gui.lobby.tankman.PersonalCaseSkillsItemRenderer.SKILL_DOUBLE_CLICK, this.modifiers_eventHandler);
            this.emptySkillsMessage.text = MENU.TANKMSNPERSONALCASE_LACKOFSKILLSFORLEARN;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(this.UPDATE_DATA_PROVIDER) && this.model) 
                if (this.model.length > 0) 
                {
                    var loc1:*;
                    this.emptySkillsMessage.visible = loc1 = false;
                    this.emptySkillsBG.visible = loc1;
                    this.modifiers.dataProvider = new scaleform.clik.data.DataProvider(this.model);
                    if (this.model.length > 0) 
                        this.autoSelectIndex();
                    this.modifiers.validateNow();
                    this.selectBtn.visible = this.checkForNewSkills();
                    if (this.selectBtn.visible) 
                        this.selectBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.selectBtn_buttonClickHandler);
                    this.updateSelectBtn();
                }
                else 
                {
                    this.emptySkillsMessage.visible = loc1 = true;
                    this.emptySkillsBG.visible = loc1;
                }
            return;
        }

        internal function autoSelectIndex():void
        {
            if (this.lastSelectedIndex == -1) 
                this.lastSelectedIndex = 1;
            var loc1:*=Math.min(this.lastSelectedIndex, (this.model.length - 1));
            if (this.model[loc1].isHeader) 
                --loc1;
            this.updateIndexies(loc1);
            return;
        }

        internal function updateIndexies(arg1:int):void
        {
            this.modifiers.selectedIndex = arg1;
            this.modifiers.invalidateSelectedIndex();
            this.selectedSkillName = this.model[arg1].title;
            this.updateSelectBtn();
            return;
        }

        internal function updateSelectBtn():void
        {
            this.selectBtn.enabled = !(this.selectedSkillName == null);
            return;
        }

        internal function checkForNewSkills():Boolean
        {
            if (!this.model) 
                return false;
            var loc1:*=0;
            while (loc1 < this.model.length) 
            {
                if (this.model[loc1].hasNewSkills) 
                {
                    this.hasNewSkill = true;
                    return true;
                }
                ++loc1;
            }
            return false;
        }

        public function update(arg1:Object):void
        {
            this.model = arg1 as Array;
            this.hasNewSkill = false;
            invalidate(this.UPDATE_DATA_PROVIDER);
            return;
        }

        internal function modifiers_itemPressHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (!arg1.itemData) 
                return;
            this.selectedSkillName = arg1.itemData.title;
            this.lastSelectedIndex = arg1.index;
            this.updateSelectBtn();
            return;
        }

        internal function modifiers_listIndexChangeHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (!arg1.itemData) 
                return;
            this.selectedSkillName = arg1.itemData.title;
            this.lastSelectedIndex = arg1.index;
            this.updateSelectBtn();
            return;
        }

        internal function modifiers_eventHandler(arg1:flash.events.Event):void
        {
            this.learnSkillDispatchEvent();
            return;
        }

        internal function selectBtn_buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.learnSkillDispatchEvent();
            return;
        }

        internal function learnSkillDispatchEvent():void
        {
            if (!this.hasNewSkill) 
                return;
            if (this.selectedSkillName == null) 
                return;
            var loc1:*=new net.wg.gui.events.PersonalCaseEvent(net.wg.gui.events.PersonalCaseEvent.TRAINING_SKILL, true);
            loc1.trainingSkillName = this.selectedSkillName;
            dispatchEvent(loc1);
            this.selectedSkillName = null;
            this.updateSelectBtn();
            return;
        }

        internal const UPDATE_DATA_PROVIDER:String="updateDataProvider";

        public var windowDescr:flash.text.TextField;

        public var modifiers:net.wg.gui.components.controls.ScrollingListEx;

        public var scrollBar:net.wg.gui.components.controls.ScrollBar;

        public var selectBtn:net.wg.gui.components.controls.SoundButtonEx;

        public var emptySkillsBG:flash.display.MovieClip;

        public var emptySkillsMessage:flash.text.TextField;

        internal var model:Array;

        internal var hasNewSkill:Boolean=false;

        internal var selectedSkillName:String=null;

        internal var lastSelectedIndex:int=-1;
    }
}
