intrinsic class gfx.controls.UILoader extends gfx.core.UIComponent
{
  var contentHolder;

  function set source(value:String);
  function set autoSize(value:Boolean);
  function get content():MovieClip;
  
  function unload();
  function load(url);

  function setSize(width, height);
  
  function addEventListener(event, scope, callBack);
  function removeEventListener(event, scope, callBack);
}
