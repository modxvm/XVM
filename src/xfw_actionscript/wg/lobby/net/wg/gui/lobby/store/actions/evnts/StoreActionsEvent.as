package net.wg.gui.lobby.store.actions.evnts
{
    import flash.events.Event;

    public class StoreActionsEvent extends Event
    {

        public static const ACTION_CLICK:String = "onStoreActionClick";

        public static const BATTLE_TASK_CLICK:String = "onBattleTaskClick";

        public static const ACTION_SEEN:String = "onStoreActionSeen";

        public static const ANIM_FINISHED:String = "onStoreActionFocusAnimFinished";

        public var actionId:String = "";

        public var triggerChainID:String = "";

        public function StoreActionsEvent(param1:String, param2:String, param3:String, param4:Boolean = false, param5:Boolean = false)
        {
            super(param1,param4,param5);
            this.actionId = param2;
            this.triggerChainID = param3;
        }

        override public function clone() : Event
        {
            return new StoreActionsEvent(type,this.actionId,this.triggerChainID,bubbles,cancelable);
        }

        override public function toString() : String
        {
            return formatToString("StoreActionsEvent","type","actionId","triggerChainID","bubbles","cancelable");
        }
    }
}
