/**
 * ...
 * @author Maxim Schedriviy
 */
import net.wargaming.controls.UILoaderAlt;

class wot.utils.Iconset
{
  private var m_owner: Object;
  private var m_iconLoader: UILoaderAlt;
  private var m_altIcons: Array;
  private var m_currentIndex: Number;
  private var m_iconLoaded: Boolean = false;
  private var m_completeFunc: Function;

  public function Iconset(owner: Object, iconLoader: UILoaderAlt, altIcons: Array, completeFunc: Function)
  {
    m_owner = owner;
    m_iconLoader = iconLoader;
    m_altIcons = altIcons;
    if (iconLoader._sourceAlt != "")
    {
      m_altIcons.push(iconLoader._sourceAlt);
      iconLoader._sourceAlt = "";
    }
    m_currentIndex = 0;
    m_completeFunc = completeFunc;
    iconLoader.addEventListener("ioError", this, "errorLoad");
    iconLoader.addEventListener("complete", this, "completeLoad");
  }

  public function get currentIcon(): String
  {
    return (m_currentIndex < m_altIcons.length) ? m_altIcons[m_currentIndex] : "";
  }
  
  private function errorLoad(event)
  {
    m_currentIndex++;
    event.target.source = currentIcon;
  }

  private function completeLoad(event)
  {
    if (!m_iconLoaded)
    {
      m_iconLoaded = true;
      if (m_owner && m_completeFunc)
        m_completeFunc.call(m_owner);
    }
    event.target.visible = true;
  }
}
