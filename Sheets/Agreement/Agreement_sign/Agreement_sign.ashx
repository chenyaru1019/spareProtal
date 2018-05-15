﻿<%@ WebHandler Language="C#" Class="Agreement_sign" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;


public class Agreement_sign : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "Agreementcont": Agreementcont(context); break;
            case "getAgency_ratesByANO": getAgency_ratesByANO(context); break;        
            case "getrecord": getrecord(context); break;
        }
    }
    //审签协议内容
    public void Agreementcont(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        Dictionary<string, object> dic = new Dictionary<string, object>();
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        String sqls = "SELECT am.Project_head_A,am.Project_head_B,am.AgreeMent_number,am.AgreeMent_name,am.Agreement_client,am.Agency_Pro_approval,am.Pay_conditions,am.CreatedBy,am.CreatedTime " +
                        " FROM I_Agreement_mains am  " +
                        "  where am.AgreeMent_number='" + AgreeMent_number + "'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        if (dt.Rows.Count > 0) {
            dic.Add("Project_head_A", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["Project_head_A"].ToString()));
            dic.Add("Project_head_B", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["Project_head_B"].ToString()));
            dic.Add("Agreement_client", dt.Rows[0]["Agreement_client"].ToString());
            dic.Add("apply_peo", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["CreatedBy"].ToString()));
            dic.Add("AgreeMent_name", dt.Rows[0]["AgreeMent_name"].ToString());
            dic.Add("CreatedTime", dt.Rows[0]["CreatedTime"].ToString());
            dic.Add("Pay_conditions", dt.Rows[0]["Pay_conditions"].ToString());
            dic.Add("AgreeMent_number", dt.Rows[0]["AgreeMent_number"].ToString());
            dic.Add("Agency_Pro_approval", dt.Rows[0]["Agency_Pro_approval"].ToString());
            //foreach (DataRow dr in dt.Rows)
            //{
            //    Dictionary<string, string> ar = new Dictionary<string, string>();
            //    ar.Add("agency_money", dr["agency_money"].ToString());
            //    ar.Add("agency_type", dr["agency_type"].ToString());
            //    ar.Add("up_limit", dr["up_limit"].ToString());
            //    ar.Add("lower_limit", dr["lower_limit"].ToString());
            //    ls.Add(ar);
            //}
            //dic.Add("agency_rate", ls);
        }
        //根据协议号查询当前协议记录

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取代理费表
    public void getAgency_ratesByANO(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        Dictionary<string, object> dic = new Dictionary<string, object>();
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        String sqls = "SELECT ar.agency_money,e.EnumValue agency_type,ar.lower_limit,ar.up_limit FROM I_Agreement_mains am, I_agency_rates ar,OT_EnumerableMetadata e "+
                        " where am.ObjectID = ar.ParentObjectID and ar.agency_type = e.Code and e.Category='代理费费率／金额' and am.AgreeMent_number = '" + AgreeMent_number + "'"+
                        " ORDER BY ar.ParentIndex" ;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> ar = new Dictionary<string, string>();
                ar.Add("agency_money", dr["agency_money"].ToString());
                ar.Add("agency_type", dr["agency_type"].ToString());
                ar.Add("up_limit", dr["up_limit"].ToString());
                ar.Add("lower_limit", dr["lower_limit"].ToString());
                ls.Add(ar);
            }
            dic.Add("agency_rate", ls);
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    //查询协议审签记录
    public void getrecord(HttpContext context)
    {
        string AgreeMent_number = context.Request["AgreeMent_number"];

        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        String record = "SELECT wf.FinisherName,ct.TEXT AS btext,wf.DisplayName,wf.FinishTime,wf.State,wf.ObjectID,ct.Approval FROM I_Agreement_sign ag " +
            "LEFT JOIN OT_InstanceContext Ic ON Ic.BizObjectId= ag.ObjectID " +
            "LEFT JOIN OT_WorkItemFinished wf ON wf.InstanceId=Ic.ObjectID " +
            "LEFT JOIN OT_Comment ct ON ct.InstanceId = wf.InstanceId  AND  wf.ActivityCode=ct.Activity  AND ct.TokenId= wf.TokenId " +
            "WHERE ag.AgreeMent_number ='" + AgreeMent_number + "' AND wf.Approval !='-1' ORDER BY wf.FinishTime ASC";
        System.Data.DataTable dt_record = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(record);
        if (dt_record.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_record.Rows)
            {
                Dictionary<string, string> dic_two = new Dictionary<string, string>();
                dic_two.Add("ObjectID", dr["ObjectID"].ToString());
                dic_two.Add("DisplayName", dr["DisplayName"].ToString());
                dic_two.Add("UserName", dr["FinisherName"].ToString());
                dic_two.Add("CreatedTime", dr["FinishTime"].ToString());
                if (dr["Approval"].ToString() != "" && dr["Approval"].ToString() != null)
                {
                    dic_two.Add("State", dr["Approval"].ToString() == "1" ? "通过" : "驳回");
                }
                else
                {
                    dic_two.Add("State", dr["Approval"].ToString());
                }

                dic_two.Add("btext", dr["btext"].ToString());
                ls.Add(dic_two);
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