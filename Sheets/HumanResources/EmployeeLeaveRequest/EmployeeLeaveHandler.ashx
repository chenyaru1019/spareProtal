<%@ WebHandler Language="C#" Class="EmployeeLeaveHandler" %>
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

public class EmployeeLeaveHandler : IHttpHandler {

    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "generateEmployeeLeaveNo": generateEmployeeLeaveNo(context); break;
            case "getSurplusDaysBeforeApplying": getSurplusDaysBeforeApplying(context);break;
                //case "doBGContract": doBGContract(context); break;


        }
    }

    public void generateEmployeeLeaveNo (HttpContext context) {

        string ApplicationNumber = "";
        string year = DateTime.Now.Year.ToString();
        year = string.Format("{0:yyyy}", year);
        string month = DateTime.Now.Month.ToString();
        month = string.Format("{0:MM}",month);
        string YGQJ = "YGQJ";

        //a)YGQJ201709065
        //YGQJ：员工请假申请
        //2017：当前年度
        //09：当前月份
        //065：当年累积流水号，三位数
        int curContnum = (int)Convert.ToSingle(getMaxContNumOfPro(YGQJ,year,month)) + 1;
        ApplicationNumber = YGQJ + year+month + string.Format("{0:000}",curContnum);


        object JSONObj = JsonConvert.SerializeObject(ApplicationNumber);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    public string getMaxContNumOfPro(string YGQJ,string year,string month)
    {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ApplicationNumber FROM I_EmployeeLeaveRequest where ApplicationNumber like '%"+YGQJ+year+"%' ");
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
    public void getSurplusDaysBeforeApplying(HttpContext context) {
        string ParticularYear = context.Request["ParticularYear"];
        string HolidayType = context.Request["HolidayType"];
        string Applicant = context.Request["Applicant"];
        var sql = " SELECT s.TotalDays " +
                    " FROM I_StaffHolidaySetting s " +
                    " INNER JOIN OT_EnumerableMetadata e1 on s.HolidayType = e1.Code and e1.Category = '员工假期类型' " ;
        if(!ParticularYear.Equals(""))
        {
            sql += " and s.ParticularYear = '"+ParticularYear+"' ";
        }
        if(!HolidayType.Equals(""))
        {
            sql += " and e1.EnumValue = '"+HolidayType+"' ";
        }
        sql += " and s.StaffObjectId = '"+Applicant+"' ";
        sql += "  order by s.CreatedTime desc ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql );
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        double TotalDays = 0;
        if (dt.Rows.Count > 0)
        {
            TotalDays =  (double)dt.Rows[0]["TotalDays"];
            //foreach (DataRow dr in dt.Rows)
            //{
            //    Dictionary<string, string> dic = new Dictionary<string, string>();

            //    dic.Add("Title", dr["Title"].ToString());
            //    dic.Add("BusinessType", dr["FileTypeName"].ToString());
            //    dic.Add("ApplicationNumber", dr["ApplicationNumber"].ToString());
            //    dic.Add("ApplicationDate", dr["ApplicationDate"].ToString());
            //    dic.Add("Originator", dr["OriginatorName"].ToString());
            //    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
            //    foreach (var item in workItemDic)
            //    {
            //        Console.WriteLine(item.Key + item.Value);
            //        if (item.Key.Equals("workItemId"))
            //        {
            //            dic.Add("WorkItemId", item.Value);
            //        }
            //    }
            //    ls.Add(dic);
            //    TheNo++;
            //}
        }

        var sql2 = " select SUM(e.SumApplyDays) SumApplyDays from I_EmployeeLeaveRequest e   " +
                   " INNER JOIN OT_EnumerableMetadata e1 on e.HolidayType = e1.Code and e1.Category = '员工假期类型'  ";
        if(!ParticularYear.Equals(""))
        {
            sql2 += " and e.ParticularYear = '"+ParticularYear+"' ";
        }
        if(!HolidayType.Equals(""))
        {
            sql2 += " and e1.EnumValue = '"+HolidayType+"' ";
        }
        sql2 += " and e.Applicant = '"+Applicant+"' ";
        sql2 += " GROUP BY  e.Applicant,e.HolidayType,e.ParticularYear ";

        System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2 );
        
        double SumApplyDays = 0;

        if (dt2.Rows.Count > 0)
        {
            if (dt2.Rows[0]!= null &&dt2.Rows[0]["SumApplyDays"] !=null && !"".Equals(dt2.Rows[0]["SumApplyDays"].ToString())) {
            SumApplyDays =  (double)dt2.Rows[0]["SumApplyDays"];
            }
            //foreach (DataRow dr in dt.Rows)
            //{
            //    Dictionary<string, string> dic = new Dictionary<string, string>();

            //    dic.Add("Title", dr["Title"].ToString());
            //    dic.Add("BusinessType", dr["FileTypeName"].ToString());
            //    dic.Add("ApplicationNumber", dr["ApplicationNumber"].ToString());
            //    dic.Add("ApplicationDate", dr["ApplicationDate"].ToString());
            //    dic.Add("Originator", dr["OriginatorName"].ToString());
            //    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
            //    foreach (var item in workItemDic)
            //    {
            //        Console.WriteLine(item.Key + item.Value);
            //        if (item.Key.Equals("workItemId"))
            //        {
            //            dic.Add("WorkItemId", item.Value);
            //        }
            //    }
            //    ls.Add(dic);
            //    TheNo++;
            //}
        }

        object JSONObj = JsonConvert.SerializeObject(TotalDays-SumApplyDays);
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