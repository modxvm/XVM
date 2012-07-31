intrinsic class gfx.controls.UILoader extends gfx.core.UIComponent
{
  var contentHolder;
  var source: String;

  function unload();
  function load(url);

  function setSize(width, height);
  
  function addEventListener(event, scope, callBack);
  function removeEventListener(event, scope, callBack);
}
