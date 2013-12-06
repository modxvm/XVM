package net.wg.gui.lobby.techtree.nodes
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.math.MatrixPosition;
   import net.wg.gui.lobby.techtree.data.state.StateProperties;
   import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
   import net.wg.gui.components.controls.ActionPrice;
   import flash.display.MovieClip;
   import net.wg.gui.lobby.techtree.controls.ActionButton;
   import flash.geom.Point;
   import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.techtree.constants.NodeState;
   import net.wg.gui.lobby.techtree.constants.NamedLabels;
   import net.wg.gui.lobby.techtree.MenuHandler;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.ColorIndex;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.lobby.techtree.constants.TTSoundID;
   import scaleform.clik.constants.InvalidationType;
   import __AS3__.vec.Vector;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import scaleform.clik.events.InputEvent;
   import flash.events.EventPhase;
   import scaleform.gfx.MouseEventEx;
   import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
   import scaleform.gfx.Extensions;


   public class Renderer extends SoundListItemRenderer implements IRenderer
   {
          
      public function Renderer() {
         Extensions.enabled = true;
         super();
         if(this.actionPrice)
         {
            this.actionPrice.visible = false;
         }
      }

      public static const LINES_AND_ARROWS_NAME:String = "linesAndArrows";

      public static const NAMED_VALUE_TYPE_NUMBER:String = "Number";

      public static const NAMED_VALUE_TYPE_STRING:String = "String";

      protected var _valueObject:NodeData;

      protected var _matrixPosition:MatrixPosition;

      protected var stateProps:StateProperties;

      protected var dataInited:Boolean;

      protected var isDelegateEvents:Boolean = false;

      protected var _container:INodesContainer = null;

      protected var _entityType:uint = 0;

      protected var _tooltipID:String = null;

      protected var _doValidateNow:Boolean = false;

      public var actionPrice:ActionPrice;

      public var hit:MovieClip;

      public var button:ActionButton;

      public function get container() : INodesContainer {
         return this._container;
      }

      public function set container(param1:INodesContainer) : void {
         this._container = param1;
      }

      public function get matrixPosition() : MatrixPosition {
         return this._matrixPosition;
      }

      public function setup(param1:uint, param2:NodeData, param3:uint=0, param4:MatrixPosition=null) : void {
         var _loc6_:Point = null;
         if(param3 != 0)
         {
            this._entityType = param3;
         }
         this._index = param1;
         this._matrixPosition = param4;
         if(this._valueObject == param2 || param2 == null)
         {
            return;
         }
         this._valueObject = param2;
         this.dataInited = true;
         this.updateStatesProps();
         setState(state);
         var _loc5_:Object = this.getDisplayInfo();
         if(!(_loc5_ == null) && _loc5_  is  NTDisplayInfo)
         {
            _loc6_ = (_loc5_ as NTDisplayInfo).position;
            if(_loc6_ != null)
            {
               this.setPosition(_loc6_);
            }
         }
      }

      public function cleanUp() : void {
         this.container = null;
         if(this.button != null)
         {
            this.button.removeEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
            this.button.removeEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
            this.button.dispose();
         }
         if((this.isDelegateEvents) && !(this.hit == null))
         {
            this.removeEventsHandlers();
         }
         if(this.actionPrice != null)
         {
            this.actionPrice.dispose();
         }
         this.dataInited = false;
         this._valueObject = null;
         super.dispose();
      }

      public function getEntityType() : uint {
         return this._entityType;
      }

      public function getID() : Number {
         return this.dataInited?this._valueObject.id:0;
      }

      public function getItemName() : String {
         return this.dataInited?this._valueObject.nameString:"";
      }

      public function getItemType() : String {
         return this.dataInited?this._valueObject.primaryClass.name:"";
      }

      public function getGraphicsName() : String {
         return LINES_AND_ARROWS_NAME + this._entityType.toString() + _index.toString();
      }

      public function getLevel() : int {
         return this.dataInited?this._valueObject.level:-1;
      }

      public function getIconPath() : String {
         return this.dataInited?this._valueObject.iconPath:"";
      }

      public function getDisplayInfo() : Object {
         return this.dataInited?this._valueObject.displayInfo:null;
      }

      public function isNext2Unlock() : Boolean {
         return (this.dataInited) && (this._valueObject.state & NodeState.NEXT_2_UNLOCK) > 0;
      }

      public function isUnlocked() : Boolean {
         return (this.dataInited) && (this._valueObject.state & NodeState.UNLOCKED) > 0;
      }

      public function isElite() : Boolean {
         return (this.dataInited) && (this._valueObject.state & NodeState.ELITE) > 0;
      }

      public function isPremium() : Boolean {
         return (this.dataInited) && (this._valueObject.state & NodeState.PREMIUM) > 0;
      }

      public function inInventory() : Boolean {
         return (this.dataInited) && (this._valueObject.state & NodeState.IN_INVENTORY) > 0;
      }

      public function isAvailable4Unlock() : Boolean {
         if(!this.dataInited)
         {
            return false;
         }
         var _loc1_:Number = this._valueObject.state;
         return (_loc1_ & NodeState.NEXT_2_UNLOCK) > 0 && (_loc1_ & NodeState.ENOUGH_XP) > 0;
      }

      public function isAvailable4Buy() : Boolean {
         if(!this.dataInited)
         {
            return false;
         }
         var _loc1_:Number = this._valueObject.state;
         return (_loc1_ & NodeState.UNLOCKED) > 0 && (_loc1_ & NodeState.ENOUGH_MONEY) > 0 && (_loc1_ & NodeState.IN_INVENTORY) == 0;
      }

      public function isAvailable4Sell() : Boolean {
         return (this.dataInited) && (this._valueObject.state & NodeState.CAN_SELL) > 0;
      }

      public function isActionEnabled() : Boolean {
         if(!this.dataInited)
         {
            return false;
         }
         return this.stateProps.enough == 0 || (this._valueObject.state & this.stateProps.enough) > 0;
      }

      public function isButtonVisible() : Boolean {
         return (this.stateProps.visible) && this.stateProps.animation == null;
      }

      public function isSelected() : Boolean {
         return (this.dataInited) && (this._valueObject.state & NodeState.SELECTED) > 0;
      }

      public function isFake() : Boolean {
         return false;
      }

      public function isShopAction() : Boolean {
         return (this.dataInited) && (this._valueObject.state & NodeState.SHOP_ACTION) > 0;
      }

      public function getEarnedXP() : Number {
         return this.dataInited?this._valueObject.earnedXP:0;
      }

      public function getNamedDefValue(param1:String) : Number {
         var _loc2_:* = NaN;
         if(!this.dataInited)
         {
            return 0;
         }
         switch(param1)
         {
            case NamedLabels.XP_COST:
               _loc2_ = this._valueObject.unlockProps.defXpCost;
               break;
            case NamedLabels.EARNED_XP:
               _loc2_ = this._valueObject.defEarnedXP;
               break;
            case NamedLabels.CREDITS_PRICE:
               _loc2_ = this._valueObject.shopPrice.defCredits;
               break;
            case NamedLabels.GOLD_PRICE:
               _loc2_ = this._valueObject.shopPrice.defGold;
               break;
            default:
               _loc2_ = 0;
         }
         return _loc2_;
      }

      public function getNamedActionPrc(param1:String) : Number {
         if(!this.dataInited)
         {
            return 0;
         }
         var _loc2_:Number = 0;
         switch(param1)
         {
            case NamedLabels.XP_COST:
               _loc2_ = 0;
               break;
            case NamedLabels.EARNED_XP:
               _loc2_ = 0;
               break;
            case NamedLabels.CREDITS_PRICE:
               _loc2_ = this._valueObject.shopPrice.actionPrc;
               break;
            case NamedLabels.GOLD_PRICE:
               _loc2_ = this._valueObject.shopPrice.actionPrc;
               break;
            default:
               _loc2_ = 0;
         }
         return _loc2_;
      }

      public function getNamedValue(param1:String, param2:String) : Object {
         var _loc3_:Object = null;
         if(!this.dataInited)
         {
            return "";
         }
         switch(param1)
         {
            case NamedLabels.XP_COST:
               _loc3_ = param2 == NAMED_VALUE_TYPE_NUMBER?this._valueObject.unlockProps.xpCost:this._valueObject.unlockProps.xpCostLabel;
               break;
            case NamedLabels.EARNED_XP:
               _loc3_ = param2 == NAMED_VALUE_TYPE_NUMBER?this._valueObject.earnedXP:this._valueObject.earnedXPLabel;
               break;
            case NamedLabels.CREDITS_PRICE:
               _loc3_ = param2 == NAMED_VALUE_TYPE_NUMBER?this._valueObject.shopPrice.credits:this._valueObject.shopPrice.creditsLabel;
               break;
            case NamedLabels.GOLD_PRICE:
               _loc3_ = param2 == NAMED_VALUE_TYPE_NUMBER?this._valueObject.shopPrice.gold:this._valueObject.shopPrice.goldLabel;
               break;
            default:
               _loc3_ = param2 == NAMED_VALUE_TYPE_NUMBER?0:"";
         }
         return _loc3_;
      }

      public function validateNowEx() : void {
         this._doValidateNow = true;
         super.validateNow();
      }

      public function invalidateNodeState(param1:Number) : void {
         this.updateStatesProps();
         setState(state);
         if(param1 > -1)
         {
            MenuHandler.getInstance().hideMenu();
            dispatchEvent(new TechTreeEvent(TechTreeEvent.STATE_CHANGED,param1,_index,this._entityType));
         }
      }

      public function getColorIdx(param1:Number=-1) : Number {
         var _loc2_:Number = ColorIndex.LOCKED;
         if(this.isUnlocked())
         {
            if(param1 == -1 || param1 > 0 && (this.isParentUnlocked(param1)))
            {
               _loc2_ = ColorIndex.UNLOCKED;
            }
         }
         else
         {
            if(this.isNext2Unlock())
            {
               if(param1 == -1 || param1 > 0 && (this.isParentUnlocked(param1)))
               {
                  _loc2_ = ColorIndex.NEXT2UNLOCK;
               }
            }
         }
         return _loc2_;
      }

      public function getColorIdxEx(param1:IRenderer) : Number {
         var _loc2_:Number = ColorIndex.LOCKED;
         if(this.isUnlocked())
         {
            if(param1 == null || (param1.isUnlocked()))
            {
               _loc2_ = ColorIndex.UNLOCKED;
            }
         }
         else
         {
            if(this.isNext2Unlock())
            {
               if(param1 == null || (param1.isUnlocked()))
               {
                  _loc2_ = ColorIndex.NEXT2UNLOCK;
               }
            }
         }
         return _loc2_;
      }

      public function click2Unlock() : void {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_UNLOCK,0,_index,this._entityType));
      }

      public function click2Buy() : void {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_BUY,0,_index,this._entityType));
      }

      public function click2Sell() : void {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_SELL,0,_index,this._entityType));
      }

      public function click2Info() : void {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_MODULE_INFO,0,_index,this._entityType));
      }

      public function getInX() : Number {
         return Math.round(x + (this.hit != null?this.hit.x:0));
      }

      public function getOutX() : Number {
         return x + (this.hit != null?this.hit.x + Math.round(this.hit.width):Math.round(_width));
      }

      public function getY() : Number {
         return y + (this.hit != null?this.hit.y + (Math.round(this.hit.height) >> 1):Math.round(_height) >> 1);
      }

      public function getRatioY() : Number {
         return this.hit != null?Math.round(this.hit.height) >> 1:Math.round(_height) >> 1;
      }

      public function getActualWidth() : Number {
         return this.hit != null?this.hit.width:_width;
      }

      public function setPosition(param1:Point) : void {
         if(this.hit != null)
         {
            this.x = Math.round(param1.x - this.hit.x);
            this.y = Math.round(param1.y - this.hit.y);
         }
         else
         {
            this.x = param1.x;
            this.y = param1.y;
         }
      }

      public function getExtraState() : Object {
         return null;
      }

      public function showContextMenu() : void {
          
      }

      public function isParentUnlocked(param1:Number) : Boolean {
         return this._container != null?this._container.isParentUnlocked(param1,this._valueObject.id):true;
      }

      public function populateUI() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         if(this.actionPrice != null)
         {
            _loc1_ = Number(this.getNamedValue(this.stateProps.label,Renderer.NAMED_VALUE_TYPE_NUMBER));
            _loc2_ = Number(this.getNamedDefValue(this.stateProps.label));
            this.actionPrice.setData(this.getNamedActionPrc(this.stateProps.label),_loc1_,_loc2_,this.getPriceIco(this.stateProps.label));
            this.actionPrice.visible = (this.isShopAction()) && !(this.button == null) && (this.button.visible);
            if(this._doValidateNow)
            {
               this.actionPrice.validateNow();
            }
         }
         this._doValidateNow = false;
         if(this.button != null)
         {
            this.button.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
            this.button.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
         }
      }

      private function getPriceIco(param1:String) : String {
         var _loc2_:* = "";
         switch(param1)
         {
            case NamedLabels.XP_COST:
               _loc2_ = IconText.XP_PRICE;
               break;
            case NamedLabels.EARNED_XP:
               _loc2_ = IconText.XP_PRICE;
               break;
            case NamedLabels.CREDITS_PRICE:
               _loc2_ = IconText.CREDITS;
               break;
            case NamedLabels.GOLD_PRICE:
               _loc2_ = IconText.GOLD;
               break;
            default:
               _loc2_ = "";
         }
         return _loc2_;
      }

      private function buttonOut(param1:MouseEvent) : void {
         if(this.actionPrice != null)
         {
            this.actionPrice.hideTooltip();
         }
      }

      private function buttonOver(param1:MouseEvent) : void {
         if(!(this.actionPrice == null) && (this.actionPrice.visible))
         {
            this.actionPrice.showTooltip();
         }
      }

      override protected function preInitialize() : void {
         preventAutosizing = false;
         constraintsDisabled = true;
         super.preInitialize();
         _state = "up";
         this.dataInited = false;
         soundType = TTSoundID.SUPER_TYPE;
         soundId = TTSoundID.UNDEFINED;
      }

      override protected function initialize() : void {
         super.initialize();
         this.updateStatesProps();
      }

      override protected function configUI() : void {
         if((this.isDelegateEvents) && !(this.hit == null))
         {
            this.delegateEventsHandlers();
         }
         else
         {
            super.configUI();
         }
         if(App.soundMgr)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }

      override protected function draw() : void {
         super.draw();
         if(!_baseDisposed)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               if(this._valueObject != null)
               {
                  visible = true;
                  this.populateUI();
               }
               else
               {
                  visible = false;
               }
            }
         }
      }

      protected function getMouseEnabledChildren() : Vector.<DisplayObjectContainer> {
         var _loc1_:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
         if(this.hit != null)
         {
            _loc1_.push(this.hit);
         }
         if(this.button != null)
         {
            _loc1_.push(this.button);
         }
         return _loc1_;
      }

      protected function disableMouseChildren() : void {
         var _loc1_:DisplayObject = null;
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:Vector.<DisplayObjectContainer> = this.getMouseEnabledChildren();
         var _loc4_:Number = 0;
         while(_loc4_ < numChildren)
         {
            _loc1_ = getChildAt(_loc4_);
            if(_loc1_  is  DisplayObjectContainer && _loc3_.indexOf(_loc1_) == -1)
            {
               _loc2_ = DisplayObjectContainer(_loc1_);
               _loc2_.mouseEnabled = _loc2_.mouseChildren = false;
            }
            _loc4_++;
         }
      }

      protected function delegateEventsHandlers() : void {
         mouseEnabled = false;
         this.disableMouseChildren();
         this.hit.buttonMode = this.hit.mouseEnabled = true;
         this.hit.addEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver,false,0,true);
         this.hit.addEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut,false,0,true);
         this.hit.addEventListener(MouseEvent.MOUSE_DOWN,this.handleMousePress,false,0,true);
         this.hit.addEventListener(MouseEvent.CLICK,this.handleMouseRelease,false,0,true);
         this.hit.addEventListener(MouseEvent.DOUBLE_CLICK,this.handleMouseRelease,false,0,true);
         this.hit.addEventListener(InputEvent.INPUT,handleInput,false,0,true);
      }

      protected function removeEventsHandlers() : void {
         this.hit.removeEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver,false);
         this.hit.removeEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut,false);
         this.hit.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMousePress,false);
         this.hit.removeEventListener(MouseEvent.CLICK,this.handleMouseRelease,false);
         this.hit.removeEventListener(MouseEvent.DOUBLE_CLICK,this.handleMouseRelease,false);
         this.hit.removeEventListener(InputEvent.INPUT,handleInput,false);
      }

      override protected function updateAfterStateChange() : void {
         if(this.isDelegateEvents)
         {
            this.disableMouseChildren();
         }
         super.updateAfterStateChange();
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         if((this._tooltipID) && !(App.toolTipMgr == null))
         {
            App.toolTipMgr.showSpecial(this._tooltipID,null,this._valueObject,this._container != null?this._container.getRootNode().getID():null);
         }
         super.handleMouseRollOver(param1);
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         if(App.toolTipMgr != null)
         {
            App.toolTipMgr.hide();
         }
         super.handleMouseRollOut(param1);
      }

      override protected function handleMouseRelease(param1:MouseEvent) : void {
         super.handleMouseRelease(param1);
         if(param1.eventPhase == EventPhase.AT_TARGET && param1  is  MouseEventEx && (param1 as MouseEventEx).buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            this.showContextMenu();
         }
      }

      override protected function handleMousePress(param1:MouseEvent) : void {
         if(App.toolTipMgr != null)
         {
            App.toolTipMgr.hide();
         }
         super.handleMousePress(param1);
      }

      private function updateStatesProps() : void {
         this.stateProps = NodeStateCollection.getStateProps(this._entityType,this.dataInited?this._valueObject.state:0,this.getExtraState());
         var _loc1_:String = NodeStateCollection.getStatePrefix(this.stateProps.index);
         statesSelected = Vector.<String>(["selected_",_loc1_]);
         statesDefault = Vector.<String>([_loc1_]);
      }
   }

}