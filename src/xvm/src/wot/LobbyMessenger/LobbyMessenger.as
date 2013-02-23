/**
 * @author ilitvinov
 */

import wot.utils.Logger;
import wot.utils.Utils;

/**
 * LobbyMessenger
 * manages hangar bottom bar: messages\channels\invites etc
 */

class wot.LobbyMessenger.LobbyMessenger extends net.wargaming.messenger.LobbyMessenger
{
    public function LobbyMessenger() 
    {
        Utils.TraceXvmModule("LobbyMessenger");
        super();
    }
}
