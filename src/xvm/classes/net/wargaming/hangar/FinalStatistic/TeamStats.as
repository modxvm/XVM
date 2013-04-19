intrinsic class net.wargaming.hangar.FinalStatistic.TeamStats extends gfx.core.UIComponent
{
    var sqadHead1, sqadHead2; 
    var playerHead1, playerHead2; 
    var tankHead2, tankHead1; 
    var damageHead1, damageHead2;
    var fragHead1, fragHead2;
    var xpHead1, xpHead2;
    var medalHead1, medalHead2;
    var team1buttons, team2buttons;
    var parent; 

    function configUI();
    function clearHeadersSelection(headers, except);
    function applySort(iconType, sortDirection);
}
