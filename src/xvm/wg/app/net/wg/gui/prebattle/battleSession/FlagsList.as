package net.wg.gui.prebattle.battleSession
{
    import net.wg.gui.lobby.battleResults.MedalsList;
    import flash.events.Event;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.interfaces.IListItemRenderer;
    import scaleform.gfx.MouseEventEx;
    
    public class FlagsList extends MedalsList
    {
        
        public function FlagsList()
        {
            super();
        }
        
        override protected function dispatchItemEvent(param1:Event) : Boolean
        {
            var _loc2_:String = null;
            switch(param1.type)
            {
                case ButtonEvent.PRESS:
                    _loc2_ = ListEvent.ITEM_PRESS;
                    break;
                case ButtonEvent.CLICK:
                    _loc2_ = ListEvent.ITEM_CLICK;
                    break;
                case MouseEvent.ROLL_OVER:
                    _loc2_ = ListEvent.ITEM_ROLL_OVER;
                    break;
                case MouseEvent.ROLL_OUT:
                    _loc2_ = ListEvent.ITEM_ROLL_OUT;
                    break;
                case MouseEvent.DOUBLE_CLICK:
                    _loc2_ = ListEvent.ITEM_DOUBLE_CLICK;
                    break;
                default:
                    return true;
            }
            var _loc3_:IListItemRenderer = param1.currentTarget as IListItemRenderer;
            var _loc4_:uint = 0;
            if(param1 is ButtonEvent)
            {
                _loc4_ = (param1 as ButtonEvent).controllerIdx;
            }
            else if(param1 is MouseEventEx)
            {
                _loc4_ = (param1 as MouseEventEx).mouseIdx;
            }
            
            var _loc5_:uint = 0;
            if(param1 is ButtonEvent)
            {
                _loc5_ = (param1 as ButtonEvent).buttonIdx;
            }
            else if(param1 is MouseEventEx)
            {
                _loc5_ = (param1 as MouseEventEx).buttonIdx;
            }
            
            var _loc6_:* = false;
            if(param1 is ButtonEvent)
            {
                _loc6_ = (param1 as ButtonEvent).isKeyboard;
            }
            var _loc7_:ListEvent = new ListEvent(_loc2_,false,true,_loc3_.index,0,_loc3_.index,_loc3_,dataProvider[_loc3_.index],_loc4_,_loc5_,_loc6_);
            if(_loc2_ == ListEvent.ITEM_ROLL_OVER)
            {
                App.toolTipMgr.show(dataProvider[_loc3_.index].tooltip);
            }
            else if(_loc2_ == ListEvent.ITEM_ROLL_OUT)
            {
                App.toolTipMgr.hide();
            }
            
            return dispatchEvent(_loc7_);
        }
    }
}
