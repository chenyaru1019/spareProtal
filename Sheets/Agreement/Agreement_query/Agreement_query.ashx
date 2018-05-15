<%@ WebHandler Language="C#" Class="AgreeMent_main" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;


public class AgreeMent_main : IHttpHandler {
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
        string agreement_num = context.Request["agreement_num"];
        string Agreement_name= context.Request["Agreement_name"];
        string entrust= context.Request["entrust"];
        String sqls = "SELECT a.AgreeMent_name AS 协议名称,a.AgreeMent_number AS 协议编号,(" +
        "SELECT Name FROM   OT_User u WHERE u.ObjectID = a.Agreement_client) AS 委托方,a.Rate_type AS 收费类型,a.agency_rate AS 费率金额," +
        "a.ModifiedTime AS 签约时间,( ( SELECT Name FROM OT_User u WHERE u.ObjectID = a.Project_head_A ) + '," +
        "' + (  SELECT Name FROM OT_User u WHERE  u.ObjectID = a.Project_head_B)) AS 项目负责人 FROM I_AgreeMent_mains a " +
        "LEFT JOIN OT_User u on u.ObjectID = a.Agreement_client where 1=1";
        //委托方
        if (entrust != "") {
            sqls+= " and u.Name = '" + entrust + "'";
        }
        //协议号
        if (agreement_num != "") {
            sqls+= " and a.AgreeMent_number = '" + agreement_num + "'";
        }
        if (Agreement_name != "") {
            sqls+= " and a.AgreeMent_name  like '%" + Agreement_name + "%'";
        }

        //if (agreement != "") {
        //    switch (agreement) {
        //        case "w1":sqls += "我的协议";break;
        //        case "w2":sqls += "代职协议";break;
        //        case "w3":sqls += "全部";break;
        //    }
        //}
        //if (my_role != "") {
        //     sqls+= " 当前登录人的名字和我传入参数的匹配";
        //}
        //获取协议执行的版本号
        int versionAgreen_performNo = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Agreen_perform");
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        if (dt.Rows.Count > 0) {
                
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("agreement_name",dr["协议名称"].ToString());
                dic.Add("agreement_num",dr["协议编号"].ToString());
                dic.Add("Agreement_client",dr["委托方"].ToString());
                dic.Add("Rate_type",dr["收费类型"].ToString());
                dic.Add("agency_rate",dr["费率金额"].ToString());
                dic.Add("ModifiedTime",dr["签约时间"].ToString());
                dic.Add("Project_head",dr["项目负责人"].ToString());
                dic.Add("versions", versionAgreen_performNo.ToString());
                ls.Add(dic);
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