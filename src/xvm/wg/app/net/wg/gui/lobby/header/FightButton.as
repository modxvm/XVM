package net.wg.gui.lobby.header
{
    import net.wg.gui.components.controls.SoundButton;
    import net.wg.gui.interfaces.IHelpLayoutComponent;
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import net.wg.utils.IHelpLayout;
    import net.wg.data.constants.Directions;
    
    public class FightButton extends SoundButton implements IHelpLayoutComponent
    {
        
        public function FightButton()
        {
            super();
        }
        
        private var _buttonHelpLayout:DisplayObject;
        
        public function getRectangle() : Rectangle
        {
            var _loc1_:Rectangle = new Rectangle();
            _loc1_.x = this.x + hitMc.x;
            _loc1_.width = hitMc.width;
            return _loc1_;
        }
        
        public function showHelpLayout() : void
        {
            App.popoverMgr.hide();
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            var _loc2_:Object = _loc1_.getProps(this.hitMc.width,this.hitMc.height,Directions.BOTTOM,LOBBY_HELP.HEADER_FIGHT_BUTTON,0,0,37);
            this._buttonHelpLayout = _loc1_.create(root,_loc2_,this.hitMc);
        }
        
        public function closeHelpLayout() : void
        {
            var _loc1_:IHelpLayout = null;
            if(this._buttonHelpLayout)
            {
                _loc1_ = App.utils.helpLayout;
                _loc1_.destroy(this._buttonHelpLayout);
            }
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this._buttonHelpLayout = null;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
    }
}
