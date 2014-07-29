package net.wg.gui.lobby.battleResults
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import scaleform.clik.constants.InvalidationType;
    
    public class SpecialAchievement extends UIComponent
    {
        
        public function SpecialAchievement()
        {
            super();
        }
        
        public var stripe:MovieClip;
        
        public var loader:UILoaderAlt;
        
        private var _data:Object;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.stripe.visible = this.loader.visible = false;
        }
        
        override protected function draw() : void
        {
            var _loc1_:BattleResultsMedalsListVO = null;
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._data))
            {
                _loc1_ = new BattleResultsMedalsListVO(this._data);
                if(_loc1_.isEpic)
                {
                    this.stripe.visible = true;
                }
                else if(_loc1_.specialIcon)
                {
                    this.loader.visible = true;
                    this.loader.source = _loc1_.specialIcon;
                }
                else
                {
                    this.stripe.visible = this.loader.visible = false;
                }
                
            }
        }
        
        public function set data(param1:Object) : void
        {
            this._data = param1;
            invalidateData();
        }
        
        override protected function onDispose() : void
        {
            this.stripe = null;
            this.loader.dispose();
            this.loader = null;
            this._data = null;
            super.onDispose();
        }
    }
}
