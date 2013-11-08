package net.wg.gui.lobby.techtree.data.state
{
   import __AS3__.vec.Vector;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.constants.NodeState;
   import net.wg.gui.lobby.techtree.constants.NamedLabels;


   public class NodeStateCollection extends Object
   {

      public function NodeStateCollection() {
         super();
      }

      private static var statePrefixes:Array;

      private static var animation:AnimationProperties;

      private static var nationNodeStates:Vector.<NodeStateItem>;

      private static var itemStates:Vector.<ResearchStateItem>;

      public static function getStateProps(param1:uint, param2:Number, param3:Object) : StateProperties {
         var _loc4_:StateProperties = null;
         switch(param1)
         {
            case NodeEntityType.NATION_TREE:
            case NodeEntityType.TOP_VEHICLE:
            case NodeEntityType.NEXT_VEHICLE:
               _loc4_ = getNTNodeStateProps(param2);
               break;
            case NodeEntityType.RESEARCH_ROOT:
               _loc4_ = getNTNodeStateProps(param2);
               break;
            case NodeEntityType.RESEARCH_ITEM:
               _loc4_ = getResearchNodeStateProps(param2,param3.rootState,param3.isParentUnlocked);
               break;
         }
         if(_loc4_ == null)
         {
            _loc4_ = new StateProperties(0,0);
         }
         return _loc4_;
      }

      public static function getStatePrefix(param1:Number) : String {
         var _loc2_:String = statePrefixes[param1];
         return _loc2_ != null?_loc2_:"locked_";
      }

      public static function isRedrawNTLines(param1:Number) : Boolean {
         return (param1 & NodeState.UNLOCKED) > 0 || (param1 & NodeState.NEXT_2_UNLOCK) > 0 || (param1 & NodeState.IN_INVENTORY) > 0;
      }

      public static function isRedrawResearchLines(param1:Number) : Boolean {
         return (param1 & NodeState.UNLOCKED) > 0 || (param1 & NodeState.NEXT_2_UNLOCK) > 0;
      }

      private static function getNTNodeStateProps(param1:Number) : StateProperties {
         var _loc2_:NodeStateItem = null;
         var _loc3_:Number = getNTNodePrimaryState(param1);
         var _loc4_:Number = nationNodeStates.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = nationNodeStates[_loc5_];
            if(_loc3_ == _loc2_.getState())
            {
               return _loc2_.getProps();
            }
            _loc5_++;
         }
         return nationNodeStates[0].getProps();
      }

      private static function getResearchNodeStateProps(param1:Number, param2:Number, param3:Boolean) : StateProperties {
         var _loc4_:ResearchStateItem = null;
         var _loc5_:Number = getResearchNodePrimaryState(param1);
         var _loc6_:Number = itemStates.length;
         var _loc7_:Number = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_ = itemStates[_loc7_];
            if(_loc5_ == _loc4_.getState())
            {
               return _loc4_.resolveProps(param1,param2,param3);
            }
            _loc7_++;
         }
         return itemStates[0].getProps();
      }

      private static function getNTNodePrimaryState(param1:Number) : Number {
         var _loc2_:Number = param1;
         if((param1 & NodeState.ENOUGH_XP) > 0)
         {
            _loc2_ = _loc2_ ^ NodeState.ENOUGH_XP;
         }
         if((param1 & NodeState.ENOUGH_MONEY) > 0)
         {
            _loc2_ = _loc2_ ^ NodeState.ENOUGH_MONEY;
         }
         if((param1 & NodeState.ELITE) > 0)
         {
            _loc2_ = _loc2_ ^ NodeState.ELITE;
         }
         if((param1 & NodeState.CAN_SELL) > 0)
         {
            _loc2_ = _loc2_ ^ NodeState.CAN_SELL;
         }
         return _loc2_;
      }

      private static function getResearchNodePrimaryState(param1:Number) : Number {
         var _loc2_:Number = param1;
         if((param1 & NodeState.ENOUGH_XP) > 0)
         {
            _loc2_ = _loc2_ ^ NodeState.ENOUGH_XP;
         }
         if((param1 & NodeState.ENOUGH_MONEY) > 0)
         {
            _loc2_ = _loc2_ ^ NodeState.ENOUGH_MONEY;
         }
         if((param1 & NodeState.AUTO_UNLOCKED) > 0)
         {
            _loc2_ = _loc2_ ^ NodeState.AUTO_UNLOCKED;
         }
         if((param1 & NodeState.CAN_SELL) > 0)
         {
            _loc2_ = _loc2_ ^ NodeState.CAN_SELL;
         }
         return _loc2_;
      }
   }

}
