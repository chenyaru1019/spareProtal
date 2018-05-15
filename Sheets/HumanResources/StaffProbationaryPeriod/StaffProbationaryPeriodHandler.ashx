<%@ WebHandler Language="C#" Class="StaffProbationaryPeriodHandler" %>
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

public class StaffProbationaryPeriodHandler : IHttpHandler {

    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "getCommentByFlg": getCommentByFlg(context);break;
            case "getStaffProbationaryPeriodQuery": getStaffProbationaryPeriodQuery(context);break;
                //case "doBGContract": doBGContract(context); break;


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
    public void getStaffProbationaryPeriodQuery(HttpContext context) {
        string StaffName = context.Request["StaffName"];
        string Organization = context.Request["Organization"];
        string ApplicationDateFrom = context.Request["ApplicationDateFrom"];
        string ApplicationDateTo = context.Request["ApplicationDateTo"];
        var sql = " SELECT s.StaffName,s.Organization,CONVERT(varchar(12),s.CreatedTime,111) ApplicationDate,s.TalkingAboutGraphsAndTrends," +
                    " ic.State Status,ic.ObjectID IcObjectID " +
                    " FROM I_StaffProbationaryPeriod s " +
                    " INNER JOIN OT_InstanceContext ic on s.ObjectID = ic.BizObjectId and ic.State = '4' ";

        if(!StaffName.Equals(""))
        {
            sql += " and s.StaffName like '%"+StaffName+"%' ";
        }
        if(!Organization.Equals(""))
        {
            sql += " and s.Organization = '"+Organization+"' ";
        }
        if(!ApplicationDateFrom.Equals(""))
        {
            sql += " and s.CreatedTime >= '"+ApplicationDateFrom+" 00:00:00' ";
        }
        if(!ApplicationDateTo.Equals(""))
        {
            sql += " and s.CreatedTime <= '"+ApplicationDateTo+" 23:59:59' ";
        }
        sql += "  order by s.CreatedTime desc ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql );
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        var TheNo = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("StaffName", dr["StaffName"].ToString());
                dic.Add("Organization", dr["Organization"].ToString());
                dic.Add("ApplicationDate", dr["ApplicationDate"].ToString());
                dic.Add("TalkingAboutGraphsAndTrends", dr["TalkingAboutGraphsAndTrends"].ToString());
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                }
                ls.Add(dic);
                TheNo++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
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