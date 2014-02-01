package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.questsWindow.components.SortingPanel;
   import net.wg.gui.lobby.questsWindow.components.AlertMessage;
   import net.wg.gui.components.controls.ScrollBar;
   import flash.display.MovieClip;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.gui.lobby.questsWindow.data.QuestDataVO;
   import __AS3__.vec.Vector;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.events.IndexEvent;
   import flash.events.Event;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.events.QuestEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import fl.transitions.easing.Strong;
   import scaleform.clik.interfaces.IDataProvider;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
   import scaleform.clik.data.DataProvider;
   import net.wg.infrastructure.base.meta.IQuestsCurrentTabMeta;


   public class QuestContent extends UIComponent
   {
          
      public function QuestContent() {
         this.tweens = new Vector.<Tween>();
         super();
         this._allTasks = new Vector.<String>();
      }

      private static const INVALIDATE_QUEST_INFO:String = "invQuestInfo";

      private static const INVALIDATE_QUEST_ID:String = "invQuestID";

      private static const INVALIDATE_SORTING_FUNC:String = "invSortFunc";

      private static const INVALIDATE_NODATA_LABEL:String = "invNodataLabel";

      private static const AVAILABLE_HEIGHT:int = 583;

      private static const WAITING_SIZE:int = 400;

      private static const AWARDS_PADDING:int = 1;

      private static const WAITING_TOP_PADDING:int = 10;

      public var sortingPanel:SortingPanel;

      public var alertMsg:AlertMessage;

      public var scrollBar:ScrollBar;

      public var questsList:QuestsList;

      public var notSelected:MovieClip;

      public var noQuestsMC:MovieClip;

      public var listHidingBG:MovieClip;

      public var questBG:MovieClip;

      public var questInfo:QuestBlock = null;

      public var scrollPane:QuestScrollPane;

      private var currentQuest:String = "";

      private var questForUpdate:String = "";

      private var lastUpdatedQuest:String = "";

      private var totalTasks:Number = 0;

      private var _waiting:Waiting = null;

      private var questData:QuestDataVO = null;

      public var header:HeaderBlock;

      public var awards:QuestAwardsBlock;

      private var _allTasks:Vector.<String> = null;

      private var _sortingFunction:Function = null;

      private var _hideDoneCB:Boolean = false;

      private var _noDataLael:String = "";

      private var _showWaiting:Boolean = false;

      private var awardsResized:Boolean = false;

      private var questInfoResized:Boolean = false;

      private var headerResized:Boolean = false;

      private var _isInRoaming:Boolean = false;

      private var questInFade:Boolean = false;

      private var tweens:Vector.<Tween>;

      public function setQuestsData(param1:Array, param2:Number) : void {
         this.questsList.dataProvider = this.setupDataProvider(param1);
         this.totalTasks = param2;
         invalidateData();
      }

      public function setSelectedQuest(param1:String) : void {
         this.sortingPanel.doneCB.selected = false;
         this.currentQuest = param1;
         invalidateData();
      }

      override protected function configUI() : void {
         super.configUI();
         this.questInfo = QuestBlock(this.scrollPane.target);
         this.notSelected.textField.text = QUESTS.QUESTS_TABS_NOSELECTED_TEXT;
         this.addListeners();
         this.listHidingBG.mouseEnabled = false;
         this.listHidingBG.mouseChildren = false;
         this.scrollPane.visible = false;
         this.awards.visible = false;
         this.header.visible = false;
         this.alertMsg.visible = false;
         this._isInRoaming = App.globalVarsMgr.isInRoamingS();
      }

      private function addListeners() : void {
         this.header.contentTabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
         this.header.addEventListener(Event.RESIZE,this.layoutBlocks);
         this.awards.addEventListener(Event.RESIZE,this.layoutBlocks);
         this.questInfo.addEventListener(Event.RESIZE,this.layoutBlocks);
         this.questsList.addEventListener(ListEventEx.ITEM_CLICK,this.handleItemClick);
         this.questsList.addEventListener(ListEvent.INDEX_CHANGE,this.handleItemClick);
         this.sortingPanel.doneCB.addEventListener(Event.SELECT,this.handleCheckBox);
         this.sortingPanel.sortingDD.addEventListener(ListEvent.INDEX_CHANGE,this.handleSortingDD);
         this.questInfo.addEventListener(QuestEvent.SELECT_QUEST,this.changeQuest);
         this.awards.addEventListener(QuestEvent.SELECT_QUEST,this.changeQuest);
      }

      private function removeListeners() : void {
         this.header.contentTabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onChangeViewHandler);
         this.awards.removeEventListener(QuestEvent.SELECT_QUEST,this.changeQuest);
         this.awards.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.header.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.questInfo.removeEventListener(Event.RESIZE,this.layoutBlocks);
         this.questsList.removeEventListener(ListEventEx.ITEM_CLICK,this.handleItemClick);
         this.questsList.removeEventListener(ListEvent.INDEX_CHANGE,this.handleItemClick);
         this.sortingPanel.doneCB.removeEventListener(Event.SELECT,this.handleCheckBox);
         this.sortingPanel.sortingDD.removeEventListener(ListEvent.INDEX_CHANGE,this.handleSortingDD);
         this.questInfo.removeEventListener(QuestEvent.SELECT_QUEST,this.changeQuest);
      }

      override protected function onDispose() : void {
         var _loc1_:Tween = null;
         this.removeListeners();
         if(this._allTasks)
         {
            this._allTasks.splice(0,this._allTasks.length);
            this._allTasks = null;
         }
         if(this.questData)
         {
            this.questData.dispose();
            this.questData = null;
         }
         if(this._waiting)
         {
            this._waiting.dispose();
            removeChild(this._waiting);
            this._waiting = null;
         }
         for each (_loc1_ in this.tweens)
         {
            _loc1_.onComplete = null;
            _loc1_.onChange = null;
            _loc1_.paused = true;
            _loc1_ = null;
         }
         this.tweens = null;
         this.header.dispose();
         this.header = null;
         this.awards.dispose();
         this.awards = null;
         this.sortingPanel.dispose();
         this.sortingPanel = null;
         this.alertMsg.dispose();
         this.alertMsg = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.questsList.dispose();
         this.questsList = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.questInfo = null;
         this.notSelected = null;
         this.noQuestsMC = null;
         this.listHidingBG = null;
         this.questBG = null;
         this._sortingFunction = null;
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.invalidateCommonData();
         }
         if((isInvalid(INVALIDATE_SORTING_FUNC)) && !(this._sortingFunction == null))
         {
            this.questInfo.conditionsView.blocksContainer.sortingFunction = this._sortingFunction;
            this.questInfo.requirementsView.blocksContainer.sortingFunction = this._sortingFunction;
         }
         if(isInvalid(INVALIDATE_NODATA_LABEL))
         {
            this.noQuestsMC.noResult.text = this._noDataLael;
         }
         if(isInvalid(WindowViewInvalidationType.WAITING_INVALID))
         {
            this.invalidateWaiting();
         }
         if(isInvalid(INVALIDATE_QUEST_ID))
         {
            if(this.questInFade)
            {
               if(this.lastUpdatedQuest == this.questForUpdate)
               {
                  this.getQuestData();
               }
               else
               {
                  this.lastUpdatedQuest = this.questForUpdate;
                  App.utils.scheduler.envokeInNextFrame(invalidate,INVALIDATE_QUEST_ID);
               }
            }
         }
         if(isInvalid(INVALIDATE_QUEST_INFO))
         {
            if(this.questData)
            {
               this.scrollPane.scrollPosition = 0;
               this.questInfo.setData(this.questData);
               this.header.setData(this.questData.header);
               this.awards.setAwards(this.questData.award.awardsStr);
               this.awards.setOpenedQuests(this.questData.award.openedQuests);
            }
         }
      }

      private function invalidateWaiting() : void {
         if(!this._waiting)
         {
            this._waiting = new Waiting();
            addChild(this._waiting);
            this._waiting.x = Math.round(this.notSelected.x + (this.notSelected.width - WAITING_SIZE) / 2);
            this._waiting.y = Math.round((AVAILABLE_HEIGHT - WAITING_SIZE) / 2) - WAITING_TOP_PADDING;
            this._waiting.setSize(WAITING_SIZE,WAITING_SIZE);
            this._waiting.setMessage("");
            this._waiting.show();
            this._waiting.hide();
            this._waiting.validateNow();
            this._waiting.backgroundAlpha = 0;
         }
         if(this._waiting)
         {
            if(this._showWaiting)
            {
               this._waiting.show();
               this.playFadeAnimation(0,150,this.tweenFadeOutCallback);
            }
            else
            {
               this._waiting.hide();
               this.playFadeAnimation(1,600,null);
            }
         }
      }

      private function invalidateCommonData() : void {
         this.questInfo.setAvailableQuests(this._allTasks);
         var _loc1_:* = this.totalTasks > 0;
         this.sortingPanel.sortingDD.visible = _loc1_;
         this.sortingPanel.doneCB.visible = !this._hideDoneCB && (_loc1_);
         this.sortingPanel.sortTF.visible = _loc1_;
         this.scrollBar.visible = _loc1_;
         this.questsList.visible = _loc1_;
         this.listHidingBG.visible = _loc1_;
         this.questBG.visible = _loc1_;
         this.notSelected.visible = _loc1_;
         this.noQuestsMC.visible = !_loc1_;
         this.sortingPanel.visible = (_loc1_) && !this._isInRoaming;
         this.alertMsg.visible = (_loc1_) && (this._isInRoaming);
         if(_loc1_)
         {
            this.checkSelectedQuest();
         }
         else
         {
            this.scrollPane.visible = false;
            this.header.visible = false;
            this.awards.visible = false;
         }
      }

      private function updateQuest(param1:String) : void {
         this.showWaiting = true;
         this.questForUpdate = param1;
         invalidate(INVALIDATE_QUEST_ID);
      }

      private function playFadeAnimation(param1:Number, param2:Number, param3:Function) : void {
         var _loc4_:Tween = null;
         var _loc5_:Tween = null;
         for each (_loc4_ in this.tweens)
         {
            _loc4_.onComplete = null;
            _loc4_.paused = true;
            _loc4_ = null;
         }
         this.tweens = Vector.<Tween>([new Tween(param2,this.header,{"alpha":param1},
            {
               "paused":false,
               "ease":Strong.easeInOut,
               "onComplete":null
            }
         ),new Tween(param2,this.awards,{"alpha":param1},
            {
               "paused":false,
               "ease":Strong.easeInOut,
               "onComplete":null
            }
         ),new Tween(param2,this.notSelected,{"alpha":param1},
            {
               "paused":false,
               "ease":Strong.easeInOut,
               "onComplete":null
            }
         ),new Tween(param2,this.scrollPane,{"alpha":param1},
            {
               "paused":false,
               "ease":Strong.easeInOut,
               "onComplete":param3
            }
         )]);
         for each (_loc5_ in this.tweens)
         {
            _loc5_.fastTransform = false;
         }
      }

      private function tweenFadeOutCallback(param1:Tween) : void {
         this.questInFade = true;
         invalidate(INVALIDATE_QUEST_ID);
      }

      private function showQuestInfo(param1:Boolean) : void {
         this.notSelected.visible = !param1;
         this.scrollPane.visible = param1;
         this.header.visible = param1;
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
         return _loc2_;
      }

      public function hideDoneCheckbox(param1:Boolean) : void {
         this._hideDoneCB = param1;
      }

      public function setNodataLabel(param1:String) : void {
         this._noDataLael = param1;
         invalidate(INVALIDATE_NODATA_LABEL);
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
               this.updateQuest(this.currentQuest);
               _loc4_ = true;
               this.showQuestInfo(true);
               break;
            }
            _loc5_++;
         }
         if(!_loc4_)
         {
            this.questsList.selectedIndex = -1;
         }
      }

      public function set showWaiting(param1:Boolean) : void {
         if(this._showWaiting != param1)
         {
            this._showWaiting = param1;
            invalidate(WindowViewInvalidationType.WAITING_INVALID);
         }
      }

      private function get myParent() : IQuestsCurrentTabMeta {
         return IQuestsCurrentTabMeta(parent);
      }

      private function setNotSelected() : void {
         this.showQuestInfo(false);
         this.awards.visible = false;
         this.currentQuest = "";
      }

      private function handleItemClick(param1:ListEvent) : void {
         var _loc2_:QuestRendererVO = null;
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
               _loc2_ = QuestRendererVO(param1.itemData);
               this.currentQuest = _loc2_.questID;
               this.updateQuest(this.currentQuest);
            }
            else
            {
               this.setNotSelected();
            }
         }
      }

      private function handleCheckBox(param1:Event) : void {
         this.myParent.sortS(this.sortingPanel.sortingDD.selectedIndex,this.sortingPanel.doneCB.selected);
      }

      private function handleSortingDD(param1:ListEvent) : void {
         this.myParent.sortS(param1.index,this.sortingPanel.doneCB.selected);
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

      private function layoutBlocks(param1:Event) : void {
         if(this.questData)
         {
            if(param1.target == this.awards)
            {
               this.awardsResized = true;
            }
            if(param1.target == this.header)
            {
               this.headerResized = true;
            }
            if(param1.target == this.questInfo)
            {
               this.questInfoResized = true;
            }
            if((this.awardsResized) && (this.headerResized) && (this.questInfoResized))
            {
               this.awardsResized = this.headerResized = this.questInfoResized = false;
               this.awards.visible = Boolean((this.questData.award) && ((this.questData.award.awardsStr) || (this.questData.award.openedQuests.length)));
               this.awards.y = Math.round(AVAILABLE_HEIGHT - this.awards.height - AWARDS_PADDING);
               this.scrollPane.y = Math.round(this.header.height);
               this.scrollPane.height = Math.round(AVAILABLE_HEIGHT - this.header.height - this.awards.height - AWARDS_PADDING);
               this.scrollPane.validateNow();
               if(this.lastUpdatedQuest != this.questForUpdate)
               {
                  invalidate(INVALIDATE_QUEST_ID);
               }
               else
               {
                  if(this.questsList.selectedIndex > -1)
                  {
                     this.showQuestInfo(true);
                  }
                  else
                  {
                     this.setNotSelected();
                  }
                  this.questInFade = false;
                  this.showWaiting = false;
               }
            }
         }
      }

      private function getQuestData() : void {
         var _loc6_:QuestRenderer = null;
         var _loc1_:Object = this.myParent.getQuestInfoS(this.questForUpdate);
         this.questData = _loc1_?new QuestDataVO(_loc1_):null;
         this.lastUpdatedQuest = this.questForUpdate;
         var _loc2_:IDataProvider = this.questsList.dataProvider;
         var _loc3_:Number = _loc2_.length;
         var _loc4_:QuestRendererVO = null;
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc5_];
            if(_loc4_.questID == this.questForUpdate)
            {
               _loc4_.isNew = false;
               if(this.questsList.selectedIndex == _loc5_)
               {
                  _loc6_ = QuestRenderer(this.questsList.getRendererAt(_loc5_,this.questsList.scrollPosition));
                  _loc6_.hideNew();
                  break;
               }
            }
            _loc5_++;
         }
         invalidate(INVALIDATE_QUEST_INFO);
      }

      private function onChangeViewHandler(param1:IndexEvent) : void {
         this.questInfo.changeView(this.header.contentTabs.selectedItem.data);
      }

      public function get sortingFunction() : Function {
         return this._sortingFunction;
      }

      public function set sortingFunction(param1:Function) : void {
         this._sortingFunction = param1;
         invalidate(INVALIDATE_SORTING_FUNC);
      }
   }

}