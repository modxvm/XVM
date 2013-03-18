class wot.crew.CrewLoader
{
    public static var s_defaultCrew:Array = []; // save crew list

    public static function PutCrewAction(args)
    {
        switch (args.id)
        {
            case "PutOwnCrew":
                LoadCrew(PutCrew(CheckOwn));
                break;

            case "PutBestCrew":
                LoadCrew(PutCrew(CheckBest));
                break;
        }
    }

    private static function LoadCrew(crew)
    {
        for (var i = 0; i < crew.length; ++i)
        {
            var t:Object = crew[i];
            if (t["compact"] != "")
                gfx.io.GameDelegate.call("tankmen.equipTankman", [t["compact"], null, t["slot"]]);
        }
    }
    
    private static function PutCrew(checkFunc:Function):Array
    {
        var tnkObj:Object = s_defaultCrew[0];
        var tankmanList = new Array();

        for (var index:Object in s_defaultCrew)
        {
            var slot = s_defaultCrew[index];
            if (slot["inTank"] == true)
                continue;
            var theRecruits = slot["recruitList"];

            var mostSuitable = null;
            for (var y in theRecruits)
            {
                var tankMan = theRecruits[y];
                if (tankMan["compact"] == null || tankMan["inTank"] == true || TankmanInArray(tankmanList, tankMan))
                    continue;
                if (!checkFunc(tankMan, mostSuitable, tnkObj))
                    continue;
                mostSuitable = tankMan;
                break;
            }
            if (mostSuitable != null)
            {
                mostSuitable["slot"] = slot["slot"];
                tankmanList.push(mostSuitable);
            }
        }
        return tankmanList;
    }

    private static function CheckOwn(actualCandidate:Object, bestChoice:Object, theTank:Object)
    {
        if (actualCandidate["vehicleType"] != s_defaultCrew[0]["curVehicleName"])
            return;
        return CheckBest(actualCandidate, bestChoice, theTank);
    }
    
    /**
     * Compares two tankman
     * @param actualTankman current candidate
     * @param bestTankman current best candidate
     * @param theTank
     * @return
     */
    private static function CheckBest(actualTankman:Object, bestTankman:Object, theTank:Object):Boolean
    {
		//No bestTankman : select first tankman met
        if (bestTankman == null)
            return true;

        var current = getPenality(actualTankman, theTank);
        var best = getPenality(bestTankman, theTank);
		
		//CASE 1 : bestTankman is better than actual
		//conserve the bestTankman
        if (best > current)
            return false;
			
		//CASE 2 : bestTankman's capacity is equal with the actualTankman's skill
		//Need deeper analysis
        else if (best == current)
		{
			//CASE 2.1 : bestTankman has more skills than actualTankman
			//conserve the bestTankman
			if (bestTankman["skills"].length > actualTankman["skills"].length)
				return false;
			
			//CASE 2.2 : bestTankman has less skills than actualTankman
			//select the actualTankman
			if (bestTankman["skills"].length < actualTankman["skills"].length)
				return true;
			
			//CASE 2.3 : bestTankman has the same number of skills that the actualTankman
			//if the bestTankman's lastskilllevel is < that actualTankman's
			//select the actualTankman
			if (bestTankman["lastSkillLevel"] < actualTankman["lastSkillLevel"])
				return true;
			
		}
		//CASE 3 : actual tankman is better than bestTankman
		//select the actualTankman
        else if (best < current)
            return true;
        
			
        return false;
    }
    
    /**
     * skill tankman penality
     * @param aTankman
     * @param dummyTankman current tank's
     * @return Tankman's efficiencyLevel - penality
     */
    private static function getPenality(tankman:Object, dummyTankman:Object)
    {
        var res = 0;
        
        if (tankman["vehicleType"] == dummyTankman["curVehicleName"])
            res = 0;
        else 
        {
            if (tankman["tankType"] == dummyTankman["curVehicleType"])
            {
                // 25% penalty same tanktype but tank is different
                res = (dummyTankman["vehicleElite"] == true) ? 0 : ((tankman["efficiencyLevel"] / 100) * 25);
            }
            else 
            {
                // 50% penalty different tanktype
                res = ((tankman["efficiencyLevel"] / 100) * 50);
            }
        }
        return tankman["efficiencyLevel"] - res;
    }
	
    private static function TankmanInArray(list:Array, elem:Object):Boolean
    {
        for (var i = 0; i < list.length; ++i)
        {
            if (list[i]["tankmanID"] == elem["tankmanID"])
                return true;
        }
        return false;
    }    
}