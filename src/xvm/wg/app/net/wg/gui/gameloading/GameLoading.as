package net.wg.gui.gameloading
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.common.BaseLogoView;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import scaleform.clik.controls.StatusIndicator;
   import flash.geom.Point;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.data.constants.Locales;
   import scaleform.clik.constants.InvalidationType;
   import flash.text.TextFormat;
   import flash.display.StageScaleMode;
   
   public class GameLoading extends UIComponent
   {
      
      public function GameLoading() {
         super();
         stage.scaleMode = StageScaleMode.NO_SCALE;
      }
      
      private static const AWARDS_PATH:String = "../maps/loading_award.png";
      
      private static const INVALID_VERSION:String = "invalidVersion";
      
      private static const INVALID_PROGRESS:String = "invalidProgress";
      
      private static const INVALID_LOCALE:String = "invalidLocale";
      
      private static const MIN_APP_WIDTH:Number = 1024;
      
      private static const MIN_APP_HEIGHT:Number = 768;
      
      private static const FORM_VERTICAL_OFFSET:Number = 52;
      
      private static const INFO_TEXT_PADDING:Number = 20;
      
      private static const MAX_INFO_FONT_SIZE:Number = 64;
      
      public var versionTF:TextField;
      
      public var background:UILoaderAlt;
      
      public var wotLogo:BaseLogoView;
      
      public var form:MovieClip;
      
      public var copyright:MovieClip;
      
      public var ageRating:Sprite;
      
      private var progressBar:StatusIndicator;
      
      private var awardsLoader:UILoaderAlt;
      
      private var infoTF:TextField;
      
      private var bottomLogos:BaseLogoView;
      
      private var initVersionTFPos:Point;
      
      private var initCopyrightPos:Point;
      
      private var initAgeRatingPos:Point;
      
      private var appWidth:Number;
      
      private var appHeight:Number;
      
      private var isKorea:Boolean;
      
      private var isLocaleSet:Boolean = false;
      
      private var _version:String;
      
      private var _locale:String;
      
      private var _progress:Number;
      
      public function setVersion(param1:String) : void {
         this._version = param1;
         invalidate(INVALID_VERSION);
      }
      
      public function setLocale(param1:String) : void {
         this._locale = param1;
         this.isLocaleSet = true;
         invalidate(INVALID_LOCALE);
      }
      
      public function setProgress(param1:Number) : void {
         this._progress = param1;
         invalidate(INVALID_PROGRESS);
      }
      
      public function updateStage(param1:Number, param2:Number) : void {
         this.appWidth = param1;
         this.appHeight = param2;
         invalidateSize();
      }
      
      public function cleanup() : void {
         this.awardsLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onAwardsLoaded);
         this.awardsLoader.dispose();
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.progressBar = this.form.progressBar;
         this.infoTF = this.form.infoTF;
         this.awardsLoader = this.copyright.awards;
         this.bottomLogos = this.copyright.logos;
         this.progressBar.maximum = 1;
         this.ageRating.visible = this.infoTF.visible = false;
         this.awardsLoader.visible = false;
         this.initVersionTFPos = new Point(this.versionTF.x,this.versionTF.y);
         this.initCopyrightPos = new Point(this.copyright.x,this.copyright.y);
         this.initAgeRatingPos = new Point(this.ageRating.x,this.ageRating.y);
         this.awardsLoader.addEventListener(UILoaderEvent.COMPLETE,this.onAwardsLoaded);
      }
      
      private function onAwardsLoaded(param1:UILoaderEvent) : void {
         this.awardsLoader.x = -(this.awardsLoader.width >> 1);
         this.awardsLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onAwardsLoaded);
      }
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(INVALID_VERSION))
         {
            this.versionTF.text = this._version;
         }
         if(isInvalid(INVALID_PROGRESS))
         {
            this.progressBar.position = this._progress;
         }
         if((isInvalid(INVALID_LOCALE)) && (this.isLocaleSet))
         {
            if(this._locale)
            {
               this.wotLogo.setLocale(this._locale);
               this.bottomLogos.setLocale(this._locale);
            }
            this.isKorea = this._locale == Locales.KOREA;
            if(this.isKorea)
            {
               this.ageRating.visible = this.infoTF.visible = true;
               this.infoTF.htmlText = MENU.LOADING_GAMEINFO;
               this.copyright.removeChild(this.awardsLoader);
            }
            else
            {
               this.awardsLoader.visible = true;
               this.awardsLoader.source = AWARDS_PATH;
            }
         }
         if((isInvalid(InvalidationType.SIZE)) && !isNaN(this.appWidth) && !isNaN(this.appHeight))
         {
            this.relayout();
         }
      }
      
      private function relayout() : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:TextFormat = null;
         var _loc1_:Number = this.appWidth - MIN_APP_WIDTH >> 1;
         _loc2_ = this.appHeight - MIN_APP_HEIGHT >> 1;
         this.versionTF.x = this.initVersionTFPos.x - _loc1_;
         this.versionTF.y = this.initVersionTFPos.y - _loc2_;
         this.form.y = this.wotLogo.y + FORM_VERTICAL_OFFSET ^ 0;
         this.copyright.y = this.initCopyrightPos.y + _loc2_;
         if(this.isKorea)
         {
            this.ageRating.x = this.initAgeRatingPos.x + _loc1_;
            this.ageRating.y = this.initAgeRatingPos.y - _loc2_;
            this.infoTF.x = INFO_TEXT_PADDING - (this.appWidth >> 1);
            this.infoTF.width = this.appWidth - 2 * INFO_TEXT_PADDING;
            _loc3_ = this.appHeight - this.copyright.height - this.form.y - this.infoTF.y - _loc2_;
            _loc4_ = this.infoTF.getTextFormat();
            if(this.infoTF.textHeight >= _loc3_)
            {
               while(this.infoTF.textHeight >= _loc3_)
               {
                  _loc4_.size = int(_loc4_.size) - 1;
                  this.infoTF.setTextFormat(_loc4_);
               }
            }
            else
            {
               while(this.infoTF.textHeight <= _loc3_ && _loc4_.size < MAX_INFO_FONT_SIZE)
               {
                  _loc4_.size = int(_loc4_.size) + 1;
                  this.infoTF.setTextFormat(_loc4_);
               }
            }
            this.infoTF.height = this.infoTF.textHeight + 10;
         }
      }
   }
}
