package net.wg.gui.lobby.techtree
{
   import net.wg.infrastructure.base.meta.impl.ResearchMeta;
   import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
   import net.wg.gui.lobby.techtree.sub.ResearchItems;
   import flash.display.Sprite;
   import scaleform.clik.events.InputEvent;
   import net.wg.gui.lobby.techtree.constants.NodeState;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.ResearchXMLDataProvider;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.display.InteractiveObject;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;


   public class ResearchPage extends ResearchMeta implements IResearchPage
   {
          
      public function ResearchPage() {
         super();
      }

      public static const BACKGROUND_ALPHA:Number = 0.9;

      public var researchItems:ResearchItems;

      public var background:Sprite;

      private function handleEscape(param1:InputEvent) : void {
         exitFromResearchS();
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         setViewSize(param1,param2);
      }

      public function as_drawResearchItems(param1:String, param2:Number) : void {
         var _loc3_:Object = getResearchItemsDataS(param2,false);
         if(this.researchItems != null)
         {
            this.researchItems.invalidateNodesData(param1,_loc3_);
         }
      }

      public function as_setNodesStates(param1:Number, param2:Array) : void {
         if(this.researchItems != null)
         {
            this.researchItems.setNodesStates(param1,param2);
         }
      }

      public function as_setNext2Unlock(param1:Array) : void {
         if(this.researchItems != null)
         {
            this.researchItems.setNodesStates(NodeState.NEXT_2_UNLOCK,param1,NodeData.UNLOCK_PROPS_FIELD);
         }
      }

      public function as_setWalletStatus(param1:Object) : void {
         App.utils.voMgr.walletStatusVO.update(param1);
         this.researchItems.setWalletStatus();
      }

      public function as_setFreeXP(param1:Number) : void {
         if(this.researchItems != null)
         {
            this.researchItems.setFreeXP(param1);
         }
      }

      public function as_setVehicleTypeXP(param1:Array) : void {
         if(this.researchItems != null)
         {
            this.researchItems.setVehicleTypeXP(param1);
         }
      }

      public function as_setInventoryItems(param1:Array) : void {
         if(this.researchItems != null)
         {
            this.researchItems.setNodesStates(NodeState.IN_INVENTORY,param1);
         }
      }

      public function as_setInstalledItems(param1:Array) : void {
         if(this.researchItems != null)
         {
            this.researchItems.setNodesStates(NodeState.INSTALLED,param1);
         }
      }

      public function as_useXMLDumping() : void {
         if(this.researchItems != null)
         {
            this.researchItems.dataProvider = new ResearchXMLDataProvider();
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         if(!initialized)
         {
            validateNow();
         }
         if(this.researchItems != null)
         {
            this.researchItems.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.handleRequestFocus,false,0,true);
         }
         requestNationDataS();
      }

      override protected function onDispose() : void {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
         super.onDispose();
         if(this.researchItems != null)
         {
            this.researchItems.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.handleRequestFocus,false);
            this.researchItems.dispose();
         }
      }

      override protected function configUI() : void {
         super.configUI();
         if(this.researchItems != null)
         {
            this.researchItems.view = this;
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
         setFocus(this.researchItems);
      }

      protected function updateLayouts() : void {
         if(this.background != null)
         {
            this.background.width = _width;
            this.background.height = _height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
         }
         if(this.researchItems != null)
         {
            this.researchItems.y = 0;
            this.researchItems.x = _width - LobbyMetrics.MIN_STAGE_WIDTH >> 1;
            this.researchItems.height = _height;
         }
      }

      override public function get isModal() : Boolean {
         return true;
      }

      override public function get modalAlpha() : Number {
         return BACKGROUND_ALPHA;
      }

      private function handleRequestFocus(param1:FocusRequestEvent) : void {
         setFocus(IFocusContainer(param1.focusContainer).getComponentForFocus());
      }
   }

}