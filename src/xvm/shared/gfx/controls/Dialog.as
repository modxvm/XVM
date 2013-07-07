intrinsic class gfx.controls.Dialog extends gfx.core.UIComponent
{
    var _name, closeBtn, cancelBtn, submitBtn, dragBar;
    static var currentDialog;
    static function show(context, linkage, props, modal);
    static function hide();
}
