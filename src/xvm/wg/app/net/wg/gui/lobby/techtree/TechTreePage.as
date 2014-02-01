package net.wg.gui.lobby.techtree
{
   import net.wg.infrastructure.base.meta.impl.TechTreeMeta;
   import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
   import net.wg.gui.lobby.techtree.helpers.TitleAppearance;
   import flash.text.TextField;
   import net.wg.gui.lobby.techtree.sub.NationTree;
   import net.wg.gui.lobby.techtree.controls.NationsButtonBar;
   import net.wg.gui.components.controls.ScrollBar;
   import flash.display.Sprite;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.lobby.techtree.constants.NodeState;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.NationXMLDataProvider;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.gfx.TextFieldEx;
   import scaleform.clik.constants.InvalidationType;
   import flash.display.InteractiveObject;
   import net.wg.data.constants.LobbyMetrics;


   public class TechTreePage extends TechTreeMeta implements ITechTreePage
   {
          
      public function TechTreePage() {
         super();
      }

      public static const BACKGROUND_ALPHA:Number = 0.9;

      private var titleAppearance:TitleAppearance = null;

      public var titleField:TextField;

      public var nationTree:NationTree;

      public var nationsBar:NationsButtonBar;

      public var scrollBar:ScrollBar;

      public var background:Sprite;

      public var treeRightBG:Sprite;

      private function handleEscape(param1:InputEvent) : void {
         onCloseTechTreeS();
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         setViewSize(param1,param2);
      }

      public function as_setAvailableNations(param1:Array) : void {
         if(this.nationsBar != null)
         {
            this.nationsBar.dataProvider = new DataProvider(param1);
         }
      }

      public function as_setSelectedNation(param1:String) : void {
         if(!this.nationsBar)
         {
            return;
         }
         var _loc2_:int = this.nationsBar.dataProvider.indexOf(param1);
         if(_loc2_ > -1)
         {
            this.nationsBar.selectedIndex = _loc2_;
         }
      }

      public function as_refreshNationTreeData(param1:String) : void {
         var _loc2_:Object = null;
         if(getNationTreeData != null)
         {
            _loc2_ = getNationTreeDataS(param1);
         }
         if(this.nationTree != null)
         {
            this.nationTree.storeScrollPosition();
            this.nationTree.invalidateNodesData(param1,_loc2_);
         }
      }

      public function as_setNodesStates(param1:Number, param2:Array) : void {
         if(this.nationTree != null)
         {
            this.nationTree.setNodesStates(param1,param2);
         }
      }

      public function as_setNext2Unlock(param1:Array) : void {
         if(this.nationTree != null)
         {
            this.nationTree.setNodesStates(NodeState.NEXT_2_UNLOCK,param1,NodeData.UNLOCK_PROPS_FIELD);
         }
      }

      public function as_setVehicleTypeXP(param1:Array) : void {
         if(this.nationTree != null)
         {
            this.nationTree.setVehicleTypeXP(param1);
         }
      }

      public function as_setInventoryItems(param1:Array) : void {
         if(this.nationTree != null)
         {
            this.nationTree.setNodesStates(NodeState.IN_INVENTORY,param1);
         }
      }

      public function as_setUnlockProps(param1:Array) : void {
         if(this.nationTree != null)
         {
            this.nationTree.setItemsField(param1,NodeData.UNLOCK_PROPS_FIELD);
         }
      }

      public function as_useXMLDumping() : void {
         if(this.nationTree != null)
         {
            this.nationTree.dataProvider = new NationXMLDataProvider();
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         if(!initialized)
         {
            validateNow();
         }
         requestNationTreeDataS();
      }

      override protected function onDispose() : void {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
         super.onDispose();
         if(this.titleAppearance != null)
         {
            this.titleAppearance.clearUp();
            this.titleAppearance = null;
         }
         if(this.nationsBar != null)
         {
            this.nationsBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.handleIndexChange);
            this.nationsBar.dispose();
         }
         if(this.nationTree != null)
         {
            this.nationTree.dispose();
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.titleAppearance = new TitleAppearance(this.titleField);
         if(this.titleField != null)
         {
            this.titleField.mouseEnabled = false;
            TextFieldEx.setVerticalAlign(this.titleField,TextFieldEx.VALIGN_CENTER);
         }
         if(this.nationsBar != null)
         {
            this.nationsBar.addEventListener(IndexEvent.INDEX_CHANGE,this.handleIndexChange,false,0,true);
            this.nationsBar.focused = 1;
         }
         if(this.nationTree != null)
         {
            this.nationTree.view = this;
         }
         if(this.treeRightBG != null)
         {
            this.treeRightBG.mouseEnabled = this.treeRightBG.tabEnabled = false;
         }
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayouts();
         }
      }

      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(this.nationsBar);
      }

      protected function updateLayouts() : void {
         if(this.nationsBar != null)
         {
            this.nationsBar.height = _height;
         }
         if(this.nationTree != null)
         {
            this.nationTree.setSize(Math.round(_width - this.nationTree.x),Math.round(_height));
         }
         if(this.treeRightBG != null)
         {
            this.treeRightBG.x = _width - this.treeRightBG.width;
            this.treeRightBG.height = _height;
         }
         this.titleAppearance.updateInTT(_width,App.appHeight);
         if(this.background != null)
         {
            this.background.width = _width;
            this.background.height = _height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
         }
      }

      override public function get isModal() : Boolean {
         return true;
      }

      override public function get modalAlpha() : Number {
         return BACKGROUND_ALPHA;
      }

      private function handleIndexChange(param1:IndexEvent) : void {
         var _loc4_:String = null;
         var _loc2_:String = this.nationsBar.itemToLabel(param1.data);
         var _loc3_:Object = null;
         if(getNationTreeData != null)
         {
            _loc3_ = getNationTreeDataS(_loc2_);
         }
         if(this.titleField != null)
         {
            _loc4_ = MENU.nation_tree_title(_loc2_);
            if(_loc4_)
            {
               this.titleField.text = _loc4_;
            }
            else
            {
               this.titleField.text = "";
            }
         }
         if(this.nationTree != null)
         {
            this.nationTree.storeScrollPosition();
            this.nationTree.invalidateNodesData(_loc2_,_loc3_);
         }
      }
   }

}