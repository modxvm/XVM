/**
 * ...
 * @author Maxim Schedriviy
 */
import net.wargaming.controls.UILoaderAlt;
import wot.utils.Utils;

class wot.utils.IconLoader
{
  private static var s_failIcons: Array = [];

  private var m_owner: Object;
  private var m_completeFunc: Function;
  private var m_iconLoader: UILoaderAlt = null;
  private var m_altIcons: Array;
  private var m_currentIndex: Number;

  public function IconLoader(owner: Object, completeFunc: Function)
  {
    m_owner = owner;
    m_completeFunc = completeFunc;
  }

  public function init(iconLoader: UILoaderAlt, altIcons: Array, useNoImage)
  {
    if (m_iconLoader != null)
    {
      m_iconLoader.removeEventListener("ioError", this, "errorLoad");
      m_iconLoader.removeEventListener("complete", this, "completeLoad");
    }

    m_iconLoader = iconLoader;
    m_iconLoader.addEventListener("ioError", this, "errorLoad");
    m_iconLoader.addEventListener("complete", this, "completeLoad");

    m_altIcons = [];
    var altIcons_length = altIcons.length;
    for (var i = 0; i < altIcons_length; ++i)
    {
      var icon = altIcons[i];
      if (Utils.indexOf(s_failIcons, icon) < 0)
        m_altIcons.push(icon);
    }
    if (m_iconLoader._sourceAlt != "")
    {
      var icon = m_iconLoader._sourceAlt;
      if (Utils.indexOf(s_failIcons, icon) < 0)
        m_altIcons.push(icon);
      m_iconLoader._sourceAlt = "";
    }

    if (useNoImage == undefined || useNoImage)
        m_altIcons.push("../maps/icons/vehicle/contour/noImage.png");

    m_currentIndex = 0;
  }

  public function get currentIcon(): String
  {
    return (m_currentIndex < m_altIcons.length) ? m_altIcons[m_currentIndex] : "";
  }

  private function errorLoad(event)
  {
    m_currentIndex++;
    var next = currentIcon;
    //wot.utils.Logger.add("errorLoad(): " + event.target.source + " => " + next);
    s_failIcons.push(event.target.source);
    event.target.source = next;
    if (next == "" && m_owner && m_completeFunc)
    {
        event.target._source = "";
        m_completeFunc.call(m_owner, event);
    }
  }

  private function completeLoad(event)
  {
    //wot.utils.Logger.add("completeLoad(): " + event.target.source);
    if (m_owner && m_completeFunc)
      m_completeFunc.call(m_owner, event);
  }
}
