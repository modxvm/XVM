package com.xvm.lobby.ui
{
    /**
     *  Link additional classes into xfw.swc
     */
    import com.xvm.lobby.ui.company.*;
    import com.xvm.lobby.ui.contacts.*;
    import com.xvm.lobby.ui.profile.*;
    import com.xvm.lobby.ui.squad.*;
    import flash.display.*;

    //// company
    UI_CompanyDropItemRenderer;
    UI_CompanyListItemRenderer;
    UI_TeamMemberRenderer;

    // contacts
    UI_ContactItem;
    UI_ContactsTreeItemRenderer;
    UI_EditContactDataView;

    // profile
    UI_ProfileSortingButton;
    UI_ProfileTechniquePage;
    UI_ProfileTechniqueWindow;
    UI_StatisticsDashLineTextItemIRenderer;
    UI_TechniqueRenderer;
    UI_TechniqueStatisticTab;

    // squad
    // TODO
    //UI_SquadItemRenderer;

    import com.xfw.*;
    public class LobbyHangarUIMod extends Sprite
    {
        Logger.add("LobbyHangarUIMod");
    }
}
