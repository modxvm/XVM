package net.wg.gui.battle.eventBattle.views
{
    import net.wg.infrastructure.base.meta.impl.WTEventPlayerLivesMeta;
    import net.wg.infrastructure.base.meta.IWTEventPlayerLivesMeta;
    import flash.display.Sprite;
    import flash.display.MovieClip;

    public class EventPlayerLives extends WTEventPlayerLivesMeta implements IWTEventPlayerLivesMeta
    {

        private static const LIVE_UI:String = "EventLiveUI";

        private static const RESPAWN_LIVE_LABEL:String = "Live";

        private static const RESPAWN_DEAD_LABEl:String = "Dead";

        private static const SPACING:int = 45;

        public var livesContainer:Sprite = null;

        private var _lives:Vector.<MovieClip>;

        public function EventPlayerLives()
        {
            this._lives = new Vector.<MovieClip>();
            super();
        }

        public function as_setCountLives(param1:int, param2:int) : void
        {
            var _loc3_:MovieClip = null;
            var _loc4_:int = param1 + param2;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                if(_loc5_ == this._lives.length)
                {
                    _loc3_ = App.utils.classFactory.getComponent(LIVE_UI,Sprite);
                    this.livesContainer.addChild(_loc3_);
                    this._lives.push(_loc3_);
                }
                else
                {
                    _loc3_ = this._lives[_loc5_];
                    _loc3_.visible = true;
                }
                if(_loc5_ < param2)
                {
                    _loc3_.gotoAndPlay(RESPAWN_DEAD_LABEl);
                }
                else
                {
                    _loc3_.gotoAndStop(RESPAWN_LIVE_LABEL);
                }
                _loc3_.x = _loc5_ * SPACING;
                _loc5_++;
            }
            _loc4_ = this._lives.length;
            while(_loc5_ < _loc4_)
            {
                _loc3_ = this._lives[_loc5_];
                _loc3_.visible = false;
                _loc5_++;
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
