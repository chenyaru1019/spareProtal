﻿<%@ WebHandler Language="C#" Class="AgreeMent_main" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;
using OThinker.H3.Portal.service;
using OThinker.H3.Portal.Entity;

public class AgreeMent_main : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "AgreementNo": AgreementNo(context); break;
            case "getSalesHYData": getSalesHYData(context); break;
            case "getAgreementrecord":getAgreementrecord(context);break;
            //case "getpjcon":getpjcon(context);break;//获取项目和合同关联
            case "getAgreementNumber":getAgreementNumber(context);break;//查询协议号审批记录
            case "getGDrecord":getGDrecord(context);break;//获取归档记录
            case "getProjecsk":getProjecsk(context);break;//获取关联项目收款查询
            case "sel_sk":sel_sk(context);break;
            case "AgreeMent_number":AgreeMent_number(context);break;//判断协议号是否存在
            case "Sh_money":Sh_money(context);break;

            case "GetDatasByAgreement_client":GetDatasByAgreement_client(context);break;
            case "getYSListRMB":getYSListRMB(context);break;
            case "getYSListPercent":getYSListPercent(context);break;
            case "getApplyingCountOfOper":getApplyingCountOfOper(context);break;
            case "getInstanceById":getInstanceById(context);break;
            case "getInformationByAgreementNumber":getInformationByAgreementNumber(context);break;
            case "getWorkItemIDByAgreeMent_number":getWorkItemIDByAgreeMent_number(context);break;
        }
    }
    public void getInformationByAgreementNumber (HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string IsHYFlg = context.Request["IsHYFlg"];
        AgreeMentMain con = new AgreeMentMain();
        if (IsHYFlg == "true")
        {
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT AgreeMent_number,AgreeMent_name,Project_head_A,Project_head_B"+
                " ,Agreement_client "+
                " FROM I_AircraftOilAgreement air"+
                " where air.AgreeMent_number = '"+AgreeMent_number+"'");
            if (dt.Rows.Count > 0)
            {
                con.AgreeMent_number = dt.Rows[0]["AgreeMent_number"].ToString();
                con.AgreeMent_name = dt.Rows[0]["AgreeMent_name"].ToString();
                //OThinker.Organization.User ua = Common.getUserById(dt.Rows[0]["PostA"].ToString());
                //OThinker.Organization.User ub = Common.getUserById(dt.Rows[0]["PostB"].ToString());
                con.Project_head_A = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["Project_head_A"].ToString());
                con.Project_head_B = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["Project_head_B"].ToString());
                con.Agreement_client = dt.Rows[0]["Agreement_client"].ToString();
            }
        }
        else if(IsHYFlg == "false"){

            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT AgreeMent_number,AgreeMent_name,Project_head_A,Project_head_B"+
                " ,Agreement_client "+
                " FROM I_Agreement_mains agr"+
                " where agr.AgreeMent_number = '"+AgreeMent_number+"'");
            if (dt.Rows.Count > 0)
            {
                con.AgreeMent_number = dt.Rows[0]["AgreeMent_number"].ToString();
                con.AgreeMent_name = dt.Rows[0]["AgreeMent_name"].ToString();
                //OThinker.Organization.User ua = Common.getUserById(dt.Rows[0]["PostA"].ToString());
                //OThinker.Organization.User ub = Common.getUserById(dt.Rows[0]["PostB"].ToString());
                con.Project_head_A = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["Project_head_A"].ToString());
                con.Project_head_B = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["Project_head_B"].ToString());
                con.Agreement_client = dt.Rows[0]["Agreement_client"].ToString();
            }
        }
        object JSONObj = JsonConvert.SerializeObject(con);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    // 根据流程id获取流程entity
    public void getInstanceById (HttpContext context) {
        string InstanceId = context.Request["InstanceId"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT top 1 * from OT_InstanceContext where ObjectID = '"+InstanceId+"'");
        if (dt.Rows.Count > 0)
        {
            dic.Add("ObjectID",dt.Rows[0]["ObjectID"].ToString());
            dic.Add("InstanceName",dt.Rows[0]["InstanceName"].ToString());
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    // 获取执行中的所有相关流程正在申请中的数量
    public void getApplyingCountOfOper(HttpContext context)
    {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        var sql = " select Count(ck.ObjectID) ckCnt, "+
                    " Count(change.ObjectID) changeCnt, "+
                    " Count(gd.ObjectID) gdCnt "+
                    " from OT_InstanceContext ic "+
                    " LEFT JOIN I_Charge_back ck on ic.BizObjectId = ck.ObjectID and ck.AgreeMent_number = '"+AgreeMent_number+"' and ic.State = '2' "+
                    " LEFT JOIN I_Agreenment_change change on ic.BizObjectId = change.ObjectID and change.AgreeMent_number = '"+AgreeMent_number+"' and ic.State = '2' "+
                    " LEFT JOIN I_Agreement_file gd on ic.BizObjectId = gd.ObjectID and gd.AgreeMent_number = '"+AgreeMent_number+"' and ic.State = '2' ";
        //var sql_js = " select js.ObjectID JSObjectID ,Max(js.JSResult) JSResult,Max(qk.ObjectID) QKObjcetID,Max(fk.ObjectID) FKObjectID "+
        //            " from I_JS js "+
        //            " INNER JOIN OT_InstanceContext ic on ic.BizObjectId = js.ObjectID and js.ContractNo = '"+ContractNo+"' and ic.State = '4' "+
        //            " left JOIN I_QK qk on qk.JSObjectID = js.ObjectID  "+
        //            " left JOIN I_FK fk on fk.JSObjectID = js.ObjectID  "+
        //            " group BY js.ObjectID ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        //System.Data.DataTable dt_js = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_js);
        Dictionary<string, string> dic = new Dictionary<string, string>();

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                dic.Add("ckCnt", dr["ckCnt"].ToString());
                dic.Add("changeCnt", dr["changeCnt"].ToString());
                dic.Add("gdCnt", dr["gdCnt"].ToString());
                //// 如果结算有在申请中的，直接返回count
                //if((int)Convert.ToSingle(dr["jsCnt"].ToString()) > 0)
                //{
                //    dic.Add("jsCnt", dr["jsCnt"].ToString());
                //}else
                //{
                //    // 如果结算申请完了，则需要查看待请款和待付款情况
                //    if (dt_js.Rows.Count > 0)
                //    {
                //        foreach (DataRow dr2 in dt_js.Rows)
                //        {
                //            if(dr2["JSResult"].ToString().Equals("0")
                //                    || (!dr2["JSResult"].ToString().Equals("0") && (!dr2["QKObjcetID"].ToString().Equals("") || !dr2["FKObjectID"].ToString().Equals(""))))
                //            {
                //                continue;
                //            } else
                //            {
                //                dic.Add("jsCnt", "1");
                //                break;
                //            }
                //        }
                //    }
                //}

                //dic.Add("psCnt", dr["psCnt"].ToString());
                //dic.Add("ilsCnt", dr["ilsCnt"].ToString());
                //dic.Add("dhCnt", dr["dhCnt"].ToString());
                //dic.Add("bgCnt", dr["bgCnt"].ToString());
                //dic.Add("bhCnt", dr["bhCnt"].ToString());
                //dic.Add("gdCnt", dr["gdCnt"].ToString());
                //dic.Add("gdcCnt", dr["gdcCnt"].ToString());
            }
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    //查询收款记录
    public void Sh_money(HttpContext context){
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        String Agreement_record = "SELECT ObjectID,CreatedTime,Reduced_money FROM I_Charge_back " +
            " WHERE AgreeMent_number='"+AgreeMent_number+"'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("ObjectID",dr["ObjectID"].ToString());
                dic.Add("Application_Date", dr["CreatedTime"].ToString());
                dic.Add("Receivable_money", dr["Reduced_money"].ToString());
                dic.Add("Account_time", dr["CreatedTime"].ToString());
                dic.Add("Receipt_State", "2");
                ls.Add(dic);
            }

        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }

    //判断协议号是否存在
    public void AgreeMent_number(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        String Agreement_one = "select AgreeMent_name from  I_Agreement_mains where AgreeMent_number='"+AgreeMent_number+"'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_one);
        var bz = "";
        if (dt.Rows.Count > 0)
        {
            bz = "1";
        }
        else {
            bz = "2";
        }
        object JSONObj = JsonConvert.SerializeObject(bz);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    // 获取关联项目收款查询
    public void getProjecsk(HttpContext context){
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();

        String Agreement_record = "SELECT cm.ObjectID,cm.ContractType,cm.ContractNo,cm.ContractName,am.agency_rate,em.EnumValue,am.ys_agency,am.agency_ye FROM I_Agreement_mains am " +
            "LEFT JOIN I_ContractMain cm ON am.AgreeMent_number=cm.AgencySelect LEFT JOIN OT_EnumerableMetadata em ON am.Rate_type=em.Code" +
            " WHERE am.AgreeMent_number='"+AgreeMent_number+"'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("ObjectID",dr["ObjectID"].ToString());
                dic.Add("ContractType", dr["ContractType"].ToString());
                dic.Add("ContractNo", dr["ContractNo"].ToString());
                dic.Add("ContractName", dr["ContractName"].ToString());
                dic.Add("agency_rate", dr["agency_rate"].ToString()+""+dt.Rows[0]["EnumValue"].ToString());
                dic.Add("ys_money", dr["ys_agency"].ToString()+""+dt.Rows[0]["EnumValue"].ToString());
                dic.Add("ye_money",(int)Convert.ToSingle(dr["agency_rate"])-(int)Convert.ToSingle(dr["ys_agency"])+dr["EnumValue"].ToString());
                ls.Add(dic);
            }

        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }
    //收款记录查询
    public void sel_sk(HttpContext context) {

    }
    //获取归档记录
    public void getGDrecord(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();

        String Agreement_record = "SELECT af.OwnerId,CONVERT(varchar(12),af.CreatedTime,111) CreatedTime," +
           "case ic.State when '2' then '审批中' when '4' then  '审批完了' end DisplayName,wf.ObjectID  FROM I_Agreement_file af " +
           "LEFT JOIN OT_InstanceContext ic ON af.ObjectID = ic.BizObjectId LEFT JOIN OT_WorkItemFinished wf ON wf.InstanceId=ic.ObjectID " +
           " WHERE af.AgreeMent_number='"+AgreeMent_number+"'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("Application_people", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["OwnerId"].ToString()));
                dic.Add("Application_time", dt.Rows[0]["CreatedTime"].ToString());
                dic.Add("file_state", dt.Rows[0]["DisplayName"].ToString());
                dic.Add("workItemId", dt.Rows[0]["ObjectID"].ToString());
                ls.Add(dic);
            }

        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    //查询协议号审批记录
    public void getAgreementNumber(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        String Agreement_record = "SELECT ins.OriginatorName Approver,CONVERT(varchar(12),ins.StartTime,111) ApproveDate,ins.State,ins.ObjectID " +
            " FROM I_Update_agreement_number ua,OT_InstanceContext ins " +
            " where ua.ObjectID = ins.BizObjectId and ins.State= '4' " +
            " and ua.Update_agreeMent_number='" + AgreeMent_number + "' " +
             " Union " +
                    " SELECT ins.OriginatorName Approver,CONVERT(varchar(12),ins.StartTime,111) ApproveDate,ins.State,ins.ObjectID" +
                    " FROM I_Update_agreement_number ua, OT_InstanceContext ins " +
                    " where ua.Self_agreeMent_number = '" + AgreeMent_number + "' and ua.ObjectID = ins.BizObjectId and ins.State = '2' order by ins.StartTime";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {

                Dictionary<string, string> dic_two = new Dictionary<string, string>();
                dic_two.Add("Apply_people", dr["Approver"].ToString());
                dic_two.Add("Apply_time", dr["ApproveDate"].ToString());
                var st = dr["State"].ToString();
                dic_two.Add("State", st == "2" ? "审批中" : (st == "4" ? "审批完了" : ""));
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["ObjectID"].ToString(), st);
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        //bizObjects[i]["WorkItemId"] = item.Value;
                        dic_two.Add("WorkItemId",item.Value);
                    }

                }
                dic_two.Add("Operate","");
                ls.Add(dic_two);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    //获取合同项目关联
    //public void getpjcon(HttpContext context) {
    //    string AgreeMent_number = context.Request["AgreeMent_number"];
    //    List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
    //    String Agreement_record = "SELECT ib.ProjectName,ib.BiddingCode,ct.ContractNo,ct.ContractName,ct.ContractType FROM I_Agreement_mains am " +
    //        "LEFT JOIN I_ContractMain ct ON am.AgreeMent_number = ct.AgencyCode LEFT JOIN I_AgencyAgreements ay ON ay.AgreementCode=am.AgreeMent_number " +
    //        "LEFT JOIN I_InviteBids ib ON ib.ObjectID=ay.ParentObjectID WHERE am.AgreeMent_number='"+AgreeMent_number+"'";

    //    System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);


    //    if (dt.Rows.Count > 0)
    //    {
    //        foreach (DataRow dr in dt.Rows)
    //        {

    //            Dictionary<string, string> dic_two = new Dictionary<string, string>();
    //            dic_two.Add("ProjectName", dr["ProjectName"].ToString());
    //            dic_two.Add("BiddingCode", dr["BiddingCode"].ToString());
    //            dic_two.Add("ContractNo", dr["ContractNo"].ToString());
    //            dic_two.Add("ContractName", dr["ContractName"].ToString());
    //            dic_two.Add("ContractType", dr["ContractType"].ToString());

    //            //dic_two.Add("State",re_state.Rows[0]["DisplayName"].ToString() !=""?"审批中":"审批完成");
    //            ls.Add(dic_two);
    //        }
    //    }
    //    object JSONObj = JsonConvert.SerializeObject(ls);
    //    context.Response.ContentType = "application/json";
    //    context.Response.Write(JSONObj);

    //}
    //生成协议号
    public void AgreementNo (HttpContext context) {
        Dictionary<string,string> dic = new Dictionary<string,string>();
        string year = DateTime.Now.Year.ToString().Substring(2, 2);
        String sql = "SELECT MAX(AgreeMent_number) as num FROM I_AgreeMent_mains";
        string AgreementNo = "";
        string Number = "001";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        if (dt.Rows.Count > 0 && dt.Rows[0]["num"].ToString() != "")
        {
            Number = dt.Rows[0]["num"].ToString().Substring(12);
            int Numbers_int = (int)Convert.ToSingle(Number) + 1;
            Number = string.Format("{0:000}", Numbers_int);
        }

        AgreementNo = "SPIAIE-XY-" + year + Number;
        dic.Add("AgreementNo", AgreementNo);

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    //协议变更查询
    public void getAgreementrecord(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        String Agreement_record = "SELECT ObjectID, Old_agency_fee,New_money,Old_pay_condition,New_pay_condition,Change_pay_content,agrency_type  " +
            "FROM I_Agreenment_change WHERE AgreeMent_number='"+AgreeMent_number+"'";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
  Agreement_record);
        //判断当前协议变更审批的状态
        //        String states = "SELECT wt.DisplayName FROM I_Agreenment_change ac LEFT JOIN OT_InstanceContext ic ON ac.ObjectID = ic.BizObjectId " +
        //            "LEFT JOIN OT_WorkItem wt ON ic.ObjectID=wt.InstanceId where ac.Agreenment_number='"+AgreeMent_number+"'";
        //        System.Data.DataTable re_state = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        //states);

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {

                Dictionary<string, string> dic_two = new Dictionary<string, string>();
                dic_two.Add("Old_agency_fee", dr["Old_agency_fee"].ToString());
                dic_two.Add("New_money", dr["New_money"].ToString()+dr["agrency_type"].ToString());
                dic_two.Add("Old_pay_condition", dr["Old_pay_condition"].ToString());
                dic_two.Add("New_pay_condition", dr["Change_pay_content"].ToString());
                String states = "SELECT wt.DisplayName FROM I_Agreenment_change ac LEFT JOIN OT_InstanceContext ic ON ac.ObjectID = ic.BizObjectId " +
           "LEFT JOIN OT_WorkItem wt ON ic.ObjectID=wt.InstanceId where ac.ObjectID='"+dr["ObjectID"].ToString()+"'";
                System.Data.DataTable re_state = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        states);

                dic_two.Add("State",re_state.Rows[0]["DisplayName"].ToString() !=""?"审批中":"审批完成");
                //dic_two.Add("btext", dr["btext"].ToString());
                ls.Add(dic_two);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }


    public void getSalesHYData (HttpContext context) {
        // 
        string ObjectID = context.Request["ObjectID"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT shy.* FROM I_SalerTblOfHY shy, I_HYContractSet hy where shy.ParentObjectID = hy.ObjectID and hy.ObjectID = '"+ObjectID+"'");
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("ObjectID",dr["ObjectID"].ToString());
                dic.Add("CompanyName",dt.Rows[0]["CompanyName"].ToString());
                dic.Add("ContactName",dt.Rows[0]["ContactName"].ToString());
                dic.Add("Telephone",dt.Rows[0]["Telephone"].ToString());
                dic.Add("Mobile",dt.Rows[0]["Mobile"].ToString());
                dic.Add("Fax",dt.Rows[0]["Fax"].ToString());
                dic.Add("Email",dt.Rows[0]["Email"].ToString());
                ls.Add(dic);
            }

        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    // 根据协议委托方获取相关数据
    public void GetDatasByAgreement_client(HttpContext context){
        string Agreement_client = context.Request["Agreement_client"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        var Contacts = "";
        var Con_phone = "";
        var Mobile_phone = "";
        var Fax = "";
        var Email = "";
        var Contact_address = "";
        String Agreement_record = "select cu.*,p.* FROM I_CustomerList cu "+
                                    " INNER JOIN I_ContactsTbl p on cu.ObjectID = p.ParentObjectID  "+
                                    " and cu.CompanyName = '"+Agreement_client+"'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Contacts += dr["ContactName"].ToString()+",";
                Con_phone += dr["Telephone"].ToString()+",";
                Mobile_phone += dr["Mobile"].ToString()+",";
                Fax += dr["Fax"].ToString()+",";
                Email += dr["Email"].ToString()+",";
                Contact_address = dr["Address"].ToString();
            }
        }
        dic.Add("Contacts",Contacts);
        dic.Add("Con_phone",Con_phone);
        dic.Add("Mobile_phone",Mobile_phone);
        dic.Add("Fax",Fax);
        dic.Add("Email",Email);
        dic.Add("Contact_address",Contact_address);
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }

    // 应收代理费列表 RMB
    public void getYSListRMB(HttpContext context){
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string ReceiveAgencyFee = "0";
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        // 获取所有的人民币协议子表数据
        String sqls_fs = " select ar.ParentIndex TheNo,ar.agency_money " +
                " from I_Agreement_mains am" +
                " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID " +
                " and am.AgreeMent_number = '"+AgreeMent_number+"' and ar.agency_type = 'AgencyRate_RMB'";
        System.Data.DataTable dt_fs = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls_fs);
        if (dt_fs.Rows.Count > 0) {
            foreach (DataRow dr1 in dt_fs.Rows)
            {
                var TheNo = dr1["TheNo"].ToString();
                var agency_money = dr1["agency_money"].ToString();

                // 通过协议号获取协议表单中保存的已收代理费字段
                String sqls = "select AgreeMent_number,ReceiveAgencyFeeHidden " +
                        "from I_Agreement_mains  where AgreeMent_number='"+AgreeMent_number+"'";
                System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
                if (dt1.Rows.Count > 0) {
                    ReceiveAgencyFee = dt1.Rows[0]["ReceiveAgencyFeeHidden"].ToString();
                }
                string Agreement_bid_record = " select max(ib.ProjectName) ProjectName,max(ib.BiddingCode) BiddingCode,sum(tp.TenderPrice1*tp.TenderPrice1ExchangeRate) bidPrice "+
                    " from I_Agreement_mains am   "+
                    " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_RMB' and am.AgreeMent_number = '"+AgreeMent_number+"'  "+
                    " INNER JOIN I_TenderPrice tp on am.AgreeMent_number = tp.AgreementCode and ar.ParentIndex+1 = tp.AgreementIndex and ar.ParentIndex = '"+TheNo+"' and tp.IsBiddingAgency = '1' "+
                    " INNER JOIN I_InviteBids ib on tp.ParentObjectID = ib.ObjectID "+
                    " GROUP BY ib.BiddingCode   "+
                    " HAVING sum(tp.TenderPrice1*tp.TenderPrice1ExchangeRate) > 0  "+
                    " ORDER BY ib.BiddingCode  ";
                String Agreement_cont_record = " select e.EnumValue ContractType,cm.ContractNo,cm.ContractName,ar.agency_money YSAgencyFee " +
                    " from I_Agreement_mains am " +
                    " INNER JOIN I_ContractMain cm on cm.AgencyCode = am.AgreeMent_number " +
                    " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_RMB'  and cm.AgencyTheNo = ar.ParentIndex+1 and ar.ParentIndex = '"+TheNo+"'" +
                    " INNER JOIN OT_EnumerableMetadata e on e.Code = cm.ContractType and e.Category = '合同类型' " +
                    " and am.AgreeMent_number = '"+AgreeMent_number+"' and cm.AgencyReturnType ='人民币' and cm.ContractTotalPrice > 0" +
                    " ORDER BY ContractType,ContractNo";
                System.Data.DataTable dt_bid = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_bid_record);
                System.Data.DataTable dt_cont = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_cont_record);
                var cnt = dt_bid.Rows.Count + dt_cont.Rows.Count;
                if (dt_bid.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt_bid.Rows)
                    {
                        Dictionary<string,string> dic = new Dictionary<string,string>();
                        dic.Add("Type","招标");
                        dic.Add("ProjectNo", dr["BiddingCode"].ToString());
                        dic.Add("ProjectName", dr["ProjectName"].ToString());
                        dic.Add("YSAgencyFee", agency_money);
                        dic.Add("ReceiveAgencyFee", ReceiveAgencyFee);
                        double AgencyFeeRemain =  (double)Convert.ToSingle(dr["YSAgencyFee"]) - (double)Convert.ToSingle(ReceiveAgencyFee);
                        dic.Add("AgencyFeeRemain", AgencyFeeRemain.ToString());
                        dic.Add("cnt", cnt.ToString());
                        ls.Add(dic);
                    }

                }
                if (dt_cont.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt_cont.Rows)
                    {
                        Dictionary<string,string> dic = new Dictionary<string,string>();
                        dic.Add("Type",dr["ContractType"].ToString());
                        dic.Add("ProjectNo", dr["ContractNo"].ToString());
                        dic.Add("ProjectName", dr["ContractName"].ToString());
                        dic.Add("YSAgencyFee", agency_money);
                        dic.Add("ReceiveAgencyFee", ReceiveAgencyFee);
                        double AgencyFeeRemain =  (double)Convert.ToSingle(dr["YSAgencyFee"]) - (double)Convert.ToSingle(ReceiveAgencyFee);
                        dic.Add("AgencyFeeRemain", AgencyFeeRemain.ToString());
                        dic.Add("cnt", cnt.ToString());
                        ls.Add(dic);
                    }
                }
            }
        }


        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }

    // 应收代理费列表 百分比
    public void getYSListPercent(HttpContext context){
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string ProjectNos = context.Request["ProjectNos"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        List<Dictionary<string,string>> lsRet = new List<Dictionary<string,string>>();
        // 获取所有的人民币协议子表数据
        String sqls_fs = " select ar.ParentIndex TheNo,ar.agency_money " +
                " from I_Agreement_mains am" +
                " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID " +
                " and am.AgreeMent_number = '"+AgreeMent_number+"' and ar.agency_type = 'AgencyRate_Percent'";
        System.Data.DataTable dt_fs = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls_fs);
        if (dt_fs.Rows.Count > 0)
        {
            foreach (DataRow dr1 in dt_fs.Rows)
            {
                var TheNo = dr1["TheNo"].ToString();
                var agency_money = dr1["agency_money"].ToString();
                // 先获取相关项目、合同的数据1
                // 再获取本表单的代理费列表数据2
                // 把数据1加到数据2中（已经有的不用加）

                string Agreement_bid_record = " SELECT "+
                    "  ib.BiddingCode,e2.EnumValue Currency, "+
                    "  MAX (ib.ProjectName) ProjectName, "+
                    "  sum(tp.TenderPrice1) bidPrice "+
                    " FROM I_Agreement_mains am "+
                    " INNER JOIN I_agency_rates ar ON am.ObjectID = ar.ParentObjectID AND ar.agency_type = 'AgencyRate_Percent' AND am.AgreeMent_number = '" + AgreeMent_number + "' "+
                    " INNER JOIN I_TenderPrice tp ON am.AgreeMent_number = tp.AgreementCode AND ar.ParentIndex + 1 = tp.AgreementIndex AND ar.ParentIndex = '" + TheNo + "' AND tp.IsBiddingAgency = '1' "+
                    " INNER JOIN I_InviteBids ib ON tp.ParentObjectID = ib.ObjectID "+
                    " Left JOIN OT_EnumerableMetadata e2 on e2.Code = tp.TenderPrice1Unit and e2.Category = '币种' "+
                    " GROUP BY ib.BiddingCode,e2.EnumValue "+
                    " HAVING sum(tp.TenderPrice1)> 0 "+
                    " ORDER BY ib.BiddingCode ";
                String Agreement_cont_record = " select e.EnumValue ContractType,cm.ContractNo,cm.ContractName " +
                    " ,cm.ContractTotalPrice*ar.agency_money/100 YSAgencyFeeRMB" +
                    " ,cm.JKTotalAmount*ar.agency_money/100 YSAgencyFeeWB" +
                    " ,e2.EnumValue Currency " +
                    " from I_Agreement_mains am " +
                    " INNER JOIN I_ContractMain cm on cm.AgencyCode = am.AgreeMent_number " +
                    " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_Percent' and cm.AgencyTheNo = ar.ParentIndex+1 and ar.ParentIndex = '" + TheNo + "'" +
                    " INNER JOIN OT_EnumerableMetadata e on e.Code = cm.ContractType and e.Category = '合同类型' " +
                    " and am.AgreeMent_number = '" + AgreeMent_number + "' and cm.AgencyReturnType ='百分比' and (cm.ContractTotalPrice > 0 or cm.JKTotalAmount > 0)" +
                    " Left JOIN OT_EnumerableMetadata e2 on e2.Code = cm.Currency and e2.Category = '币种' " +
                    " ORDER BY ContractType,ContractNo";
                String Agreement_tbl = " select yp.* " +
                    " from I_YSList_Percent yp " +
                    " INNER JOIN I_Agreement_mains am on yp.parentObjectID = am.ObjectID and am.AgreeMent_number = '" + AgreeMent_number + "' " +
                    " ORDER BY yp.Type,yp.projectNo ";
                System.Data.DataTable dt_bid = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_bid_record);
                System.Data.DataTable dt_cont = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_cont_record);
                System.Data.DataTable dt_tbl = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_tbl);
                if (dt_bid.Rows.Count > 0)
                {
                    List<Dictionary<string,string>> lstmp = new List<Dictionary<string,string>>();
                    foreach (DataRow dr in dt_bid.Rows)
                    {
                        Dictionary<string, string> dic = new Dictionary<string, string>();
                        dic.Add("Type", "招标");
                        dic.Add("BiddingCode", dr["BiddingCode"].ToString());
                        dic.Add("ProjectName", dr["ProjectName"].ToString());
                        dic.Add("bidPrice", dr["bidPrice"].ToString());
                        dic.Add("Currency", dr["Currency"].ToString());
                        lstmp.Add(dic);
                    }
                    lstmp = TransByBiddingCode(lstmp);
                    foreach (Dictionary<string,string> item in lstmp)
                    {
                        Dictionary<string, string> dic = new Dictionary<string, string>();
                        dic.Add("Type", "招标");
                        dic.Add("ProjectNo", item["BiddingCode"].ToString());
                        dic.Add("ProjectName", item["ProjectName"].ToString());
                        var YSAgencyFeeRMB = getPrice(item["Currency"].ToString(),item["bidPrice"].ToString(),"RMB");
                        var YSAgencyFeeWB =  getPrice(item["Currency"].ToString(),item["bidPrice"].ToString(),"WB");
                        dic.Add("YSAgencyFeeRMB", get2(YSAgencyFeeRMB));
                        dic.Add("YSAgencyFeeWB", get2(delLastCom(YSAgencyFeeWB)));
                        dic.Add("Currency", delLastCom(item["Currency"].ToString().Replace("人民币,","")   ));

                        bool isContainFlg = false;
                        if (dt_tbl.Rows.Count > 0)
                        {
                            foreach (DataRow dr2 in dt_tbl.Rows)
                            {
                                if (item["BiddingCode"].ToString() == dr2["ProjectNo"].ToString())
                                {
                                    dic.Add("ReceiveAgencyFee", get2(dr2["ReceiveAgencyFee"].ToString()));
                                    dic.Add("ReceiveAgencyFeeWB", get2(dr2["ReceiveAgencyFeeWB"].ToString()));
                                    dic.Add("ReceiveTotalRMB", get2(dr2["ReceiveTotalRMB"].ToString()));
                                    dic.Add("AgencyFeeRemainRMB", get2(((double)Convert.ToSingle(YSAgencyFeeRMB) - (double)Convert.ToSingle(dr2["ReceiveAgencyFee"].ToString())).ToString()));
                                    dic.Add("AgencyFeeRemainWB", get2(Subs(delLastCom(YSAgencyFeeWB),dr2["ReceiveAgencyFeeWB"].ToString())));
                                    isContainFlg = true; break;
                                }
                            }
                        }
                        if (!isContainFlg)
                        {
                            dic.Add("ReceiveAgencyFee", get2("0"));
                            var ReceiveAgencyFeeWB = iniWB(delLastCom(YSAgencyFeeWB));
                            dic.Add("ReceiveAgencyFeeWB", get2(ReceiveAgencyFeeWB));
                            dic.Add("ReceiveTotalRMB", get2("0"));
                            dic.Add("AgencyFeeRemainRMB", get2(YSAgencyFeeRMB));
                            dic.Add("AgencyFeeRemainWB", get2(delLastCom(YSAgencyFeeWB)));
                        }
                        ls.Add(dic);
                    }
                }
                if (dt_cont.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt_cont.Rows)
                    {
                        Dictionary<string, string> dic = new Dictionary<string, string>();
                        dic.Add("Type", dr["ContractType"].ToString());
                        dic.Add("ProjectNo", dr["ContractNo"].ToString());
                        dic.Add("ProjectName", dr["ContractName"].ToString());
                        dic.Add("YSAgencyFeeRMB", get2(dr["YSAgencyFeeRMB"].ToString()));
                        dic.Add("YSAgencyFeeWB", get2(dr["YSAgencyFeeWB"].ToString()));
                        dic.Add("Currency", dr["Currency"].ToString());

                        bool isContainFlg = false;
                        if (dt_tbl.Rows.Count > 0)
                        {
                            foreach (DataRow dr2 in dt_tbl.Rows)
                            {
                                if (dr["ContractNo"].ToString() == dr2["ProjectNo"].ToString())
                                {
                                    dic.Add("ReceiveAgencyFee", get2(dr2["ReceiveAgencyFee"].ToString()));
                                    dic.Add("ReceiveAgencyFeeWB", get2(dr2["ReceiveAgencyFeeWB"].ToString()));
                                    dic.Add("ReceiveTotalRMB", get2(dr2["ReceiveTotalRMB"].ToString()));
                                    dic.Add("AgencyFeeRemainRMB", get2(dr2["AgencyFeeRemainRMB"].ToString()));
                                    dic.Add("AgencyFeeRemainWB", get2(dr2["AgencyFeeRemainWB"].ToString()));
                                    isContainFlg = true; break;
                                }
                            }
                        }
                        if (!isContainFlg)
                        {
                            dic.Add("ReceiveAgencyFee", get2("0"));
                            dic.Add("ReceiveAgencyFeeWB", get2("0"));
                            dic.Add("ReceiveTotalRMB", get2("0"));
                            dic.Add("AgencyFeeRemainRMB", get2(dr["YSAgencyFeeRMB"].ToString()));
                            dic.Add("AgencyFeeRemainWB", get2(dr["YSAgencyFeeWB"].ToString()));
                        }
                        ls.Add(dic);
                    }
                }
            }
        }
        if (ProjectNos != null && ProjectNos != "")
        {
            string[] proArr = ProjectNos.Split(',');
            if (proArr.Length > 0)
            {
                foreach (Dictionary<string, string> dic in ls)
                {
                    bool isContainFlg = false;
                    foreach (string item in proArr)
                    {
                        if (item == dic["ProjectNo"].ToString())
                        {
                            isContainFlg = true;
                            break;
                        }
                    }
                    if (isContainFlg)
                    {
                        lsRet.Add(dic);
                    }
                }
            }
        }
        else
        {
            lsRet = ls;
        }
        object JSONObj = JsonConvert.SerializeObject(lsRet);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }
    // 根据ContractNo获取workItem的id
    public void getWorkItemIDByAgreeMent_number (HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string CurrentUser = context.Request["CurrentUser"];
        Dictionary<string, string> item = new Dictionary<string, string>();
        Dictionary<string, string> workItemDic = new Dictionary<string, string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT top 1 ic.ObjectID ,ic.State "+
            " from I_Agreement_mains c "+
            " INNER JOIN OT_InstanceContext ic on c.ObjectID = ic.BizObjectId "+
            " and c.AgreeMent_number = '"+AgreeMent_number+"'  ");
        if (dt.Rows.Count > 0)
        {
            workItemDic = Common.getWorkItemIdNew(dt.Rows[0]["ObjectId"].ToString(),dt.Rows[0]["State"].ToString(),CurrentUser);
            
            item.Add("workItemId",workItemDic["workItemId"]);
            item.Add("isHY","false");
        }
        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            
            " SELECT top 1 ic.ObjectID ,ic.State "+
            " from I_AircraftOilAgreement c "+
            " INNER JOIN OT_InstanceContext ic on c.ObjectID = ic.BizObjectId "+
            " and c.AgreeMent_number = '"+AgreeMent_number+"' ");
        if (dt1.Rows.Count > 0)
        {
            workItemDic = Common.getWorkItemIdNew(dt1.Rows[0]["ObjectId"].ToString(),dt1.Rows[0]["State"].ToString(),CurrentUser);
            item.Add("workItemId",workItemDic["workItemId"]);
            item.Add("isHY","true");
        }
        object JSONObj = JsonConvert.SerializeObject(item);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    public  List<Dictionary<string,string>> TransByBiddingCode( List<Dictionary<string,string>> lstmp)
    {
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        var BiddingCodeBak = "";
        var BiddingCode = "";
        var ProjectName = "";
        var Currency = "";
        var bidPrice = "";
        foreach (Dictionary<string, string> dic in lstmp)
        {
            if(BiddingCodeBak!="" &&!dic["BiddingCode"].Equals(BiddingCodeBak))
            {
                Dictionary<string, string> item = new Dictionary<string, string>();
                item.Add("BiddingCode",BiddingCode);
                item.Add("ProjectName",ProjectName);
                item.Add("Currency",Currency);
                item.Add("bidPrice",bidPrice);
                ls.Add(item);
                Currency = "";
                bidPrice = "";
            }
            BiddingCode = dic["BiddingCode"].ToString();
            ProjectName = dic["ProjectName"].ToString();
            Currency += dic["Currency"].ToString()+",";
            bidPrice += dic["bidPrice"].ToString()+",";

        }
        if(Currency != "")
        {
            Dictionary<string, string> item = new Dictionary<string, string>();
            item.Add("BiddingCode",BiddingCode);
            item.Add("ProjectName",ProjectName);
            item.Add("Currency",Currency);
            item.Add("bidPrice",bidPrice);
            ls.Add(item);
        }
        return ls;
    }

    public String getPrice(string Currencys,string bidPrices,string flg)
    {
        string [] cs  = Currencys.Split(',');
        string [] bs  = bidPrices.Split(',');
        if(flg.Equals("RMB"))
        {
            var i = 0;
            foreach (string str in cs)
            {
                if(str.Equals("人民币"))
                {
                    return bs[i];
                }
                i++;
            }
        } else
        {
            var rbs = "";
            for(var i = 0;i<cs.Length;i++)
            {
                if(cs[i].Equals("") || cs[i].Equals("人民币"))
                {
                    continue;
                } else
                {
                    rbs += bs[i]+",";
                }

            }
            return rbs;
        }
        return "";
    }

    // 保留两位小数
    public string get2(string str)
    {
        string ret = "";
        string[] arr = str.Split(',');
        for(var i = 0;i< arr.Length;i++)
        {
            string s = ((double)Convert.ToSingle(arr[i])).ToString("0.00");;
            ret += s + ",";
        }
        return delLastCom(ret);
    }

    // 初始化多个外币金额的值
    public string iniWB(string str) {
        string [] arr = str.Split(',');
        string ret = "";
        for(var i = 0;i< arr.Length;i++)
        {
            ret += "0,";
        }
        return delLastCom(ret);
    }
    public string delLastCom(string str)
    {
        if(str.Substring(str.Length - 1).Equals(","))
        {
            return str.Substring(0,str.Length - 1);
        }
        return "";
    }

    // 两个带逗号的字符串数据相减（200,500 - 100,100 = 100,400）
    public string Subs(string com1,string com2) {
        string [] com1arr = com1.Split(',');
        string [] com2arr = com2.Split(',');
        string ret = "";
        for(var i = 0;i< com1arr.Length;i++)
        {
            double d1 = (double)Convert.ToSingle(com1arr[i]) - (double)Convert.ToSingle(com2arr.Length-1>=i?com2arr[i]:"0");
            ret += d1.ToString() + ",";
        }
        return delLastCom(ret);
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