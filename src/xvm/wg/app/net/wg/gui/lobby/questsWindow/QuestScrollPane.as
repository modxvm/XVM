package net.wg.gui.lobby.questsWindow 
{
    import net.wg.gui.lobby.profile.components.*;
    
    public class QuestScrollPane extends net.wg.gui.lobby.profile.components.ResizableScrollPane
    {
        public function QuestScrollPane()
        {
            super();
            return;
        }

        protected override function applyScrollBarUpdating():void
        {
            var loc1:*=scrollPageSize;
            var loc2:*=0;
            var loc3:*=maxScroll;
            scrollBar.setScrollProperties(loc1, loc2, loc3);
            var loc4:*=(scrollBar.position - loc2) / (loc3 - loc2);
            var loc5:*;
            if (!(loc5 = !(isNaN(loc4) || isNaN(loc1) || loc3 <= 0 || loc3 == Infinity))) 
            {
                _scrollPosition = 0;
            }
            if (_target) 
            {
                _target.y = -_scrollStepFactor * _scrollPosition;
            }
            scrollBar.position = _scrollPosition;
            scrollBar.trackScrollPageSize = loc1;
            return;
        }
    }
}
