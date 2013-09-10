package net.wg.infrastructure.managers.utils.impl 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import net.wg.utils.*;
    import scaleform.gfx.*;
    
    public class IME extends Object implements net.wg.utils.IIME
    {
        public function IME()
        {
            super();
            this._container = new flash.display.Sprite();
            this._container.visible = false;
            return;
        }

        public function init(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this._container && arg1) 
            {
                loc1 = new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain, null);
                loc2 = new flash.net.URLRequest("LangBar.swf");
                this._langBarLoader = new flash.display.Loader();
                this._langBarLoader.load(loc2, loc1);
                this._langBarLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.langBarLoaded);
                this._langBarLoader.name = "LangBar";
                this._container.addChild(this._langBarLoader);
                loc3 = new flash.net.URLRequest("StatusWindow.swf");
                this._statusWindowLoader = new flash.display.Loader();
                this._statusWindowLoader.name = "StatusWindow";
                this._statusWindowLoader.load(loc3, loc1);
                this._statusWindowLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.statusWindowLoaded);
                this._container.addChild(this._statusWindowLoader);
            }
            this.initStyle();
            return;
        }

        internal function initStyle():void
        {
            var loc1:*=new scaleform.gfx.IMECandidateListStyle();
            loc1.textColor = 0;
            loc1.selectedTextColor = 16777215;
            loc1.fontSize = 20;
            loc1.backgroundColor = 15725300;
            loc1.selectedBackgroundColor = 9755539;
            loc1.indexBackgroundColor = 12503505;
            loc1.selectedIndexBackgroundColor = 6994017;
            loc1.readingWindowTextColor = 0;
            loc1.readingWindowBackgroundColor = 15725300;
            loc1.readingWindowFontSize = 30;
            scaleform.gfx.IMEEx.setIMECandidateListStyle(loc1);
            return;
        }

        internal function langBarLoaded(arg1:flash.events.Event):void
        {
            var loc1:*=flash.display.LoaderInfo(arg1.currentTarget);
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.langBarLoaded);
            this.langBar = arg1.currentTarget.content;
            this.langBar.setOwner(this);
            this.updateStyle();
            return;
        }

        internal function statusWindowLoaded(arg1:flash.events.Event):void
        {
            var loc1:*=flash.display.LoaderInfo(arg1.currentTarget);
            loc1.removeEventListener(flash.events.Event.COMPLETE, this.statusWindowLoaded);
            this.statusWinContainer = arg1.currentTarget.content;
            this.updateStyle();
            return;
        }

        internal function updateStyle():void
        {
            if (!(this.langBar == null) && !(this.statusWinContainer == null)) 
            {
                this.langBar.SetBackgroundColor(14608366, 5619932);
                this.langBar.SetTextColor(5592921, 16777215);
                this.statusWinContainer.SetBackgroundColor(14608366, 5619932);
                this.statusWinContainer.SetTextColor(5592921, 16777215);
                this.langBar.x = 0;
                this.langBar.y = 0;
                this.statusWinContainer.x = this.langBar.x + this.langBar.width;
                this.statusWinContainer.y = 0;
                this.langBar.SetTextColor(this.TextColor, this.TextColorSelected);
                this.langBar.SetBackgroundColor(this.BGColor, this.BGColorOnOver);
                this.statusWinContainer.SetTextColor(this.TextColor, this.TextColorSelected);
                this.statusWinContainer.SetBackgroundColor(this.BGColor, this.BGColorOnOver);
            }
            return;
        }

        public function setVisible(arg1:Boolean):void
        {
            if (App.globalVarsMgr.isShowLangaugeBarS()) 
            {
                this._container.visible = arg1;
            }
            return;
        }

        public function getContainer():flash.display.Sprite
        {
            return this._container;
        }

        public function dispose():void
        {
            if (this._container) 
            {
                if (this.langBar) 
                {
                    this._container.removeChild(this.langBar);
                    this.langBar = null;
                }
                if (this.statusWinContainer) 
                {
                    this._container.removeChild(this.statusWinContainer);
                    this.statusWinContainer = null;
                }
                this._container = null;
            }
            if (this._langBarLoader != null) 
            {
                this._langBarLoader.unloadAndStop();
                this._langBarLoader = null;
            }
            if (this._statusWindowLoader != null) 
            {
                this._statusWindowLoader.unloadAndStop();
                this._statusWindowLoader = null;
            }
            return;
        }

        public function onLangBarResize(arg1:Number, arg2:Number):void
        {
            if (this.statusWinContainer != null) 
            {
                this.statusWinContainer.x = arg1;
                this.statusWinContainer.y = arg2;
            }
            return;
        }

        public function onSwitchLanguage():void
        {
            return;
        }

        internal const BGColor:Number=4145200;

        internal const BGColorOnOver:Number=6448204;

        internal const TextColor:Number=16774371;

        internal const TextColorSelected:Number=16777215;

        internal var _container:flash.display.Sprite=null;

        internal var langBar:flash.display.MovieClip=null;

        internal var statusWinContainer:flash.display.MovieClip=null;

        internal var _langBarLoader:flash.display.Loader=null;

        internal var _statusWindowLoader:flash.display.Loader=null;
    }
}
