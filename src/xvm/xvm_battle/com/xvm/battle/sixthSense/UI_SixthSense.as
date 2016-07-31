package com.xvm.battle.sixthSense {
import com.greensock.TweenLite;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.Macros;
import com.xvm.Utils;
import com.xvm.Xvm;
import com.xvm.wg.ImageWG;

import flash.events.Event;

public class UI_SixthSense extends sixthSenseUI {

    private var _loader:ImageWG;
    private var _isPathValid:Boolean;
    private var _isLoadComplete:Boolean;
    private var _isImageLoading : Boolean;
    private var _currentAlpha : int = 0;
    private var _isShown : Boolean;

    public function UI_SixthSense() {
        super();
        _loader = new ImageWG();
        _loader.successCallback = onImageSuccessLoadHandler;
        _loader.errorCallback = onImageFaultLoadHandler;
        _loader.alpha = 0;
        _currentAlpha = 0;
        Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
    }

    override protected function configUI():void {
        super.configUI();
        onConfigLoaded(null);
    }

    override public function as_show():void {
        _isShown = true;
        checkImage();
    }

    private function checkImage() : void {
        if(!_isImageLoading) {
            if(_isPathValid && _isLoadComplete) {
                if(_isShown) {
                    if(_loader.alpha != 1) {
                        TweenLite.to(_loader, 0.2, {alpha: 1});
                        _currentAlpha = 1;
                    }
                } else {
                    if(_loader.alpha != 0) {
                        TweenLite.to(_loader, 0.5, {alpha: 0});
                        _currentAlpha = 1;
                    }
                }
            } else {
                if(_isShown) {
                    if(_currentAlpha != 1) {
                        super.as_show();
                        _currentAlpha = 1;
                    }
                } else {
                    if(_currentAlpha != 0) {
                        super.as_hide();
                        _currentAlpha = 0;
                    }
                }
            }
        }
    }

    override public function as_hide():void {
        _isShown = false;
        checkImage();
    }

    private function onConfigLoaded(event:Event):void {
        var iconPath : String = Config.config.battle.sixthSenseIcon;
        if (iconPath)
        {
            iconPath = Utils.fixImgTagSrc(Macros.FormatStringGlobal(iconPath));
            _isPathValid = true;
            _isImageLoading = true;
            _loader.source = iconPath;
        }
        else
        {
            _isPathValid = false;
        }
    }

    private function onImageSuccessLoadHandler():void {
        if (!_loader.parent) {
            while (numChildren > 0) {
                removeChildAt(0);
            }
            addChild(_loader);
        }
        _loader.x = -_loader.width/2;
        _loader.y = -_loader.height/2;
        _isImageLoading = false;
        _isLoadComplete = true;
        checkImage();
    }

    private function onImageFaultLoadHandler():void {
        _isImageLoading = false;
        _isLoadComplete = false;
        checkImage();
    }

    override protected function onDispose():void {
        Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
        _loader.dispose();
        _loader = null;
        super.onDispose();
    }
}
}
