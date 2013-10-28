package net.wg.gui.lobby.questsWindow
{
   import net.wg.infrastructure.base.meta.impl.QuestsCurrentTabMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.base.meta.IQuestsCurrentTabMeta;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.CheckBox;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollBar;
   import flash.display.MovieClip;
   import __AS3__.vec.Vector;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.events.ListEvent;
   import flash.events.Event;
   import net.wg.gui.events.QuestEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;


   public class QuestsCurrentTab extends QuestsCurrentTabMeta implements IViewStackContent, IQuestsCurrentTabMeta
   {
          
      public function QuestsCurrentTab() {
         super();
         this._allTasks = new Vector.<String>();
      }

      public var sortingDD:DropdownMenu;

      public var doneCB:CheckBox;

      public var sortTF:TextField;

      public var scrollBar:ScrollBar;

      public var questsList:QuestsList;

      public var notSelected:MovieClip;

      public var questScrollBar:ScrollBar;

      public var noQuestsMC:MovieClip;

      public var listHidingBG:MovieClip;

      public var questBG:MovieClip;

      public var upperShadow:MovieClip;

      public var questInfo:QuestBlock = null;

      public var scrollPane:QuestScrollPane;

      private var currentQuest:String = "";

      private var totalTasks:Number = 0;

      private var _allTasks:Vector.<String> = null;

      public function as_setQuestsData(param1:Array, param2:Number) : void {
         this.questsList.dataProvider = this.setupDataProvider(param1);
         this.totalTasks = param2;
         invalidateData();
      }

      public function as_setSelectedQuest(param1:String) : void {
         this.doneCB.selected = false;
         this.currentQuest = param1;
         invalidateData();
      }

      public function update(param1:Object) : void {
          
      }

      override protected function configUI() : void {
         super.configUI();
         this.questInfo = QuestBlock(this.scrollPane.target);
         this.sortTF.mouseEnabled = false;
         this.sortTF.text = QUESTS.QUESTS_CURRENTTAB_HEADER_SORT;
         this.doneCB.label = QUESTS.QUESTS_CURRENTTAB_HEADER_CHECKBOX_TEXT;
         this.sortingDD.dataProvider = new DataProvider([{"label":QUESTS.QUESTS_CURRENTTAB_HEADER_DROPDOWN_DATE},{"label":QUESTS.QUESTS_CURRENTTAB_HEADER_DROPDOWN_TIME}]);
         this.notSelected.textField.text = QUESTS.QUESTS_TABS_NOSELECTED_TEXT;
         this.questsList.addEventListener(ListEventEx.ITEM_CLICK,this.handleItemClick);
         this.questsList.addEventListener(ListEvent.INDEX_CHANGE,this.handleItemClick);
         this.doneCB.addEventListener(Event.SELECT,this.handleCheckBox);
         this.sortingDD.selectedIndex = 0;
         this.sortingDD.addEventListener(ListEvent.INDEX_CHANGE,this.handleSortingDD);
         this.questInfo.addEventListener(QuestEvent.SELECT_QUEST,this.changeQuest);
         this.listHidingBG.mouseEnabled = false;
         this.listHidingBG.mouseChildren = false;
         this.upperShadow.mouseEnabled = false;
         this.upperShadow.mouseChildren = false;
         this.noQuestsMC.noResult.text = QUESTS.QUESTS_CURRENT_NODATA;
         this.scrollPane.visible = false;
      }

      override protected function onDispose() : void {
         this.questsList.removeEventListener(ListEventEx.ITEM_CLICK,this.handleItemClick);
         this.questsList.removeEventListener(ListEvent.INDEX_CHANGE,this.handleItemClick);
         this.doneCB.removeEventListener(Event.SELECT,this.handleCheckBox);
         this.sortingDD.removeEventListener(ListEvent.INDEX_CHANGE,this.handleSortingDD);
         this.questInfo.removeEventListener(QuestEvent.SELECT_QUEST,this.changeQuest);
         if(this._allTasks)
         {
            this._allTasks.splice(0,this._allTasks.length);
            this._allTasks = null;
         }
         this.questsList.dispose();
         this.doneCB.dispose();
         this.sortingDD.dispose();
         this.questInfo.dispose();
         super.onDispose();
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         super.draw();
         this.sortingDD.x = this.sortTF.x + this.sortTF.textWidth + 3;
         this.doneCB.x = this.sortingDD.x + this.sortingDD.width + 13;
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this.totalTasks > 0;
            this.sortingDD.visible = _loc1_;
            this.doneCB.visible = _loc1_;
            this.sortTF.visible = _loc1_;
            this.scrollBar.visible = _loc1_;
            this.questsList.visible = _loc1_;
            this.questScrollBar.visible = _loc1_;
            this.listHidingBG.visible = _loc1_;
            this.questBG.visible = _loc1_;
            this.upperShadow.visible = _loc1_;
            this.notSelected.visible = _loc1_;
            this.noQuestsMC.visible = !_loc1_;
            if(_loc1_)
            {
               this.checkSelectedQuest();
            }
            else
            {
               this.scrollPane.visible = false;
            }
         }
      }

      private function setupDataProvider(param1:Array) : IDataProvider {
         var _loc3_:Object = null;
         var _loc4_:QuestRendererVO = null;
         var _loc2_:DataProvider = new DataProvider();
         this._allTasks.splice(0,this._allTasks.length);
         for each (_loc3_ in param1)
         {
            _loc4_ = new QuestRendererVO(_loc3_);
            this._allTasks.push(_loc4_.questID);
            _loc2_.push(_loc4_);
         }
         this.questInfo.setAvailableQuests(this._allTasks);
         return _loc2_;
      }

      private function checkSelectedQuest() : void {
         var _loc1_:IDataProvider = this.questsList.dataProvider;
         var _loc2_:Number = _loc1_.length;
         var _loc3_:QuestRendererVO = null;
         var _loc4_:* = false;
         var _loc5_:* = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc5_];
            if(_loc3_.questID == this.currentQuest)
            {
               if(this.questsList.selectedIndex == _loc5_)
               {
                  this.questsList.scrollToIndex(_loc5_);
               }
               else
               {
                  this.questsList.selectedIndex = _loc5_;
               }
               this.questInfo.setData(getQuestInfoS(this.currentQuest));
               _loc4_ = true;
               this.notSelected.visible = false;
               this.scrollPane.visible = true;
               break;
            }
            _loc5_++;
         }
         if(!_loc4_)
         {
            this.setNotSelected();
         }
      }

      private function setNotSelected() : void {
         this.questsList.selectedIndex = -1;
         this.notSelected.visible = true;
         this.scrollPane.visible = false;
         this.currentQuest = "";
         this.questInfo.setData({});
      }

      private function handleItemClick(param1:ListEvent) : void {
         var _loc2_:QuestRendererVO = null;
         var _loc3_:Object = null;
         var _loc4_:QuestRenderer = null;
         if(param1.type == ListEventEx.ITEM_CLICK)
         {
            if(param1.index == this.questsList.selectedIndex)
            {
               this.questsList.selectedIndex = -1;
            }
         }
         else
         {
            if(param1.index >= 0)
            {
               this.notSelected.visible = false;
               this.scrollPane.visible = true;
               _loc2_ = QuestRendererVO(param1.itemData);
               if(_loc2_.isNew)
               {
                  _loc2_.isNew = false;
                  _loc4_ = QuestRenderer(this.questsList.getRendererAt(param1.index,this.questsList.scrollPosition));
                  _loc4_.hideNew();
               }
               this.currentQuest = _loc2_.questID;
               _loc3_ = getQuestInfoS(this.currentQuest);
               if(_loc3_)
               {
                  this.questInfo.setData(_loc3_);
               }
               else
               {
                  this.setNotSelected();
               }
            }
            else
            {
               this.setNotSelected();
            }
         }
      }

      private function handleCheckBox(param1:Event) : void {
         sortS(this.sortingDD.selectedIndex,this.doneCB.selected);
      }

      private function handleSortingDD(param1:ListEvent) : void {
         sortS(param1.index,this.doneCB.selected);
      }

      private function changeQuest(param1:QuestEvent) : void {
         var _loc2_:IDataProvider = this.questsList.dataProvider;
         var _loc3_:int = _loc2_.length;
         var _loc4_:QuestRendererVO = null;
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc5_];
            if(_loc4_.questID == param1.questID)
            {
               if(this.questsList.selectedIndex == _loc5_)
               {
                  this.questsList.scrollToIndex(_loc5_);
               }
               else
               {
                  this.questsList.selectedIndex = _loc5_;
                  this.questInfo.setData(getQuestInfoS(param1.questID));
               }
               break;
            }
            _loc5_++;
         }
      }

      public function get allTasks() : Vector.<String> {
         return this._allTasks;
      }

      public function set allTasks(param1:Vector.<String>) : void {
         this._allTasks = param1;
      }
   }

}