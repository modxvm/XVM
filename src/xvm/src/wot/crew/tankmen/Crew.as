/**
 * @author LEMAXHO
 */

//FOR SUIGINTOU
import wot.utils.Config;
import wot.utils.Utils;

class wot.crew.tankmen.Crew extends net.wargaming.tankmen.Crew
{
    public static var s_listTankmen:Array = []; //save crew list

    public function Crew()
    {
        super();

        Utils.TraceXvmModule("Crew");

        Config.LoadConfig("BattleLoading.as");
    }

    public function putCrewList(value:Array) 
    {
        Crew.s_listTankmen = value;
    }

    function setTankmenRoles(data)
    {
        tankmenRoles.slice(0, tankmenRoles.length);
        tankmenRoles = data;
    }

    function setTankmen(data)
    {
        var _loc19 = new Array();
        for (var _loc20 in tankmenRoles.reverse())
        {
            var _loc3;
            if (tankmenRoles[_loc20].tankmanID != null)
            {
                _loc3 = data[tankmenRoles[_loc20].tankmanID];
            }
            else
            {
                _loc3 = {iconFile: tankmenRoles[_loc20].nationID == 0 ? ("ussr-empty.png") : ("germany-empty.png"), role: tankmenRoles[_loc20].role, roleIconFile: tankmenRoles[_loc20].roleIcon, firstname: tankmenRoles[_loc20].firstname ? (tankmenRoles[_loc20].firstname) : (""), lastname: tankmenRoles[_loc20].lastname ? (tankmenRoles[_loc20].lastname) : (""), rank: tankmenRoles[_loc20].rank ? (tankmenRoles[_loc20].rank) : (""), specializationLevel: -1, vehicleType: tankmenRoles[_loc20].vehicleType, tankType: tankmenRoles[_loc20].tankType, tankmanID: null};
            } // end else if
            _loc3.slot = tankmenRoles[_loc20].slot;
            _loc3.curVehicleType = tankmenRoles[_loc20].tankType;
            _loc3.curVehicleName = tankmenRoles[_loc20].vehicleType;
            _loc3.roles = tankmenRoles[_loc20].roles;
            _loc3.vehicleElite = tankmenRoles[_loc20].vehicleElite;
            _loc3.recruitList = new Array();
            _loc3.recruitList.push({specializationLevel: 101, recruit: true, roleType: tankmenRoles[_loc20].roleType, role: tankmenRoles[_loc20].role, roleIconFile: tankmenRoles[_loc20].roleIcon, vehicleType: tankmenRoles[_loc20].vehicleType, typeID: tankmenRoles[_loc20].typeID, nationID: tankmenRoles[_loc20].nationID, iconFile: tankmenRoles[_loc20].nationID == 0 ? ("ussr-empty.png") : ("germany-empty.png"), tankType: tankmenRoles[_loc20].tankType});
            for (var _loc13 in data)
            {
                if (data[_loc13].roleType == tankmenRoles[_loc20].roleType && data[_loc13].nationID == tankmenRoles[_loc20].nationID)
                {
                    if (data[_loc13].tankmanID == tankmenRoles[_loc20].tankmanID)
                    {
                        data[_loc13].selected = true;
                    } // end if
                    if (!data[_loc13].inTank || data[_loc13].tankmanID == tankmenRoles[_loc20].tankmanID)
                    {
                        _loc3.recruitList.push(data[_loc13]);
                    } // end if
                } // end if
            } // end of for...in
            _loc19.push(_loc3);
        } // end of for...in
        list.dataProvider.cleanUp();
        list.dataProvider = _loc19;
		
        //LEMAXHO ADDON
        this.putCrewList(_loc19);//setting the crewlist
		
        bg._height = list.dataProvider.length * list.rowHeight;
    }
	
} 
