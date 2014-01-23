package com.xvm.controls
{
    import com.xvm.*;
    import com.xvm.components.*;
    import scaleform.clik.data.*;

    public class PrefMultiSelectionDropDown extends DropDown
    {
        public function PrefMultiSelectionDropDown()
        {
            var dp:Array = [
                { label: Locale.get("Normal"), icon: "../maps/icons/library/CreditsIcon-1.png", data: "normal" },
                { label: Locale.get("Premium"), icon: "../maps/icons/library/GoldIcon-1.png", data: "premium" },
                { label: Locale.get("Favorite"), icon: "../maps/icons/library/TournamentBattleResultIcon-1.png", data: "favorite" },
                { label: Locale.get("In hangar"), icon: "", data: "hangar" },
                { label: Locale.get("All played tanks"), icon: "", data: "played" },
                { label: Locale.get("All tanks"), icon: "", data: "all" }
            ];
            dataProvider = new DataProvider(dp);

            menuRowCount = dp.length;
        }

    }

}
