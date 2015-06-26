intrinsic class gfx.controls.UILoader extends gfx.core.UIComponent
{
  // not implemented function
  function onLoadInit();

  function get source():String;
  function set source(value:String);
  function get autoSize():Boolean;
  function set autoSize(value:Boolean);
  function get maintainAspectRatio():Boolean;
  function set maintainAspectRatio(value:Boolean);
  function get content():MovieClip;

  function unload();
  function load(url:String);

  function addEventListener(event, scope, callBack);
  function removeEventListener(event, scope, callBack);
}
