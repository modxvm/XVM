/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.controls
{
    import com.xfw.components.*;
    import com.xvm.*;
    import scaleform.clik.data.*;

    public class PrefMultiSelectionDropDown extends MultiSelectionDropDown
    {
        public static const PREF_NON_ELITE:String = "nonelite";
        public static const PREF_PREMIUM:String = "premium";
        public static const PREF_NORMAL:String = "normal";
        public static const PREF_MULTIXP:String = "multiXp";
        public static const PREF_NOMASTER:String = "noMaster";
        public static const PREF_FULLCREW:String = "fullCrew";
        public static const PREF_RESERVE:String = "reserve";
        public static const PREF_NON_DOMINATION:String = "nonDomination";

        public function PrefMultiSelectionDropDown()
        {
            var dp:Array = [
                { label: Locale.get("NonElite"), icon: "../maps/icons/library/PersonalAchievementsIcon-1.png", data: PREF_NON_ELITE },
                { label: Locale.get("Premium"), icon: "../maps/icons/library/GoldIcon-1.png", data: PREF_PREMIUM },
                { label: Locale.get("Normal"), icon: "../maps/icons/library/CreditsIcon-1.png", data: PREF_NORMAL },
                { label: Locale.get("MultiXP"), icon: "../maps/icons/library/multyXp.png", data: PREF_MULTIXP },
                { label: Locale.get("NoMaster"), icon: "../maps/icons/library/PowerlevelIcon-1.png", data: PREF_NOMASTER },
                { label: Locale.get("CompleteCrew"), icon: "../maps/icons/messenger/contactIgnored.png", data: PREF_FULLCREW },
                { label: Locale.get("ReserveFilter"), icon: "../maps/icons/library/nut-1.png", data: PREF_RESERVE },
                { label: Locale.get("NonDomination"), icon: "../maps/icons/library/swordsIcon.png", data: PREF_NON_DOMINATION },
            ];
            dataProvider = new DataProvider(dp);

            icon.source = "../maps/icons/buttons/Tank-ico.png";
            menuRowCount = dp.length;
            menuDirection = "up";
        }
    }
}
