using System;
using System.Net.Http;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using LitJson;

namespace wot
{
    class XvmApi
    {
        private static HttpClient client = new HttpClient();

        private string Token { get; set; } = "-";

        public string ServerUrl { get; } = "https://stat.modxvm.com:443";

        public string ApiVersion { get; } = "4.0";

        public XvmApi()
        {
            Token = getTokenFromClient();
        }

        public XvmApi(string token)
        {
            Token = token;
        }

        public async Task<List<Stat>> GetStatsAsync(IEnumerable<long> ids)
        {
            var stats = new List<Stat>();

            var datastr = "";
            foreach(var id in ids)
            {
                datastr += $"{id}=0,";
            }
            datastr = datastr.TrimEnd(',');

            var request_url = getRequestUri("getStats", datastr);

            var resp = await client.GetAsync(request_url);
            var content = await resp.Content.ReadAsStringAsync();

            var jd = JsonMapper.ToObject(content);
            foreach(JsonData player in jd["players"])
            {
                var stat = new Stat();
                stat.id = int.Parse(player["_id"].ToString());
                stat.name = player["nm"].ToString();
                stat.wins = int.Parse(player["w"].ToString());
                stat.battles = int.Parse(player["b"].ToString());
                stat.eff = int.Parse(player["wn8"].ToString());

                stats.Add(stat);
            }

            return stats;
        }


        private string getRequestUri(string requestType, string requestData)
        {
            return $"{ServerUrl}/{ApiVersion}/{requestType}/{Token}/{requestData}";
        }

        private string getTokenFromClient()
        {
            var wothome = $"{Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)}/Wargaming.net/WorldOfTanks";
            var latestAccountFilepath = $"{wothome}/xvm/tokens/lastAccountDBID.dat";
            if (!File.Exists(latestAccountFilepath)){
                return "-";
            }

            var latestAccount = File.ReadAllLines(latestAccountFilepath).First().Substring(1);

            var accountFilepath = $"{wothome}/xvm/tokens/{latestAccount}.dat";
            if (!File.Exists(accountFilepath)){
                return "-";
            }

            var lines = File.ReadAllLines(accountFilepath);
            for(int i = 0; i < lines.Length; i++)
            {
                if(lines[i]!= "sS'token'")
                {
                    continue;
                }

                return lines[i + 2].Substring(1).Trim('\'');
            }

            return "-";
        }
    }
}
