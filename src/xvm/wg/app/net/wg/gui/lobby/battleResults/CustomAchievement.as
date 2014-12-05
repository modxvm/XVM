package net.wg.gui.lobby.battleResults
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.data.VO.IconVO;
    
    public class CustomAchievement extends SoundListItemRenderer
    {
        
        public function CustomAchievement()
        {
            super();
            this.loader.hideLoader = false;
        }
        
        public static function getDataOwnValue(param1:Object, param2:String, param3:*) : *
        {
            var _loc4_:* = undefined;
            if(param1)
            {
                _loc4_ = param1.hasOwnProperty(param2)?param1[param2]:param3;
                if(_loc4_ is Function)
                {
                    return _loc4_();
                }
            }
            return _loc4_;
        }
        
        public var loader:UILoaderAlt;
        
        public var useBigIcon:Boolean = false;
        
        protected var _dataDirty:Boolean = false;
        
        override public function setData(param1:Object) : void
        {
            if(param1 == null)
            {
                return;
            }
            this.data = param1;
            this._dataDirty = true;
            this.drawLoader();
        }
        
        override protected function onDispose() : void
        {
            if(this.loader)
            {
                this.loader.dispose();
                this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onComplete);
                this.loader = null;
            }
            super.onDispose();
        }
        
        protected function drawLoader() : void
        {
            if(this._dataDirty)
            {
                if(data == null)
                {
                    return;
                }
                if(getDataOwnValue(data,"isRare",false))
                {
                    this.tryToLoadRareAchievement();
                }
                else if(!(this.loader == null) && (data.icon))
                {
                    this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onComplete);
                    if(data.icon is IconVO)
                    {
                        if(this.useBigIcon)
                        {
                            this.loader.source = data.icon.big;
                        }
                        else
                        {
                            this.loader.source = data.icon.small;
                        }
                    }
                    else
                    {
                        this.loader.source = data.icon;
                    }
                }
                
                this._dataDirty = false;
            }
        }
        
        protected function tryToLoadRareAchievement() : void
        {
            if(getDataOwnValue(data,"rareIconId",null))
            {
                this.loader.source = "img://" + data.rareIconId;
                this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onComplete);
            }
        }
        
        private function changeSaturation() : void
        {
            this.loader.alpha = 0.9;
            App.utils.commons.setSaturation(this.loader,0);
        }
        
        protected function onComplete(param1:UILoaderEvent) : void
        {
            this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onComplete);
            if((data.hasOwnProperty("inactive")) && (data.inactive))
            {
                this.changeSaturation();
            }
        }
    }
}
