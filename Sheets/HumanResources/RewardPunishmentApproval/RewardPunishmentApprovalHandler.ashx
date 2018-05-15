<%@ WebHandler Language="C#" Class="RewardPunishmentApprovalHandler" %>
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

public class RewardPunishmentApprovalHandler : IHttpHandler {

    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "getRewardPunishmentApprovalQuery": getRewardPunishmentApprovalQuery(context);break;
                //case "doBGContract": doBGContract(context); break;


        }
    }
    public void getRewardPunishmentApprovalQuery(HttpContext context) {
        string StaffName = context.Request["StaffName"];
        string RewardPunishmentTimeFrom = context.Request["RewardPunishmentTimeFrom"];
        string RewardPunishmentTimeTo = context.Request["RewardPunishmentTimeTo"];
        string RewardsPunishmentsType = context.Request["RewardsPunishmentsType"];
        string RewardsPunishmentsReasons = context.Request["RewardsPunishmentsReasons"];
        string RewardPunishmentDetails = context.Request["RewardPunishmentDetails"];
        var sql = "SELECT r.Title,r.StaffName,CONVERT(varchar(12),r.RewardPunishmentTime,111) "+
                "RewardPunishmentTime,r.RewardsPunishmentsReasons,"+
                "e1.EnumValue RewardsPunishmentsType,"+
                "e2.EnumValue RewardPunishmentDetails,"+
                "r.AmountOfMoney,r.Organization,OT_User.Name CreatedBy,"+
                "ic.State Status,ic.ObjectID IcObjectID "+
                " FROM I_RewardPunishmentApproval r "+
                " LEFT JOIN OT_User on r.CreatedBy = OT_User.ObjectID "+
                "INNER JOIN OT_InstanceContext ic on r.ObjectID = ic.BizObjectId and ic.State = '4' "+
                "INNER JOIN OT_EnumerableMetadata e1 on r.RewardsPunishmentsType = e1.Code and e1.Category = '奖惩类型' " +
                "INNER JOIN OT_EnumerableMetadata e2 on r.RewardPunishmentDetails = e2.Code and e2.Category = '奖惩明细' ";

        if(!StaffName.Equals(""))
        {
            sql += " and r.StaffName like '%"+StaffName+"%' ";
        }
        if(!RewardPunishmentTimeFrom.Equals(""))
        {
            sql += " and r.RewardPunishmentTime >= '"+RewardPunishmentTimeFrom+" 00:00:00' ";
        }
        if(!RewardPunishmentTimeTo.Equals(""))
        {
            sql += " and r.RewardPunishmentTime <= '"+RewardPunishmentTimeTo+" 23:59:59' ";
        }
        if(!RewardsPunishmentsType.Equals(""))
        {
            sql += " and e1.EnumValue = '"+RewardsPunishmentsType+"' ";
        }
        if(!RewardsPunishmentsReasons.Equals(""))
        {
            sql += " and r.RewardsPunishmentsReasons like '%"+RewardsPunishmentsReasons+"%' ";
        }
        if(!RewardPunishmentDetails.Equals(""))
        {
            sql += " and e2.EnumValue = '"+RewardPunishmentDetails+"' ";
        }
        sql += "  order by r.CreatedTime desc ";

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
                dic.Add("Title",dr["Title"].ToString());
                dic.Add("StaffName", dr["StaffName"].ToString());
                dic.Add("RewardPunishmentTime", dr["RewardPunishmentTime"].ToString());
                dic.Add("RewardsPunishmentsReasons", dr["RewardsPunishmentsReasons"].ToString());
                dic.Add("RewardsPunishmentsType", dr["RewardsPunishmentsType"].ToString());
                dic.Add("RewardPunishmentDetails", dr["RewardPunishmentDetails"].ToString());
                dic.Add("AmountOfMoney", dr["AmountOfMoney"].ToString());
                dic.Add("Organization", dr["Organization"].ToString());
                dic.Add("CreatedBy", dr["CreatedBy"].ToString());
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