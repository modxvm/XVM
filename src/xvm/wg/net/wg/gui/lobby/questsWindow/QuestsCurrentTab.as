package net.wg.gui.lobby.questsWindow 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.questsWindow.data.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class QuestsCurrentTab extends net.wg.infrastructure.base.meta.impl.QuestsCurrentTabMeta implements net.wg.infrastructure.interfaces.IViewStackContent, net.wg.infrastructure.base.meta.IQuestsCurrentTabMeta
    {
        public function QuestsCurrentTab()
        {
            super();
            return;
        }

        public function as_setQuestsData(arg1:Array, arg2:Number):void
        {
            this.questsList.dataProvider = setupDataProvider(arg1);
            this.totalTasks = arg2;
            invalidateData();
            return;
        }

        public function as_setSelectedQuest(arg1:String):void
        {
            this.currentQuest = arg1;
            invalidateData();
            return;
        }

        public function update(arg1:Object):void
        {
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.questInfo = net.wg.gui.lobby.questsWindow.QuestBlock(this.scrollPane.target);
            this.sortTF.mouseEnabled = false;
            this.sortTF.text = QUESTS.QUESTS_CURRENTTAB_HEADER_SORT;
            this.doneCB.label = QUESTS.QUESTS_CURRENTTAB_HEADER_CHECKBOX_TEXT;
            this.sortingDD.dataProvider = new scaleform.clik.data.DataProvider([{"label":QUESTS.QUESTS_CURRENTTAB_HEADER_DROPDOWN_DATE}, {"label":QUESTS.QUESTS_CURRENTTAB_HEADER_DROPDOWN_TIME}]);
            this.notSelected.textField.text = QUESTS.QUESTS_TABS_NOSELECTED_TEXT;
            this.questsList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.handleItemClick);
            this.questsList.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleItemClick);
            this.doneCB.addEventListener(flash.events.Event.SELECT, this.handleCheckBox);
            this.sortingDD.selectedIndex = 0;
            this.sortingDD.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleSortingDD);
            this.questInfo.addEventListener(net.wg.gui.events.QuestEvent.SELECT_QUEST, this.changeQuest);
            this.listHidingBG.mouseEnabled = false;
            this.listHidingBG.mouseChildren = false;
            this.upperShadow.mouseEnabled = false;
            this.upperShadow.mouseChildren = false;
            this.noQuestsMC.noResult.text = QUESTS.QUESTS_CURRENT_NODATA;
            this.scrollPane.visible = false;
            return;
        }

        protected override function onDispose():void
        {
            this.questsList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.handleItemClick);
            this.questsList.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleItemClick);
            this.doneCB.removeEventListener(flash.events.Event.SELECT, this.handleCheckBox);
            this.sortingDD.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleSortingDD);
            this.questInfo.removeEventListener(net.wg.gui.events.QuestEvent.SELECT_QUEST, this.changeQuest);
            this.questsList.dispose();
            this.doneCB.dispose();
            this.sortingDD.dispose();
            this.questInfo.dispose();
            super.onDispose();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=false;
            super.draw();
            this.sortingDD.x = this.sortTF.x + this.sortTF.textWidth + 3;
            this.doneCB.x = this.sortingDD.x + this.sortingDD.width + 13;
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                loc1 = this.totalTasks > 0;
                this.sortingDD.visible = loc1;
                this.doneCB.visible = loc1;
                this.sortTF.visible = loc1;
                this.scrollBar.visible = loc1;
                this.questsList.visible = loc1;
                this.questScrollBar.visible = loc1;
                this.listHidingBG.visible = loc1;
                this.questBG.visible = loc1;
                this.upperShadow.visible = loc1;
                this.notSelected.visible = loc1;
                this.noQuestsMC.visible = !loc1;
                if (loc1) 
                    this.checkSelectedQuest();
                else 
                    this.scrollPane.visible = false;
            }
            return;
        }

        internal function checkSelectedQuest():void
        {
            var loc1:*=this.questsList.dataProvider;
            var loc2:*=loc1.length;
            var loc3:*=null;
            var loc4:*=false;
            var loc5:*=0;
            while (loc5 < loc2) 
            {
                loc3 = loc1[loc5];
                if (loc3.questID == this.currentQuest) 
                {
                    if (this.questsList.selectedIndex != loc5) 
                    {
                        this.questsList.selectedIndex = loc5;
                        this.questInfo.setData(getQuestInfoS(this.currentQuest));
                    }
                    else 
                        this.questsList.scrollToIndex(loc5);
                    loc4 = true;
                    this.notSelected.visible = false;
                    this.scrollPane.visible = true;
                    break;
                }
                ++loc5;
            }
            if (!loc4) 
                this.setNotSelected();
            return;
        }

        internal function setNotSelected():void
        {
            this.questsList.selectedIndex = -1;
            this.notSelected.visible = true;
            this.scrollPane.visible = false;
            this.currentQuest = "";
            this.questInfo.setData({});
            return;
        }

        internal function handleItemClick(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1.type != net.wg.gui.events.ListEventEx.ITEM_CLICK) 
                if (arg1.index >= 0) 
                {
                    this.notSelected.visible = false;
                    this.scrollPane.visible = true;
                    loc1 = net.wg.gui.lobby.questsWindow.data.QuestRendererVO(arg1.itemData);
                    if (loc1.isNew) 
                    {
                        loc1.isNew = false;
                        (loc3 = net.wg.gui.lobby.questsWindow.QuestRenderer(this.questsList.getRendererAt(arg1.index, this.questsList.scrollPosition))).hideNew();
                    }
                    this.currentQuest = loc1.questID;
                    loc2 = getQuestInfoS(this.currentQuest);
                    if (loc2) 
                        this.questInfo.setData(loc2);
                    else 
                        this.setNotSelected();
                }
                else 
                    this.setNotSelected();
            else if (arg1.index == this.questsList.selectedIndex) 
                this.questsList.selectedIndex = -1;
            return;
        }

        internal function handleCheckBox(arg1:flash.events.Event):void
        {
            sortS(this.sortingDD.selectedIndex, this.doneCB.selected);
            return;
        }

        internal function handleSortingDD(arg1:scaleform.clik.events.ListEvent):void
        {
            sortS(arg1.index, this.doneCB.selected);
            return;
        }

        internal function changeQuest(arg1:net.wg.gui.events.QuestEvent):void
        {
            var loc1:*=this.questsList.dataProvider;
            var loc2:*=loc1.length;
            var loc3:*=null;
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                if ((loc3 = loc1[loc4]).questID == arg1.questID) 
                {
                    if (this.questsList.selectedIndex != loc4) 
                    {
                        this.questsList.selectedIndex = loc4;
                        this.questInfo.setData(getQuestInfoS(arg1.questID));
                    }
                    else 
                        this.questsList.scrollToIndex(loc4);
                    break;
                }
                ++loc4;
            }
            return;
        }

        internal static function setupDataProvider(arg1:Array):scaleform.clik.interfaces.IDataProvider
        {
            var loc2:*=null;
            var loc1:*=new scaleform.clik.data.DataProvider();
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
                loc1.push(new net.wg.gui.lobby.questsWindow.data.QuestRendererVO(loc2));
            return loc1;
        }

        public var sortingDD:net.wg.gui.components.controls.DropdownMenu;

        public var doneCB:net.wg.gui.components.controls.CheckBox;

        public var sortTF:flash.text.TextField;

        public var scrollBar:net.wg.gui.components.controls.ScrollBar;

        public var questsList:net.wg.gui.lobby.questsWindow.QuestsList;

        public var notSelected:flash.display.MovieClip;

        public var questScrollBar:net.wg.gui.components.controls.ScrollBar;

        public var noQuestsMC:flash.display.MovieClip;

        public var listHidingBG:flash.display.MovieClip;

        public var questBG:flash.display.MovieClip;

        public var upperShadow:flash.display.MovieClip;

        public var questInfo:net.wg.gui.lobby.questsWindow.QuestBlock=null;

        public var scrollPane:net.wg.gui.lobby.questsWindow.QuestScrollPane;

        internal var currentQuest:String="";

        internal var totalTasks:Number=0;
    }
}
