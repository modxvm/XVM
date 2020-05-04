package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventBattleResultScreenMeta extends AbstractScreen
    {

        public var closeView:Function;

        public var addToSquad:Function;

        public var addToFriend:Function;

        public var playSoundFeedback:Function;

        private var _resultDataVO:ResultDataVO;

        private var _array:Array;

        public function EventBattleResultScreenMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._resultDataVO)
            {
                this._resultDataVO.dispose();
                this._resultDataVO = null;
            }
            if(this._array)
            {
                this._array.splice(0,this._array.length);
                this._array = null;
            }
            super.onDispose();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }

        public function addToSquadS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.addToSquad,"addToSquad" + Errors.CANT_NULL);
            this.addToSquad(param1);
        }

        public function addToFriendS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.addToFriend,"addToFriend" + Errors.CANT_NULL);
            this.addToFriend(param1,param2);
        }

        public function playSoundFeedbackS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.playSoundFeedback,"playSoundFeedback" + Errors.CANT_NULL);
            this.playSoundFeedback(param1);
        }

        public final function as_setVictoryData(param1:Object, param2:Boolean, param3:Array) : void
        {
            var _loc4_:ResultDataVO = this._resultDataVO;
            this._resultDataVO = new ResultDataVO(param1);
            var _loc5_:Array = this._array;
            this._array = param3;
            this.setVictoryData(this._resultDataVO,param2,this._array);
            if(_loc4_)
            {
                _loc4_.dispose();
            }
            if(_loc5_)
            {
                _loc5_.splice(0,_loc5_.length);
            }
        }

        protected function setVictoryData(param1:ResultDataVO, param2:Boolean, param3:Array) : void
        {
            var _loc4_:String = "as_setVictoryData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc4_);
            throw new AbstractException(_loc4_);
        }
    }
}
