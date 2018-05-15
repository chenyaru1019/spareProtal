﻿<%@ WebHandler Language="C#" Class="AttendanceStatisticsHandler" %>
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
using System.Text;

public class AttendanceStatisticsHandler : IHttpHandler {

    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            // case "getCommentByFlg": getCommentByFlg(context);break;
            case "getAttendanceStatisticsQuery": getAttendanceStatisticsQuery(context);break;
            case "hidExport_Click": hidExport_Click(context);break;
            case "exportExcel":exportExcel(context);break;
                //case "doBGContract": doBGContract(context); break;


        }
    }

    public void getAttendanceStatisticsQuery(HttpContext context) {
        string ParticularYear = context.Request["ParticularYear"];
        string Organization = context.Request["Organization"];
        System.Data.DataTable dt = getAllAttendanceStatistics(ParticularYear,Organization);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        var TheNo = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("StaffName", dr["StaffName"].ToString());
                dic.Add("TotalDays1", dr["TotalDays1"].ToString());
                dic.Add("SumApplyDays1", dr["SumApplyDays1"].ToString());
                dic.Add("TotalDays2", dr["TotalDays2"].ToString());
                dic.Add("SumApplyDays2", dr["SumApplyDays2"].ToString());
                dic.Add("SumApplyDays3", dr["SumApplyDays3"].ToString());
                dic.Add("SumApplyDays4", dr["SumApplyDays4"].ToString());
                dic.Add("SumApplyDays5", dr["SumApplyDays5"].ToString());
                dic.Add("SumApplyDays6", dr["SumApplyDays6"].ToString());
                dic.Add("SumApplyDays7", dr["SumApplyDays7"].ToString());
                dic.Add("SumApplyDays8", dr["SumApplyDays8"].ToString());
                dic.Add("SumApplyDays9", dr["SumApplyDays9"].ToString());
                dic.Add("SumApplyDays10", dr["SumApplyDays10"].ToString());
                dic.Add("SumApplyDays11", dr["SumApplyDays11"].ToString());
                dic.Add("SumApplyDays12", dr["SumApplyDays12"].ToString());
                dic.Add("SumApplyDays13", dr["SumApplyDays13"].ToString());
                dic.Add("SumApplyDays14", dr["SumApplyDays14"].ToString());
                dic.Add("SumApplyDays15", dr["SumApplyDays15"].ToString());
                dic.Add("SumApplyDays16", dr["SumApplyDays16"].ToString());
                //Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                //foreach (var item in workItemDic)
                //{
                //    Console.WriteLine(item.Key + item.Value);
                //    if (item.Key.Equals("workItemId"))
                //    {
                //        dic.Add("WorkItemId", item.Value);
                //    }
                //}
                ls.Add(dic);
                TheNo++;
            }
        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);


    }
    private System.Data.DataTable getAllAttendanceStatistics(string ParticularYear,string Organization) {
        string[] HolidayTypes = { "带薪年休假","加班补休假","带薪病假","婚假","丧假","探亲假","晚育护理假","计划生育假","教育考试假","产前检查假","产前假","产假","晚育假","哺乳假","病假","事假"};
        var sql = " select otuser.Name as StaffName,";

        for (int i=0;i<HolidayTypes.Length;i++) {
            if (i<2)
            {
                sql += "ISNULL((select  shs.TotalDays FROM I_StaffHolidaySetting shs " +
                "WHERE shs.HolidayType='" + HolidayTypes[i] + "' and shs.StaffObjectId = sim.RoleId and shs.ParticularYear='" + ParticularYear + "'), 0) as TotalDays" + (i + 1) + ", " +
                "ISNULL((select SUM(e1.SumApplyDays) from I_EmployeeLeaveRequest e1 " +
                "INNER JOIN OT_InstanceContext ic on e1.ObjectID = ic.BizObjectId and ic.State = '4' " +
                "WHERE sim.RoleId = e1.Applicant AND e1.HolidayType='" + HolidayTypes[i] + "' and e1.ParticularYear='" + ParticularYear + "' " +
                "GROUP BY e1.Applicant,e1.HolidayType,e1.ParticularYear), 0) as SumApplyDays" + (i + 1) + ", ";
            }else  if (i == (HolidayTypes.Length - 1))
            {
                sql += "ISNULL((select SUM(e1.SumApplyDays) from I_EmployeeLeaveRequest e1 " +
                        "INNER JOIN OT_InstanceContext ic on e1.ObjectID = ic.BizObjectId and ic.State = '4' " +
                        "WHERE sim.RoleId = e1.Applicant AND e1.HolidayType='" + HolidayTypes[i] + "' and e1.ParticularYear='" + ParticularYear + "' " +
                     "GROUP BY e1.Applicant,e1.HolidayType,e1.ParticularYear), '') as SumApplyDays" + (i + 1) + " ";
            }
            else {

                sql += "ISNULL((select SUM(e1.SumApplyDays) from I_EmployeeLeaveRequest e1 " +
                        "INNER JOIN OT_InstanceContext ic on e1.ObjectID = ic.BizObjectId and ic.State = '4' " +
                         "WHERE sim.RoleId = e1.Applicant AND e1.HolidayType='" + HolidayTypes[i] + "' and e1.ParticularYear='" + ParticularYear + "' " +
                         "GROUP BY e1.Applicant,e1.HolidayType,e1.ParticularYear), '') as SumApplyDays"+(i+1)+",";
            }

        }
        sql += "from I_StaffInformationManagement sim " +
       "LEFT JOIN OT_User otuser on otuser.ObjectID = sim.StaffName " +
       "LEFT JOIN I_StaffHolidaySetting shs on sim.RoleId = shs.StaffObjectId ";
        //"LEFT JOIN I_EmployeeLeaveRequest e on sim.RoleId=e.Applicant";

        if(!Organization.Equals(""))
        {
            sql += " where sim.Organization = '"+Organization+"' ";
        }

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql );

        return dt;

    }
    //内容很好理解，只需当成Table来拼字符串即可 (ParticularYear,Organization)
    private string getExcelContent(string ParticularYear,string Organization)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<h3>员工考勤统计</h3>");
        sb.Append("<table class='table table-striped table-bordered table-hover' id='table_AttendanceStatisticsQuery' border=\"1\"> ");
        sb.Append("<thead> <tr bgcolor='Yellow'><th rowspan='2' >员工</th>");
        sb.Append("<th rowspan='2' >年份</th>");
        sb.Append("<th colspan='3' >带薪年休假</th>");
        sb.Append("<th colspan='3' >加班补休假</th>");
        sb.Append("<th rowspan='2' >带薪病假</th>");
        sb.Append("<th rowspan='2' >婚假</th>");
        sb.Append("<th rowspan='2' >丧假</th>");
        sb.Append("<th rowspan='2' >探亲假</th>");
        sb.Append("<th rowspan='2' >晚育护理假</th>");
        sb.Append("<th rowspan='2' >计划生育假</th>");
        sb.Append("<th rowspan='2' >教育考试假</th>");
        sb.Append("<th rowspan='2' >产前检查假</th>");
        sb.Append("<th rowspan='2' >产前假</th>");
        sb.Append("<th rowspan='2' >产假</th>");
        sb.Append("<th rowspan='2' >晚育假</th>");
        sb.Append("<th rowspan='2' >哺乳假</th>");
        sb.Append("<th rowspan='2' >病假</th>");
        sb.Append("<th rowspan='2' >事假</th>");
        sb.Append(" </tr><tr bgcolor='Yellow'><th >总数</th>");
        sb.Append("<th >已用</th>");
        sb.Append(" <th >剩余</th>");
        sb.Append("<th >总数</th>");
        sb.Append(" <th >已用</th>");
        sb.Append("<th >剩余</th>");
        sb.Append(" </tr> </thead><tbody>");
        System.Data.DataTable dt = getAllAttendanceStatistics(ParticularYear,Organization);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("<tr><td>");
                sb.Append( dr["StaffName"].ToString());
                sb.Append("</td><td>");
                sb.Append(ParticularYear+"");
                sb.Append("</td><td>");
                if (dr["TotalDays1"].ToString().Equals("0")) {

                    sb.Append("");
                }
                else
                {
                    sb.Append(dr["TotalDays1"].ToString());
                }
                sb.Append("</td><td>");
                if (dr["SumApplyDays1"].ToString().Equals("0")) {

                    sb.Append("");
                }
                else
                {
                    sb.Append(dr["SumApplyDays1"].ToString());
                }
                sb.Append("</td><td>");
                double DaysRemaining1 = (double)dr["TotalDays1"] - (double)dr["SumApplyDays1"];
                if (DaysRemaining1==0)
                {
                    sb.Append("");
                }
                else
                {
                    sb.Append(DaysRemaining1);
                }
                sb.Append("</td><td>");
                if (dr["TotalDays2"].ToString().Equals("0")) {

                    sb.Append("");
                }
                else
                {
                    sb.Append(dr["TotalDays2"].ToString());
                }
                sb.Append("</td><td>");
                if (dr["SumApplyDays2"].ToString().Equals("0")) {

                    sb.Append("");
                }
                else
                {
                    sb.Append(dr["SumApplyDays2"].ToString());
                }
                sb.Append("</td><td>");
                double DaysRemaining2 = (double)dr["TotalDays2"] - (double)dr["SumApplyDays2"];
                if (DaysRemaining2==0)
                {
                    sb.Append("");
                }
                else
                {
                    sb.Append(DaysRemaining2);
                }
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays3"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays4"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays5"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays6"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays7"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays8"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays9"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays10"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays11"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays12"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays13"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays14"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays15"].ToString());
                sb.Append("</td><td>");
                sb.Append( dr["SumApplyDays16"].ToString());
                sb.Append("</td>");


                //Dictionary<string, string> dic = new Dictionary<string, string>();
                //dic.Add("StaffName", dr["StaffName"].ToString());
                //dic.Add("TotalDays1", dr["TotalDays1"].ToString());
                //dic.Add("SumApplyDays1", dr["SumApplyDays1"].ToString());


                //dic.Add("SumApplyDays2", dr["SumApplyDays2"].ToString());
                //dic.Add("SumApplyDays3", dr["SumApplyDays3"].ToString());
                //dic.Add("SumApplyDays4", dr["SumApplyDays4"].ToString());
                //dic.Add("SumApplyDays5", dr["SumApplyDays5"].ToString());
                //dic.Add("SumApplyDays6", dr["SumApplyDays6"].ToString());
                //dic.Add("SumApplyDays7", dr["SumApplyDays7"].ToString());
                //dic.Add("SumApplyDays8", dr["SumApplyDays8"].ToString());
                //dic.Add("SumApplyDays9", dr["SumApplyDays9"].ToString());
                //dic.Add("SumApplyDays10", dr["SumApplyDays10"].ToString());
                //dic.Add("SumApplyDays11", dr["SumApplyDays11"].ToString());
                //dic.Add("SumApplyDays12", dr["SumApplyDays12"].ToString());
                //dic.Add("SumApplyDays13", dr["SumApplyDays13"].ToString());
                //dic.Add("SumApplyDays14", dr["SumApplyDays14"].ToString());
                //dic.Add("SumApplyDays15", dr["SumApplyDays15"].ToString());
                //dic.Add("SumApplyDays16", dr["SumApplyDays16"].ToString());
                //Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                //foreach (var item in workItemDic)
                //{
                //    Console.WriteLine(item.Key + item.Value);
                //    if (item.Key.Equals("workItemId"))
                //    {
                //        dic.Add("WorkItemId", item.Value);
                //    }
                //}
                //ls.Add(dic);
                //TheNo++;
            }
        }
        //List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //var TheNo = 1;
        //DataSet ds=new DataSet();
        //ds.Tables.Add(dt);
        //sb.Append( " </tbody> </table>");
        return sb.ToString();
        //return ds;
    }

    public void hidExport_Click(HttpContext context)
    {
        string ParticularYear = context.Request["ParticularYear"];
        string Organization = context.Request["Organization"];
        string content = getExcelContent(ParticularYear,Organization);

        //DataSet ds = getExcelContent(ParticularYear, Organization);
        System.Data.DataTable dt = getAllAttendanceStatistics(ParticularYear,Organization);

        //string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
        string filename = "考勤统计";
        CommonTool.ExportToExcel(filename,content);
        //CommonTool.ExportToExcel(dt,filename,content);
        //CommonTool.ExportToExcel(dt,filename, content ,css);
        //CommonTool.ExportDataSetToExcel(ds, filename, "sheet1");
        //object JSONObj = JsonConvert.SerializeObject(ls);
        //context.Response.ContentType = "application/json";
        //context.Response.Write(JSONObj);
    }

    // exportExcel
    public void exportExcel(HttpContext context)
    {
        string ParticularYear = context.Request["ParticularYear"];
        string Organization = context.Request["Organization"];
        System.Data.DataTable dataList = getAllAttendanceStatistics(ParticularYear,Organization);
        string [] fields = { "员工姓名","年度" }; string[] headTexts = { "员工姓名","年度"}; string title = "员工考勤统计"; string TableName = "员工考勤统计";
        //DataRow dr;
        DataColumn dc;
        //添加第0列 
        dc=new DataColumn("员工姓名",System.Type.GetType("System.String"));
        dataList.Columns.Add(dc);
        dc=new DataColumn("年度",System.Type.GetType("System.String"));
        dataList.Columns.Add(dc);
        //dr = dataList.NewRow();
        //dr["id"] = "123";dr["name"] = "呵呵";
        //dataList.Rows.Add(dr);

        Common.ExportToExcel(dataList, fields, headTexts, title, TableName);
        //Common.outExcel();
        //object JSONObj = JsonConvert.SerializeObject("");
        //context.Response.ContentType = "application/json";
        //context.Response.Write(JSONObj);
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