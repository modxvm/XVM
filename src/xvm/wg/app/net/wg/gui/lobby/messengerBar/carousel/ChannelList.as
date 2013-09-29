package net.wg.gui.lobby.messengerBar.carousel 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.messengerBar.carousel.events.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.gfx.*;
    
    public class ChannelList extends net.wg.gui.components.controls.TileList
    {
        public function ChannelList()
        {
            super();
            return;
        }

        protected override function setupRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            super.setupRenderer(arg1);
            var loc1:*=arg1 as net.wg.gui.lobby.messengerBar.carousel.ChannelRenderer;
            loc1.openButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onItemOpenClick);
            loc1.closeButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onItemCloseClick);
            return;
        }

        protected override function cleanUpRenderer(arg1:scaleform.clik.interfaces.IListItemRenderer):void
        {
            super.cleanUpRenderer(arg1);
            var loc1:*=arg1 as net.wg.gui.lobby.messengerBar.carousel.ChannelRenderer;
            loc1.openButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onItemOpenClick);
            loc1.closeButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onItemCloseClick);
            return;
        }

        internal function onItemOpenClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(this.generateEvent(net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent.OPEN_CHANNEL_CLICK, arg1));
            return;
        }

        internal function onItemCloseClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(this.generateEvent(net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent.CLOSE_CHANNEL_CLICK, arg1));
            return;
        }

        internal function generateEvent(arg1:String, arg2:flash.events.Event):net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent
        {
            var loc1:*=arg2.currentTarget.parent as scaleform.clik.interfaces.IListItemRenderer;
            var loc2:*=0;
            if (arg2 is scaleform.clik.events.ButtonEvent) 
            {
                loc2 = (arg2 as scaleform.clik.events.ButtonEvent).controllerIdx;
            }
            else if (arg2 is scaleform.gfx.MouseEventEx) 
            {
                loc2 = (arg2 as scaleform.gfx.MouseEventEx).mouseIdx;
            }
            var loc3:*=0;
            if (arg2 is scaleform.clik.events.ButtonEvent) 
            {
                loc3 = (arg2 as scaleform.clik.events.ButtonEvent).buttonIdx;
            }
            else if (arg2 is scaleform.gfx.MouseEventEx) 
            {
                loc3 = (arg2 as scaleform.gfx.MouseEventEx).buttonIdx;
            }
            var loc4:*=false;
            if (arg2 is scaleform.clik.events.ButtonEvent) 
            {
                loc4 = (arg2 as scaleform.clik.events.ButtonEvent).isKeyboard;
            }
            var loc5:*;
            return loc5 = new net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent(arg1, false, true, loc1.index, 0, loc1.index, loc1, dataProvider.requestItemAt(loc1.index), loc2, loc3, loc4);
        }
    }
}
