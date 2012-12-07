intrinsic class net.wargaming.login.Login extends MovieClip //gfx.core.UIComponent
{
    var form_mc, visible;
    function draw();
/*
    var __set__visible, copyr, awards, _parent, bg_image, invalidate, __height, version, __width, __get__visible, visible, sparks_mc, WOTLogo, logo_mc, shadow_mc;
    function Login()
    {
        super();
        this.__set__visible(false);
        gfx.io.GameDelegate.addCallBack("Login.SetVersion", this, "onSetVersion");
        _global.ASSetPropFlags(net.wargaming.login.Login.prototype, ["isToken", "resetToken"], 6, 1);
    } // End of the function
    function setSize(width, height)
    {
        super.setSize(width, height);
        net.wargaming.EULA.EULADialog.onUpdateLoginStage(width, height);
        form_mc.checkCapsLock();
    } // End of the function
    function configUI()
    {
        super.configUI();
        var _loc5 = 4280163867.000000;
        var _loc4 = 4288059015.000000;
        var _loc3 = form_mc.login.textField;
        _loc3.selectionTextColor = _loc5;
        _loc3.selectionBkgColor = _loc4;
        _loc3.selectionTextColor = _loc5;
        _loc3.selectionBkgColor = _loc4;
        awards = copyr.awards;
        awards.__set__source("../maps/loading_award.png");
        this.setHotKeys();
        net.wargaming.managers.ContextMenuManager.__get__instance().hide();
        form_mc.addEventListener("eventResetToken", this, "startResetToken");
        gfx.io.GameDelegate.addCallBack("login.ShowLicense", this, "onShowLicense");
        gfx.io.GameDelegate.addCallBack("login.ShowCreateAnAccount", this, "onShowCreateAnAccount");
        gfx.io.GameDelegate.addCallBack("login.updateNeeded", this, "showUpdateNedded");
        gfx.io.GameDelegate.addCallBack("login.setAutoLogin", this, "setAutoLogin");
        gfx.io.GameDelegate.addCallBack("login.doAutoLogin", this, "doAutoLogin");
        gfx.io.GameDelegate.addCallBack("login.clearAutoLogin", this, "cancelLoginQueue");
        gfx.io.GameDelegate.addCallBack("login.setLoginQueue", this, "setLoginQueue");
        gfx.io.GameDelegate.addCallBack("login.cancelLoginQueue", this, "cancelLoginQueue");
        gfx.io.GameDelegate.addCallBack("login.showWallpaper", this, "showWallpaper");
        if (_parent._name != "gameloading")
        {
            this.create_sparks();
        } // end if
        if (bg_image != null)
        {
            bg_image.ui_loader_bg.addEventListener("complete", this, "onLoadingImageCoplete");
        } // end if
    } // End of the function
    function startResetToken(ev)
    {
        this.resetToken();
    } // End of the function
    function onLoadingImageCoplete(event)
    {
        this.set_position_wallpaper();
        bg_image._alpha = 100;
        this.invalidate();
    } // End of the function
    function withoutWallpaper()
    {
        useWallpaper = false;
        this.invalidate();
    } // End of the function
    function draw()
    {
        super.draw();
        copyr._y = 738 + Math.round((__height - 768) / 2);
        version._y = 10 - Math.round((__height - 768) / 2);
        version._x = 15 - Math.round((__width - 1024) / 2);
        this.set_position_wallpaper();
        this.reposition_loginform();
        if (!this.__get__visible())
        {
            function onEnterFrame()
            {
                visible = true;
                delete this.onEnterFrame;
            } // End of the function
        } // end if
    } // End of the function
    function set_position_wallpaper()
    {
        if (useWallpaper)
        {
            if (bg_image)
            {
                var _loc3 = __width / 1920;
                var _loc4 = __height / 1200;
                var _loc2 = 1;
                if (_loc3 > _loc4)
                {
                    _loc2 = _loc4;
                }
                else
                {
                    _loc2 = _loc3;
                } // end else if
                bg_image._xscale = bg_image._yscale = 100 * _loc2;
                bg_image._x = (1024 - bg_image._width) / 2;
                bg_image._y = (768 - bg_image._height) / 2;
            } // end if
            sparks_mc._x = bg_image._x;
            sparks_mc._y = bg_image._y;
        }
        else
        {
            bg_image._xscale = bg_image._yscale = 100;
            bg_image._x = (1024 - bg_image._width) / 2;
            bg_image._y = (768 - bg_image._height) / 2;
            sparks_mc._alpha = 0;
            sparks_mc._visible = false;
        } // end else if
    } // End of the function
    function reposition_loginform()
    {
        form_mc._y = Math.round(__height * 0.650000) - Math.round((__height - 768) / 2) - 47;
        if (_parent._name == "gameloading")
        {
            form_mc._y = Math.round(WOTLogo._y + 52);
        } // end if
        logo_mc._y = form_mc._y - 52;
        shadow_mc._y = form_mc._y - 257;
    } // End of the function
    function randRange(min, max)
    {
        var _loc1 = Math.floor(Math.random() * (max - min + 1)) + min;
        return (_loc1);
    } // End of the function
    function getPositionSparks()
    {
        var _loc4 = new Object();
        var _loc2 = 0;
        var _loc3 = 0;
        if (bg_image._width)
        {
            _loc2 = bg_image._width;
        }
        else
        {
            _loc2 = __width;
        } // end else if
        if (bg_image._width)
        {
            _loc3 = bg_image._height;
        }
        else
        {
            _loc3 = __height;
        } // end else if
        _loc4.x = this.randRange(100, _loc2 - 100) - 200;
        _loc4.y = this.randRange(0, _loc3) - 100;
        return (_loc4);
    } // End of the function
    function create_sparks()
    {
        var _loc6 = this;
        var _loc2 = 0;
        var _loc5 = false;
        var _loc3 = 0;
        for (var _loc2 = 0; _loc2 < 150; ++_loc2)
        {
            var _loc4 = this.getPositionSparks();
            _loc5 = Math.random() > 0.750000 ? (true) : (false);
            if (_loc5)
            {
                _loc3 = this.randRange(70, 100);
                sparks_mc.attachMovie("sparks_big", "spark" + _loc2, _loc2);
            }
            else
            {
                _loc3 = this.randRange(20, 40);
                sparks_mc.attachMovie("spark_small", "spark" + _loc2, _loc2);
            } // end else if
            sparks_mc["spark" + _loc2]._x = _loc4.x;
            sparks_mc["spark" + _loc2]._y = _loc4.y;
            sparks_mc["spark" + _loc2]._alpha = this.randRange(5, 50);
            sparks_mc["spark" + _loc2]._xscale = _loc3;
            sparks_mc["spark" + _loc2]._yscale = _loc3;
            sparks_mc["spark" + _loc2]._rotation = this.randRange(-120, -100);
        } // end of for
    } // End of the function
    function onSetVersion(value)
    {
        version.text = value;
    } // End of the function
    function onShowLicense(flag)
    {
        if (flag)
        {
            var _loc3 = net.wargaming.EULA.EULADialog.show(_root);
            if (_loc3 != null)
            {
                net.wargaming.managers.GameInputHandler.__get__instance().clearKeyHandlers();
                _loc3.addEventListener("close", this, "handleCloseEULADialog");
                return;
            } // end if
        } // end if
    } // End of the function
    function onShowCreateAnAccount(dTitle, dInfo, dBtnName, dDefNick)
    {
        if (dTitle.length > 0 && dInfo.length > 0 && dBtnName.length > 0)
        {
            if (!dDefNick || dDefNick == "undefined")
            {
                dDefNick = "";
            } // end if
            var _loc3 = net.wargaming.login.LoginCreateAnAccountDialog.show(dTitle, dInfo, dBtnName, dDefNick);
            if (_loc3 != null)
            {
                net.wargaming.managers.GameInputHandler.__get__instance().clearKeyHandlers();
                _loc3.addEventListener("close", this, "hanleClickQuitLoginCreateAnAccount");
                return;
            } // end if
        } // end if
    } // End of the function
    function hanleClickQuitLoginCreateAnAccount()
    {
        this.setHotKeys();
        form_mc.setErrorMessage("");
        net.wargaming.login.LoginCreateAnAccountDialog.dialog = null;
    } // End of the function
    function handleCloseEULADialog(event)
    {
        this.setHotKeys();
        gfx.io.GameDelegate.call("login.EULAClose", []);
    } // End of the function
    function setAutoLogin(titleText, messageText, cancelLabel)
    {
        net.wargaming.managers.GameInputHandler.__get__instance().clearKeyHandlers();
        var _loc2 = net.wargaming.login.LoginQueueDialog.show(titleText, messageText, cancelLabel);
        _loc2.addEventListener("close", this, "hanleClickQuitButton");
    } // End of the function
    function doAutoLogin()
    {
        form_mc.onSubmit();
    } // End of the function
    function hanleClickQuitButton()
    {
        this.setHotKeys();
        form_mc.setErrorMessage("");
        net.wargaming.login.LoginQueueDialog.dialog = null;
        gfx.io.GameDelegate.call("login.ExitFromAutoLogin", []);
    } // End of the function
    function showUpdateNedded()
    {
        var _loc1 = net.wargaming.notification.ClientUpdateDialog.show();
        _loc1.addEventListener("submit", function (event)
        {
            gfx.io.GameDelegate.call("login.ConfirmUpdate", []);
        });
    } // End of the function
    function cancelLoginQueue(logged)
    {
        gfx.controls.Dialog.hide();
        net.wargaming.login.LoginQueueDialog.dialog = null;
        if (!logged)
        {
            this.setHotKeys();
        } // end if
    } // End of the function
    function setLoginQueue(titleText, messageText, cancelLabel)
    {
        net.wargaming.managers.GameInputHandler.__get__instance().clearKeyHandlers();
        var _loc2 = net.wargaming.login.LoginQueueDialog.show(titleText, messageText, cancelLabel);
        _loc2.addEventListener("close", this, "setHotKeys");
    } // End of the function
    function setHotKeys()
    {
        net.wargaming.managers.GameInputHandler.__get__instance().clearKeyHandlers();
        net.wargaming.managers.GameInputHandler.__get__instance().setKeyHandler(27, "keyDown", form_mc, "onEscape");
        net.wargaming.managers.GameInputHandler.__get__instance().setKeyHandler(13, "keyDown", form_mc, "onSubmit");
    } // End of the function
    function showWallpaper(isShow, path)
    {
        bg_image.ui_loader_bg.source = path;
        if (isShow)
        {
        }
        else
        {
            bg_image.ui_loader_bg.autoSize = true;
            this.withoutWallpaper();
        } // end else if
    } // End of the function
    var useWallpaper = true;
    var id = "";
    var isToken = null;
    var resetToken = null;
*/
}
