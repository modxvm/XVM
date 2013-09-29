package net.wg.gui.prebattle.battleSession 
{
    import flash.events.*;
    import net.wg.gui.lobby.battleResults.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.gfx.*;
    
    public class FlagsList extends net.wg.gui.lobby.battleResults.MedalsList
    {
        public function FlagsList()
        {
            super();
            return;
        }

        protected override function dispatchItemEvent(arg1:flash.events.Event):Boolean
        {
            var loc1:*=null;
            var loc7:*=arg1.type;
            switch (loc7) 
            {
                case scaleform.clik.events.ButtonEvent.PRESS:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_PRESS;
                    break;
                }
                case scaleform.clik.events.ButtonEvent.CLICK:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_CLICK;
                    break;
                }
                case flash.events.MouseEvent.ROLL_OVER:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_ROLL_OVER;
                    break;
                }
                case flash.events.MouseEvent.ROLL_OUT:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_ROLL_OUT;
                    break;
                }
                case flash.events.MouseEvent.DOUBLE_CLICK:
                {
                    loc1 = scaleform.clik.events.ListEvent.ITEM_DOUBLE_CLICK;
                    break;
                }
                default:
                {
                    return true;
                }
            }
            var loc2:*=arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer;
            var loc3:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
            {
                loc3 = (arg1 as scaleform.clik.events.ButtonEvent).controllerIdx;
            }
            else if (arg1 is scaleform.gfx.MouseEventEx) 
            {
                loc3 = (arg1 as scaleform.gfx.MouseEventEx).mouseIdx;
            }
            var loc4:*=0;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
            {
                loc4 = (arg1 as scaleform.clik.events.ButtonEvent).buttonIdx;
            }
            else if (arg1 is scaleform.gfx.MouseEventEx) 
            {
                loc4 = (arg1 as scaleform.gfx.MouseEventEx).buttonIdx;
            }
            var loc5:*=false;
            if (arg1 is scaleform.clik.events.ButtonEvent) 
            {
                loc5 = (arg1 as scaleform.clik.events.ButtonEvent).isKeyboard;
            }
            var loc6:*=new scaleform.clik.events.ListEvent(loc1, false, true, loc2.index, 0, loc2.index, loc2, dataProvider[loc2.index], loc3, loc4, loc5);
            if (loc1 != scaleform.clik.events.ListEvent.ITEM_ROLL_OVER) 
            {
                if (loc1 == scaleform.clik.events.ListEvent.ITEM_ROLL_OUT) 
                {
                    App.toolTipMgr.hide();
                }
            }
            else 
            {
                App.toolTipMgr.show(dataProvider[loc2.index].tooltip);
            }
            return dispatchEvent(loc6);
        }
    }
}
