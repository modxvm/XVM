/**
 * Based on Tank Icon Maker by Roman Starkov
 * https://bitbucket.org/rstarkov/tankdataconverter
 * GPLv3
 */
using System;
using System.IO;
using System.Linq;
using RT.Util;
using RT.Util.ExtensionMethods;
using RT.Util.Json;
using System.Collections.Generic;

namespace VehicleBankParser
{
    class Program
    {
        static Dictionary<string, string> descriptionNameFullWG = new Dictionary<string, string>();
        static Dictionary<string, string> descriptionNameShortWG = new Dictionary<string, string>();
        static HashSet<string> hardcodedExceptions = new HashSet<string>(new[] { "china-Ch01_Type59_Gold", "usa-T23", "germany-White_Tiger" });

        static void Main(string[] args)
        {
            var vehicleListPath = @"res\scripts\item_defs\vehicles\{0}\list.xml";
            var moFilesPath = @"res\text\LC_MESSAGES";
            var countries = new[] { "ussr", "germany", "usa", "france", "china", "uk" };
            var outputPath = @"D:\bank.txt";

            descriptionNameFullWG["Ru"] = "Полные названия танков, оригинал – как в игре.";
            descriptionNameFullWG["En"] = "Full tank names, original – like in the game.";
            descriptionNameShortWG["Ru"] = "Короткие названия танков, оригинал – как в игре.";
            descriptionNameShortWG["En"] = "Short tank names, original – like in the game.";

            //generateFiles(@"I:\Games\WorldOfTanks\GameEn", "En", "0.7.4", new[] { "ussr", "germany", "usa", "france", "china" }, outputPath, vehicleListPath, moFilesPath);
            //generateFiles(@"I:\Games\WorldOfTanks\GameRu", "Ru", "0.7.4", new[] { "ussr", "germany", "usa", "france", "china" }, outputPath, vehicleListPath, moFilesPath);
            generateFiles(@"D:\Program Files\World_of_Tanks", "Ru", "0.7.5", countries, outputPath, vehicleListPath, moFilesPath);
        }

        private static void generateFiles(string gamePath, string lang, string builtInVersion, string[] countries, string outputPath, string vehicleListPath, string moFilesPath)
        {
            // Read the tank data from game files

            var splitStringRef = Ut.Lambda((string str) =>
            {
                var split = str.Split(':');
                if (split.Length != 2) throw new Exception();
                if (!split[0].StartsWith("#")) throw new Exception();
                return new { file = split[0].Substring(1), key = split[1] };
            });

            var tanks = countries.SelectMany(country =>
                BxmlReader.ReadFile(Path.Combine(gamePath, vehicleListPath.Fmt(country)))
                .AsDict
                .Select(kvp => new { country, id = kvp.Key, raw = kvp.Value })
            ).ToDictionary(tank => tank.country + "-" + tank.id, tank =>
            {
                var tags1 = tank.raw["tags"].AsString.Split("\r\n").Select(s => s.Trim()).ToHashSet();
                var tags2 = tank.raw["tags"].AsString.Split(' ').Select(s => s.Trim()).ToHashSet();
                var tags = tags1.Count > tags2.Count ? tags1 : tags2;
                bool notInShop = tank.raw.ContainsKey("notInShop") && tank.raw["notInShop"].AsBool;
                bool gold = tank.raw["price"] is JsonDict && tank.raw["price"].ContainsKey("gold");
                return new
                {
                    tank.id,
                    tank.country,
                    tank.raw,
                    nameFull = splitStringRef(tank.raw["userString"].AsString),
                    nameShort = splitStringRef(tank.raw.ContainsKey("shortUserString") ? tank.raw["shortUserString"].AsString : tank.raw["userString"].AsString),
                    tier = tank.raw["level"].AsInt,
                    secret = tags.Contains("secret"),
                    tags, notInShop, gold,
                    kind = notInShop ? "special" : gold ? "premium" : "normal",
                    class_ = tags.Contains("lightTank") ? "light" : tags.Contains("mediumTank") ? "medium" : tags.Contains("heavyTank") ? "heavy" : tags.Contains("SPG") ? "artillery" : tags.Contains("AT-SPG") ? "destroyer" : Ut.Throw<string>(new Exception("Unknown tank class")),
                };
            });

            foreach (var id in hardcodedExceptions)
                tanks.Remove(id);

            var moFiles = tanks.Select(kvp => kvp.Value.nameFull.file).Concat(tanks.Select(kvp => kvp.Value.nameShort.file)).Distinct()
                .ToDictionary(filename => filename, filename => MoReader.ReadFile(Path.Combine(gamePath, moFilesPath, filename + ".mo")));

            // Generate data

            // Built-in
            using (var csv = OpenWriteCsv(Path.Combine(outputPath, "Data-BuiltIn-{0}-001.csv".Fmt(builtInVersion))))
            {
                csv.WriteLine("WOT-BUILTIN-DATA,1,,,");
                foreach (var tank in tanks.OrderBy(tank => tank.Key))
                    csv.WriteLine(ToCsv(new[] { tank.Key, tank.Value.country, tank.Value.tier.ToString(), tank.Value.class_, tank.Value.kind }));
            }

            // NameFullWG
            using (var csv = OpenWriteCsv(Path.Combine(outputPath, "Data-NameFullWG-{0}-Romkyns-0.0.0-001.csv".Fmt(lang))))
            {
                csv.WriteLine(ToCsv(new[] { "WOT-DATA", "1", descriptionNameFullWG[lang] }));
                foreach (var tank in tanks.OrderBy(tank => tank.Key))
                    csv.WriteLine(ToCsv(new[] { tank.Key, moFiles[tank.Value.nameFull.file][tank.Value.nameFull.key] }));
            }

            // NameShortWG
            using (var csv = OpenWriteCsv(Path.Combine(outputPath, "Data-NameShortWG-{0}-Romkyns-0.0.0-001.csv".Fmt(lang))))
            {
                csv.WriteLine(ToCsv(new[] { "WOT-DATA", "1", descriptionNameShortWG[lang] }));
                foreach (var tank in tanks.OrderBy(tank => tank.Key))
                    csv.WriteLine(ToCsv(new[] { tank.Key, moFiles[tank.Value.nameShort.file][tank.Value.nameShort.key] }));
            }
        }

        private static StreamWriter OpenWriteCsv(string filename)
        {
            return new StreamWriter(File.Open(filename, FileMode.Create, FileAccess.Write, FileShare.Read));
        }

        private static string ToCsv(string[] row)
        {
            return string.Join(",", row.Select(f => f.Contains('"') || f.Contains(',') ? ("\"" + f.Replace("\"", "\"\"") + "\"") : f));
        }
    }
}
