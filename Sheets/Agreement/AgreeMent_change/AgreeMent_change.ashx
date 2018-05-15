<%@ WebHandler Language="C#" Class="AgreeMent_change" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;


public class AgreeMent_change : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "getAgreement": getAgreement(context); break;

        }
    }
    //数据加载要变更的协议
    public void getAgreement (HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string agency_type = context.Request["agency_type"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        
        String sqls = "";
        if ("USD".Equals(agency_type)) {
            sqls = "select AgreeMent_number,AgreeMent_name,Agreement_client,Pay_conditions,CreatedTime " +
                "from I_AircraftOilAgreement  where AgreeMent_number='"+AgreeMent_number+"'";
        }
        else
        {
            sqls = "select AgreeMent_number,AgreeMent_name,Agreement_client,agency_rate,Pay_conditions,CreatedTime " +
                    "from I_Agreement_mains  where AgreeMent_number='"+AgreeMent_number+"'";

        }
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        if (dt.Rows.Count > 0) {
            dic.Add("AgreeMent_number",dt.Rows[0]["AgreeMent_number"].ToString());
            dic.Add("Agreement_name",dt.Rows[0]["AgreeMent_name"].ToString());
            dic.Add("Agreement_entrust",dt.Rows[0]["Agreement_client"].ToString());
            dic.Add("PayConditionOld",dt.Rows[0]["Pay_conditions"].ToString());
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