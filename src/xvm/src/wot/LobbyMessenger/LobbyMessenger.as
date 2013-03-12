/**
 * @author ilitvinov
 */

//import wot.utils.Logger;
//import wot.utils.Utils;

/**
 * LobbyMessenger
 * manages hangar bottom bar: messages\channels\invites etc
 */

class wot.LobbyMessenger.LobbyMessenger extends net.wargaming.messenger.LobbyMessenger
{
    public function LobbyMessenger() 
    {
        //Utils.TraceXvmModule("LobbyMessenger");
        super();
    }
    
    function handleToggleContacsWindow(event)
    {
        //Logger.addObject(_root.lobbyMessengerLoader, "_root.lobbyMessengerLoader", 1);

        super.handleToggleContacsWindow(event);
    }
    
    function onRecieveChannelMessage(cid, message, blinking)
    {
        //Logger.add("onRecieveChannelMessage" + " cid " + cid + " message " + message + " blinking " + blinking);
        super.onRecieveChannelMessage(cid, message, blinking);
    }
    
    /**
     * Method is invoked when chat window is opened.
     */
    function handleConfirmChannelPageFormComplete(event)
    {
        /** Channel bar blinking is already faded at this moment */
        
        /*
         * Example memberList contents for private channel:
            {
             "nickName": "Itsyourdeath",
             "uid": 1447627,
             "roster": 1,
             "himself": false,
            },
            {
             "nickName": "XlebniDizele4ku",
             "uid": 1784226,
             "roster": 0,
             "himself": true,
            },
            null,
            null,
            null
        */
        var memberList:Array = event.window.form.LobbyChPage.memberList.cachedData;
        
        if (isPrivateChat(memberList) && !isFriendChat(memberList))
        {
            //Logger.add("## private");
            if (true)
            {
                //Logger.add("#### friend");
            }
        }
        
        /** Creates channel window */
        super.handleConfirmChannelPageFormComplete(event);
    }
    
    // -- Private
    
    function isPrivateChat(memberList:Array):Boolean
    {
        return memberList[2] == null;
    }
    
    function isFriendChat(memberList:Array):Boolean
    {
        return memberList[0].roster || memberList[1].roster; // roster: 1 -> friend
    }
}
