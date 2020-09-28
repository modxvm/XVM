package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.gui.battle.components.BattleDisplayable;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.Sprite;
    import scaleform.clik.motion.Tween;
    import flash.text.TextFieldAutoSize;

    public class PostmortemNotification extends BattleDisplayable
    {

        private static const FADE_IN_DURATION:uint = 300;

        private static const VISIBILITY_TIME:uint = 4000;

        private static const FADE_OUT_DURATION:uint = 400;

        private static const FADE_IN_TARGET_ALPHA:uint = 1;

        public var icon:MovieClip = null;

        public var tf:TextField = null;

        public var bg:Sprite = null;

        private var _tweens:Vector.<Tween>;

        public function PostmortemNotification()
        {
            this._tweens = new Vector.<Tween>();
            super();
            this.tf.autoSize = TextFieldAutoSize.CENTER;
            this.tf.text = WT_EVENT.POSTMORTEM_NOTIFICATIONMSG;
        }

        override protected function onDispose() : void
        {
            this.disposeTweens();
            this._tweens = null;
            this.icon = null;
            this.tf = null;
            this.bg = null;
            super.onDispose();
        }

        public function fadeIn() : void
        {
            setCompVisible(true);
            this.disposeTweens();
            alpha = 0;
            this._tweens.push(new Tween(FADE_IN_DURATION,this,{"alpha":FADE_IN_TARGET_ALPHA}));
            App.utils.scheduler.scheduleTask(this.fadeOut,VISIBILITY_TIME);
        }

        private function fadeOut() : void
        {
            this.disposeTweens();
            this._tweens.push(new Tween(FADE_OUT_DURATION,this,{"alpha":0}));
            App.utils.scheduler.scheduleTask(setCompVisible,FADE_OUT_DURATION,false);
        }

        private function disposeTweens() : void
        {
            var _loc1_:Tween = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.paused = true;
                _loc1_.dispose();
            }
            this._tweens.length = 0;
        }
    }
}
