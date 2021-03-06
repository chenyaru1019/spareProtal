﻿<%@ WebHandler Language="C#" Class="OAOfficeHandler" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Runtime.Serialization;
using OThinker.H3.Portal.Entity;
using OThinker.H3.Portal.service;
using System.Net.Http;

public class OAOfficeHandler : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "generateNo": generateNo(context); break;
            case "getCommentByFlg": getCommentByFlg(context); break;
            case "getSWQuery": getSWQuery(context); break;
            case "getFWQuery": getFWQuery(context); break;
            case "getNoBusiContractQuery": getNoBusiContractQuery(context); break;
            case "getSupplierManagerQuery": getSupplierManagerQuery(context); break;
            case "getComments": getComments(context); break;
            case "insertComment": insertComment(context); break;
            case "getReads": getReads(context); break;
            case "insertRead": insertRead(context); break;
            case "getPLAndReadCounts": getPLAndReadCounts(context); break;
            case "getNoticeQuery": getNoticeQuery(context); break;
            case "getLicenceQuery": getLicenceQuery(context); break;

            case "FilterWorkflowByUser": FilterWorkflowByUser(context); break;

                //case "exportExcel": exportExcel(context); break;
        }
    }

    // exportExcel
    //public void exportExcel(HttpContext context)
    //{
    //    DataTable dataList = new DataTable(); string [] fields = {"id","name" }; string[] headTexts = { "id","name"}; string title = "测试标题"; string TableName = "test";
    //    DataRow dr;
    //    DataColumn dc;
    //    //添加第0列 
    //    dc=new DataColumn("id",System.Type.GetType("System.String"));
    //    dataList.Columns.Add(dc);
    //    dc=new DataColumn("name",System.Type.GetType("System.String"));
    //    dataList.Columns.Add(dc);
    //    dr = dataList.NewRow();
    //    dr["id"] = "123";dr["name"] = "呵呵";
    //    dataList.Rows.Add(dr);

    //    Common.ExportToExcel(dataList, fields, headTexts, title, TableName);
    //    //Common.outExcel();
    //    //object JSONObj = JsonConvert.SerializeObject("");
    //    //context.Response.ContentType = "application/json";
    //    //context.Response.Write(JSONObj);
    //}

    // 生成XX编号
    public void generateNo (HttpContext context) {
        string flg = context.Request["flg"];
        string No = "";
        string year = DateTime.Now.Year.ToString();
        string month = DateTime.Now.Month.ToString();
        int curyearnum = (int)Convert.ToSingle(getMaxNumOfCurYear(year,flg)) + 1;
        No = flg + year + month + string.Format("{0:0000}",curyearnum);

        object JSONObj = JsonConvert.SerializeObject(No);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    // 获取收文当年累积流水号
    public string getMaxNumOfCurYear(string year,string flg)
    {
        int num = 0;
        string sql = "";
        int prelen = flg.Length + 6;
        if(flg.Equals("SW"))
        {
            sql = " SELECT Max(SWNo) No FROM I_SW where SWNo like 'SW" + year + "%' ";
        } else if (flg.Equals("FW"))
        {
            sql = " SELECT Max(FWNo) No FROM I_FW where FWNo like 'FW" + year + "%' ";
        } else if (flg.Equals("HTBS"))
        {
            sql = " SELECT Max(ApplyNo) No FROM I_NoBusiContract where ApplyNo like 'HTBS" + year + "%' ";
        } else if (flg.Equals("YYSQ"))
        {
            sql = " SELECT Max(YYSQNo) No FROM I_YYSQ where YYSQNo like 'YYSQ" + year + "%' ";
        } else if (flg.Equals("GZBZ"))
        {
            sql = " SELECT Max(GZBZNo) No FROM I_GZBZ where GZBZNo like 'GZBZ" + year + "%' ";
        }
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {

            try
            {
                num = (int)Convert.ToSingle(dt.Rows[0]["No"].ToString().Substring(prelen));
            }
            catch (Exception exp)
            {
            }

            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }

    // 获取是否有相关部门审批或总经理审批的数据
    public void getCommentByFlg (HttpContext context) {
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


    // 获取公司收文处理记录
    public void getSWQuery(HttpContext context)
    {
        string Title = context.Request["Title"];
        string FileType = context.Request["FileType"];
        string FromDW = context.Request["FromDW"];
        string SWDateFrom = context.Request["SWDateFrom"];
        string SWDateTo = context.Request["SWDateTo"];

        var sql = " SELECT s.Title,s.FromNo,s.FromDW,CONVERT(varchar(12),s.SWDate,111) SWDate," +
                    " ic.OriginatorName,e1.EnumValue FileTypeName,ic.State Status,ic.ObjectID IcObjectID " +
                    " FROM I_SW s " +
                    " INNER JOIN OT_InstanceContext ic on s.ObjectID = ic.BizObjectId and ic.State = '4' " +
                    " INNER JOIN OT_EnumerableMetadata e1 on s.FileType = e1.Code and e1.Category = 'OA文件类型' ";
        //var sql2 = QK_Target.Equals("")?"":" and q.QK_Target = '" + QK_Target + "'  ";
        if(!Title.Equals(""))
        {
            sql += " and s.Title like '%"+Title+"%' ";
        }
        if(!FileType.Equals(""))
        {
            sql += " and e1.EnumValue = '"+FileType+"' ";
        }
        if(!FromDW.Equals(""))
        {
            sql += " and s.FromDW like '%"+FromDW+"%' ";
        }
        if(!SWDateFrom.Equals(""))
        {
            sql += " and s.SWDate >= '"+SWDateFrom+" 00:00:00' ";
        }
        if(!SWDateTo.Equals(""))
        {
            sql += " and s.SWDate <= '"+SWDateTo+" 23:59:59' ";
        }
        sql += "  order by s.CreatedTime ";

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
                dic.Add("FileType", dr["FileTypeName"].ToString());
                dic.Add("FromNo", dr["FromNo"].ToString());
                dic.Add("FromDW", dr["FromDW"].ToString());
                dic.Add("SWDate", dr["SWDate"].ToString());
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

    // 获取公司发文处理记录
    public void getFWQuery(HttpContext context)
    {
        string Title = context.Request["Title"];
        string FileType = context.Request["FileType"];
        string FWNo = context.Request["FWNo"];
        string FWDateFrom = context.Request["FWDateFrom"];
        string FWDateTo = context.Request["FWDateTo"];

        var sql = " SELECT s.Title,s.FWNo,CONVERT(varchar(12),s.FWDate,111) FWDate,ic.OriginatorName,e1.EnumValue FileTypeName,e2.EnumValue ImportLevelName,ic.State Status,ic.ObjectID IcObjectID " +
                    " FROM I_FW s " +
                    " INNER JOIN OT_InstanceContext ic on s.ObjectID = ic.BizObjectId and ic.State = '4' " +
                    " INNER JOIN OT_EnumerableMetadata e1 on s.FileType = e1.Code and e1.Category = 'OA文件类型' " +
                    " INNER JOIN OT_EnumerableMetadata e2 on s.ImportLevel = e2.Code and e2.Category = 'OA重要程度' ";
        //var sql2 = QK_Target.Equals("")?"":" and q.QK_Target = '" + QK_Target + "'  ";
        if(!Title.Equals(""))
        {
            sql += " and s.Title like '%"+Title+"%' ";
        }
        if(!FileType.Equals(""))
        {
            sql += " and e1.EnumValue = '"+FileType+"' ";
        }
        if(!FWNo.Equals(""))
        {
            sql += " and s.FWNo like '%"+FWNo+"%' ";
        }
        if(!FWDateFrom.Equals(""))
        {
            sql += " and s.FWDate >= '"+FWDateFrom+" 00:00:00' ";
        }
        if(!FWDateTo.Equals(""))
        {
            sql += " and s.FWDate <= '"+FWDateTo+" 23:59:59' ";
        }
        sql += "  order by s.CreatedTime ";

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
                dic.Add("FileType", dr["FileTypeName"].ToString());
                dic.Add("FWNo", dr["FWNo"].ToString());
                dic.Add("ImportLevel", dr["ImportLevelName"].ToString());
                dic.Add("FWDate", dr["FWDate"].ToString());
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

    // 获取非业务类合同审批记录
    public void getNoBusiContractQuery(HttpContext context)
    {
        string Title = context.Request["Title"];
        string SignDW = context.Request["SignDW"];
        string TheYear = context.Request["TheYear"];
        string ApplyDateFrom = context.Request["ApplyDateFrom"];
        string ApplyDateTo = context.Request["ApplyDateTo"];

        var sql = " SELECT s.Title,s.ApplyNo,CONVERT(varchar(12),s.ApplyDate,111) ApplyDate,s.SignDW,s.TheYear,ic.OriginatorName," +
                    "  ic.State Status,ic.ObjectID IcObjectID  " +
                    " FROM I_NoBusiContract s " +
                    " INNER JOIN OT_InstanceContext ic on s.ObjectID = ic.BizObjectId and ic.State = '4' " ;
        //var sql2 = QK_Target.Equals("")?"":" and q.QK_Target = '" + QK_Target + "'  ";
        if(!Title.Equals(""))
        {
            sql += " and s.Title like '%"+Title+"%' ";
        }
        if(!SignDW.Equals(""))
        {
            sql += " and s.SignDW like '%"+SignDW+"%' ";
        }
        if(!TheYear.Equals(""))
        {
            sql += " and s.TheYear = '"+TheYear+"' ";
        }
        if(!ApplyDateFrom.Equals(""))
        {
            sql += " and s.ApplyDate >= '"+ApplyDateFrom+" 00:00:00' ";
        }
        if(!ApplyDateTo.Equals(""))
        {
            sql += " and s.ApplyDate <= '"+ApplyDateTo+" 23:59:59' ";
        }
        sql += "  order by s.CreatedTime ";

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
                dic.Add("ApplyNo", dr["ApplyNo"].ToString());
                dic.Add("SignDW", dr["SignDW"].ToString());
                dic.Add("TheYear", dr["TheYear"].ToString());
                dic.Add("ApplyDate", dr["ApplyDate"].ToString());
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

    // 获取供应商管理记录
    public void getSupplierManagerQuery(HttpContext context)
    {
        string ManagerType = context.Request["ManagerType"];
        string SupplierName = context.Request["SupplierName"];
        string Salesman = context.Request["Salesman"];

        var sql = "  SELECT e1.EnumValue ManagerTypeName,s.SupplierName,s.SupplierNo,s.Contact,s.Telephone,s.ManagerOrg,s.Salesman," +
                    "  ic.State Status,ic.ObjectID IcObjectID  " +
                    " FROM I_SupplierManager s " +
                    " INNER JOIN OT_InstanceContext ic on s.ObjectID = ic.BizObjectId " +
                    " INNER JOIN OT_EnumerableMetadata e1 on s.ManagerType = e1.Code and e1.Category = 'OA管理类型' " ;
        //var sql2 = QK_Target.Equals("")?"":" and q.QK_Target = '" + QK_Target + "'  ";
        if(!ManagerType.Equals(""))
        {
            sql += " and e1.EnumValue = '"+ManagerType+"' ";
        }
        if(!SupplierName.Equals(""))
        {
            sql += " and s.SupplierName like '%"+SupplierName+"%' ";
        }
        if(!Salesman.Equals(""))
        {
            sql += " and s.Salesman = '"+Salesman+"' ";
        }
        sql += "  order by s.CreatedTime ";

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
                dic.Add("ManagerType", dr["ManagerTypeName"].ToString());
                dic.Add("SupplierName", dr["SupplierName"].ToString());
                dic.Add("SupplierNo", dr["SupplierNo"].ToString());
                dic.Add("Contact", dr["Contact"].ToString());
                dic.Add("Telephone", dr["Telephone"].ToString());
                dic.Add("ManagerOrg", dr["ManagerOrg"].ToString());
                dic.Add("Salesman", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["Salesman"].ToString()));
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                    else if (item.Key.Equals("ActivityCode"))
                    {
                        ActivityCode = item.Value;
                    }
                }
                string st = "";
                if (dr["Status"].ToString().Equals("4"))
                {
                    st = "完成";
                }
                else if (dr["Status"].ToString().Equals("2"))
                {

                    if (ActivityCode.Equals("ActivityOrig"))
                    {
                        st = "发起申请";
                    }
                    else
                    {
                        st = "审批中";
                    }

                }

                dic.Add("DisplayName", st);
                ls.Add(dic);
                TheNo++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取评论数据
    public void getComments(HttpContext context)
    {
        string ArticleID = context.Request["ArticleID"];
        var sql = " SELECT * from ( "+
                    " SELECT *,id groupId FROM PD_Comment "+
                    " where ArticleID = '"+ArticleID+"' and ParentId = '0' "+
                    " UNION "+
                    " SELECT c2.*,c2.ParentId groupId FROM PD_Comment c1, PD_Comment c2 "+
                    " where c1.ArticleID = '"+ArticleID+"' and c2.ArticleID = '"+ArticleID+"' and c1.Id = c2.ParentId "+
                    " ) t "+
                    " order by t.groupId desc, t.PLTime " ;

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {

                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("PLAuthor", dr["PLAuthor"].ToString());
                dic.Add("PLTime", dr["PLTime"].ToString());
                dic.Add("PLContent", dr["PLContent"].ToString());
                dic.Add("HFAuthor", dr["HFAuthor"].ToString());
                dic.Add("ParentId", dr["ParentId"].ToString());
                dic.Add("groupId", dr["groupId"].ToString());
                dic.Add("Id", dr["Id"].ToString());
                ls.Add(dic);

            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 新增评论数据
    public void insertComment(HttpContext context)
    {
        string ArticleID = context.Request["ArticleID"];
        string PLAuthor = context.Request["PLAuthor"];
        string PLContent = context.Request["PLContent"];
        string HFAuthor = context.Request["HFAuthor"];
        string ParentId = context.Request["ParentId"];
        var sql = " insert into PD_Comment ( " +
            " ArticleID," +
            " PLAuthor," +
            " PLTime," +
            " PLContent," +
            " HFAuthor," +
            " ParentId" +
            " ) values (" +
            " '"+ArticleID+"'," +
            " '"+PLAuthor+"'," +
            " getdate()," +
            " '"+PLContent+"'," +
            " '"+HFAuthor+"'," +
            " '"+ParentId+"'" +
            " ) " ;
        string ret = "";
        try
        {
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
            ret = "success";
        } catch(Exception e)
        {
            ret = "error";
        }

        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取查阅数据
    public void getReads(HttpContext context)
    {
        string ArticleID = context.Request["ArticleID"];
        var sql = " SELECT * from PD_Read where ArticleID = '"+ArticleID+"' order by ReadTime desc " ;

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        if (dt.Rows.Count > 0)
        {
            var TheNo = 1;
            foreach (DataRow dr in dt.Rows)
            {

                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo++.ToString());
                dic.Add("Reader", dr["Reader"].ToString());
                dic.Add("ReadTime", dr["ReadTime"].ToString());
                ls.Add(dic);

            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 新增查阅数据
    public void insertRead(HttpContext context)
    {
        string ArticleID = context.Request["ArticleID"];
        string Reader = context.Request["Reader"];
        var sql = " insert into PD_Read ( " +
            " ArticleID," +
            " Reader," +
            " ReadTime" +
            " ) values (" +
            " '"+ArticleID+"'," +
            " '"+Reader+"'," +
            " getdate()" +
            " ) " ;
        string ret = "";
        try
        {
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
            ret = "success";
        } catch(Exception e)
        {
            ret = "error";
        }

        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取评论数据数和查阅数
    public void getPLAndReadCounts(HttpContext context)
    {
        string ArticleID = context.Request["ArticleID"];
        var sqlPL = " SELECT count(1) cnt from PD_Comment where ArticleID = '"+ArticleID+"'" ;
        var sqlRead = " SELECT count(1) cnt from PD_Read where ArticleID = '"+ArticleID+"'" ;

        System.Data.DataTable dtPL = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqlPL);
        System.Data.DataTable dtRead = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqlRead);
        Dictionary<string, string> dic = new Dictionary<string, string>();
        // 
        if (dtPL.Rows.Count > 0)
        {
            dic.Add("PLCount",dtPL.Rows[0]["cnt"].ToString());
        }
        if (dtRead.Rows.Count > 0)
        {
            dic.Add("ReadCount",dtRead.Rows[0]["cnt"].ToString());
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取公司公告记录
    public void getNoticeQuery(HttpContext context)
    {
        string Title = context.Request["Title"];
        string NoticeType = context.Request["NoticeType"];
        //string Content = context.Request["Content"];
        var sql = " select t1.*,t2.cnt PLCount,t3.cnt ReadCount "+
                    " from "+
                    " (SELECT n.ObjectID BizObjectId,n.IsTop,n.Title,CONVERT(varchar(12),n.PublishDate,111) PublishDate,e1.EnumValue Status,e2.EnumValue NoticeType,n.RejectFlg, "+
                    " ic.State ,ic.ObjectID IcObjectId,ic.OriginatorName,v.ObjectID vObjectID,ic2.ObjectID IcObjectId2 "+
                    " FROM I_Notice n "+
                    " INNER JOIN OT_InstanceContext ic on n.ObjectID = ic.BizObjectID " +
                    " Left JOIN OT_EnumerableMetadata e1 on e1.Category = 'OA公告状态' and n.Status = e1.Code " +
                    " Left JOIN OT_EnumerableMetadata e2 on e2.Category = 'OA公告类型' and n.NoticeType = e2.Code " +
                    " Left JOIN I_NoticeView v on v.NoticeInstanceID = n.ObjectID " +
                    " Left JOIN OT_InstanceContext ic2 on v.ObjectID = ic2.BizObjectID "+
                    " ) t1, "+
                    " (select n.ObjectID, count(c.id) cnt "+
                    " from I_Notice n "+
                    " left JOIN PD_Comment c on c.ArticleId = n.ObjectID "+
                    " group by n.ObjectID "+
                    " ) t2, "+
                    " (select n.ObjectID, count(r.id) cnt "+
                    " from I_Notice n "+
                    " left JOIN PD_Read r on r.ArticleId = n.ObjectID "+
                    " group by n.ObjectID "+
                    " ) t3 "+
                    " where t1.BizObjectID = t2.ObjectID and t1.BizObjectID = t3.ObjectID ";
        if(!Title.Equals(""))
        {
            sql += " and t1.Title like '%"+Title+"%' ";
        }
        if(!NoticeType.Equals(""))
        {
            sql += " and t1.NoticeType = '"+NoticeType+"' ";
        }
        sql += "  order by t1.IsTop desc,t1.PublishDate ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        var TheNo = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("IsTop", dr["IsTop"].ToString());
                dic.Add("Title", dr["Title"].ToString());
                dic.Add("PublishDate", dr["PublishDate"].ToString());
                dic.Add("Status", dr["Status"].ToString());
                dic.Add("NoticeType", dr["NoticeType"].ToString());
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["State"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                    else if (item.Key.Equals("ActivityCode"))
                    {
                        ActivityCode = item.Value;
                    }
                }
                string st = "";
                if (dr["State"].ToString().Equals("4"))
                {
                    st = "完成";
                    Dictionary<string, string> workItemDic2 = Common.getWorkItemId(dr["IcObjectId2"].ToString(), "4");
                    foreach (var item in workItemDic2)
                    {
                        Console.WriteLine(item.Key + item.Value);
                        if (item.Key.Equals("workItemId"))
                        {
                            dic.Add("WorkItemId2", item.Value);
                        }
                    }
                }
                else if (dr["State"].ToString().Equals("2"))
                {
                    if (dr["RejectFlg"].ToString().Equals("1"))
                    {
                        st = "驳回";
                    }
                    else
                    {
                        if (ActivityCode.Equals("ActivityOrig"))
                        {
                            st = "发起公告";
                        }
                        else
                        {
                            st = "审批中";
                        }

                    }
                }


                dic.Add("DisplayName", st);
                dic.Add("RejectFlg", dr["RejectFlg"].ToString());
                dic.Add("Originator", dr["OriginatorName"].ToString());
                dic.Add("PLCount", dr["PLCount"].ToString());
                dic.Add("ReadCount", dr["ReadCount"].ToString());
                ls.Add(dic);
                TheNo++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取证照印章记录
    public void getLicenceQuery(HttpContext context)
    {

        string LicenceType = context.Request["LicenceType"];
        string LicenceNo = context.Request["LicenceNo"];
        string LicenceName = context.Request["LicenceName"];
        var sql = " SELECT e1.EnumValue LicenceTypeName,l.LicenceNo,l.LicenceName, "+
                    " CONVERT(varchar(12),l.StartDate,111) StartDate,CONVERT(varchar(12),l.EndDate,111) EndDate, "+
                    " CONVERT(varchar(12),l.NJDate,111) NJDate,CONVERT(varchar(12),l.ChangeLicDate,111) ChangeLicDate, "+
                    " ic.State ,ic.ObjectID IcObjectId "+
                    " FROM I_LicenceManager l "+
                    " INNER JOIN OT_InstanceContext ic on l.ObjectID = ic.BizObjectID  "+
                    " INNER JOIN OT_EnumerableMetadata e1 on e1.Category = 'OA证件类型' and l.LicenceType = e1.Code ";

        if(!LicenceType.Equals(""))
        {
            sql += " and e1.EnumValue = '"+LicenceType+"' ";
        }
        if(!LicenceNo.Equals(""))
        {
            sql += " and l.LicenceNo like '%"+LicenceNo+"%' ";
        }
        if(!LicenceName.Equals(""))
        {
            sql += " and l.LicenceName like '%"+LicenceName+"%' ";
        }
        sql += "  ORDER BY l.CreateTime ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        var TheNo = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("LicenceType", dr["LicenceTypeName"].ToString());
                dic.Add("LicenceNo", dr["LicenceNo"].ToString());
                dic.Add("LicenceName", dr["LicenceName"].ToString());
                dic.Add("StartDate", dr["StartDate"].ToString());
                dic.Add("EndDate", dr["EndDate"].ToString());
                dic.Add("NJDate", dr["NJDate"].ToString());
                dic.Add("ChangeLicDate", dr["ChangeLicDate"].ToString());
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["State"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                    else if (item.Key.Equals("ActivityCode"))
                    {
                        ActivityCode = item.Value;
                    }
                }
                string st = "";
                if (dr["State"].ToString().Equals("4"))
                {
                    st = "完成";
                }
                else if (dr["State"].ToString().Equals("2"))
                {
                    if (ActivityCode.Equals("ActivityOrig"))
                    {
                        st = "发起申请";
                    }
                    else
                    {
                        st = "审批中";
                    }
                }
                dic.Add("DisplayName", st);
                ls.Add(dic);
                TheNo++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 
    public void FilterWorkflowByUser(HttpContext context)
    {

        string nodes = context.Request["nodes"];
        string userName = context.Request["userName"];
        OThinker.Organization.User user = Common.getUserByName(userName);
        List<Dictionary<string, Object>> ls = new List<Dictionary<string, Object>>();
        JArray ja = (JArray)JsonConvert.DeserializeObject(nodes);
        foreach(JObject item in ja) {
            Dictionary<string, Object> dic = RecuGetNodes(item, user.ObjectID, userName);
            if(dic != null)
            {
                ls.Add(dic);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    public Dictionary<string, Object> RecuGetNodes(JObject item, string userId, string userName)
    {
        Dictionary<string, Object> dic = new Dictionary<string, Object>();
        dic.Add("IsLeaf",item["IsLeaf"]);
        dic.Add("ObjectID",item["ObjectID"].ToString());
        dic.Add("Code",item["Code"].ToString());
        dic.Add("DisplayName",item["DisplayName"].ToString());
        dic.Add("PublishedTime",item["PublishedTime"]);
        dic.Add("Version",item["Version"]);
        dic.Add("Frequent",item["Frequent"]);
        dic.Add("IconFileName",item["IconFileName"].ToString());
        dic.Add("Icon",item["Icon"]);
        if(item["IsLeaf"].ToString().Equals("True"))
        {
            if (userName == "系统管理员" || hasAcl(item["Code"].ToString(),userId))
            {
                dic.Add("children",item["children"].ToString());
            } else
            {
                return null;
            }

        } else
        {
            List<Dictionary<string, Object>> chs = new List<Dictionary<string, Object>>();
            JArray ja = (JArray)JsonConvert.DeserializeObject(item["children"].ToString());
            foreach(JObject jo in ja) {
                Dictionary<string, Object> d = RecuGetNodes(jo,userId,userName);
                if(d != null)
                {
                    chs.Add(d);
                }
            }
            if(chs.Count >0)
            {
                dic.Add("children",chs);
            } else
            {
                return null;
            }

        }

        return dic;
    }

    // 如果当前用户有查看权限、或者组织（包含当前用户的组织）有权限，返回true
    public bool hasAcl(string code, string userId)
    {
        if(hasAclByWorkflowCode(code, userId))
        {
            return true;
        }
        string[] arr = getOrgIDByWorkflowCode(code);
        List<OThinker.Organization.User> users = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetMemberUsers(arr, OThinker.Organization.State.Unspecified);
        foreach(OThinker.Organization.User u in users)
        {
            if(userId.Equals(u.ObjectID))
            {
                return true;
            }
        }
        return false;

    }

    // 获取当前用户是否可以查看此流程的权限
    public bool hasAclByWorkflowCode(string code, string userId)
    {
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        " SELECT u.ObjectID " +
        " FROM OT_BizObjectAcl ba " +
        " INNER JOIN OT_User u on ba.UserID = u.ObjectID and ba.SchemaCode = '"+code+"' and ba.ViewData = '1' and u.ObjectID ='"+userId+"' ");
        if (dt.Rows.Count > 0)
        {
            return true;
        }
        return false;
    }


    // 获取流程节点中配置了对应查看权限的组织结构ID（包含组织和角色）
    public string [] getOrgIDByWorkflowCode(string code)
    {

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        " SELECT ou.ObjectID " +
        " FROM OT_BizObjectAcl ba " +
        " INNER JOIN OT_OrganizationUnit ou on ba.UserID = ou.ObjectID and ba.SchemaCode = '"+code+"' and ba.ViewData = '1' " +
        " Union " +
        " SELECT g.ObjectID " +
        " FROM OT_BizObjectAcl ba " +
        " INNER JOIN OT_Group g on ba.UserID = g.ObjectID and ba.SchemaCode = '"+code+"' and ba.ViewData = '1' ");
        string[] orgs = new string[dt.Rows.Count];
        if (dt.Rows.Count > 0)
        {
            var i = 0;
            foreach(DataRow dr in dt.Rows)
            {
                orgs[i++] = dr["ObjectID"].ToString();
            }
        }
        return orgs;
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