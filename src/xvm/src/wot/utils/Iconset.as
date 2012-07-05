/**
 * ...
 * @author Maxim Schedriviy
 */
import net.wargaming.controls.UILoaderAlt;
import wot.utils.Utils;

class wot.utils.Iconset
{
  private static var s_failIcons: Array = [];

  private var m_owner: Object;
  private var m_completeFunc: Function;
  private var m_iconLoader: UILoaderAlt = null;
  private var m_altIcons: Array;
  private var m_currentIndex: Number;

  public function Iconset(owner: Object, completeFunc: Function)
  {
    m_owner = owner;
    m_completeFunc = completeFunc;
  }

  public function init(iconLoader: UILoaderAlt, altIcons: Array)
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
      if (Utils.indexOf(s_failIcons, altIcons[i]) < 0)
        m_altIcons.push(altIcons[i]);
    }
    if (m_iconLoader._sourceAlt != "")
    {
      if (Utils.indexOf(s_failIcons, m_iconLoader._sourceAlt) < 0)
        m_altIcons.push(m_iconLoader._sourceAlt);
      m_iconLoader._sourceAlt = "";
    }

    m_currentIndex = 0;
  }

  public function get currentIcon(): String
  {
    return (m_currentIndex < m_altIcons.length) ? m_altIcons[m_currentIndex] : "";
  }

  private function errorLoad(event)
  {
    m_currentIndex++;
    //wot.utils.Logger.add("errorLoad(): " + event.target.source + " => " + currentIcon);
    s_failIcons.push(event.target.source);
    event.target.source = currentIcon;
  }

  private function completeLoad(event)
  {
    //wot.utils.Logger.add("completeLoad(): " + currentIcon);
    if (m_owner && m_completeFunc)
      m_completeFunc.call(m_owner);
  }
}
