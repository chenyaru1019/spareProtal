<%@ WebHandler Language="C#" Class="EmployeeOvertimeHandler" %>
using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;
using OThinker.H3.Portal.Entity;
using OThinker.H3.Portal.service;

public class EmployeeOvertimeHandler : IHttpHandler {

    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "generateEmployeeOvertimeNo": generateEmployeeOvertimeNo(context); break;
            case "getCommentByFlg": getCommentByFlg(context);break;
                //case "getSurplusDaysBeforeApplying": getSurplusDaysBeforeApplying(context);break;
                //case "doBGContract": doBGContract(context); break;


        }
    }

    public void generateEmployeeOvertimeNo (HttpContext context) {

        string ApplicationNumber = "";
        string year = DateTime.Now.Year.ToString();
        year = string.Format("{0:yyyy}", year);
        string month = DateTime.Now.Month.ToString();
        month = string.Format("{0:MM}",month);
        string YGJB = "YGJB";

        //a)YGJB201709065
        // YGJB：员工加班申请
        // 2017：当前年度
        // 09：当前月份
        // 065：当年累积流水号，三位数
        int curContnum = (int)Convert.ToSingle(getMaxContNumOfPro(YGJB,year,month)) + 1;
        ApplicationNumber = YGJB + year+month + string.Format("{0:000}",curContnum);


        object JSONObj = JsonConvert.SerializeObject(ApplicationNumber);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    public string getMaxContNumOfPro(string YGQJ,string year,string month)
    {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ApplicationNumber FROM I_EmployeeOvertimeApplication where ApplicationNumber like '%"+YGQJ+year+"%' ");
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        int len = (YGQJ).Length + (year).Length+ (month).Length;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                try
                {
                    int curnum = (int)Convert.ToSingle(dr["ApplicationNumber"].ToString().Substring(len));

                    if (curnum > num)
                    {
                        num = curnum;
                    }

                }
                catch (Exception exp)
                {
                    continue;
                }

            }
            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }
    public void getCommentByFlg(HttpContext context) {
        string flg = context.Request["flg"];
        string InstanceId = context.Request["InstanceId"];
        string ret = "";
        string sql = " select ObjectID from OT_Comment " +
        " where InstanceId = '" + InstanceId + "' " +
        " and Activity = '"+flg+"'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            ret = dt.Rows[0]["ObjectID"].ToString();
        }
        object JSONObj = JsonConvert.SerializeObject(ret);
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