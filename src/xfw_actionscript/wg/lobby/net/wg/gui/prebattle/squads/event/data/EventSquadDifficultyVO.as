package net.wg.gui.prebattle.squads.event.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class EventSquadDifficultyVO extends ToolTipVO
    {

        private static const DIFFICULTIES_DATA:String = "difficultiesData";

        public var isCommander:Boolean = false;

        public var difficultyLevel:int = 0;

        public var difficultiesData:DataProvider = null;

        public function EventSquadDifficultyVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == DIFFICULTIES_DATA)
            {
                this.difficultiesData = new DataProvider();
                _loc3_ = param2 as Array;
                App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
                for each(_loc4_ in _loc3_)
                {
                    this.difficultiesData.push(new EventSquadDifficultyRendererVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            if(this.difficultiesData != null)
            {
                for each(_loc1_ in this.difficultiesData)
                {
                    _loc1_.dispose();
                }
                this.difficultiesData.cleanUp();
                this.difficultiesData = null;
            }
            super.onDispose();
        }
    }
}
