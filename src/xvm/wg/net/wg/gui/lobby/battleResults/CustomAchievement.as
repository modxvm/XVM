package net.wg.gui.lobby.battleResults 
{
    import net.wg.data.VO.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    
    public class CustomAchievement extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function CustomAchievement()
        {
            super();
            this.loader.hideLoader = false;
            return;
        }

        public override function dispose():void
        {
            if (this.loader) 
            {
                this.loader.dispose();
                this.loader.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onComplete);
                this.loader = null;
            }
            super.dispose();
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            this.data = arg1;
            this._dataDirty = true;
            this.drawLoader();
            return;
        }

        protected function drawLoader():void
        {
            if (this._dataDirty) 
            {
                if (data == null) 
                    return;
                if (this.getDataOwnValue("isRare", false)) 
                    this.tryToLoadRareAchievement();
                else if (!(this.loader == null) && data.icon) 
                {
                    this.loader.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onComplete);
                    if (data.icon is net.wg.data.VO.IconVO) 
                        this.loader.source = data.icon.big;
                    else 
                        this.loader.source = data.icon;
                }
                this._dataDirty = false;
            }
            return;
        }

        protected function tryToLoadRareAchievement():void
        {
            if (this.getDataOwnValue("rareIconId", null)) 
            {
                this.loader.source = "img://" + data.rareIconId;
                this.loader.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onComplete);
            }
            return;
        }

        protected function getDataOwnValue(arg1:String, arg2:*):*
        {
            var loc1:*=undefined;
            if (data) 
            {
                loc1 = data.hasOwnProperty(arg1) ? data[arg1] : arg2;
                if (loc1 is Function) 
                    return loc1();
            }
            return loc1;
        }

        internal function changeSaturation():void
        {
            this.loader.alpha = 0.9;
            App.utils.commons.setSaturation(this.loader, 0);
            return;
        }

        protected function onComplete(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.loader.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onComplete);
            if (data.hasOwnProperty("inactive") && data.inactive) 
                this.changeSaturation();
            return;
        }

        public var loader:net.wg.gui.components.controls.UILoaderAlt;

        protected var _dataDirty:Boolean=false;
    }
}
