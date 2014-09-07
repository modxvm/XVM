package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.fortifications.cmp.build.ICooldownIcon;
    import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicator;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.cmp.build.impl.animationImpl.BuildingsAnimationController;
    import net.wg.gui.lobby.fortifications.cmp.build.IArrowWithNut;
    
    public class FortBuildingUIBase extends UIComponentEx
    {
        
        public function FortBuildingUIBase()
        {
            super();
            this._exportArrow.mouseEnabled = this._exportArrow.mouseChildren = false;
            this._importArrow.mouseEnabled = this._importArrow.mouseChildren = false;
        }
        
        public var cooldownIcon:ICooldownIcon = null;
        
        public var hitAreaControl:HitAreaControl = null;
        
        public var indicators:IBuildingIndicator = null;
        
        public var orderProcess:MovieClip = null;
        
        public var buildingMc:FortBuildingBtn = null;
        
        public var trowel:TrowelCmp = null;
        
        public var ground:MovieClip = null;
        
        public var animationController:BuildingsAnimationController;
        
        private var _exportArrow:IArrowWithNut = null;
        
        private var _importArrow:IArrowWithNut = null;
        
        public function get exportArrow() : IArrowWithNut
        {
            return this._exportArrow;
        }
        
        public function set exportArrow(param1:IArrowWithNut) : void
        {
            this._exportArrow = param1;
        }
        
        public function get importArrow() : IArrowWithNut
        {
            return this._importArrow;
        }
        
        public function set importArrow(param1:IArrowWithNut) : void
        {
            this._importArrow = param1;
        }
        
        override protected function onDispose() : void
        {
            this.hitAreaControl.dispose();
            this.hitAreaControl = null;
            this.indicators.dispose();
            this.indicators = null;
            this.buildingMc.dispose();
            this.buildingMc = null;
            this.trowel.dispose();
            this.trowel = null;
            this.orderProcess = null;
            this._exportArrow.dispose();
            this._exportArrow = null;
            this._importArrow.dispose();
            this._importArrow = null;
            this.cooldownIcon.dispose();
            this.cooldownIcon = null;
            this.ground = null;
            super.onDispose();
        }
    }
}
