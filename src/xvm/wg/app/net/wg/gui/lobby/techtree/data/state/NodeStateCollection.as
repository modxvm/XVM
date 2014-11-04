package net.wg.gui.lobby.techtree.data.state
{
    import net.wg.gui.lobby.techtree.constants.NodeEntityType;
    import net.wg.gui.lobby.techtree.constants.NodeState;
    import net.wg.gui.lobby.techtree.constants.NamedLabels;
    
    public class NodeStateCollection extends Object
    {
        
        public function NodeStateCollection()
        {
            super();
        }
        
        private static var statePrefixes:Array = ["locked_","next2unlock_","next4buy_","premium_","inventory_","inventory_cur_","inventory_prem_","inventory_prem_cur_","auto_unlocked_","installed_","installed_plocked_","was_in_battle_sell_","inRent_"];
        
        private static var animation:AnimationProperties = new AnimationProperties(150,{"alpha":0},{"alpha":1});
        
        private static var nationNodeStates:Vector.<NodeStateItem> = Vector.<NodeStateItem>([new NodeStateItem(NodeState.LOCKED,new StateProperties(1,0,null,0,false,null,0.4)),new NodeStateItem(NodeState.NEXT_2_UNLOCK,new StateProperties(2,1,NamedLabels.XP_COST,NodeState.ENOUGH_XP,true)),new NodeStateItem(NodeState.UNLOCKED,new StateProperties(3,2,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,true)),new NodeStateItem(NodeState.UNLOCKED | NodeState.WAS_IN_BATTLE,new StateProperties(4,11,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,true,animation)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM,new StateProperties(5,3,NamedLabels.GOLD_PRICE,NodeState.ENOUGH_MONEY,true)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.WAS_IN_BATTLE,new StateProperties(6,3,NamedLabels.GOLD_PRICE,NodeState.ENOUGH_MONEY,true)),new NodeStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY,new StateProperties(7,4,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,false)),new NodeStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY | NodeState.WAS_IN_BATTLE,new StateProperties(8,4,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,false)),new NodeStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY | NodeState.SELECTED,new StateProperties(9,5,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,false)),new NodeStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY | NodeState.WAS_IN_BATTLE | NodeState.SELECTED,new StateProperties(10,5,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,false)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY,new StateProperties(11,6,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,false)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.WAS_IN_BATTLE,new StateProperties(12,6,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,false)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.SELECTED,new StateProperties(13,7,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,false)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.WAS_IN_BATTLE | NodeState.SELECTED,new StateProperties(14,7,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,false)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.VEHICLE_IN_RENT,new StateProperties(15,12,NamedLabels.GOLD_PRICE,NodeState.ENOUGH_MONEY,true)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.VEHICLE_IN_RENT | NodeState.SELECTED,new StateProperties(16,12,NamedLabels.GOLD_PRICE,NodeState.ENOUGH_MONEY,true)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.VEHICLE_IN_RENT | NodeState.WAS_IN_BATTLE,new StateProperties(17,12,NamedLabels.GOLD_PRICE,NodeState.ENOUGH_MONEY,true)),new NodeStateItem(NodeState.UNLOCKED | NodeState.PREMIUM | NodeState.IN_INVENTORY | NodeState.VEHICLE_IN_RENT | NodeState.WAS_IN_BATTLE | NodeState.SELECTED,new StateProperties(18,12,NamedLabels.GOLD_PRICE,NodeState.ENOUGH_MONEY,true))]);
        
        private static var itemStates:Vector.<ResearchStateItem> = Vector.<ResearchStateItem>([new ResearchStateItem(NodeState.LOCKED,new StateProperties(1,0,null,0,true)),new ResearchStateItem(NodeState.NEXT_2_UNLOCK,new StateProperties(2,1,NamedLabels.XP_COST,NodeState.ENOUGH_XP,true)),new UnlockedStateItem(new StateProperties(3,2),new StateProperties(4,8),new StateProperties(5,2),new StateProperties(6,2,NamedLabels.CREDITS_PRICE,NodeState.ENOUGH_MONEY,true)),new InventoryStateItem(new StateProperties(7,2),new StateProperties(8,8),new StateProperties(9,4),new StateProperties(10,4)),new ResearchStateItem(NodeState.UNLOCKED | NodeState.INSTALLED,new StateProperties(11,9,null,NodeState.ENOUGH_MONEY)),new ResearchStateItem(NodeState.UNLOCKED | NodeState.IN_INVENTORY | NodeState.INSTALLED,new StateProperties(12,9,null,NodeState.ENOUGH_MONEY)),new ResearchStateItem(NodeState.UNLOCKED | NodeState.VEHICLE_IN_RENT | NodeState.ELITE | NodeState.PREMIUM,new StateProperties(13,12,null,NodeState.ENOUGH_MONEY))]);
        
        public static function getStateProps(param1:uint, param2:Number, param3:Object) : StateProperties
        {
            var _loc4_:StateProperties = null;
            switch(param1)
            {
                case NodeEntityType.NATION_TREE:
                case NodeEntityType.TOP_VEHICLE:
                case NodeEntityType.NEXT_VEHICLE:
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
        
        public static function getStatePrefix(param1:Number) : String
        {
            var _loc2_:String = statePrefixes[param1];
            return _loc2_ != null?_loc2_:"locked_";
        }
        
        public static function isRedrawNTLines(param1:Number) : Boolean
        {
            return (param1 & NodeState.UNLOCKED) > 0 || (param1 & NodeState.NEXT_2_UNLOCK) > 0 || (param1 & NodeState.IN_INVENTORY) > 0;
        }
        
        public static function isRedrawResearchLines(param1:Number) : Boolean
        {
            return (param1 & NodeState.UNLOCKED) > 0 || (param1 & NodeState.NEXT_2_UNLOCK) > 0;
        }
        
        private static function getNTNodeStateProps(param1:Number) : StateProperties
        {
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
        
        private static function getResearchNodeStateProps(param1:Number, param2:Number, param3:Boolean) : StateProperties
        {
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
        
        private static function getNTNodePrimaryState(param1:Number) : Number
        {
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
            if((param1 & NodeState.SHOP_ACTION) > 0)
            {
                _loc2_ = _loc2_ ^ NodeState.SHOP_ACTION;
            }
            if((param1 & NodeState.VEHICLE_CAN_BE_CHANGED) > 0)
            {
                _loc2_ = _loc2_ ^ NodeState.VEHICLE_CAN_BE_CHANGED;
            }
            return _loc2_;
        }
        
        private static function getResearchNodePrimaryState(param1:Number) : Number
        {
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
            if((param1 & NodeState.SHOP_ACTION) > 0)
            {
                _loc2_ = _loc2_ ^ NodeState.SHOP_ACTION;
            }
            if((param1 & NodeState.VEHICLE_CAN_BE_CHANGED) > 0)
            {
                _loc2_ = _loc2_ ^ NodeState.VEHICLE_CAN_BE_CHANGED;
            }
            if((param1 & NodeState.VEHICLE_IN_RENT) > 0)
            {
                _loc2_ = _loc2_ ^ NodeState.VEHICLE_IN_RENT;
            }
            return _loc2_;
        }
    }
}
