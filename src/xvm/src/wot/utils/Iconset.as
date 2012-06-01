/**
 * ...
 * @author Maxim Schedriviy
 */
import net.wargaming.controls.UILoaderAlt;

class wot.utils.Iconset
{
  private var m_owner: Object;
  private var m_completeFunc: Function;
  private var m_originalIcon: String;
  private var m_iconLoader: UILoaderAlt = null;
  private var m_altIcons: Array;
  private var m_currentIndex: Number;
  
  public function Iconset(owner: Object, completeFunc: Function, originalIcon: String)
  {
    m_owner = owner;
    m_completeFunc = completeFunc;
    m_originalIcon = originalIcon;
  }

  public function init(iconLoader: UILoaderAlt, altIcons: Array)
  {
    if (m_iconLoader != null)
    {
      iconLoader.removeEventListener("ioError", this, "errorLoad");
      iconLoader.removeEventListener("complete", this, "completeLoad");
    }

    m_iconLoader = iconLoader;
    iconLoader.addEventListener("ioError", this, "errorLoad");
    iconLoader.addEventListener("complete", this, "completeLoad");

    m_altIcons = altIcons;
    if (iconLoader._sourceAlt != "")
    {
      m_altIcons.push(iconLoader._sourceAlt);
      iconLoader._sourceAlt = "";
    }

    m_currentIndex = 0;
  }

  public function get originalIcon(): String
  {
    return m_originalIcon;
  }
  
  public function get currentIcon(): String
  {
    return (m_currentIndex < m_altIcons.length) ? m_altIcons[m_currentIndex] : "";
  }
  
  private function errorLoad(event)
  {
    m_currentIndex++;
    //wot.utils.Logger.add("errorLoad(): " + event.target.source + " => " + currentIcon);
    event.target.source = currentIcon;
  }

  private function completeLoad(event)
  {
    //wot.utils.Logger.add("completeLoad(): " + currentIcon);
    if (m_owner && m_completeFunc)
      m_completeFunc.call(m_owner);
    event.target.visible = true;
  }
}
