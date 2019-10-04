package net.wg.gui.lobby.battleResults.components
{
    import net.wg.gui.lobby.questsWindow.SubtasksList;
    import net.wg.gui.lobby.interfaces.ISubtaskComponent;
    import flash.events.Event;

    public class MultiColumnSubtasksList extends SubtasksList
    {

        private var _columnCount:int = 1;

        public function MultiColumnSubtasksList()
        {
            super();
        }

        override protected function layoutTasks() : void
        {
            var _loc6_:* = NaN;
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:int = tasks.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                tasks[_loc4_].y = _loc1_;
                tasks[_loc4_].x = _loc2_;
                if((_loc4_ - 1) % this._columnCount == 0)
                {
                    _loc1_ = _loc1_ + tasks[_loc4_].height;
                    _loc2_ = 0;
                }
                else
                {
                    _loc2_ = _loc2_ + tasks[_loc4_].actualWidth;
                }
                _loc4_++;
            }
            var _loc5_:ISubtaskComponent = _loc3_?tasks[_loc3_ - 1]:null;
            if(_loc5_)
            {
                _loc6_ = _loc5_?this._columnCount * _loc5_.actualWidth:this.width;
                setSize(_loc6_,_loc1_);
                dispatchEvent(new Event(Event.RESIZE));
            }
        }

        public function setColumns(param1:int) : void
        {
            this._columnCount = param1;
        }
    }
}
