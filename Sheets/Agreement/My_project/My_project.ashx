<%@ WebHandler Language="C#" Class="My_project" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;


public class My_project : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {

            case "getByContractNo": getByContractNo(context); break;
            case "getHYData": getHYData(context); break;
            case "getSalesHYData": getSalesHYData(context); break;
            case "getBizStatusOfContract": getBizStatusOfContract(context); break;
            case "getWorkItemIDByICPID": getWorkItemIDByICPID(context); break;
            case "getMaxQKSeqByContractNo": getMaxQKSeqByContractNo(context); break;
            case "setChangePayment": setChangePayment(context); break;
            case "getPaymentUpdateByPID": getPaymentUpdateByPID(context); break;
            case "cancelImportLicence": cancelImportLicence(context); break;
            case "getproject":getproject(context);break;


        }
    }
    //获取项目列表
    public void getproject(HttpContext context) {
        string user=context.Request["user"];
        //我的项目
        string Project_sel = context.Request["Project_sel"];
        string Project_state = "";
        Project_state=context.Request["Project_state"];//项目状态
        if (Project_state != "" && Project_state != null) {
            Project_state = Project_state.Remove(Project_state.Length - 1,1);//去掉最后一个字符
        }

        string Project_role = context.Request["Project_role"];
        string bids_code = context.Request["bids_code"];
        string zb_advice2 = context.Request["zb_advice2"];
        string zb_advice = context.Request["zb_advice"];
        //项目查询
        //string zb_number = context.Request["zb_number"];//招标编码
        string Project_head = context.Request["Project_head"];//项目负责人
        string fb_time = context.Request["fb_time"];//发标开始时间
        string fb_time2 = context.Request["fb_time2"];//发标结束时间
        string Project_name = context.Request["Project_name"];//项目名称
        string pb_specialist = context.Request["pb_specialist"];//评标专家
        string kb_time = context.Request["kb_time"];//开标开始时间
        string kb_time2 = context.Request["kb_time2"];//开标结束时间
        string bao_number = context.Request["bao_number"];//包号
        //string Project_states = context.Request["Project_state"];//项目状态
        string jx_time = context.Request["jx_time"];//结项开始时间
        string jx_time2 = context.Request["jx_time2"];//结项结束时间
        string tb_units = context.Request["tb_units"];//投标单位
        string zb_way = context.Request["zb_way"];//招标方式
        string zb_money = context.Request["zb_money"];//中标开始价格
        string zb_money2 = context.Request["zb_money2"];//中标结束价格
        string zb_units = context.Request["zb_units"];//中标单位
        string zb_scope = context.Request["zb_scope"];//招标范围
        string agency_fee = context.Request["agency_fee"];//代理费开始
        string agency_fee2 = context.Request["agency_fee2"];//代理费结束
        string zb_people = context.Request["zb_people"];//招标人
        string objection = context.Request["objection"];//是否有意义
        //string zb_time = context.Request["zb_time"];//中标通知书开始
        //string zb_time2 = context.Request["zb_time2"];//中标通知书结束

        String sqls = "select DISTINCT inv.ProjectShortName,inv.OwnerId,inv.BiddingCode,bid.PackageName,inv.CreatedTime,inv.BiddingScope,inv.BiddingMethod," +
            "ten.OrgName,inv.ManagerA,inv.ManagerB,inv.WinnerNoticeDate,wit.ObjectID,(SELECT wi.DisplayName FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = inv.ObjectID " +
            "AND ic.state = '2'  UNION SELECT  '已完成' FROM OT_InstanceContext ic " +
            "where ic.state = '4' and ic.BizObjectId=inv.ObjectID) as con_state from I_InviteBids inv  " +
            "left join I_Tenderees ten on ten.ParentObjectID = inv.ObjectID left join I_BidOpening bid on bid.ParentObjectID = inv.ObjectID " +
            "left join I_BiddingEvaluation bideva on bideva.ParentObjectID = inv.ObjectID left join I_BiddingTender bidten on bidten.ParentObjectID = inv.ObjectID " +
            "left join I_Tenders tenders on tenders.ParentObjectID = bidten.ObjectID left join I_TenderPrice tenderPrice on tenderPrice.ParentObjectID = inv.ObjectID " +
            "left join I_Agreement_mains agreement on tenderPrice.RelatedAgreement = agreement.AgreeMent_name " +
            "left join I_BiddingTenderAuditExperts experts on experts.ParentObjectID = inv.ObjectID " +
            "left join I_ExaminationApprovalObjection examinationApproval on examinationApproval.TenderReference=inv.BiddingCode " +
            "LEFT JOIN OT_InstanceContext ics ON ics.BizObjectid=inv.ObjectID LEFT JOIN OT_WorkItem wit ON wit.InstanceId=ics.ObjectID where 1=1";
        //项目选择
        if (Project_sel != "" && Project_sel != null)
        {
            if (Project_sel == "我的项目") {
                sqls += " and inv.OwnerId='" + user + "'";
            }
            if (Project_sel == "代职项目") {
                sqls += " and inv.OwnerId !='" + user + "'";
            }
        }
        //我的角色
        if (Project_role != null && Project_role != "")
        {
            if (Project_role == "我是A角") {
                sqls += " and inv.ManagerA ='" + user + "'";
            }
            if (Project_role == "我是B角") {
                sqls += " and inv.ManagerB ='" + user + "'";
            }

        }
        //招标编号
        if (bids_code != null && bids_code != "")
        {
            sqls += " and inv.BiddingCode like '%" + bids_code + "%'";

        }
        //中标通知书开始时间
        if (zb_advice2 != null && zb_advice2 != "")
        {
            sqls += " and inv.WinnerNoticeDate  >='" + zb_advice2 + "'";

        }
        //中标通知书结束时间
        if (zb_advice != null && zb_advice != "")
        {
            sqls += " and inv.WinnerNoticeDate  <='" + zb_advice + "'";

        }
        //end 我的项目查询条件结束
        //项目负责人
        if (Project_head != "" && Project_head !=null)
        {
            sqls += " and inv.ManagerA like '%" + Project_head + "%'";
        }
        //发标开始时间
        if (fb_time != "" && fb_time !=null)
        {
            sqls += " and bid.IssueDate  >='" + fb_time + "'";
        }
        //发标结束时间
        if (fb_time2 != "" && fb_time2 !=null)
        {
            sqls += " and bid.IssueDate  <='" + fb_time2 + "'";
        }
        //项目名称
        if (Project_name != "" && Project_name !=null)
        {
            sqls += " and (inv.ProjectName like '%" + Project_name + "%' OR inv.ProjectShortName like '%" + Project_name + "%')";
        }
        //评标专家
        if (pb_specialist != "" && pb_specialist != null) {
            sqls += " and experts.ExpertName like '%" + pb_specialist + "%'";
        }
        //开标开始时间
        if (kb_time != "" && kb_time !=null)
        {
            sqls += " and bid.OpeningDate  >='" + kb_time + "'";
        }
        //开标结束时间
        if (kb_time2 != "" && kb_time2 !=null)
        {
            sqls += " and bid.OpeningDate  <='" + kb_time2 + "'";
        }
        //包号
        if (bao_number != "" && bao_number != null) {
            sqls += " and bid.PackageName like '%" + bao_number + "%'";
        }
        //项目状态
        if (Project_state != "" && Project_state != null) {
            sqls += " and (SELECT wi.DisplayName FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = inv.ObjectID " +
                "AND ic.state = '2'  UNION SELECT  '已完成' FROM OT_InstanceContext ic " +
                "where ic.state = '4' and ic.BizObjectId=inv.ObjectID) = '" + Project_state + "'";
        }
        //结项开始时间
        //if(jx_time !="" && jx_time != null){

        //}
        ////结项结束时间
        //if(jx_time2 !="" && jx_time2 != null){

        //}
        //投标单位
        if (tb_units != "" && tb_units != null) {
            sqls += " and tenders.TenderName like '%" + tb_units + "%'";
        }
        //投标方式
        if (zb_way != "" && zb_way != null) {
            sqls += " and inv.BiddingMethod like '%" + zb_way + "%'";
        }
        //zb_money中标价格开始
        if (zb_money != "" && zb_money != null) {
            sqls += " and tenderPrice.TenderPrice1 >= '" + zb_money + "'";
        }
        //中标价格结束
        if (zb_money2 != "" && zb_money2 != null) {
            sqls += " and tenderPrice.TenderPrice1 <= '" + zb_money2 + "'";
        }
        //中标单位zb_units
        if (zb_units != "" && zb_units != null) {
            sqls += " and bideva.BidWinner like '%" + zb_units + "%'";
        }
        //招标范围zb_scope
        if (zb_scope != "" && zb_scope != null) {
            sqls += " and inv.BiddingScope like '%" + zb_scope + "%'";
        }
        //agency_fee代理费价格开始
        if (agency_fee != "" && agency_fee != null) {
            sqls += " and agreement.agency_rate >= '" + agency_fee + "'";
        }
        //代理费价格结束
        if (agency_fee2 != "" && agency_fee2 != null) {
            sqls += " and agreement.agency_rate <= '" + agency_fee2 + "'";
        }
        //zb_people招标人
        if (zb_people != "" && zb_people != null) {
            sqls += " and ten.OrgName <= '" + zb_people + "'";
        }
        //是否有异议objection
        if (objection != "" && objection != null) {
            if (objection == "1")
            {
                sqls += " and examinationApproval.TenderReference IS NULL";
            }
            else{
                sqls += " and examinationApproval.TenderReference IS NOT NULL";
            }

        }
        //获取协议执行的版本号
        int versionAgreen_performNo = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Agreen_perform");
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        var TheNo = 1;
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("TheNo",TheNo.ToString());
                dic.Add("ProjectShortName",dr["ProjectShortName"].ToString());
                dic.Add("BiddingCode",dr["BiddingCode"].ToString());
                dic.Add("PackageName",dr["PackageName"].ToString());
                dic.Add("CreatedTime",dr["CreatedTime"].ToString());
                dic.Add("BiddingMethod",dr["BiddingMethod"].ToString());
                dic.Add("OrgName",dr["OrgName"].ToString());
                dic.Add("Project_head",OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["ManagerA"].ToString()) + ',' + OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["ManagerB"].ToString()));
                dic.Add("WinnerNoticeDate", dr["WinnerNoticeDate"].ToString());
                dic.Add("con_state", dr["con_state"].ToString());
                dic.Add("ObjectID", dr["ObjectID"].ToString());
                ls.Add(dic);
                TheNo++;
            }


        }


        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    // 获取国内合同当年累积流水号
    public string getMaxContNumOfCurYear(string year)
    {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ContractNo FROM I_ContractMain where ContractNo like 'SPIAIE-"+year+"%' ");
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                int curnum = (int)Convert.ToSingle(dr["ContractNo"].ToString().Split('-')[1].Substring(2));
                if(curnum > num)
                {
                    num = curnum;
                }
            }
            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }

    // 获取对应工程下国内合同流水号（国内／进口分开）
    public string getMaxContNumOfGNPro(string SubProjectCode, string countrytype)
    {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ContractNo FROM I_ContractMain where ContractNo like '%"+SubProjectCode+countrytype+"%' ");
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        int len = (SubProjectCode + countrytype).Length;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                int curnum = (int)Convert.ToSingle(dr["ContractNo"].ToString().Split('-')[2].Substring(len));
                if(curnum > num)
                {
                    num = curnum;
                }
            }
            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }

    // 获取航油、非航油合同累积流水号
    public string getMaxContNumOfHY(string year, string type)
    {
        int num = 0;

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ContractNo FROM I_ContractMain where ContractNo like '"+year+"SPIAIE"+type+"-%' ");
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                string tp = dr["ContractNo"].ToString().Split('-')[1];
                int curnum = (int)Convert.ToSingle(tp.Substring(0,tp.Length-2));
                if(curnum > num)
                {
                    num = curnum;
                }
            }
            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }

    public void getByContractNo (HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string state = "";
        // 国内合同
        String numberid = "SELECT AgreeMent_name  FROM I_AgreeMent_main where AgreeMent_number='"+AgreeMent_number+"'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
           numberid);
        if (dt.Rows.Count > 0)
        {
            state = "1";
        }
        else {
            state = "2";
        }

        object JSONObj = JsonConvert.SerializeObject(state);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }



    public void getHYData (HttpContext context) {
        Dictionary<string,string> dic = new Dictionary<string,string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT * from I_HYContractSet ");
        if (dt.Rows.Count > 0) {
            dic.Add("ObjectID",dt.Rows[0]["ObjectID"].ToString());
            dic.Add("PostB",dt.Rows[0]["PostB"].ToString());
            dic.Add("FinalUser",dt.Rows[0]["FinalUser"].ToString());
            dic.Add("BidType",dt.Rows[0]["BidType"].ToString());
            dic.Add("ContractType",dt.Rows[0]["ContractType"].ToString());
            dic.Add("ContractName",dt.Rows[0]["ContractName"].ToString());
            dic.Add("ContractShortName",dt.Rows[0]["ContractShortName"].ToString());
            dic.Add("ProjectName",dt.Rows[0]["ProjectName"].ToString());
            dic.Add("SubProjectName",dt.Rows[0]["SubProjectName"].ToString());
            dic.Add("SubProjectCode",dt.Rows[0]["SubProjectCode"].ToString());
            dic.Add("TradeMethod",dt.Rows[0]["TradeMethod"].ToString());
            dic.Add("Country",dt.Rows[0]["Country"].ToString());
            dic.Add("ContractRemark",dt.Rows[0]["ContractRemark"].ToString());
            dic.Add("Salers",dt.Rows[0]["Salers"].ToString());
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
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



    // 获取业务子流程的状态，和合同号相关
    public void getBizStatusOfContract (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        string BizNo = context.Request["BizNo"];
        string ret = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT ic.State FROM I_"+BizNo+" tbl, OT_InstanceContext ic where tbl.ObjectID = ic.BizObjectId and tbl.ContractNo = '"+ContractNo+"'");
        if (dt.Rows.Count > 0) {
            ret = dt.Rows[0]["State"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    // 根据InstanceContext父节点id获取workItem的id
    public void getWorkItemIDByICPID (HttpContext context) {
        string InstanceId = context.Request["InstanceId"];
        // workItem的id
        string ObjectId = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select top 1 wi.ObjectId"+
            " from OT_InstanceContext ic,OT_WorkItem wi"+
            " where ic.ParentInstanceId = '"+InstanceId+"'"+
            " and ic.ObjectID = wi.InstanceId"+
            " order by ic.CreatedTime desc ");
        if (dt.Rows.Count > 0)
        {
            ObjectId = dt.Rows[0]["ObjectId"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(ObjectId);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取合同号对应的请款最大批次
    public void getMaxQKSeqByContractNo (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        // workItem的id
        string QKSeq = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT Max(QKSeq) QKSeq FROM I_QK "+
            " where ContractNo = '"+ContractNo+"'");
        if (dt.Rows.Count > 0)
        {
            QKSeq = dt.Rows[0]["QKSeq"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(QKSeq);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void setChangePayment (HttpContext context) {
        string PaymentObjectID = context.Request["PaymentObjectID"];
        string Status = context.Request["Status"];

        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " update I_PaymentSub set changePaymentFlg = '"+Status+"' where ObjectID = '"+PaymentObjectID+"' ");

        System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " update I_PaymentUpdateSub set changePaymentFlg = '"+Status+"' where ObjectID = '"+PaymentObjectID+"' ");

        object JSONObj = JsonConvert.SerializeObject("");
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void cancelImportLicence (HttpContext context) {
        string ImportLicenseId = context.Request["ImportLicenseId"];
        string flg = context.Request["flg"];
        string cancelFlg = "";
        if(flg.Equals("cancel"))
        {
            cancelFlg = "1";
        } else if(flg.Equals("undocancel"))
        {
            cancelFlg = "0";
        }

        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " update I_ImportLicenseSub set cancelFlg = '"+cancelFlg+"' where ObjectID = '"+ImportLicenseId+"' ");

        object JSONObj = JsonConvert.SerializeObject("");
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    public void getPaymentUpdateByPID (HttpContext context) {
        // 
        string PObjectID = context.Request["PObjectID"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT p.BankName," +
            " up.PaymentAmount," +
            " ic.State Status," +
            " case ic.State when '2' then '审批中' when '4' then '已开证' end DisplayName, " +
            " up.CreatedTime," +
            " ic.ObjectID," +
            " p.PaymentNo PaymentId, " +
            " case up.changePaymentFlg when '2' then '改证中' when '4' then '已改证' end changePaymentFlg " +
            " FROM I_PaymentUpdateSub up ,OT_InstanceContext ic ,I_PaymentSub p " +
            " where p.ObjectID ='603ea6c6-054e-4eff-8dd9-9a961b248e45' " +
            " and up.ObjectID = ic.BizObjectId and p.paymentNo = up.paymentno " +
            " order by CreatedTime desc ");
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("BankName",dr["BankName"].ToString());
                dic.Add("PaymentAmount",dt.Rows[0]["PaymentAmount"].ToString());
                dic.Add("DisplayName",dt.Rows[0]["DisplayName"].ToString());
                dic.Add("changePaymentFlg",dt.Rows[0]["changePaymentFlg"].ToString());

                ls.Add(dic);
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