package 
{
    public class ACHIEVEMENTS extends Object
    {
        public function ACHIEVEMENTS()
        {
            super();
            return;
        }

        public static function all(arg1:String):String
        {
            var loc1:*="#achievements:" + arg1;
            App.utils.asserter.assert(!(all_ENUM.indexOf(loc1) == -1), "locale key \"" + loc1 + "\" was not found");
            return loc1;
        }

        public static function achievement(arg1:String):String
        {
            var loc1:*="#achievements:achievement/" + arg1;
            App.utils.asserter.assert(!(ACHIEVEMENT_ENUM.indexOf(loc1) == -1), "locale key \"" + loc1 + "\" was not found");
            return loc1;
        }

        public static const ACHIEVEMENT_RANK3:String="#achievements:achievement/rank3";

        public static const ACHIEVEMENT_RANK4:String="#achievements:achievement/rank4";

        public static const ACHIEVEMENT_RANK:String="#achievements:achievement/rank";

        public static const ACHIEVEMENT_MASTER1:String="#achievements:achievement/master1";

        public static const ACHIEVEMENT_MASTER2:String="#achievements:achievement/master2";

        public static const ACHIEVEMENT_MASTER3:String="#achievements:achievement/master3";

        public static const ACHIEVEMENT_MASTER4:String="#achievements:achievement/master4";

        public static const ACHIEVEMENT_MAXMEDALVALUE:String="#achievements:achievement/maxMedalValue";

        public static const GLOBALRATING:String="#achievements:globalRating";

        public static const GLOBALRATING_DESCR:String="#achievements:globalRating_descr";

        public static const WARRIOR:String="#achievements:warrior";

        public static const WARRIOR_DESCR:String="#achievements:warrior_descr";

        public static const INVADER:String="#achievements:invader";

        public static const INVADER_DESCR:String="#achievements:invader_descr";

        public static const SNIPER:String="#achievements:sniper";

        public static const SNIPER_DESCR:String="#achievements:sniper_descr";

        public static const DEFENDER:String="#achievements:defender";

        public static const DEFENDER_DESCR:String="#achievements:defender_descr";

        public static const STEELWALL:String="#achievements:steelwall";

        public static const STEELWALL_DESCR:String="#achievements:steelwall_descr";

        public static const SUPPORTER:String="#achievements:supporter";

        public static const SUPPORTER_DESCR:String="#achievements:supporter_descr";

        public static const SCOUT:String="#achievements:scout";

        public static const SCOUT_DESCR:String="#achievements:scout_descr";

        public static const EVILEYE:String="#achievements:evileye";

        public static const EVILEYE_DESCR:String="#achievements:evileye_descr";

        public static const MEDALKAY:String="#achievements:medalKay";

        public static const MEDALKAY_DESCR:String="#achievements:medalKay_descr";

        public static const MEDALKAY_HEROINFO:String="#achievements:medalKay_heroInfo";

        public static const MEDALCARIUS:String="#achievements:medalCarius";

        public static const MEDALCARIUS_DESCR:String="#achievements:medalCarius_descr";

        public static const MEDALCARIUS_HEROINFO:String="#achievements:medalCarius_heroInfo";

        public static const MEDALKNISPEL:String="#achievements:medalKnispel";

        public static const MEDALKNISPEL_DESCR:String="#achievements:medalKnispel_descr";

        public static const MEDALKNISPEL_HEROINFO:String="#achievements:medalKnispel_heroInfo";

        public static const MEDALPOPPEL:String="#achievements:medalPoppel";

        public static const MEDALPOPPEL_DESCR:String="#achievements:medalPoppel_descr";

        public static const MEDALPOPPEL_HEROINFO:String="#achievements:medalPoppel_heroInfo";

        public static const MEDALABRAMS:String="#achievements:medalAbrams";

        public static const MEDALABRAMS_DESCR:String="#achievements:medalAbrams_descr";

        public static const MEDALABRAMS_HEROINFO:String="#achievements:medalAbrams_heroInfo";

        public static const MEDALLECLERC:String="#achievements:medalLeClerc";

        public static const MEDALLECLERC_DESCR:String="#achievements:medalLeClerc_descr";

        public static const MEDALLECLERC_HEROINFO:String="#achievements:medalLeClerc_heroInfo";

        public static const MEDALLAVRINENKO:String="#achievements:medalLavrinenko";

        public static const MEDALLAVRINENKO_DESCR:String="#achievements:medalLavrinenko_descr";

        public static const MEDALLAVRINENKO_HEROINFO:String="#achievements:medalLavrinenko_heroInfo";

        public static const MEDALEKINS:String="#achievements:medalEkins";

        public static const MEDALEKINS_DESCR:String="#achievements:medalEkins_descr";

        public static const MEDALEKINS_HEROINFO:String="#achievements:medalEkins_heroInfo";

        public static const MEDALCRUCIALCONTRIBUTION:String="#achievements:medalCrucialContribution";

        public static const MEDALCRUCIALCONTRIBUTION_DESCR:String="#achievements:medalCrucialContribution_descr";

        public static const MEDALBROTHERSINARMS:String="#achievements:medalBrothersInArms";

        public static const MEDALBROTHERSINARMS_DESCR:String="#achievements:medalBrothersInArms_descr";

        public static const MEDALDELANGLADE:String="#achievements:medalDeLanglade";

        public static const MEDALDELANGLADE_DESCR:String="#achievements:medalDeLanglade_descr";

        public static const MEDALTAMADAYOSHIO:String="#achievements:medalTamadaYoshio";

        public static const MEDALTAMADAYOSHIO_DESCR:String="#achievements:medalTamadaYoshio_descr";

        public static const HEROESOFRASSENAY:String="#achievements:heroesOfRassenay";

        public static const HEROESOFRASSENAY_DESCR:String="#achievements:heroesOfRassenay_descr";

        public static const MEDALWITTMANN:String="#achievements:medalWittmann";

        public static const MEDALWITTMANN_DESCR:String="#achievements:medalWittmann_descr";

        public static const MEDALORLIK:String="#achievements:medalOrlik";

        public static const MEDALORLIK_DESCR:String="#achievements:medalOrlik_descr";

        public static const MEDALOSKIN:String="#achievements:medalOskin";

        public static const MEDALOSKIN_DESCR:String="#achievements:medalOskin_descr";

        public static const MEDALHALONEN:String="#achievements:medalHalonen";

        public static const MEDALHALONEN_DESCR:String="#achievements:medalHalonen_descr";

        public static const MEDALBURDA:String="#achievements:medalBurda";

        public static const MEDALBURDA_DESCR:String="#achievements:medalBurda_descr";

        public static const MEDALBILLOTTE:String="#achievements:medalBillotte";

        public static const MEDALBILLOTTE_DESCR:String="#achievements:medalBillotte_descr";

        public static const MEDALKOLOBANOV:String="#achievements:medalKolobanov";

        public static const MEDALKOLOBANOV_DESCR:String="#achievements:medalKolobanov_descr";

        public static const MEDALFADIN:String="#achievements:medalFadin";

        public static const MEDALFADIN_DESCR:String="#achievements:medalFadin_descr";

        public static const MEDALRADLEYWALTERS:String="#achievements:medalRadleyWalters";

        public static const MEDALRADLEYWALTERS_DESCR:String="#achievements:medalRadleyWalters_descr";

        public static const MEDALLAFAYETTEPOOL:String="#achievements:medalLafayettePool";

        public static const MEDALLAFAYETTEPOOL_DESCR:String="#achievements:medalLafayettePool_descr";

        public static const MEDALBRUNOPIETRO:String="#achievements:medalBrunoPietro";

        public static const MEDALBRUNOPIETRO_DESCR:String="#achievements:medalBrunoPietro_descr";

        public static const MEDALTARCZAY:String="#achievements:medalTarczay";

        public static const MEDALTARCZAY_DESCR:String="#achievements:medalTarczay_descr";

        public static const MEDALPASCUCCI:String="#achievements:medalPascucci";

        public static const MEDALPASCUCCI_DESCR:String="#achievements:medalPascucci_descr";

        public static const MEDALDUMITRU:String="#achievements:medalDumitru";

        public static const MEDALDUMITRU_DESCR:String="#achievements:medalDumitru_descr";

        public static const MEDALLEHVASLAIHO:String="#achievements:medalLehvaslaiho";

        public static const MEDALLEHVASLAIHO_DESCR:String="#achievements:medalLehvaslaiho_descr";

        public static const MEDALNIKOLAS:String="#achievements:medalNikolas";

        public static const MEDALNIKOLAS_DESCR:String="#achievements:medalNikolas_descr";

        public static const BOMBARDIER:String="#achievements:bombardier";

        public static const BOMBARDIER_DESCR:String="#achievements:bombardier_descr";

        public static const BEASTHUNTER:String="#achievements:beasthunter";

        public static const BEASTHUNTER_DESCR:String="#achievements:beasthunter_descr";

        public static const PATTONVALLEY:String="#achievements:pattonValley";

        public static const PATTONVALLEY_DESCR:String="#achievements:pattonValley_descr";

        public static const SINAI:String="#achievements:sinai";

        public static const SINAI_DESCR:String="#achievements:sinai_descr";

        public static const MOUSEBANE:String="#achievements:mousebane";

        public static const MOUSEBANE_DESCR:String="#achievements:mousebane_descr";

        public static const MECHANICENGINEER:String="#achievements:mechanicEngineer";

        public static const MECHANICENGINEER_DESCR:String="#achievements:mechanicEngineer_descr";

        public static const MECHANICENGINEER0:String="#achievements:mechanicEngineer0";

        public static const MECHANICENGINEER0_DESCR:String="#achievements:mechanicEngineer0_descr";

        public static const MECHANICENGINEER1:String="#achievements:mechanicEngineer1";

        public static const MECHANICENGINEER1_DESCR:String="#achievements:mechanicEngineer1_descr";

        public static const MECHANICENGINEER2:String="#achievements:mechanicEngineer2";

        public static const MECHANICENGINEER2_DESCR:String="#achievements:mechanicEngineer2_descr";

        public static const MECHANICENGINEER3:String="#achievements:mechanicEngineer3";

        public static const MECHANICENGINEER3_DESCR:String="#achievements:mechanicEngineer3_descr";

        public static const MECHANICENGINEER4:String="#achievements:mechanicEngineer4";

        public static const MECHANICENGINEER4_DESCR:String="#achievements:mechanicEngineer4_descr";

        public static const MECHANICENGINEER5:String="#achievements:mechanicEngineer5";

        public static const MECHANICENGINEER5_DESCR:String="#achievements:mechanicEngineer5_descr";

        public static const TANKEXPERT:String="#achievements:tankExpert";

        public static const TANKEXPERT_DESCR:String="#achievements:tankExpert_descr";

        public static const TANKEXPERT0:String="#achievements:tankExpert0";

        public static const TANKEXPERT0_DESCR:String="#achievements:tankExpert0_descr";

        public static const TANKEXPERT1:String="#achievements:tankExpert1";

        public static const TANKEXPERT1_DESCR:String="#achievements:tankExpert1_descr";

        public static const TANKEXPERT2:String="#achievements:tankExpert2";

        public static const TANKEXPERT2_DESCR:String="#achievements:tankExpert2_descr";

        public static const TANKEXPERT3:String="#achievements:tankExpert3";

        public static const ACHIEVEMENT_RANK1:String="#achievements:achievement/rank1";

        public static const TANKEXPERT4:String="#achievements:tankExpert4";

        public static const TANKEXPERT4_DESCR:String="#achievements:tankExpert4_descr";

        public static const TANKEXPERT5:String="#achievements:tankExpert5";

        public static const TANKEXPERT5_DESCR:String="#achievements:tankExpert5_descr";

        public static const TITLESNIPER:String="#achievements:titleSniper";

        public static const TITLESNIPER_DESCR:String="#achievements:titleSniper_descr";

        public static const INVINCIBLE:String="#achievements:invincible";

        public static const INVINCIBLE_DESCR:String="#achievements:invincible_descr";

        public static const DIEHARD:String="#achievements:diehard";

        public static const DIEHARD_DESCR:String="#achievements:diehard_descr";

        public static const RAIDER:String="#achievements:raider";

        public static const RAIDER_DESCR:String="#achievements:raider_descr";

        public static const HANDOFDEATH:String="#achievements:handOfDeath";

        public static const HANDOFDEATH_DESCR:String="#achievements:handOfDeath_descr";

        public static const ARMORPIERCER:String="#achievements:armorPiercer";

        public static const ARMORPIERCER_DESCR:String="#achievements:armorPiercer_descr";

        public static const KAMIKAZE:String="#achievements:kamikaze";

        public static const KAMIKAZE_DESCR:String="#achievements:kamikaze_descr";

        public static const WHITETIGER:String="#achievements:whiteTiger";

        public static const WHITETIGER_DESCR:String="#achievements:whiteTiger_descr";

        public static const TANKEXPERT3_DESCR:String="#achievements:tankExpert3_descr";

        public static const LUCKYDEVIL_DESCR:String="#achievements:luckyDevil_descr";

        public static const IRONMAN:String="#achievements:ironMan";

        public static const IRONMAN_DESCR:String="#achievements:ironMan_descr";

        public static const STURDY:String="#achievements:sturdy";

        public static const STURDY_DESCR:String="#achievements:sturdy_descr";

        public static const HUNTSMAN:String="#achievements:huntsman";

        public static const HUNTSMAN_DESCR:String="#achievements:huntsman_descr";

        public static const MARKOFMASTERY:String="#achievements:markOfMastery";

        public static const MARKOFMASTERYCONTENT:String="#achievements:markOfMasteryContent";

        public static const MARKOFMASTERYCONTENT_4:String="#achievements:markOfMasteryContent/4";

        public static const MARKOFMASTERYCONTENT_4_INFO:String="#achievements:markOfMasteryContent/4/info";

        public static const MARKOFMASTERYCONTENT_3:String="#achievements:markOfMasteryContent/3";

        public static const MARKOFMASTERYCONTENT_3_INFO:String="#achievements:markOfMasteryContent/3/info";

        public static const MARKOFMASTERYCONTENT_2:String="#achievements:markOfMasteryContent/2";

        public static const MARKOFMASTERYCONTENT_2_INFO:String="#achievements:markOfMasteryContent/2/info";

        public static const MARKOFMASTERYCONTENT_1:String="#achievements:markOfMasteryContent/1";

        public static const MARKOFMASTERYCONTENT_1_INFO:String="#achievements:markOfMasteryContent/1/info";

        public static const ACHIEVEMENT_ENUM:Array=[ACHIEVEMENT_RANK1, ACHIEVEMENT_RANK2, ACHIEVEMENT_RANK3, ACHIEVEMENT_RANK4, ACHIEVEMENT_RANK, ACHIEVEMENT_MASTER1, ACHIEVEMENT_MASTER2, ACHIEVEMENT_MASTER3, ACHIEVEMENT_MASTER4, ACHIEVEMENT_MAXMEDALVALUE];

        public static const all_ENUM:Array=[GLOBALRATING, GLOBALRATING_DESCR, WARRIOR, WARRIOR_DESCR, INVADER, INVADER_DESCR, SNIPER, SNIPER_DESCR, DEFENDER, DEFENDER_DESCR, STEELWALL, STEELWALL_DESCR, SUPPORTER, SUPPORTER_DESCR, SCOUT, SCOUT_DESCR, EVILEYE, EVILEYE_DESCR, MEDALKAY, MEDALKAY_DESCR, MEDALKAY_HEROINFO, MEDALCARIUS, MEDALCARIUS_DESCR, MEDALCARIUS_HEROINFO, MEDALKNISPEL, MEDALKNISPEL_DESCR, MEDALKNISPEL_HEROINFO, MEDALPOPPEL, MEDALPOPPEL_DESCR, MEDALPOPPEL_HEROINFO, MEDALABRAMS, MEDALABRAMS_DESCR, MEDALABRAMS_HEROINFO, MEDALLECLERC, MEDALLECLERC_DESCR, MEDALLECLERC_HEROINFO, MEDALLAVRINENKO, MEDALLAVRINENKO_DESCR, MEDALLAVRINENKO_HEROINFO, MEDALEKINS, MEDALEKINS_DESCR, MEDALEKINS_HEROINFO, MEDALCRUCIALCONTRIBUTION, MEDALCRUCIALCONTRIBUTION_DESCR, MEDALBROTHERSINARMS, MEDALBROTHERSINARMS_DESCR, MEDALDELANGLADE, MEDALDELANGLADE_DESCR, MEDALTAMADAYOSHIO, MEDALTAMADAYOSHIO_DESCR, HEROESOFRASSENAY, HEROESOFRASSENAY_DESCR, MEDALWITTMANN, MEDALWITTMANN_DESCR, MEDALORLIK, MEDALORLIK_DESCR, MEDALOSKIN, MEDALOSKIN_DESCR, MEDALHALONEN, MEDALHALONEN_DESCR, MEDALBURDA, MEDALBURDA_DESCR, MEDALBILLOTTE, MEDALBILLOTTE_DESCR, MEDALKOLOBANOV, MEDALKOLOBANOV_DESCR, MEDALFADIN, MEDALFADIN_DESCR, MEDALRADLEYWALTERS, MEDALRADLEYWALTERS_DESCR, MEDALLAFAYETTEPOOL, MEDALLAFAYETTEPOOL_DESCR, MEDALBRUNOPIETRO, MEDALBRUNOPIETRO_DESCR, MEDALTARCZAY, MEDALTARCZAY_DESCR, MEDALPASCUCCI, MEDALPASCUCCI_DESCR, MEDALDUMITRU, MEDALDUMITRU_DESCR, MEDALLEHVASLAIHO, MEDALLEHVASLAIHO_DESCR, MEDALNIKOLAS, MEDALNIKOLAS_DESCR, BOMBARDIER, BOMBARDIER_DESCR, BEASTHUNTER, BEASTHUNTER_DESCR, PATTONVALLEY, PATTONVALLEY_DESCR, SINAI, SINAI_DESCR, MOUSEBANE, MOUSEBANE_DESCR, MECHANICENGINEER, MECHANICENGINEER_DESCR, MECHANICENGINEER0, MECHANICENGINEER0_DESCR, MECHANICENGINEER1, MECHANICENGINEER1_DESCR, MECHANICENGINEER2, MECHANICENGINEER2_DESCR, MECHANICENGINEER3, MECHANICENGINEER3_DESCR, MECHANICENGINEER4, MECHANICENGINEER4_DESCR, MECHANICENGINEER5, MECHANICENGINEER5_DESCR, TANKEXPERT, TANKEXPERT_DESCR, TANKEXPERT0, TANKEXPERT0_DESCR, TANKEXPERT1, TANKEXPERT1_DESCR, TANKEXPERT2, TANKEXPERT2_DESCR, TANKEXPERT3, TANKEXPERT3_DESCR, TANKEXPERT4, TANKEXPERT4_DESCR, TANKEXPERT5, TANKEXPERT5_DESCR, TITLESNIPER, TITLESNIPER_DESCR, INVINCIBLE, INVINCIBLE_DESCR, DIEHARD, DIEHARD_DESCR, RAIDER, RAIDER_DESCR, HANDOFDEATH, HANDOFDEATH_DESCR, ARMORPIERCER, ARMORPIERCER_DESCR, KAMIKAZE, KAMIKAZE_DESCR, WHITETIGER, WHITETIGER_DESCR, LUCKYDEVIL, LUCKYDEVIL_DESCR, IRONMAN, IRONMAN_DESCR, STURDY, STURDY_DESCR, HUNTSMAN, HUNTSMAN_DESCR, MARKOFMASTERY, MARKOFMASTERYCONTENT, MARKOFMASTERYCONTENT_4, MARKOFMASTERYCONTENT_4_INFO, MARKOFMASTERYCONTENT_3, MARKOFMASTERYCONTENT_3_INFO, MARKOFMASTERYCONTENT_2, MARKOFMASTERYCONTENT_2_INFO, MARKOFMASTERYCONTENT_1, MARKOFMASTERYCONTENT_1_INFO];

        public static const ACHIEVEMENT_RANK2:String="#achievements:achievement/rank2";

        public static const LUCKYDEVIL:String="#achievements:luckyDevil";
    }
}
