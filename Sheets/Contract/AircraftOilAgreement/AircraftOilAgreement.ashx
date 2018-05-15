<%@ WebHandler Language="C#" Class="AircraftOilAgreement" %>

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
public class AircraftOilAgreement : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest(HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "getAgreementInfo": getAgreementInfo(context); break;
            case "agency_rates": agency_rates(context); break;
            case "getSalesHYData": getSalesHYData(context); break;
            case "getAgreementrecord": getAgreementrecord(context); break;
            //case "getpjcon":getpjcon(context);break;//获取项目和合同关联
            case "getAgreementNumber": getAgreementNumber(context); break;//查询协议号审批记录
            case "getGDrecord": getGDrecord(context); break;//获取归档记录
            case "getProjecsk": getProjecsk(context); break;//获取关联项目收款查询
            case "sel_sk": sel_sk(context); break;
            case "AgreeMent_number": AgreeMent_number(context); break;//判断协议号是否存在
            case "Sh_money": Sh_money(context); break;

            case "GetDatasByAgreement_client": GetDatasByAgreement_client(context); break;
            case "getYSListRMB": getYSListRMB(context); break;
            case "getYSListPercent": getYSListPercent(context); break;
            case "getYSListUSD": getYSListUSD(context); break;
            case "getSKRecordsUSD": getSKRecordsUSD(context); break;
        }
    }
    public void getAgreementInfo(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        //List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        String sqls = "SELECT cm.PostA,cm.PostB,cm.FinalUser,e1.EnumValue ContractProperty,cm.ContractNo,cm.CreatedBy,cm.CreatedTime " +
                // " ar.agency_money,e1.EnumValue agency_type,ar.up_limit,ar.lower_limit " +
                " FROM I_ContractMain cm  " +
                //" inner JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID " +
                " inner JOIN OT_EnumerableMetadata e1 on e1.Code = cm.ContractProperty and e1.Category = '合同性质（JK）' " +
                "  where cm.ContractNo='" + AgreeMent_number + "'";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        Dictionary<string, string> dic = new Dictionary<string, string>();
        if (dt.Rows.Count > 0)
        {

            dic.Add("Project_head_A", dt.Rows[0]["PostA"].ToString());
            dic.Add("Project_head_B", dt.Rows[0]["PostB"].ToString());
            //dic.Add("Project_head_B", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["PostB"].ToString()));
            dic.Add("Agreement_client", dt.Rows[0]["FinalUser"].ToString());
            dic.Add("AgreeMent_name", dt.Rows[0]["ContractProperty"].ToString());
            dic.Add("AgreeMent_number", dt.Rows[0]["ContractNo"].ToString());


        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    public void agency_rates(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //String sql = "SELECT cm.AgencyComputerNum agency_money,e1.EnumValue agency_type  " +
        //        " FROM I_ContractMain cm " +
        //        " inner JOIN OT_EnumerableMetadata e1 on e1.Code = cm.AgencyComputerType and e1.Category = '代理费费率／金额' " +
        //        "  where cm.ContractNo='" + AgreeMent_number + "'";
        String sql = "SELECT cm.AgencyComputerNum agency_money,cm.AgencyComputerType agency_type  " +
                " FROM I_ContractMain cm " +
                //" inner JOIN OT_EnumerableMetadata e1 on e1.Code = cm.AgencyComputerType and e1.Category = '代理费费率／金额' " +
                "  where cm.ContractNo='" + AgreeMent_number + "'";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("agency_money", dr["agency_money"].ToString());
                dic.Add("agency_type", dr["agency_type"].ToString());
                dic.Add("up_limit", "");
                dic.Add("lower_limit", "");
                ls.Add(dic);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }
    //查询收款记录
    public void Sh_money(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        String Agreement_record = "SELECT ObjectID,CreatedTime,Reduced_money FROM I_Charge_back " +
            " WHERE Agency_number='" + AgreeMent_number + "'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("ObjectID", dr["ObjectID"].ToString());
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
        String Agreement_one = "select AgreeMent_name from  I_Agreement_mains where AgreeMent_number='" + AgreeMent_number + "'";
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
    public void getProjecsk(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();

        //String Agreement_record = "SELECT cm.ObjectID,cm.ContractType,cm.ContractNo,cm.ContractName,rates.agency_money,em.EnumValue,am.ys_agency,am.agency_ye FROM I_AircraftOilAgreement am " +
        //    "LEFT JOIN agency_rates_hy rates on am.Object=rates.ParentObjectID " +
        //    "LEFT JOIN I_ContractMain cm ON am.AgreeMent_number=cm.AgencySelect LEFT JOIN OT_EnumerableMetadata em ON am.Rate_type=em.Code" +
        //    " WHERE am.AgreeMent_number='"+AgreeMent_number+"'";
        String Agreement_record = "SELECT cm.ObjectID,cm.ContractType,cm.ContractNo,cm.ContractName,rates.agency_money,em.EnumValue,am.ys_agency,am.agency_ye FROM  I_AircraftOilAgreement am LEFT JOIN I_agency_rates_hy rates ON am.ObjectID = rates.ParentObjectID LEFT JOIN I_ContractMain cm ON am.AgreeMent_number = cm.ContractNo LEFT JOIN OT_EnumerableMetadata em ON rates.agency_type = em.Code WHERE am.AgreeMent_number = '" + AgreeMent_number + "'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("ObjectID", dr["ObjectID"].ToString());
                dic.Add("ContractType", dr["ContractType"].ToString());
                dic.Add("ContractNo", dr["ContractNo"].ToString());
                dic.Add("ContractName", dr["ContractName"].ToString());
                dic.Add("agency_rate", dr["agency_rate"].ToString() + "" + dt.Rows[0]["EnumValue"].ToString());
                dic.Add("ys_money", dr["ys_agency"].ToString() + "" + dt.Rows[0]["EnumValue"].ToString());
                dic.Add("ye_money", (int)Convert.ToSingle(dr["agency_rate"]) - (int)Convert.ToSingle(dr["ys_agency"]) + dr["EnumValue"].ToString());
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
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();

        String Agreement_record = "SELECT af.OwnerId,CONVERT(varchar(12),af.CreatedTime,111) CreatedTime," +
           "case ic.State when '2' then '审批中' when '4' then  '审批完了' end DisplayName,wf.ObjectID  FROM I_Agreement_file af " +
           "LEFT JOIN OT_InstanceContext ic ON af.ObjectID = ic.BizObjectId LEFT JOIN OT_WorkItemFinished wf ON wf.InstanceId=ic.ObjectID " +
           " WHERE af.Agreement_Number='" + AgreeMent_number + "'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
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
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        String Agreement_record = "SELECT ua.CreatedBy,CONVERT(varchar(12),ua.CreatedTime,111) CreatedTime,ic.State FROM I_Update_agreement_number ua " +
            " INNER JOIN OT_InstanceContext ic ON ua.ObjectID = ic.BizObjectId " +
            " and ua.Update_agreeMent_number='" + AgreeMent_number + "'";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {

                Dictionary<string, string> dic_two = new Dictionary<string, string>();
                dic_two.Add("Apply_people", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["CreatedBy"].ToString()));
                dic_two.Add("Apply_time", dr["CreatedTime"].ToString());
                var st = dr["State"].ToString();
                dic_two.Add("State", st == "2" ? "审批中" : (st == "4" ? "审批完了" : ""));
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
    public void AgreementNo(HttpContext context) {
        Dictionary<string, string> dic = new Dictionary<string, string>();
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
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        String Agreement_record = "SELECT ObjectID, Old_agency_fee,New_money,Old_pay_condition,New_pay_condition,Change_pay_content,agrency_type  " +
            "FROM I_Agreenment_change WHERE Agreenment_number='" + AgreeMent_number + "'";

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
                dic_two.Add("New_money", dr["New_money"].ToString() + dr["agrency_type"].ToString());
                dic_two.Add("Old_pay_condition", dr["Old_pay_condition"].ToString());
                dic_two.Add("New_pay_condition", dr["Change_pay_content"].ToString());
                String states = "SELECT wt.DisplayName FROM I_Agreenment_change ac LEFT JOIN OT_InstanceContext ic ON ac.ObjectID = ic.BizObjectId " +
           "LEFT JOIN OT_WorkItem wt ON ic.ObjectID=wt.InstanceId where ac.ObjectID='" + dr["ObjectID"].ToString() + "'";
                System.Data.DataTable re_state = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        states);

                dic_two.Add("State", re_state.Rows[0]["DisplayName"].ToString() != "" ? "审批中" : "审批完成");
                //dic_two.Add("btext", dr["btext"].ToString());
                ls.Add(dic_two);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }


    public void getSalesHYData(HttpContext context) {
        // 
        string ObjectID = context.Request["ObjectID"];
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT shy.* FROM I_SalerTblOfHY shy, I_HYContractSet hy where shy.ParentObjectID = hy.ObjectID and hy.ObjectID = '" + ObjectID + "'");
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("ObjectID", dr["ObjectID"].ToString());
                dic.Add("CompanyName", dt.Rows[0]["CompanyName"].ToString());
                dic.Add("ContactName", dt.Rows[0]["ContactName"].ToString());
                dic.Add("Telephone", dt.Rows[0]["Telephone"].ToString());
                dic.Add("Mobile", dt.Rows[0]["Mobile"].ToString());
                dic.Add("Fax", dt.Rows[0]["Fax"].ToString());
                dic.Add("Email", dt.Rows[0]["Email"].ToString());
                ls.Add(dic);
            }

        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    // 根据协议委托方获取相关数据
    public void GetDatasByAgreement_client(HttpContext context) {
        string Agreement_client = context.Request["Agreement_client"];
        Dictionary<string, string> dic = new Dictionary<string, string>();
        var Contacts = "";
        var Con_phone = "";
        var Mobile_phone = "";
        var Fax = "";
        var Email = "";
        var Contact_address = "";
        String Agreement_record = "select cu.*,p.* FROM I_CustomerList cu " +
                                    " INNER JOIN I_ContactsTbl p on cu.ObjectID = p.ParentObjectID  " +
                                    " and cu.CompanyName = '" + Agreement_client + "'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_record);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Contacts += dr["ContactName"].ToString() + ",";
                Con_phone += dr["Telephone"].ToString() + ",";
                Mobile_phone += dr["Mobile"].ToString() + ",";
                Fax += dr["Fax"].ToString() + ",";
                Email += dr["Email"].ToString() + ",";
                Contact_address = dr["Address"].ToString();
            }
        }
        dic.Add("Contacts", Contacts);
        dic.Add("Con_phone", Con_phone);
        dic.Add("Mobile_phone", Mobile_phone);
        dic.Add("Fax", Fax);
        dic.Add("Email", Email);
        dic.Add("Contact_address", Contact_address);
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }

    // 应收代理费列表 RMB
    public void getYSListRMB(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string ReceiveAgencyFee = "0";
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 通过协议号获取协议表单中保存的已收代理费字段
        String sqls = "select AgreeMent_number,ReceiveAgencyFeeHidden " +
                "from I_AircraftOilAgreement  where AgreeMent_number='" + AgreeMent_number + "'";
        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        if (dt1.Rows.Count > 0) {
            ReceiveAgencyFee = dt1.Rows[0]["ReceiveAgencyFeeHidden"].ToString();
        }
        string Agreement_bid_record = " select max(ib.ProjectName) ProjectName,max(ib.BiddingCode) BiddingCode,max(ar.agency_money) YSAgencyFee ,sum(be.EquivalentRMB) bidPrice " +
            " from I_AircraftOilAgreement am  " +
            " INNER JOIN I_agency_rates_hy ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_RMB' " +
            " INNER JOIN I_AgencyAgreements aas on aas.AgreementCode = am.AgreeMent_number and am.AgreeMent_number = '" + AgreeMent_number + "' " +
            " INNER JOIN I_InviteBids ib on aas.ParentObjectID = ib.ObjectID " +
            " INNER JOIN I_BiddingEvaluation be on ib.ObjectID = be.ParentObjectID " +
            " GROUP BY ib.BiddingCode  " +
            " HAVING sum(be.EquivalentRMB) > 0 " +
            " ORDER BY ib.BiddingCode ";
        String Agreement_cont_record = " select e.EnumValue ContractType,cm.ContractNo,cm.ContractName,ar.agency_money YSAgencyFee " +
            " from I_Agreement_mains am " +
            " INNER JOIN I_ContractMain cm on cm.AgencyCode = am.AgreeMent_number " +
            " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_Percent' " +
            " INNER JOIN OT_EnumerableMetadata e on e.Code = cm.ContractType and e.Category = '合同类型' " +
            " and am.AgreeMent_number = '" + AgreeMent_number + "' and cm.AgencyReturnType ='人民币' and cm.ContractTotalPrice > 0" +
            " ORDER BY ContractType,ContractNo";
        System.Data.DataTable dt_bid = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_bid_record);
        System.Data.DataTable dt_cont = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_cont_record);
        if (dt_bid.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_bid.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("Type", "招标");
                dic.Add("ProjectNo", dr["BiddingCode"].ToString());
                dic.Add("ProjectName", dr["ProjectName"].ToString());
                dic.Add("YSAgencyFee", dr["YSAgencyFee"].ToString());
                dic.Add("ReceiveAgencyFee", ReceiveAgencyFee);
                double AgencyFeeRemain = (double)Convert.ToSingle(dr["YSAgencyFee"]) - (double)Convert.ToSingle(ReceiveAgencyFee);
                dic.Add("AgencyFeeRemain", AgencyFeeRemain.ToString());
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
                dic.Add("YSAgencyFee", dr["YSAgencyFee"].ToString());
                dic.Add("ReceiveAgencyFee", ReceiveAgencyFee);
                double AgencyFeeRemain = (double)Convert.ToSingle(dr["YSAgencyFee"]) - (double)Convert.ToSingle(ReceiveAgencyFee);
                dic.Add("AgencyFeeRemain", AgencyFeeRemain.ToString());
                ls.Add(dic);
            }

        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }

    // 应收代理费列表 百分比
    public void getYSListPercent(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string ProjectNos = context.Request["ProjectNos"];
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> lsRet = new List<Dictionary<string, string>>();
        // 先获取相关项目、合同的数据1
        // 再获取本表单的代理费列表数据2
        // 把数据1加到数据2中（已经有的不用加）

        //string Agreement_bid_record = " select max(ib.ProjectName) ProjectName,max(ib.BiddingCode) BiddingCode,max(ar.agency_money) YSAgencyFee ,sum(be.EquivalentRMB) bidPrice " +
        //    " from I_Agreement_mains am  " +
        //    " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_RMB' " +
        //    " INNER JOIN I_AgencyAgreements aas on aas.AgreementCode = am.AgreeMent_number and am.AgreeMent_number = '"+AgreeMent_number+"' " +
        //    " INNER JOIN I_InviteBids ib on aas.ParentObjectID = ib.ObjectID " +
        //    " INNER JOIN I_BiddingEvaluation be on ib.ObjectID = be.ParentObjectID " +
        //    " GROUP BY ib.BiddingCode  " +
        //    " HAVING sum(be.EquivalentRMB) > 0 " +
        //    " ORDER BY ib.BiddingCode ";
        String Agreement_cont_record = " select e.EnumValue ContractType,cm.ContractNo,cm.ContractName " +
            " ,cm.ContractTotalPrice*ar.agency_money/100 YSAgencyFeeRMB" +
            " ,cm.JKTotalAmount*ar.agency_money/100 YSAgencyFeeWB" +
            " ,e2.EnumValue Currency " +
            " from I_Agreement_mains am " +
            " INNER JOIN I_ContractMain cm on cm.AgencyCode = am.AgreeMent_number " +
            " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_Percent'" +
            " INNER JOIN OT_EnumerableMetadata e on e.Code = cm.ContractType and e.Category = '合同类型' " +
            " and am.AgreeMent_number = '" + AgreeMent_number + "' and cm.AgencyReturnType ='百分比' and (cm.ContractTotalPrice > 0 or cm.JKTotalAmount > 0)" +
            " Left JOIN OT_EnumerableMetadata e2 on e2.Code = cm.Currency and e2.Category = '币种' " +
            " ORDER BY ContractType,ContractNo";
        String Agreement_tbl = " select yp.* " +
            " from I_YSList_Percent yp " +
            " INNER JOIN I_Agreement_mains am on yp.parentObjectID = am.ObjectID and am.AgreeMent_number = '" + AgreeMent_number + "' " +
            " ORDER BY yp.Type,yp.projectNo ";
        //System.Data.DataTable dt_bid = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_bid_record);
        System.Data.DataTable dt_cont = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_cont_record);
        System.Data.DataTable dt_tbl = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_tbl);
        //if (dt_bid.Rows.Count > 0)
        //{
        //    foreach (DataRow dr in dt_bid.Rows)
        //    {
        //        Dictionary<string,string> dic = new Dictionary<string,string>();
        //        dic.Add("Type","招标");
        //        dic.Add("ProjectNo", dr["BiddingCode"].ToString());
        //        dic.Add("ProjectName", dr["ProjectName"].ToString());
        //        dic.Add("YSAgencyFee", dr["YSAgencyFee"].ToString());
        //        dic.Add("ReceiveAgencyFee", ReceiveAgencyFee);
        //        double AgencyFeeRemain =  (double)Convert.ToSingle(dr["YSAgencyFee"]) - (double)Convert.ToSingle(ReceiveAgencyFee);
        //        dic.Add("AgencyFeeRemain", AgencyFeeRemain.ToString());
        //        ls.Add(dic);
        //    }

        //}
        if (dt_cont.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_cont.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("Type", dr["ContractType"].ToString());
                dic.Add("ProjectNo", dr["ContractNo"].ToString());
                dic.Add("ProjectName", dr["ContractName"].ToString());
                dic.Add("YSAgencyFeeRMB", dr["YSAgencyFeeRMB"].ToString());
                dic.Add("YSAgencyFeeWB", dr["YSAgencyFeeWB"].ToString());
                dic.Add("Currency", dr["Currency"].ToString());

                bool isContainFlg = false;
                if (dt_tbl.Rows.Count > 0)
                {
                    foreach (DataRow dr2 in dt_tbl.Rows)
                    {
                        if (dr["ContractNo"].ToString() == dr2["ProjectNo"].ToString())
                        {
                            dic.Add("ReceiveAgencyFee", dr2["ReceiveAgencyFee"].ToString());
                            dic.Add("ReceiveAgencyFeeWB", dr2["ReceiveAgencyFeeWB"].ToString());
                            dic.Add("ReceiveTotalRMB", dr2["ReceiveTotalRMB"].ToString());
                            dic.Add("AgencyFeeRemainRMB", dr2["AgencyFeeRemainRMB"].ToString());
                            dic.Add("AgencyFeeRemainWB", dr2["AgencyFeeRemainWB"].ToString());
                            isContainFlg = true; break;
                        }
                    }
                }
                if (!isContainFlg)
                {
                    dic.Add("ReceiveAgencyFee", "0");
                    dic.Add("ReceiveAgencyFeeWB", "0");
                    dic.Add("ReceiveTotalRMB", "0");
                    dic.Add("AgencyFeeRemainRMB", "0");
                    dic.Add("AgencyFeeRemainWB", "0");
                }
                ls.Add(dic);
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
        } else
        {
            lsRet = ls;
        }
        object JSONObj = JsonConvert.SerializeObject(lsRet);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }
    // 应收代理费列表 USD
    public void getYSListUSD(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string agency_money = context.Request["agency_money"];
        string ReceiveAgencyFee = "0";
        string ReceiveAgencyFeeWB = "0";
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 通过协议号获取协议表单中保存的已收代理费字段
        String sqls = "select AgreeMent_number,ReceiveAgencyFeeHidden,ReceiveAgencyFeeWBHidden " +
                "from I_AircraftOilAgreement  where AgreeMent_number='" + AgreeMent_number + "'";
        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        if (dt1.Rows.Count > 0)
        {
            ReceiveAgencyFee = dt1.Rows[0]["ReceiveAgencyFeeHidden"].ToString();
            ReceiveAgencyFeeWB = dt1.Rows[0]["ReceiveAgencyFeeWBHidden"].ToString();
        }
        //string Agreement_bid_record = " select max(ib.ProjectName) ProjectName,max(ib.BiddingCode) BiddingCode,max(ar.agency_money) YSAgencyFee ,sum(be.EquivalentRMB) bidPrice " +
        //    " from I_Agreement_mains am  " +
        //    " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_RMB' " +
        //    " INNER JOIN I_AgencyAgreements aas on aas.AgreementCode = am.AgreeMent_number and am.AgreeMent_number = '"+AgreeMent_number+"' " +
        //    " INNER JOIN I_InviteBids ib on aas.ParentObjectID = ib.ObjectID " +
        //    " INNER JOIN I_BiddingEvaluation be on ib.ObjectID = be.ParentObjectID " +
        //    " GROUP BY ib.BiddingCode  " +
        //    " HAVING sum(be.EquivalentRMB) > 0 " +
        //    " ORDER BY ib.BiddingCode ";

        String Agreement_cont_record = "SELECT " +
            " e.EnumValue ContractType," +
            " cm.ContractNo," +
            "cm.ContractName," +
            "qk.Tong YSAgencyFee " +
            "FROM I_QK qk  " +
            "LEFT JOIN I_ContractMain cm ON qk.ContractNo = cm.ContractNo  " +
            "INNER JOIN OT_EnumerableMetadata e ON e.Code = cm.ContractType " +
            " INNER JOIN OT_InstanceContext ins ON ins.BizObjectId = qk.ObjectID  AND  ins.State='4' " +
            "where e.Category = '合同类型' " +
            "AND cm.ContractNo='" + AgreeMent_number + "' " +
            "ORDER BY cm.ContractNo";
        //String Agreement_cont_record = " select e.EnumValue ContractType,cm.ContractNo,cm.ContractName,ar.agency_money YSAgencyFee " +
        //    " from I_Agreement_mains am " +
        //    " INNER JOIN I_ContractMain cm on cm.AgencyCode = am.AgreeMent_number " +
        //    " INNER JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID and ar.agency_type = 'AgencyRate_Percent' " +
        //    " INNER JOIN OT_EnumerableMetadata e on e.Code = cm.ContractType and e.Category = '合同类型' " +
        //    " and am.AgreeMent_number = '"+AgreeMent_number+"' and cm.AgencyReturnType ='人民币' and cm.ContractTotalPrice > 0" +
        //    " ORDER BY ContractType,ContractNo";
        //System.Data.DataTable dt_bid = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_bid_record);
        System.Data.DataTable dt_cont = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(Agreement_cont_record);
        //if (dt_bid.Rows.Count > 0)
        //{
        //    foreach (DataRow dr in dt_bid.Rows)
        //    {
        //        Dictionary<string,string> dic = new Dictionary<string,string>();
        //        dic.Add("Type","招标");
        //        dic.Add("ProjectNo", dr["BiddingCode"].ToString());
        //        dic.Add("ProjectName", dr["ProjectName"].ToString());
        //        dic.Add("YSAgencyFee", dr["YSAgencyFee"].ToString());
        //        dic.Add("ReceiveAgencyFee", ReceiveAgencyFee);
        //        double AgencyFeeRemain =  (double)Convert.ToSingle(dr["YSAgencyFee"]) - (double)Convert.ToSingle(ReceiveAgencyFee);
        //        dic.Add("AgencyFeeRemain", AgencyFeeRemain.ToString());
        //        ls.Add(dic);
        //    }

        //}
        Dictionary<string, string> dic = new Dictionary<string, string>();
        if (dt_cont.Rows.Count > 0)
        {
            double hysum = 0;
            foreach (DataRow dr in dt_cont.Rows)
            {
                double AgencyFee = 0;
                if (dr["YSAgencyFee"] != null && dr["YSAgencyFee"].ToString() != "") {
                    AgencyFee = (double)Convert.ToSingle(dr["YSAgencyFee"]);
                }
                hysum += AgencyFee;

            }

            dic.Add("Type", dt_cont.Rows[0]["ContractType"].ToString());
            dic.Add("ProjectNo", dt_cont.Rows[0]["ContractNo"].ToString());
            dic.Add("ProjectName", dt_cont.Rows[0]["ContractName"].ToString());
            double YSAgencyFee = hysum * (double)Convert.ToSingle(agency_money);
            dic.Add("YSAgencyFee", YSAgencyFee.ToString());
            dic.Add("ReceiveAgencyFee", ReceiveAgencyFee);
            dic.Add("ReceiveAgencyFeeWB", ReceiveAgencyFeeWB);
            double AgencyFeeRemain = YSAgencyFee - (double)Convert.ToSingle(ReceiveAgencyFeeWB);
            dic.Add("AgencyFeeRemain", AgencyFeeRemain.ToString());
            ls.Add(dic);
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);

    }

    public void getSKRecordsUSD(HttpContext context){
        string AgreeMent_number = context.Request["AgreeMent_number"];
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 获取收款USD记录
        System.Data.DataTable dt_skusd = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select CONVERT(varchar(12),c.CreatedTime,111) CreatedTime,CurrentSKTotalUSD,CONVERT(varchar(12),c.SKDate,111) SKDate " +
            " ,ic.State Status,ic.ObjectID ObjectID " +
            //" ,case ic.State when '2' then '审批中' when '4' then  '审批完了' end Status,ic.ObjectID ObjectID " +
            " from I_Charge_back c" +
            " INNER JOIN OT_InstanceContext ic on c.ObjectID = ic.BizObjectId " +
            //" INNER JOIN OT_WorkItemFinished wf ON wf.InstanceId=ic.ObjectID " +
            " where c.agency_type = 'USD' and c.AgreeMent_number = '" + AgreeMent_number + "' ");
        if (dt_skusd.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_skusd.Rows)
            {
                var st = dr["Status"].ToString();
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("ApplyDate", dr["CreatedTime"].ToString());
                dic.Add("SKAmount", dr["CurrentSKTotalUSD"].ToString());
                dic.Add("DKDate", dr["SKDate"].ToString() == "1753/01/01" ? "" : dr["SKDate"].ToString());
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["ObjectID"].ToString(), st);
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        //bizObjects[0]["WorkItemId"] = item.Value;
                        dic.Add("WorkItemId",item.Value);
                    }

                }
               // bizObjects[i]["Status"] = st == "2" ? "审批中" : (st == "4" ? "审批完了" : "");

                dic.Add("Status", dr["Status"].ToString()== "2" ? "审批中" : (st == "4" ? "审批完了" : ""));
                //dic.Add("WorkItemId", dr["IcObjectID"].ToString());
                ls.Add(dic);

            }

            object JSONObj = JsonConvert.SerializeObject(ls);
            context.Response.ContentType = "application/json";
            context.Response.Write(JSONObj);
        }
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