<%@ WebHandler Language="C#" Class="AgreeMent_main" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;


public class AgreeMent_main : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            
            case "getByAgreeMent_number": getByAgreeMent_number(context); break;
  

        }
    }




 //申请协议号修改

    public void getByAgreeMent_number (HttpContext context) {
        Dictionary<string,string> dic = new Dictionary<string,string>();
        string AgreeMent_number = context.Request["AgreeMent_number"];
       
       
        String numberid = "SELECT Project_head_A,Project_head_B,AgreeMent_name,Agreement_client,AgreeMent_number  FROM I_AgreeMent_mains where AgreeMent_number='"+AgreeMent_number+"'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
           numberid);
        if (dt.Rows.Count > 0)
        {
            dic.Add("Project_head",OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["Project_head_A"].ToString())+','+OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["Project_head_B"].ToString()));
            dic.Add("AgreeMent_name",dt.Rows[0]["AgreeMent_name"].ToString());
            dic.Add("Agreement_client",dt.Rows[0]["Agreement_client"].ToString());
            dic.Add("AgreeMent_number",dt.Rows[0]["AgreeMent_number"].ToString());
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }






    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    private IEngine _Engine = null;
    /// <summary>
    /// 流程引擎的接口，该接口会比this.Engine的方式更快，因为其中使用了缓存
    /// </summary>
    public IEngine Engine
    {
        get
        {
            if (OThinker.H3.Controllers.AppConfig.ConnectionMode == ConnectionStringParser.ConnectionMode.Mono)
            {
                return OThinker.H3.Controllers.AppUtility.Engine;
            }
            return _Engine;
        }
        set
        {
            _Engine = value;
        }
    }

}