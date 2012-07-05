/**
 * ...
 * @author sirmax2
 */
import wot.utils.Logger;

class wot.utils.GlobalEventDispatcher
{
  private static var _listeners = {};
  private static var dummy = Logger.dummy;

  public static function indexOfListener(event, scope, callBack)
  {
    var listeners = _listeners[event];
    if (!listeners)
      return -1;
    var len = listeners.length;
    for (var i = 0; i < len; ++i)
    {
      var l = listeners[i];
      if (l.listenerObject == scope && l.listenerFunction == callBack)
        return i;
    }
    return -1;
  }

  public static function addEventListener(event, scope, callBack)
  {
    if (!_listeners[event])
      _listeners[event] = [];
    if (indexOfListener(event, scope, callBack) == -1)
      _listeners[event].push({listenerObject: scope, listenerFunction: callBack});
  }

  public static function removeEventListener(event, scope, callBack)
  {
    var i = indexOfListener(event, scope, callBack);
    if (i != -1)
      _listeners[event].splice(i, 1);
  }

  public static function dispatchEvent(event)
  {
    //Logger.addObject(_instance._listeners[event.type]);
    var listeners = _listeners[event.type];
    if (!listeners)
      return;

    var len = listeners.length;
    for (var i = len; i >= 0; --i)
    {
      var a = listeners[i].listenerObject;
      if (!a)
        continue;

      if (typeof(a) == "function")
      {
        // static function
        a.call(null, event);
        continue;
      }

      var b = listeners[i].listenerFunction;
      if (!b)
        continue;

      //Logger.add(a + " " + b + " " + event.type);
      b.call(a, event);
    }
  }
}