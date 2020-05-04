package net.wg.gui.battle.pveEvent.views.minimap.entries
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.Sprite;
    import net.wg.infrastructure.managers.IAtlasManager;
    import scaleform.clik.motion.Tween;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;

    public class EventCustomMinimapEntry extends BattleUIComponent
    {

        public var atlasPlaceholder:Sprite = null;

        private var _atlasManager:IAtlasManager;

        private var _hideTween:Tween = null;

        private var _inTween:Tween = null;

        private var _tweenTime:int = 0;

        public function EventCustomMinimapEntry()
        {
            this._atlasManager = App.atlasMgr;
            super();
        }

        public function setIcon(param1:String) : void
        {
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.atlasPlaceholder.graphics,"",true);
        }

        public function setBlinking(param1:Boolean, param2:int = 0) : void
        {
            if(param1)
            {
                this._tweenTime = param2 >> 1;
                if(!this._inTween)
                {
                    this._hideTween = new Tween(this._tweenTime,this.atlasPlaceholder,{"alpha":0},{"onComplete":this.onFadeOutTweenComplete});
                    this._hideTween.paused = true;
                    this._inTween = new Tween(this._tweenTime,this.atlasPlaceholder,{"alpha":1},{"onComplete":this.onFadeInTweenComplete});
                    this._inTween.paused = true;
                }
                else
                {
                    this._hideTween.duration = this._tweenTime;
                    this._inTween.duration = this._tweenTime;
                }
                this.onFadeInTweenComplete();
            }
            else
            {
                if(this._inTween)
                {
                    this._inTween.paused = true;
                    this._hideTween.paused = true;
                }
                this.atlasPlaceholder.alpha = 1;
            }
        }

        private function onFadeInTweenComplete() : void
        {
            this._inTween.paused = true;
            this._hideTween.position = 0;
            this._hideTween.paused = false;
        }

        private function onFadeOutTweenComplete() : void
        {
            this._hideTween.paused = true;
            this._inTween.position = 0;
            this._inTween.paused = false;
        }

        override protected function onDispose() : void
        {
            this.atlasPlaceholder = null;
            this._atlasManager = null;
            if(this._inTween)
            {
                this._inTween.paused = true;
                this._inTween.dispose();
                this._inTween = null;
            }
            if(this._hideTween)
            {
                this._hideTween.paused = true;
                this._hideTween.dispose();
                this._hideTween = null;
            }
            super.onDispose();
        }
    }
}
