/**
 * XVM hot keys cotroller.
 * 
 * Original WG implementation is in particular bugged for Ctrl(17) key.
 * For example:
 * For net.wargaming.managers.BattleInputHandler.instance.addHandler(key, false, zoom, "onZoomKeyClick");
 * passing key 17(Ctrl) as argument breaks original cursor behaviour. Mouse cursor should apper while Ctrl is pressed.
 * onEnterFrame(){ if Key.isDown(key) works okay with this
 * 
 * @author ilitvinov87
 */
class wot.utils.HotkeysController
{
    /**
     * TODO:
     * ) Omit behaviour when battle chat is enabled
     * ) Try listening for different keys in different SWFs. May be battle chat swf can listen every regular key.
     */
    
    public function HotkeysController() 
    {
        
    }
    
}