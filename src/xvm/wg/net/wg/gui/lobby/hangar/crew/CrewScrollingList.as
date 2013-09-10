package net.wg.gui.lobby.hangar.crew 
{
    import net.wg.gui.components.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class CrewScrollingList extends net.wg.gui.components.controls.ScrollingListEx
    {
        public function CrewScrollingList()
        {
            super();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=getRendererAt(_selectedIndex, _scrollPosition);
            if (loc1 != null) 
            {
                loc1.handleInput(arg1);
                if (arg1.handled) 
                    return;
            }
            return;
        }
    }
}
