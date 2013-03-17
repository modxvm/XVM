/**
 * 
 * @author LEMAXHO
 */

//FOR HINA-ICHIGO
import wot.utils.Locale;
import wot.crew.tankmen.Crew;

class wot.crew.tankmen.CrewItemRenderer extends net.wargaming.tankmen.CrewItemRenderer
{
    function CrewItemRenderer()
    {
        super();
    }
	
    function configUI()
    {
        super.configUI();
        onMouseDownFunc = onMouseDownFuncImpl;
        onMouseDown = onMouseDownFunc;
    }

    function onMouseDownFuncImpl(button, target)
    {
        if (Mouse.RIGHT == button)
            close();
        if (Mouse.RIGHT == button && this.hitTest(_root._xmouse, _root._ymouse, true))
        {
            var top = Mouse.getTopMostEntity();
            var ok = false;
            while (top)
            {
                if (top == this)
                {
                    ok = true;
                    break;
                }
                top = top._parent;
            }
            if (!ok || _disabled)
                return;

            if (data.tankmanID > 0)
            {
                var menu = net.wargaming.managers.ContextMenuManager.instance.show([
                    ["personalCase"],
                    [net.wargaming.controls.ContextMenu.SEPARATE],
                    ["tankmanUnload"],
                    ["tankmanUnloadAll"],
                    [net.wargaming.controls.ContextMenu.SEPARATE],
                    ["dismiss"]], false, {id: data.tankmanID});
                menu.addEventListener("action", this, "onContextMenuAction");
            }
            // Add menu 
            else if (this.data.tankmanID == null)
            {
                var menu = net.wargaming.managers.ContextMenuManager.instance.show([
                    [{id: "PutOwnCrew", label: Locale.get("PutOwnCrew") }],
                    [net.wargaming.controls.ContextMenu.SEPARATE],
                    [{id: "PutBestCrew", label: Locale.get("PutBestCrew") }]
                    ], false, {id: this.data.tankmanID});
                menu.addEventListener("action", this, "onPutRightCrewAction");
            }
        }
    }
    
    //SUISEISEKI
    function onPutRightCrewAction(args)
    {
        switch (args.id)
        {
            case "PutOwnCrew":
            {
                var theTankman:Array = SuigintouAdvice(Crew.s_listTankmen);
                
                for (var index in theTankman)
                {
                    var tankiste:Object = theTankman[index];
                    if (tankiste["compact"] != "")
                    {
                        //set tankman
                        gfx.io.GameDelegate.call("tankmen.equipTankman", [tankiste["compact"], null, tankiste["slot"]]);
                    }
                }
                break;
            } 
            case "PutBestCrew":
            {
                var theTankman:Array = SouseisekiAdvice(Crew.s_listTankmen);
                
                for (var index in theTankman)
                {
                    var tankiste:Object = theTankman[index];
                    if (tankiste["compact"] != "")
                    {
                        //set tankman
                        gfx.io.GameDelegate.call("tankmen.equipTankman", [tankiste["compact"], null, tankiste["slot"]]);
                    }
                }
                break;
            }
        }
    }
	
    // Sui advices you and gives a list of this tank's crew members
    function SuigintouAdvice(theCrew:Array):Array
    {
        // le tank actuel est identifie dans le dummy tankman de l'en tete
        var theTank:String = theCrew[0]["curVehicleName"];// is not null
        
        var bestTankmanList = new Array();
        
        for (var index:Object in theCrew)
        {
            var aSlot = theCrew[index];
            var theRecruits = aSlot["recruitList"];
            
            if (aSlot["inTank"]!=true)
            {
                for (var y in theRecruits)
                {
                    var tnkmn = theRecruits[y];
                    var tnkfinded = false;
                    //verifier si objet est complet et si pas encore ete ajoute
                    if (tnkmn["compact"] != null && !SouseisekiInArray(bestTankmanList,tnkmn))
                    {
                        //hypothese : il y a qu'un seul tankiste de ce type de char dans la caserne
                        //et verif qu'il n'est pas deja dans le tank
                        if (tnkmn["vehicleType"] == theTank && tnkmn["inTank"]== false)
                        {
                            tnkmn["slot"] = aSlot["slot"];
                            bestTankmanList.push(tnkmn);
                            tnkfinded = true;
                        }
                    }
                    if(tnkfinded)
                    {
                        break;
                    }
                }
            }
        }
        return bestTankmanList;
    }
    
    // Souseiseki gies you the most capable crew for this tank
    //RETURNS: an array with available crew fot this tank
    function SouseisekiAdvice(theCrew:Array):Array
    {
        //vehicleType
        var theTank:String = theCrew[0]["curVehicleName"];//is not null
        var tnkObj:Object = theCrew[0];
        
        var bestTankmanList = new Array();
        
        for (var index:Object in theCrew)
        {
            var aSlot = theCrew[index];
            var theRecruits = aSlot["recruitList"];
            if (aSlot["inTank"]!=true)//!=true car sinon valeur est null et pas false
            {
                var mostSuitable = null;// current best choice
                
                for (var y in theRecruits)
                {
                    var tnkmn = theRecruits[y];	
                    //verifier si objet complet et si pas encore ete ajoute
                    if (tnkmn["compact"] != null && tnkmn["inTank"]== false && !SouseisekiInArray(bestTankmanList,tnkmn))
                    {
                        //current best choice
                        //appel fonction de comparaison et choix qui va decider 
                        //si oui ou non le tankman actuel est mieux qualifie que le precedent
                        if (askShinku(mostSuitable, tnkmn, tnkObj))
                        {
                            mostSuitable = tnkmn;
                        }
                    }
                }
                if (mostSuitable != null)
                {
                    mostSuitable["slot"] = aSlot["slot"];
                    bestTankmanList.push(mostSuitable);
                }
            }
        }
        return bestTankmanList;
    }
    
    //Compares two tankman
    //best choice  current best candidate
    //actualCandidate : current candidate
    function askShinku(bestChoice:Object, actualCandidate:Object, theTank:Object):Boolean
    {
        var res:Boolean = false;
        
        //efficiencyLevel : niveau d'exp principal 50 - 100%
        //availableSkillsCount : nombre des skills disponibles  null - 1 - 2 ...
        //lastSkillLevel : niveau du dernier skill - a evaluer si le nombre des skills est egal entre les deux candidats
        
        //premier candidat rencontre
        if (bestChoice == null)
        {
            return true;
        }
        //sinon evaluation des deux candidats
        
        
        //CASE1 : type des candidats correspond au type du char
        var best = getPenality(bestChoice, theTank);
        var current = getPenality(actualCandidate, theTank);
        if (best > current)
        {
            return false;
        }
        else if (best == current)
        {
            //le skill standard est egal
            if (bestChoice["skills"].length > actualCandidate["skills"].length)
            {
                    return false;
            }
            //bestChoice["skills"].length <= actualCandidate["skills"].length
            else
            {
                if (bestChoice["skills"].length < actualCandidate["skills"].length)
                {
                    return true;
                }
                else
                {
                    //bestChoice["skills"].length == actualCandidate["skills"].length
                    if (bestChoice["lastSkillLevel"] < actualCandidate["lastSkillLevel"])
                    {
                        return true;
                    }
                }
            }
        }
        else if(best < current)
        {
            return true;
        }
        
        return res;
    }
    
    //skill tankman penality
    //dummyTankman contient les donnees du tank en cours
    //dummyTankman : current tank's data
    //RETURNS: Tankman's efficiencyLevel - penality
    function getPenality(aTankman:Object, dummyTankman:Object)
    {
        var res = 0;
        
        if (aTankman["vehicleType"] == dummyTankman["curVehicleName"])
        {
            res = 0;
        }
        else 
        {
            //25% penality same tanktype but tank is different
            if(aTankman["tankType"] == dummyTankman["curVehicleType"])
            {
                if (dummyTankman["vehicleElite"] == true)
                {
                    res = 0;
                }
                else 
                {
                    res = ((aTankman["efficiencyLevel"] /100) * 25);
                }
            }
            //TYPE DIFFERENT PENALITE 50%
            //tankType different
            else 
            {
                res = ((aTankman["efficiencyLevel"] / 100) * 50);
            }
        }
        return aTankman["efficiencyLevel"] - res;
    }
	
    //verifie si l'objet tankman est present dans la liste
    //controle des tankmanID des objects
    function SouseisekiInArray(theList:Array, elem:Object):Boolean
    {
        for (var index in theList)
        {
            if (theList[index]["tankmanID"] == elem["tankmanID"])
            {
                //on sort, doublon trouve
                return true;
            }
        }
        return false;
    }
} 
