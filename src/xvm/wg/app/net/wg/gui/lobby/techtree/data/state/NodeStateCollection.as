package net.wg.gui.lobby.techtree.data.state 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.techtree.constants.*;
    
    public class NodeStateCollection extends Object
    {
        public function NodeStateCollection()
        {
            super();
            return;
        }

        public static function getStateProps(arg1:uint, arg2:Number, arg3:Object):net.wg.gui.lobby.techtree.data.state.StateProperties
        {
            var loc1:*=null;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.NATION_TREE:
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.TOP_VEHICLE:
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.NEXT_VEHICLE:
                {
                    loc1 = getNTNodeStateProps(arg2);
                    break;
                }
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.RESEARCH_ROOT:
                {
                    loc1 = getNTNodeStateProps(arg2);
                    break;
                }
                case net.wg.gui.lobby.techtree.constants.NodeEntityType.RESEARCH_ITEM:
                {
                    loc1 = getResearchNodeStateProps(arg2, arg3.rootState, arg3.isParentUnlocked);
                    break;
                }
            }
            if (loc1 == null) 
            {
                loc1 = new net.wg.gui.lobby.techtree.data.state.StateProperties(0, 0);
            }
            return loc1;
        }

        public static function getStatePrefix(arg1:Number):String
        {
            var loc1:*=statePrefixes[arg1];
            return loc1 == null ? "locked_" : loc1;
        }

        public static function isRedrawNTLines(arg1:Number):Boolean
        {
            return (arg1 & net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED) > 0 || (arg1 & net.wg.gui.lobby.techtree.constants.NodeState.NEXT_2_UNLOCK) > 0 || (arg1 & net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY) > 0;
        }

        public static function isRedrawResearchLines(arg1:Number):Boolean
        {
            return (arg1 & net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED) > 0 || (arg1 & net.wg.gui.lobby.techtree.constants.NodeState.NEXT_2_UNLOCK) > 0;
        }

        internal static function getNTNodeStateProps(arg1:Number):net.wg.gui.lobby.techtree.data.state.StateProperties
        {
            var loc1:*=null;
            var loc2:*=getNTNodePrimaryState(arg1);
            var loc3:*=nationNodeStates.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc1 = nationNodeStates[loc4];
                if (loc2 == loc1.getState()) 
                {
                    return loc1.getProps();
                }
                ++loc4;
            }
            return nationNodeStates[0].getProps();
        }

        internal static function getResearchNodeStateProps(arg1:Number, arg2:Number, arg3:Boolean):net.wg.gui.lobby.techtree.data.state.StateProperties
        {
            var loc1:*=null;
            var loc2:*=getResearchNodePrimaryState(arg1);
            var loc3:*=itemStates.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc1 = itemStates[loc4];
                if (loc2 == loc1.getState()) 
                {
                    return loc1.resolveProps(arg1, arg2, arg3);
                }
                ++loc4;
            }
            return itemStates[0].getProps();
        }

        internal static function getNTNodePrimaryState(arg1:Number):Number
        {
            var loc1:*=arg1;
            if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_XP) > 0) 
            {
                loc1 = loc1 ^ net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_XP;
            }
            if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY) > 0) 
            {
                loc1 = loc1 ^ net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY;
            }
            if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.ELITE) > 0) 
            {
                loc1 = loc1 ^ net.wg.gui.lobby.techtree.constants.NodeState.ELITE;
            }
            if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.CAN_SELL) > 0) 
            {
                loc1 = loc1 ^ net.wg.gui.lobby.techtree.constants.NodeState.CAN_SELL;
            }
            return loc1;
        }

        internal static function getResearchNodePrimaryState(arg1:Number):Number
        {
            var loc1:*=arg1;
            if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_XP) > 0) 
            {
                loc1 = loc1 ^ net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_XP;
            }
            if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY) > 0) 
            {
                loc1 = loc1 ^ net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY;
            }
            if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.AUTO_UNLOCKED) > 0) 
            {
                loc1 = loc1 ^ net.wg.gui.lobby.techtree.constants.NodeState.AUTO_UNLOCKED;
            }
            if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.CAN_SELL) > 0) 
            {
                loc1 = loc1 ^ net.wg.gui.lobby.techtree.constants.NodeState.CAN_SELL;
            }
            return loc1;
        }

        internal static const statePrefixes:Array=["locked_", "next2unlock_", "next4buy_", "premium_", "inventory_", "inventory_cur_", "inventory_prem_", "inventory_prem_cur_", "auto_unlocked_", "installed_", "installed_plocked_", "was_in_battle_sell_"];

        internal static const animation:net.wg.gui.lobby.techtree.data.state.AnimationProperties=new net.wg.gui.lobby.techtree.data.state.AnimationProperties(150, {"alpha":0}, {"alpha":1});

        internal static const nationNodeStates:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.data.state.NodeStateItem>=Vector.<net.wg.gui.lobby.techtree.data.state.NodeStateItem>([new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.LOCKED, new net.wg.gui.lobby.techtree.data.state.StateProperties(1, 0, null, 0, false, null, 0.4)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.NEXT_2_UNLOCK, new net.wg.gui.lobby.techtree.data.state.StateProperties(2, 1, net.wg.gui.lobby.techtree.constants.NamedLabels.XP_COST, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_XP, true)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED, new net.wg.gui.lobby.techtree.data.state.StateProperties(3, 2, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, true)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.WAS_IN_BATTLE, new net.wg.gui.lobby.techtree.data.state.StateProperties(4, 11, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, true, animation)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.PREMIUM, new net.wg.gui.lobby.techtree.data.state.StateProperties(5, 3, net.wg.gui.lobby.techtree.constants.NamedLabels.GOLD_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, true)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.PREMIUM | net.wg.gui.lobby.techtree.constants.NodeState.WAS_IN_BATTLE, new net.wg.gui.lobby.techtree.data.state.StateProperties(6, 3, net.wg.gui.lobby.techtree.constants.NamedLabels.GOLD_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, true)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY, new net.wg.gui.lobby.techtree.data.state.StateProperties(7, 4, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, false)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY | net.wg.gui.lobby.techtree.constants.NodeState.WAS_IN_BATTLE, new net.wg.gui.lobby.techtree.data.state.StateProperties(8, 4, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, false)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY | net.wg.gui.lobby.techtree.constants.NodeState.SELECTED, new net.wg.gui.lobby.techtree.data.state.StateProperties(9, 5, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, false)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY | net.wg.gui.lobby.techtree.constants.NodeState.WAS_IN_BATTLE | net.wg.gui.lobby.techtree.constants.NodeState.SELECTED, new net.wg.gui.lobby.techtree.data.state.StateProperties(10, 5, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, false)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.PREMIUM | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY, new net.wg.gui.lobby.techtree.data.state.StateProperties(11, 6, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, false)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.PREMIUM | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY | net.wg.gui.lobby.techtree.constants.NodeState.WAS_IN_BATTLE, new net.wg.gui.lobby.techtree.data.state.StateProperties(12, 6, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, false)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.PREMIUM | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY | net.wg.gui.lobby.techtree.constants.NodeState.SELECTED, new net.wg.gui.lobby.techtree.data.state.StateProperties(13, 7, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, false)), new net.wg.gui.lobby.techtree.data.state.NodeStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.PREMIUM | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY | net.wg.gui.lobby.techtree.constants.NodeState.WAS_IN_BATTLE | net.wg.gui.lobby.techtree.constants.NodeState.SELECTED, new net.wg.gui.lobby.techtree.data.state.StateProperties(14, 7, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, false))]);

        internal static const itemStates:__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.data.state.ResearchStateItem>=Vector.<net.wg.gui.lobby.techtree.data.state.ResearchStateItem>([new net.wg.gui.lobby.techtree.data.state.ResearchStateItem(net.wg.gui.lobby.techtree.constants.NodeState.LOCKED, new net.wg.gui.lobby.techtree.data.state.StateProperties(1, 0, null, 0, true)), new net.wg.gui.lobby.techtree.data.state.ResearchStateItem(net.wg.gui.lobby.techtree.constants.NodeState.NEXT_2_UNLOCK, new net.wg.gui.lobby.techtree.data.state.StateProperties(2, 1, net.wg.gui.lobby.techtree.constants.NamedLabels.XP_COST, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_XP, true)), new net.wg.gui.lobby.techtree.data.state.UnlockedStateItem(new net.wg.gui.lobby.techtree.data.state.StateProperties(3, 2), new net.wg.gui.lobby.techtree.data.state.StateProperties(4, 8), new net.wg.gui.lobby.techtree.data.state.StateProperties(5, 2), new net.wg.gui.lobby.techtree.data.state.StateProperties(6, 2, net.wg.gui.lobby.techtree.constants.NamedLabels.CREDITS_PRICE, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY, true)), new net.wg.gui.lobby.techtree.data.state.InventoryStateItem(new net.wg.gui.lobby.techtree.data.state.StateProperties(7, 2), new net.wg.gui.lobby.techtree.data.state.StateProperties(8, 8), new net.wg.gui.lobby.techtree.data.state.StateProperties(9, 4), new net.wg.gui.lobby.techtree.data.state.StateProperties(10, 4)), new net.wg.gui.lobby.techtree.data.state.ResearchStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.INSTALLED, new net.wg.gui.lobby.techtree.data.state.StateProperties(11, 9, null, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY)), new net.wg.gui.lobby.techtree.data.state.ResearchStateItem(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED | net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY | net.wg.gui.lobby.techtree.constants.NodeState.INSTALLED, new net.wg.gui.lobby.techtree.data.state.StateProperties(12, 9, null, net.wg.gui.lobby.techtree.constants.NodeState.ENOUGH_MONEY))]);
    }
}
