package net.wg.gui.lobby.techtree.nodes
{
   import net.wg.gui.lobby.techtree.controls.NameAndXpField;
   import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.Sprite;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.math.MatrixPosition;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.MenuHandler;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.constants.TTSoundID;
   import net.wg.data.constants.Tooltips;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import flash.display.InteractiveObject;
   import flash.display.BitmapData;
   import net.wg.gui.lobby.techtree.constants.NavIndicator;
   import flash.display.Bitmap;


   public class NationTreeNode extends Renderer
   {
          
      public function NationTreeNode() {
         super();
      }

      private var isNavContainerAdded:Boolean = false;

      private var isMouseMoved:Boolean = false;

      public var nameAndXp:NameAndXpField;

      public var typeAndLevel:TypeAndLevelField;

      public var vIconLoader:UILoaderAlt;

      public var navContainer:Sprite;

      override public function setup(param1:uint, param2:NodeData, param3:uint=0, param4:MatrixPosition=null) : void {
         super.setup(param1,param2,param3,param4);
         this.drawNavIndicator();
      }

      override public function cleanUp() : void {
         removeEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove,false);
         if(this.typeAndLevel != null)
         {
            this.typeAndLevel.dispose();
         }
         if(this.nameAndXp != null)
         {
            this.nameAndXp.dispose();
         }
         if(this.vIconLoader != null)
         {
            this.vIconLoader.dispose();
         }
         super.cleanUp();
      }

      override public function getIconPath() : String {
         return dataInited?_valueObject.smallIconPath:"";
      }

      override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean=false) : Boolean {
         var _loc4_:* = false;
         if(hit != null)
         {
            _loc4_ = hit.hitTestPoint(param1,param2,param3);
         }
         else
         {
            _loc4_ = super.hitTestPoint(param1,param2,param3);
         }
         return (_loc4_) && (button == null || !button.visible || !button.hitTestPoint(param1,param2,param3));
      }

      override public function click2Info() : void {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_VEHICLE_INFO,0,_index,_entityType));
      }

      override public function showContextMenu() : void {
         if(button != null)
         {
            button.endAnimation(true);
         }
         this.stopDragNode();
         MenuHandler.getInstance().showNationTreeMenu(this);
      }

      override public function populateUI() : void {
         var _loc1_:String = null;
         if(this.vIconLoader != null)
         {
            _loc1_ = this.getIconPath();
            this.vIconLoader.alpha = stateProps.icoAlpha;
            if(_loc1_ != this.vIconLoader.source)
            {
               this.vIconLoader.source = _loc1_;
               this.vIconLoader.visible = true;
            }
         }
         if(this.typeAndLevel != null)
         {
            this.typeAndLevel.setOwner(this,_doValidateNow);
         }
         if(this.nameAndXp != null)
         {
            this.nameAndXp.setOwner(this,_doValidateNow);
         }
         if(button != null)
         {
            button.label = getNamedValue(stateProps.label,Renderer.NAMED_VALUE_TYPE_STRING).toString();
            button.enabled = isActionEnabled();
            if(button.setAnimation(stateProps.id,stateProps.animation))
            {
               button.visible = stateProps.visible;
            }
            button.setOwner(this,_doValidateNow);
         }
         super.populateUI();
      }

      override public function toString() : String {
         return "[NationTreeNode " + index + ", " + name + "]";
      }

      override protected function preInitialize() : void {
         super.preInitialize();
         _entityType = NodeEntityType.NATION_TREE;
         soundId = TTSoundID.NATION_TREE;
         _tooltipID = Tooltips.TECHTREE_VEHICLE;
         isDelegateEvents = true;
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         if(button != null)
         {
            button.startAnimation();
         }
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         if(button != null)
         {
            button.endAnimation(false);
         }
      }

      override protected function handleMousePress(param1:MouseEvent) : void {
         super.handleMousePress(param1);
         this.startDragNode();
      }

      override protected function handleReleaseOutside(param1:MouseEvent) : void {
         super.handleReleaseOutside(param1);
         if(button != null)
         {
            button.endAnimation(false);
         }
         if(!this.hitTestPoint(stage.mouseX,stage.mouseY))
         {
            this.stopDragNode();
         }
      }

      override protected function handleClick(param1:uint=0) : void {
         MenuHandler.getInstance().hideMenu();
         if(button != null)
         {
            button.endAnimation(true);
         }
         super.handleClick(param1);
         if(!this.isMouseMoved)
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN,0,_index,_entityType));
         }
         this.stopDragNode();
      }

      private function startDragNode() : void {
         if(container  is  IDraggable)
         {
            addEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove,false,0,true);
         }
      }

      private function stopDragNode() : void {
         var _loc1_:IDraggable = null;
         var _loc2_:InteractiveObject = null;
         if(container  is  IDraggable)
         {
            removeEventListener(MouseEvent.MOUSE_MOVE,this.handleMouseMove,false);
            _loc1_ = IDraggable(container);
            _loc2_ = _loc1_.getHitArea();
            this.isMouseMoved = false;
            _loc2_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
         }
      }

      private function handleMouseMove(param1:MouseEvent) : void {
         var _loc2_:IDraggable = null;
         var _loc3_:InteractiveObject = null;
         if(container as IDraggable)
         {
            _loc2_ = IDraggable(container);
            _loc3_ = _loc2_.getHitArea();
            if(!this.isMouseMoved)
            {
               this.isMouseMoved = true;
               _loc3_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
            }
            _loc3_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
         }
      }

      private function drawNavIndicator() : void {
         var _loc1_:BitmapData = null;
         if(this.navContainer != null)
         {
            this.navContainer.mouseEnabled = this.navContainer.mouseChildren = false;
            if(!this.isNavContainerAdded && (NavIndicator.isDraw(_entityType)))
            {
               _loc1_ = App.utils.classFactory.getObject(NavIndicator.getSource(_entityType)) as BitmapData;
               if(_loc1_ != null)
               {
                  this.navContainer.addChild(new Bitmap(_loc1_));
                  this.isNavContainerAdded = true;
               }
            }
         }
      }
   }

}