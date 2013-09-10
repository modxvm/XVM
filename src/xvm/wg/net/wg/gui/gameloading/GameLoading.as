package net.wg.gui.gameloading 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.common.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    
    public class GameLoading extends scaleform.clik.core.UIComponent
    {
        public function GameLoading()
        {
            super();
            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            return;
        }

        internal function relayout():void
        {
            var loc3:*=NaN;
            var loc4:*=null;
            var loc1:*=this.appWidth - MIN_APP_WIDTH >> 1;
            var loc2:*=this.appHeight - MIN_APP_HEIGHT >> 1;
            this.versionTF.x = this.initVersionTFPos.x - loc1;
            this.versionTF.y = this.initVersionTFPos.y - loc2;
            this.form.y = this.wotLogo.y + FORM_VERTICAL_OFFSET ^ 0;
            this.copyright.y = this.initCopyrightPos.y + loc2;
            if (this.isKorea) 
            {
                this.ageRating.x = this.initAgeRatingPos.x + loc1;
                this.ageRating.y = this.initAgeRatingPos.y - loc2;
                this.infoTF.x = INFO_TEXT_PADDING - (this.appWidth >> 1);
                this.infoTF.width = this.appWidth - 2 * INFO_TEXT_PADDING;
                loc3 = this.appHeight - this.copyright.height - this.form.y - this.infoTF.y - loc2;
                loc4 = this.infoTF.getTextFormat();
                if (this.infoTF.textHeight >= loc3) 
                {
                    while (this.infoTF.textHeight >= loc3) 
                    {
                        loc4.size = (int(loc4.size) - 1);
                        this.infoTF.setTextFormat(loc4);
                    }
                }
                else 
                {
                    while (this.infoTF.textHeight <= loc3 && loc4.size < MAX_INFO_FONT_SIZE) 
                    {
                        loc4.size = int(loc4.size) + 1;
                        this.infoTF.setTextFormat(loc4);
                    }
                }
                this.infoTF.height = this.infoTF.textHeight + 10;
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALID_VERSION)) 
            {
                this.versionTF.text = this._version;
            }
            if (isInvalid(INVALID_PROGRESS)) 
            {
                this.progressBar.position = this._progress;
            }
            if (isInvalid(INVALID_LOCALE) && this.isLocaleSet) 
            {
                if (this._locale) 
                {
                    this.wotLogo.setLocale(this._locale);
                    this.bottomLogos.setLocale(this._locale);
                }
                this.isKorea = this._locale == net.wg.data.constants.Locales.KOREA;
                if (this.isKorea) 
                {
                    var loc1:*;
                    this.infoTF.visible = loc1 = true;
                    this.ageRating.visible = loc1;
                    this.infoTF.htmlText = MENU.LOADING_GAMEINFO;
                    this.copyright.removeChild(this.awardsLoader);
                }
                else 
                {
                    this.awardsLoader.visible = true;
                    this.awardsLoader.source = AWARDS_PATH;
                }
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE) && !isNaN(this.appWidth) && !isNaN(this.appHeight)) 
            {
                this.relayout();
            }
            return;
        }

        internal function onAwardsLoaded(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.awardsLoader.x = -(this.awardsLoader.width >> 1);
            this.awardsLoader.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onAwardsLoaded);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.progressBar = this.form.progressBar;
            this.infoTF = this.form.infoTF;
            this.awardsLoader = this.copyright.awards;
            this.bottomLogos = this.copyright.logos;
            this.progressBar.maximum = 1;
            var loc1:*;
            this.infoTF.visible = loc1 = false;
            this.ageRating.visible = loc1;
            this.awardsLoader.visible = false;
            this.initVersionTFPos = new flash.geom.Point(this.versionTF.x, this.versionTF.y);
            this.initCopyrightPos = new flash.geom.Point(this.copyright.x, this.copyright.y);
            this.initAgeRatingPos = new flash.geom.Point(this.ageRating.x, this.ageRating.y);
            this.awardsLoader.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onAwardsLoaded);
            return;
        }

        public function cleanup():void
        {
            this.awardsLoader.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onAwardsLoaded);
            this.awardsLoader.dispose();
            return;
        }

        public function updateStage(arg1:Number, arg2:Number):void
        {
            this.appWidth = arg1;
            this.appHeight = arg2;
            invalidateSize();
            return;
        }

        public function setProgress(arg1:Number):void
        {
            this._progress = arg1;
            invalidate(INVALID_PROGRESS);
            return;
        }

        public function setLocale(arg1:String):void
        {
            this._locale = arg1;
            this.isLocaleSet = true;
            invalidate(INVALID_LOCALE);
            return;
        }

        public function setVersion(arg1:String):void
        {
            this._version = arg1;
            invalidate(INVALID_VERSION);
            return;
        }

        internal static const MAX_INFO_FONT_SIZE:Number=64;

        internal static const AWARDS_PATH:String="../maps/loading_award.png";

        internal static const INVALID_VERSION:String="invalidVersion";

        internal static const INVALID_PROGRESS:String="invalidProgress";

        internal static const INVALID_LOCALE:String="invalidLocale";

        internal static const MIN_APP_WIDTH:Number=1024;

        internal static const MIN_APP_HEIGHT:Number=768;

        internal static const FORM_VERTICAL_OFFSET:Number=52;

        internal static const INFO_TEXT_PADDING:Number=20;

        public var versionTF:flash.text.TextField;

        public var background:net.wg.gui.components.controls.UILoaderAlt;

        public var wotLogo:net.wg.gui.components.common.BaseLogoView;

        public var form:flash.display.MovieClip;

        public var copyright:flash.display.MovieClip;

        public var ageRating:flash.display.Sprite;

        internal var progressBar:scaleform.clik.controls.StatusIndicator;

        internal var awardsLoader:net.wg.gui.components.controls.UILoaderAlt;

        internal var infoTF:flash.text.TextField;

        internal var initVersionTFPos:flash.geom.Point;

        internal var bottomLogos:net.wg.gui.components.common.BaseLogoView;

        internal var _progress:Number;

        internal var _version:String;

        internal var isLocaleSet:Boolean=false;

        internal var isKorea:Boolean;

        internal var appHeight:Number;

        internal var appWidth:Number;

        internal var initAgeRatingPos:flash.geom.Point;

        internal var initCopyrightPos:flash.geom.Point;

        internal var _locale:String;
    }
}
