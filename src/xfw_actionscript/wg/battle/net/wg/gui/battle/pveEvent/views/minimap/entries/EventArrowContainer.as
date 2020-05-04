package net.wg.gui.battle.pveEvent.views.minimap.entries
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.managers.IAtlasManager;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.data.constants.Values;

    public class EventArrowContainer extends MovieClip implements IDisposable
    {

        public var mc:MovieClip = null;

        public var mcBottom:MovieClip = null;

        public var mcTop:MovieClip = null;

        private var _atlasManager:IAtlasManager;

        public function EventArrowContainer()
        {
            this._atlasManager = App.atlasMgr;
            super();
            stop();
        }

        public function setBlinking() : void
        {
            gotoAndPlay(1);
        }

        public function setIcon(param1:String) : void
        {
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.mc.graphics,Values.EMPTY_STR,true,false,false);
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.mcBottom.graphics,Values.EMPTY_STR,true,false,false);
            this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.mcTop.graphics,Values.EMPTY_STR,true,false,false);
        }

        public final function dispose() : void
        {
            this.mcBottom = null;
            this.mc = null;
            this.mcTop = null;
            this._atlasManager = null;
        }
    }
}
