/**
 * ...
 * @author Assassik
 */
class wot.Minimap.model.mapSize.MapInfoData
{
    /** 
     * List of system mapnames
     */
    private static var data:Object;

    private static function setupData()
    {
        data = new Object();
        //data["00_tank_tutorial"] =  { size: };
        data["01_karelia"] =          { size: 100 }; // Карелия
        data["02_malinovka"] =        { size: 100 }; // Малиновка
        data["03_campania"] =         { size: 60 };  // Провинция
        data["04_himmelsdorf"] =      { size: 70 };  // Химмельсдорф
        data["05_prohorovka"] =       { size: 100 }; // Прохоровка
        data["06_ensk"] =             { size: 60 };  // Энск
        data["07_lakeville"] =        { size: 80 };  // Ласвилль
        data["08_ruinberg"] =         { size: 80 };  // Руинберг
        data["10_hills"] =            { size: 80 };  // Рудники
        data["11_murovanka"] =        { size: 80 };  // Мурованка
        data["13_erlenberg"] =        { size: 100 }; // Эрленберг
        data["14_siegfried_line"] =   { size: 100 }; // Линия Зигфрида
        data["15_komarin"] =          { size: 80 };  // Комарин
        data["17_munchen"] =          { size: 60 };  // Уайдпарк
        data["18_cliff"] =            { size: 100 }; // Утёс
        data["19_monastery"] =        { size: 100 }; // Монастырь
        data["23_westfeld"] =         { size: 100 }; // Вестфилд
        data["28_desert"] =           { size: 100 }; // Песчаная река
        data["29_el_hallouf"] =       { size: 100 }; // Эль-Халлуф
        data["31_airfield"] =         { size: 100 }; // Аэропорт
        data["33_fjord"] =            { size: 100 }; // Фьорды
        data["34_redshire"] =         { size: 100 }; // Редшир
        data["35_steppes"] =          { size: 100 }; // Степи
        data["36_fishing_bay"] =      { size: 100 }; // Рыбацкая бухта
        data["37_caucasus"] =         { size: 100 }; // Перевал
        data["38_mannerheim_line"] =  { size: 100 }; // Заполярье
        data["39_crimea"] =           { size: 100 }; // Южный берег
        data["42_north_america"] =    { size: 83 };  // Порт
        data["44_north_america"] =    { size: 100 }; // Лайв Окс
        data["45_north_america"] =    { size: 100 }; // Хайвей
        data["47_canada_a"] =         { size: 100 }; // Тихий берег
        data["51_asia"] =             { size: 100 }; // Хребет дракона
        data["60_asia_miao"] =        { size: 100 }; // Жемчужная река
        data["73_asia_korea"] =       { size: 100 }; // Священная долина
        data["85_winter"] =           { size: 100 }; // Белогорск-19
    }

    public static function getData():Object
    {
        if (!data) 
            setupData();
        return data;
    }
}