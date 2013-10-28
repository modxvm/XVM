package com.xvm.controls
{
    import com.xvm.l10n.Locale;
    import com.xvm.components.*;
    import scaleform.clik.data.*;

    public class MasteryMultiSelectionDropDown extends DropDown
    {
        public function MasteryMultiSelectionDropDown()
        {
            super();

            var dp:Array = [
                { "label":Locale.get("Mark of Mastery"), "data": -1, "icon":"../maps/icons/library/dossier/markOfMastery40x32.png" },
                { "label":Locale.get("Empty"), "data": 0, "icon":"../maps/icons/filters/empty.png" },
                { "label":Locale.get("1st class"), "data": 1, "icon":"../maps/icons/library/proficiency/class_icons_1.png" },
                { "label":Locale.get("2nd class"), "data": 2, "icon":"../maps/icons/library/proficiency/class_icons_2.png" },
                { "label":Locale.get("3rd class"), "data": 3, "icon":"../maps/icons/library/proficiency/class_icons_3.png" },
                { "label":Locale.get("Master"), "data": 4, "icon":"../maps/icons/library/proficiency/class_icons_4.png" }
            ];
            dataProvider = new DataProvider(dp);

            menuRowCount = dataProvider.length;
            selectedIndex = 0;
        }

    }

}
