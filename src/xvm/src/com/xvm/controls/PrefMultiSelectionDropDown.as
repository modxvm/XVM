package com.xvm.controls
{
    import com.xvm.*;
    import com.xvm.components.*;
    import flash.geom.Rectangle;
    import scaleform.clik.data.*;

    public class PrefMultiSelectionDropDown extends MultiSelectionDropDown
    {
        public function PrefMultiSelectionDropDown()
        {
            var dp:Array = [
                { label: Locale.get("Elite"), icon: "../maps/icons/library/PersonalAchievementsIcon-1.png", data: "elite" },
                { label: Locale.get("Premium"), icon: "../maps/icons/library/GoldIcon-1.png", data: "premium" },
                { label: Locale.get("Normal"), icon: "../maps/icons/library/CreditsIcon-1.png", data: "normal" },
                { label: Locale.get("MultiXP"), icon: "../maps/icons/library/multyXp.png", data: "multiXp" },
                { label: Locale.get("NoMaster"), icon: "../maps/icons/library/PowerlevelIcon-1.png", data: "noMaster" },
            ];
            dataProvider = new DataProvider(dp);

            icon.source = "../maps/icons/buttons/Tank-ico.png";
            menuRowCount = dp.length;
            menuDirection = "up";
        }

    }

}
