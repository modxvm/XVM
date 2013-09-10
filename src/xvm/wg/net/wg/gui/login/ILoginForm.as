package net.wg.gui.login 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.interfaces.*;
    
    public interface ILoginForm extends scaleform.clik.interfaces.IUIComponent, net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function update(arg1:Object, arg2:Boolean):void;

        function addChangeHandler(arg1:Function):void;

        function removeChangeHandler(arg1:Function):void;

        function setDefaultValues(arg1:String, arg2:String, arg3:Boolean, arg4:Boolean, arg5:Boolean, arg6:Boolean):void;

        function setServersList(arg1:Array, arg2:int):void;

        function setErrorMessage(arg1:String, arg2:int):void;

        function setCapsLockState(arg1:Boolean):void;

        function getSelectedServerName():String;

        function get submit():net.wg.gui.components.controls.SoundButton;

        function set submit(arg1:net.wg.gui.components.controls.SoundButton):void;

        function get rememberPwdCheckbox():net.wg.gui.components.controls.CheckBox;

        function set rememberPwdCheckbox(arg1:net.wg.gui.components.controls.CheckBox):void;

        function get registerLink():net.wg.gui.components.controls.HyperLink;

        function set registerLink(arg1:net.wg.gui.components.controls.HyperLink):void;

        function get recoveryLink():net.wg.gui.components.controls.HyperLink;

        function set recoveryLink(arg1:net.wg.gui.components.controls.HyperLink):void;

        function get login():net.wg.gui.components.controls.TextInput;

        function set login(arg1:net.wg.gui.components.controls.TextInput):void;

        function get pass():net.wg.gui.components.controls.TextInput;

        function set pass(arg1:net.wg.gui.components.controls.TextInput):void;

        function get message():flash.text.TextField;

        function set message(arg1:flash.text.TextField):void;
    }
}
