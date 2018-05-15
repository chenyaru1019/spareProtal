<%@ WebHandler Language="C#" Class="My_agreement" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;


public class My_agreement : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "AgreementNo": AgreementNo(context); break;
            case "getByContractNo": getByContractNo(context); break;
            case "getHYData": getHYData(context); break;
            case "getSalesHYData": getSalesHYData(context); break;
            case "getBizStatusOfContract": getBizStatusOfContract(context); break;
            case "getWorkItemIDByICPID": getWorkItemIDByICPID(context); break;
            case "getMaxQKSeqByContractNo": getMaxQKSeqByContractNo(context); break;
            case "setChangePayment": setChangePayment(context); break;
            case "getPaymentUpdateByPID": getPaymentUpdateByPID(context); break;
            case "cancelImportLicence": cancelImportLicence(context); break;
            case "getagreementList":getagreementList(context);break;


        }
    }
    //获取协议列表
    public void getagreementList(HttpContext context) {
        string AgreeMent_number = context.Request["AgreeMent_number"];
        string agreement_type = context.Request["agreement_type"];
        string agreement= context.Request["agreement"];
        string my_role= context.Request["my_role"];
        string Contra_type = context.Request["Contra_type"];
        string user=context.Request["user"];
        string entrust_side=context.Request["entrust_side"];//委托方
        string Agreement_name=context.Request["Agreement_name"];//协议名称
        string Contract_number=context.Request["Contract_number"];//合同招标项目编号
        string Contract_nature=context.Request["Contract_nature"];//合同性质
        string BGSignDate = context.Request["BGSignDate"];//变更签约日期
        string BGSignDate2 = context.Request["BGSignDate2"];//变更签约日期
        //String sqls = "SELECT a.AgreeMent_name,a.AgreeMent_number,a.Agreement_client,em.EnumValue,a.agency_rate,CONVERT(varchar(12),cts.SignDate,111) siDate," +
        //    "((SELECT Name FROM OT_User u WHERE u.ObjectID = a.Project_head_A) + ',' + (SELECT Name FROM OT_User u WHERE  u.ObjectID = a.Project_head_B)) AS Project_head," +
        //    "( SELECT wi.DisplayName FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = a.ObjectID" +
        //    " AND ic.state = '2' UNION SELECT wi.DisplayName FROM OT_InstanceContext ic INNER JOIN OT_WorkItemFinished wi ON ic.ObjectID = wi.InstanceId " +
        //    "AND ic.BizObjectId = a.ObjectID AND ic.state = '4') AS con_state,cts.ContractNo,cts.BidNo,wit.ObjectID " +
        //    "FROM I_AgreeMent_mains a LEFT JOIN I_ContractMain cts  ON a.AgreeMent_number=cts.AgencyCode LEFT JOIN OT_EnumerableMetadata em ON em.code=a.Rate_type  " +
        //    "LEFT JOIN OT_InstanceContext ics ON ics.BizObjectid=a.ObjectID LEFT JOIN OT_WorkItem wit ON wit.InstanceId=ics.ObjectID where 1=1";

        String sqls = "SELECT DISTINCT a.AgreeMent_name,a.AgreeMent_number,a.Agreement_client,STUFF( (   SELECT ','+ em.EnumValue FROM I_agency_rates rates LEFT JOIN OT_EnumerableMetadata em ON em.code = rates.agency_type where rates.ParentObjectID = a.ObjectID FOR XML PATH('') ),1 ,1, '') EnumValue,STUFF((SELECT ','+ CONVERT(VARCHAR,rates.agency_money) FROM  I_agency_rates rates where rates.ParentObjectID = a.ObjectID FOR XML PATH('')),1 ,1, '') agency_rate,CONVERT(varchar(12),a.SignDate,111) siDate," +
    "((SELECT Name FROM OT_User u WHERE u.ObjectID = a.Project_head_A) + ',' + (SELECT Name FROM OT_User u WHERE  u.ObjectID = a.Project_head_B)) AS Project_head," +
    "( SELECT wi.DisplayName FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = a.ObjectID" +
    " AND ic.state = '2' UNION SELECT '已完成' FROM OT_InstanceContext ic  WHERE ic.State='4' and ic.BizObjectId=a.ObjectID ) AS con_state," +
    "CONVERT (VARCHAR (12),( SELECT TOP 1 change.BGSignDate FROM I_Agreenment_change change INNER JOIN OT_InstanceContext ins ON ins.BizObjectId = change.ObjectID AND ins.State = '4' AND change.AgreeMent_number = a.AgreeMent_number ORDER BY change.CreatedTime DESC ),111) AS BGSignDate," +
    //"(SELECT top 1 change.BGSignDate FROM I_Agreenment_change change "+
    //"INNER JOIN OT_InstanceContext ins ON ins.BizObjectId=change.ObjectID AND ins.State='4' AND change.AgreeMent_number = a.AgreeMent_number order by change.CreatedTime DESC ) AS BGSignDate," +
    //"cts.ContractNo,cts.BidNo," +
    "(SELECT wi.ObjectID FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = a.ObjectID AND ic.state = '2' UNION SELECT top 1 wif.ObjectID FROM OT_InstanceContext ic INNER JOIN OT_WorkItemFinished wif on ic.ObjectID = wif.InstanceId WHERE ic.State = '4' AND ic.BizObjectId = a.ObjectID ORDER by wif.FinishTime DESC ) AS ObjectID " +
    "FROM I_AgreeMent_mains a " +
     " LEFT JOIN I_AgencyAgreements aa on a.Agreement_number = aa.AgreementCode " +
                    " LEFT JOIN I_InviteBids ib on aa.ParentObjectID = ib.ObjectID " +
    "LEFT JOIN I_ContractMain cts  ON a.AgreeMent_number=cts.AgencyCode LEFT JOIN I_agency_rates rates ON rates.ParentObjectID = a.ObjectID LEFT JOIN OT_EnumerableMetadata em ON em.code = rates.agency_type " +
    "LEFT JOIN OT_InstanceContext ics ON ics.BizObjectid=a.ObjectID LEFT JOIN OT_WorkItem wit ON wit.InstanceId=ics.ObjectID " +
    "LEFT JOIN OT_EnumerableMetadata e1 on cts.ContractType = e1.Code and e1.Category = '合同类型' " +
    "LEFT JOIN OT_EnumerableMetadata e2 on cts.ContractProperty = e2.Code and e2.Category = '合同性质（GN/JK）' " +
    "where 1=1";
        if (entrust_side !="" && entrust_side !=null) {
            sqls += " and a.Agreement_client like '%" + entrust_side + "%'";
        }
        if (Contract_number != "" && Contract_number != null) {
            sqls += " and (cts.ContractNo like '%" + Contract_number + "%' OR ib.BiddingCode like '%" + Contract_number + "%') ";
        }
        if (Contract_nature != "" && Contract_nature != null) {
            sqls += " and e2.EnumValue = '" + Contract_nature + "'";
        }
        if (Agreement_name != "" && Agreement_name !=null) {
            sqls += " and a.AgreeMent_name like '%" + Agreement_name + "%'";
        }
        if (AgreeMent_number != "" && AgreeMent_number !=null)
        {
            sqls += " and a.Agreement_number like '%" + AgreeMent_number + "%'";
        }

        //if (agreement != "") {
        //    switch (agreement) {
        //        case "w1":sqls += "我的协议";break;
        //        case "w2":sqls += "代职协议";break;
        //        case "w3":sqls += "全部";break;
        //    }
        //}
        if (my_role != null && my_role != "")
        {
            if (my_role == "我是A角") {
                sqls += " and a.Project_head_A='" + user + "'";
            }
            if (my_role == "我是B角") {
                sqls += " and a.Project_head_B='" + user + "'";
            }

        }
        if (agreement_type != null && agreement_type != "") {
            if (agreement_type == "我的协议") {
                sqls += " and a.OwnerId='" + user + "'";
            }
            if (agreement_type == "代职协议") {
                sqls += " and a.OwnerId !='" + user + "'";
            }
        }
        if (Contra_type != null && Contra_type !="") {
            sqls += " and e1.EnumValue = '"+Contra_type+"' ";
        }
        if (BGSignDate != "" && BGSignDate !=null)
        {
            sqls += " AND (	SELECT	top 1 change.BGSignDate	FROM I_Agreenment_change change INNER JOIN OT_InstanceContext ins ON ins.BizObjectId=change.ObjectID AND ins.State='4' AND change.Agreenment_number = a.AgreeMent_number order by change.CreatedTime DESC ) >= '"+BGSignDate+"' ";
        }
        if (BGSignDate2 != "" && BGSignDate2 !=null)
        {
            sqls += " AND (SELECT top 1 change.BGSignDate FROM I_Agreenment_change change INNER JOIN OT_InstanceContext ins ON ins.BizObjectId=change.ObjectID AND ins.State='4' AND change.Agreenment_number = a.AgreeMent_number order by change.CreatedTime DESC ) <= '"+BGSignDate2+"' ";
        }
        sqls += " UNION SELECT DISTINCT a.AgreeMent_name,a.AgreeMent_number,a.Agreement_client," +
            "STUFF(( SELECT ','+ em.EnumValue FROM I_agency_rates_hy rates LEFT JOIN OT_EnumerableMetadata em ON em.code = rates.agency_type where a.ObjectID=rates.ParentObjectID FOR XML PATH('')),1 ,1, '') EnumValue," +
            "STUFF(( SELECT ','+ CONVERT(VARCHAR,hy.agency_money) FROM I_agency_rates_hy hy LEFT JOIN OT_EnumerableMetadata em ON em.code = hy.agency_type where a.ObjectID=hy.ParentObjectID FOR XML PATH('')),1 ,1, '') agency_rate," +
            "CONVERT (VARCHAR (12),a.SignDate,111) siDate," +
             "((SELECT Name FROM OT_User u WHERE u.ObjectID = a.Project_head_A) + ',' + (SELECT Name FROM OT_User u WHERE  u.ObjectID = a.Project_head_B)) AS Project_head," +
    "( SELECT wi.DisplayName FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = a.ObjectID" +
    " AND ic.state = '2' UNION SELECT '已完成' FROM OT_InstanceContext ic  WHERE ic.State='4' and ic.BizObjectId=a.ObjectID ) AS con_state," +
    "CONVERT (VARCHAR (12),( SELECT TOP 1 change.BGSignDate FROM I_Agreenment_change change INNER JOIN OT_InstanceContext ins ON ins.BizObjectId = change.ObjectID AND ins.State = '4' AND change.AgreeMent_number = a.AgreeMent_number ORDER BY change.CreatedTime DESC ),111) AS BGSignDate," +
    //"cts.ContractNo,cts.BidNo," +
    "(SELECT wi.ObjectID FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = a.ObjectID AND ic.state = '2' UNION SELECT top 1 wif.ObjectID FROM OT_InstanceContext ic INNER JOIN OT_WorkItemFinished wif on ic.ObjectID = wif.InstanceId WHERE ic.State = '4' AND ic.BizObjectId = a.ObjectID ORDER by wif.FinishTime DESC ) AS ObjectID "  +
    "FROM I_AircraftOilAgreement a LEFT JOIN I_ContractMain cts ON a.AgreeMent_number = cts.ContractNo " +
    "left JOIN I_agency_rates_hy hy ON hy.ParentObjectID = a.ObjectID LEFT JOIN OT_EnumerableMetadata em ON em.code = hy.agency_type "+
    // "LEFT JOIN OT_EnumerableMetadata em ON em.code = cts.AgencyComputerType " +
    "LEFT JOIN OT_InstanceContext ics ON ics.BizObjectid = a.ObjectID " +
    "LEFT JOIN OT_WorkItem wit ON wit.InstanceId = ics.ObjectID " +
    "LEFT JOIN OT_EnumerableMetadata e1 on cts.ContractType = e1.Code and e1.Category = '合同类型' " +
    "LEFT JOIN OT_EnumerableMetadata e2 on cts.ContractProperty = e2.Code and e2.Category = '合同性质（GN/JK）' " +
    "WHERE  1 = 1 ";
        if (entrust_side !="" && entrust_side !=null) {
            sqls += " and a.Agreement_client like '%" + entrust_side + "%'";
        }
        if (Contract_number != "" && Contract_number != null) {
            sqls += " and (cts.ContractNo like '%" + Contract_number + "%' " +
               // "OR cts.BidNo like '%" + Contract_number + "%'" +
                ")";
        }
        //if (Contract_nature != "") {
        //    sqls += " and cts.ContractProperty = '" + Contract_nature + "'";
        //}
        if (Contract_nature != "" && Contract_nature != null) {
            sqls += " and e2.EnumValue = '" + Contract_nature + "'";
        }
        if (Agreement_name != "" && Agreement_name !=null) {
            sqls += " and a.AgreeMent_name like '%" + Agreement_name + "%'";
        }
        if (AgreeMent_number != "" && AgreeMent_number !=null)
        {
            sqls += " and a.Agreement_number like '%" + AgreeMent_number + "%'";
        }

        //if (agreement != "") {
        //    switch (agreement) {
        //        case "w1":sqls += "我的协议";break;
        //        case "w2":sqls += "代职协议";break;
        //        case "w3":sqls += "全部";break;
        //    }
        //}
        if (my_role != null && my_role != "")
        {
            if (my_role == "我是A角") {
                sqls += " and a.Project_head_A='" + user + "'";
            }
            if (my_role == "我是B角") {
                sqls += " and a.Project_head_B='" + user + "'";
            }

        }
        if (agreement_type != null && agreement_type != "") {
            if (agreement_type == "我的协议") {
                sqls += " and a.OwnerId='" + user + "'";
            }
            if (agreement_type == "代职协议") {
                sqls += " and a.OwnerId !='" + user + "'";
            }
        }
        if (Contra_type != null && Contra_type !="") {
            sqls += " and e1.EnumValue = '"+Contra_type+"' ";
        }
        if (BGSignDate != "" && BGSignDate !=null)
        {
            sqls += " AND (	SELECT	top 1 change.BGSignDate	FROM I_Agreenment_change change INNER JOIN OT_InstanceContext ins ON ins.BizObjectId=change.ObjectID AND ins.State='4' AND change.AgreeMent_number = a.AgreeMent_number order by change.CreatedTime DESC ) >= '"+BGSignDate+"'";
        }
        if (BGSignDate2 != "" && BGSignDate2 !=null)
        {
            sqls += " AND (	SELECT	top 1 change.BGSignDate	FROM I_Agreenment_change change INNER JOIN OT_InstanceContext ins ON ins.BizObjectId=change.ObjectID AND ins.State='4' AND change.AgreeMent_number = a.AgreeMent_number order by change.CreatedTime DESC ) <= '"+BGSignDate2+"'";
        }
        sqls += " order by a.AgreeMent_number desc";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        var TheNo = 1;
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("TheNo",TheNo.ToString());
                dic.Add("AgreeMent_name",dr["AgreeMent_name"].ToString());
                dic.Add("AgreeMent_number",dr["AgreeMent_number"].ToString());
                dic.Add("Agreement_client",dr["Agreement_client"].ToString());
                //dic.Add("Agreement_client",OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["Agreement_client"].ToString()));
                dic.Add("Rate_type",dr["EnumValue"].ToString());
                dic.Add("agency_rate",dr["agency_rate"].ToString());
                if (dr["siDate"].ToString() == "1753/01/01")
                {
                    dic.Add("siDate", "");
                }
                else {

                    dic.Add("siDate",dr["siDate"].ToString());
                }
                dic.Add("Project_head",dr["Project_head"].ToString());
                dic.Add("con_state",dr["con_state"].ToString());
                dic.Add("BGSignDate",dr["BGSignDate"].ToString());
                dic.Add("ObjectID",dr["ObjectID"].ToString());
                ls.Add(dic);
                TheNo++;
            }
        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    //生成协议号
    public void AgreementNo (HttpContext context) {
        Dictionary<string,string> dic = new Dictionary<string,string>();
        string year = DateTime.Now.Year.ToString().Substring(2, 2);
        String numberid = "SELECT MAX(Numberid) as num FROM I_AgreeMent_main";
        string AgreementNo = "";
        string Number = "009";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
       numberid);
        if (dt.Rows.Count > 0)
        {
            Number = dt.Rows[0]["num"].ToString();
            //Number=
        }
        else
        {
            Number = "001";
        }

        AgreementNo = "SPIAIE-XY" + year + "-" + Number;
        dic.Add("AgreementNo", AgreementNo);
        dic.Add("Nmber", Number);

        object JSONObj = JsonConvert.SerializeObject(dic);
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