package net.wg.gui.battle.views.vehicleMarkers
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.geom.Point;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.Sprite;
    import scaleform.clik.motion.Tween;
    import flash.display.Bitmap;
    import net.wg.data.constants.Values;
    import flash.utils.getDefinitionByName;
    import net.wg.data.constants.Errors;
    import scaleform.gfx.TextFieldEx;

    public class StaticObjectMarker extends BattleUIComponent
    {

        private static const ALPHA_SPEED:int = 1;

        private static const SHAPE_XY:Point = new Point(-145,-178);

        private static const COLOR_GREEN:String = "green";

        private static const COLOR_YELLOW:String = "yellow";

        private static const COLOR_WHITE:String = "white";

        public var marker:MovieClip = null;

        public var distanceFieldGreen:TextField = null;

        public var distanceFieldYellow:TextField = null;

        public var distanceFieldWhite:TextField = null;

        public var bgShadow:Sprite = null;

        private var _metersString:String;

        private var _distanceTF:TextField = null;

        private var _shapeName:String = "arrow";

        private var _minDistance:Number = 0;

        private var _alphaZone:Number = 0;

        private var _distance:Number = 120;

        private var _isShow:Boolean = false;

        private var _tween:Tween = null;

        private var _shapeBitmap:Bitmap = null;

        private var _hideTween:Tween = null;

        private var _inTween:Tween = null;

        private var _tweenTime:int = 0;

        public function StaticObjectMarker()
        {
            super();
            this._distanceTF = this.distanceFieldGreen;
            this.distanceFieldGreen.visible = false;
            this.distanceFieldYellow.visible = false;
            this.distanceFieldWhite.visible = false;
            TextFieldEx.setNoTranslate(this.distanceFieldGreen,true);
            TextFieldEx.setNoTranslate(this.distanceFieldYellow,true);
            TextFieldEx.setNoTranslate(this.distanceFieldWhite,true);
        }

        override protected function onDispose() : void
        {
            if(this._shapeBitmap != null)
            {
                if(this._shapeBitmap.bitmapData != null)
                {
                    this._shapeBitmap.bitmapData.dispose();
                    this._shapeBitmap.bitmapData = null;
                }
                this._shapeBitmap = null;
            }
            this.marker = null;
            this.distanceFieldGreen = null;
            this.distanceFieldYellow = null;
            this.distanceFieldWhite = null;
            this.bgShadow = null;
            this.clearTween();
            this._distanceTF = null;
            if(this._inTween)
            {
                this._inTween.paused = true;
                this._inTween.dispose();
                this._inTween = null;
            }
            if(this._hideTween)
            {
                this._hideTween.paused = true;
                this._hideTween.dispose();
                this._hideTween = null;
            }
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.setShape();
            this.setInitialAlpha();
            this.setDistanceText();
        }

        public function doAlphaAnimation() : void
        {
            var _loc1_:* = 0;
            if(this._alphaZone > 0)
            {
                this.clearTween();
                _loc1_ = this._distance - this._minDistance;
                if(this._isShow && _loc1_ <= 0)
                {
                    this._tween = new Tween(ALPHA_SPEED,this,{"alpha":0.0});
                    this._isShow = false;
                }
                else if(!this._isShow && _loc1_ >= this._alphaZone)
                {
                    this._tween = new Tween(ALPHA_SPEED,this,{"alpha":1});
                    this._isShow = true;
                }
            }
        }

        public function init(param1:String, param2:Number, param3:Number, param4:Number, param5:String, param6:String = "green") : void
        {
            this._shapeName = param1;
            this._minDistance = param2;
            this._alphaZone = param3 - param2;
            this._distance = !isNaN(param4)?Math.round(param4):-1;
            switch(param6)
            {
                case COLOR_GREEN:
                    this._distanceTF = this.distanceFieldGreen;
                    break;
                case COLOR_WHITE:
                    this._distanceTF = this.distanceFieldWhite;
                    break;
                case COLOR_YELLOW:
                default:
                    this._distanceTF = this.distanceFieldYellow;
            }
            this._metersString = param5;
            this._distanceTF.visible = true;
            if(initialized)
            {
                this.setShape();
                this.setInitialAlpha();
                this.setDistanceText();
            }
        }

        public function setDistance(param1:Number) : void
        {
            var _loc2_:Number = !isNaN(param1)?Math.round(param1):-1;
            if(this._distance == _loc2_)
            {
                return;
            }
            this._distance = _loc2_;
            this.doAlphaAnimation();
            this.setDistanceText();
        }

        public function setBlinking(param1:Boolean, param2:int = 0) : void
        {
            if(param1)
            {
                this._tweenTime = param2 >> 1;
                if(!this._inTween)
                {
                    this._hideTween = new Tween(this._tweenTime,this.marker,{"alpha":0},{"onComplete":this.onFadeOutTweenComplete});
                    this._hideTween.paused = true;
                    this._hideTween.fastTransform = false;
                    this._inTween = new Tween(this._tweenTime,this.marker,{"alpha":1},{"onComplete":this.onFadeInTweenComplete});
                    this._inTween.fastTransform = false;
                    this._inTween.paused = true;
                }
                else
                {
                    this._hideTween.duration = this._tweenTime;
                    this._inTween.duration = this._tweenTime;
                }
                this.onFadeInTweenComplete();
            }
            else
            {
                if(this._inTween)
                {
                    this._inTween.paused = true;
                    this._hideTween.paused = true;
                }
                this.marker.alpha = 1;
            }
        }

        private function onFadeInTweenComplete() : void
        {
            this._inTween.paused = true;
            this._hideTween.position = 0;
            this._hideTween.paused = false;
        }

        private function onFadeOutTweenComplete() : void
        {
            this._hideTween.paused = true;
            this._inTween.position = 0;
            this._inTween.paused = false;
        }

        private function setInitialAlpha() : void
        {
            if(this._alphaZone > 0)
            {
                if(this._distance - this._minDistance <= 0)
                {
                    alpha = 0;
                    this._isShow = false;
                }
                else
                {
                    alpha = 1;
                    this._isShow = true;
                }
            }
        }

        private function setDistanceText() : void
        {
            if(this._distance > -1)
            {
                this._distanceTF.text = this._distance.toString() + this._metersString;
            }
            else
            {
                this._distanceTF.text = Values.EMPTY_STR;
            }
        }

        private function setShape() : void
        {
            var shapeBitmapClass:Class = null;
            if(this._shapeBitmap != null)
            {
                this.marker.removeChild(this._shapeBitmap);
                if(this._shapeBitmap.bitmapData != null)
                {
                    this._shapeBitmap.bitmapData.dispose();
                    this._shapeBitmap.bitmapData = null;
                }
            }
            try
            {
                shapeBitmapClass = getDefinitionByName(this._shapeName) as Class;
                this._shapeBitmap = new Bitmap(new shapeBitmapClass());
                this._shapeBitmap.x = SHAPE_XY.x;
                this._shapeBitmap.y = SHAPE_XY.y;
                this.marker.addChild(this._shapeBitmap);
                return;
            }
            catch(error:ReferenceError)
            {
                DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + _shapeName);
                return;
            }
        }

        private function clearTween() : void
        {
            if(this._tween != null)
            {
                this._tween.paused = true;
                this._tween.dispose();
                this._tween = null;
            }
        }
    }
}
