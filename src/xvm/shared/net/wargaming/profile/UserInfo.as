intrinsic class net.wargaming.profile.UserInfo extends gfx.core.UIComponent
{
    var blocksArea:MovieClip;
    var list:MovieClip;

    var clanEmblem:MovieClip;
    var achievements:MovieClip;
    var lastBattleDateField:TextField;
    var registrationDateField:TextField;
    var lastBattleDateLabel:TextField;
    var registrationDateLabel:TextField;
    var clanPositionField:TextField;
    var clanJoinDataField:TextField;
    var clanField:TextField;
    var nameField:TextField;
    var title:MovieClip;
    var sb_clan:MovieClip;

    var header:MovieClip; // Added by XVM SWF patch! Contains "fights" and "wins" text fields.
    
    var USER_INFO_FRAME;

    function setClanEmblem(clanEmblemId);
    function setCommonInfo();
    function setList();
    function setStat();
    function setAchievements();
}
