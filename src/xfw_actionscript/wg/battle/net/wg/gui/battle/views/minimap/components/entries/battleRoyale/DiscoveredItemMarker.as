package net.wg.gui.battle.views.minimap.components.entries.battleRoyale
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import scaleform.clik.motion.Tween;
    import net.wg.infrastructure.managers.IAtlasManager;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import flash.display.BlendMode;

    public class DiscoveredItemMarker extends Sprite implements IDisposable
    {

        private static const DELAY_MAX_TIE_MS:int = 500;

        private static const ITESM_WITH_ADD:Vector.<String> = new <String>[BATTLEATLAS.LOOT,BATTLEATLAS.LOOT_BIG,BATTLEATLAS.IMPROVED_LOOT,BATTLEATLAS.IMPROVED_LOOT_BIG];

        private var _fadeInTween:Tween = null;

        private var _fadeOutTween:Tween = null;

        private var _isShown:Boolean = false;

        private var _atlasMgr:IAtlasManager;

        public function DiscoveredItemMarker()
        {
            this._atlasMgr = App.atlasMgr;
            super();
            alpha = 0;
        }

        public function dispose() : void
        {
            this._fadeInTween.dispose();
            this._fadeOutTween.dispose();
            this._fadeInTween = null;
            this._fadeOutTween = null;
            this._atlasMgr = null;
        }

        public function show(param1:String, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc5_:* = 0;
            this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.graphics,"",false,false,true);
            blendMode = ITESM_WITH_ADD.indexOf(param1) >= 0?BlendMode.ADD:BlendMode.NORMAL;
            if(!this._isShown)
            {
                _loc5_ = DELAY_MAX_TIE_MS * Math.random();
                this._fadeInTween = new Tween(param2,this,{"alpha":1});
                this._fadeInTween.onComplete = this.onCompleteFadeInAnim;
                this._fadeInTween.delay = _loc5_;
                this._fadeInTween.paused = false;
                this._fadeOutTween = new Tween(param4,this,{"alpha":0});
                this._fadeOutTween.delay = param3 - _loc5_;
                this._isShown = true;
            }
        }

        private function onCompleteFadeInAnim() : void
        {
            this._fadeOutTween.paused = false;
        }
    }
}
