package net.wg.gui.lobby.profile.pages.technique
{
    import net.wg.gui.lobby.profile.components.ResizableContent;
    import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
    import net.wg.gui.utils.ExcludeTweenManager;
    import net.wg.gui.components.common.containers.VerticalGroupLayout;
    import fl.transitions.easing.Strong;
    import scaleform.clik.motion.Tween;
    
    public class TechniqueStatisticTab extends ResizableContent
    {
        
        public function TechniqueStatisticTab()
        {
            this.tweenManager = new ExcludeTweenManager();
            super();
            this.alpha = 0;
        }
        
        private static var ANIM_SPEED:Number = 500;
        
        private var _data:ProfileVehicleDossierVO;
        
        private var isDataInitialized:Boolean;
        
        private var tweenManager:ExcludeTweenManager;
        
        private var group:TechDetailedUnitGroup;
        
        override public function update(param1:Object) : void
        {
            var _loc3_:VerticalGroupLayout = null;
            var _loc2_:ProfileVehicleDossierVO = ProfileVehicleDossierVO(param1);
            if(this._data != _loc2_)
            {
                this._data = _loc2_;
                if(_loc2_)
                {
                    if(!this.isDataInitialized)
                    {
                        this.isDataInitialized = true;
                        this.group = new TechDetailedUnitGroup();
                        this.group.unitRendererClass = App.utils.classFactory.getClass("TechnicsDashLineTextItemIRenderer_UI");
                        _loc3_ = new VerticalGroupLayout();
                        _loc3_.gap = 10;
                        this.group.layout = _loc3_;
                        this.group.x = 21;
                        this.group.y = 50;
                        addChild(this.group);
                        this.tweenManager.registerAndLaunch(ANIM_SPEED,this,{"alpha":1},{"ease":Strong.easeOut,
                        "onComplete":this.onTweenComplete
                    });
                }
                this.group.dataProvider = _loc2_.detailedDataList;
            }
        }
    }
    
    private function onTweenComplete(param1:Tween) : void
    {
        this.tweenManager.unregister(param1);
    }
    
    override protected function onDispose() : void
    {
        this.tweenManager.dispose();
        this.tweenManager = null;
        if(this._data)
        {
            this._data.dispose();
            this._data = null;
        }
        super.onDispose();
    }
}
}
