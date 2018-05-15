<%@ WebHandler Language="C#" Class="EmployeeHumanHandler" %>
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

public class EmployeeHumanHandler : IHttpHandler {

    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "generateEmployeeHumanNo": generateEmployeeHumanNo(context); break;
            case "getCommentByFlg": getCommentByFlg(context);break;
            case "getEmployeeHumanQuery": getEmployeeHumanQuery(context);break;
                //case "doBGContract": doBGContract(context); break;


        }
    }

    public void generateEmployeeHumanNo (HttpContext context) {

        string ApplicationNumber = "";
        string year = DateTime.Now.Year.ToString();
        year = string.Format("{0:yyyy}", year);
        string month = DateTime.Now.Month.ToString();
        month = string.Format("{0:MM}",month);
        string RSSP = "RSSP";

        //RSSP2017090065
        //RSSP：员工人力资源事项审批
        //2017：当前年度
        //09：当前月份
        //0065：当年累积流水号，四位数
        int curContnum = (int)Convert.ToSingle(getMaxContNumOfPro(RSSP,year,month)) + 1;
        ApplicationNumber = RSSP + year+month + string.Format("{0:0000}",curContnum);


        object JSONObj = JsonConvert.SerializeObject(ApplicationNumber);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    public string getMaxContNumOfPro(string RSSP,string year,string month)
    {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ApplicationNumber FROM I_EmployeeHumanResourceAffairs where ApplicationNumber like '%"+RSSP+year+"%' ");
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        int len = (RSSP).Length + (year).Length+ (month).Length;
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
    public void getEmployeeHumanQuery(HttpContext context) {
        string Title = context.Request["Title"];
        string BusinessType = context.Request["BusinessType"];
        string ApplicationNumber = context.Request["ApplicationNumber"];
        string ApplicationDateFrom = context.Request["ApplicationDateFrom"];
        string ApplicationDateTo = context.Request["ApplicationDateTo"];
        var sql = " SELECT e.Title,e.ApplicationNumber,CONVERT(varchar(12),e.ApplicationDate,111) ApplicationDate," +
                    " ic.OriginatorName,e1.EnumValue FileTypeName,ic.State Status,ic.ObjectID IcObjectID " +
                    " FROM I_EmployeeHumanResourceAffairs e " +
                    " INNER JOIN OT_InstanceContext ic on e.ObjectID = ic.BizObjectId and ic.State = '4' " +
                    " INNER JOIN OT_EnumerableMetadata e1 on e.BusinessType = e1.Code and e1.Category = '员工人力资源事务的业务类型' ";
         if(!Title.Equals(""))
        {
            sql += " and e.Title like '%"+Title+"%' ";
        }
        if(!BusinessType.Equals(""))
        {
            sql += " and e1.EnumValue = '"+BusinessType+"' ";
        }
        if(!ApplicationNumber.Equals(""))
        {
            sql += " and e.ApplicationNumber like '%"+ApplicationNumber+"%' ";
        }
        if(!ApplicationDateFrom.Equals(""))
        {
            sql += " and e.ApplicationDate >= '"+ApplicationDateFrom+" 00:00:00' ";
        }
        if(!ApplicationDateTo.Equals(""))
        {
            sql += " and e.ApplicationDate <= '"+ApplicationDateTo+" 23:59:59' ";
        }
        sql += "  order by e.CreatedTime desc ";

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
                dic.Add("Title", dr["Title"].ToString());
                dic.Add("BusinessType", dr["FileTypeName"].ToString());
                dic.Add("ApplicationNumber", dr["ApplicationNumber"].ToString());
                dic.Add("ApplicationDate", dr["ApplicationDate"].ToString());
                dic.Add("Originator", dr["OriginatorName"].ToString());
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