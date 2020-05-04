package net.wg.gui.battle.pveEvent.components.eventPlayerLives
{
    import net.wg.infrastructure.base.meta.impl.EventPlayerLivesMeta;
    import net.wg.infrastructure.base.meta.IEventPlayerLivesMeta;
    import flash.display.Sprite;
    import flash.display.MovieClip;

    public class EventPlayerLives extends EventPlayerLivesMeta implements IEventPlayerLivesMeta
    {

        private static const LIVE_UI:String = "EventLiveUI";

        private static const RESPAWN_LIVE_LABEL:String = "Live";

        private static const RESPAWN_DEAD_LABEl:String = "Dead";

        private static const RESPAWN_LOCKED_LABEl:String = "Locked";

        private static const RESPAWN_UNLOCKED_LABEl:String = "Unlocked";

        private static const SPACING:int = 45;

        public var livesContainer:Sprite = null;

        private var _lives:Vector.<MovieClip>;

        public function EventPlayerLives()
        {
            this._lives = new Vector.<MovieClip>();
            super();
        }

        public function as_setCountLives(param1:int, param2:int, param3:int) : void
        {
            var _loc4_:MovieClip = null;
            var _loc5_:int = param1 + param2 + param3;
            var _loc6_:* = 0;
            while(_loc6_ < _loc5_)
            {
                if(_loc6_ == this._lives.length)
                {
                    _loc4_ = App.utils.classFactory.getComponent(LIVE_UI,Sprite);
                    this.livesContainer.addChild(_loc4_);
                    this._lives.push(_loc4_);
                }
                else
                {
                    _loc4_ = this._lives[_loc6_];
                    _loc4_.visible = true;
                }
                if(_loc6_ < param2)
                {
                    _loc4_.gotoAndPlay(RESPAWN_DEAD_LABEl);
                }
                else if(_loc6_ >= param2 + param1)
                {
                    _loc4_.gotoAndStop(RESPAWN_LOCKED_LABEl);
                }
                else if(_loc4_.currentFrameLabel == RESPAWN_LOCKED_LABEl)
                {
                    _loc4_.gotoAndPlay(RESPAWN_UNLOCKED_LABEl);
                }
                else
                {
                    _loc4_.gotoAndStop(RESPAWN_LIVE_LABEL);
                }
                _loc4_.x = _loc6_ * SPACING;
                _loc6_++;
            }
            _loc5_ = this._lives.length;
            while(_loc6_ < _loc5_)
            {
                _loc4_ = this._lives[_loc6_];
                _loc4_.visible = false;
                _loc6_++;
            }
        }

        override protected function onDispose() : void
        {
            this._lives.splice(0,this._lives.length);
            this._lives = null;
            this.livesContainer = null;
            super.onDispose();
        }
    }
}
