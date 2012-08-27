using System;
using System.Diagnostics;

class Program
{
    /**
     * Program purpose:
     *  Get vehicles list with secondary turret modules equippable and corresponding HP.
     *  List is then used in XVM to add stock\top turret tank marker.
     * Author: ilitvinov87@gmail.com
     * 
     * RT.Util.Json and BxmlReader.cs author Roman Starkov https://bitbucket.org/rstarkov/tankdataconverter
     */

    static void Main(string[] args)
    {
        FileBank fileBank = new FileBank();
        fileBank.getBank();
        //Filter.process(fileBank);
        
        //Debug.WriteLine(fileBank.getBank().Count);

        //"\"crew\":"
        // - Define stock\top vehicles + max hitpoints
            
        // Make CSV bank
    }
}
