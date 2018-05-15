<%@ WebHandler Language="C#" Class="Contract_query" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;


public class Contract_query : IHttpHandler {
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
    //获取合同列表
    public void getagreementList(HttpContext context) {
        string ContractNO = context.Request["ContractNO"];//合同号
        string Contract_anme = context.Request["Contract_anme"];//合同名称
        string q_StartTime = context.Request["q_StartTime"];//签约日期开始
        string q_OverTime = context.Request["q_OverTime"];//签约日期结束
        string Project_peo = context.Request["Project_peo"];//项目负责人
        string trade_way = context.Request["trade_way"];//贸易方式
        string c_StartTime = context.Request["c_StartTime"];//合同创建日期开始
        string c_OverTime = context.Request["c_OverTime"];//合同创建日期结束
        string End_user = context.Request["End_user"];//最终用户
        string contract_nature = context.Request["contract_nature"];//合同性质
        string b_StartTime = context.Request["b_StartTime"];//合同变更日期开始
        string b_OverTime = context.Request["b_OverTime"];//合同变更日期结束
        string Contract_seller = context.Request["Contract_seller"];//合同卖方
        string Contract_type = context.Request["Contract_type"];//合同类型
        String sqls = "SELECT ContractNo,ContractName,CreatedTime,ContractType,ContractProperty,PostA,PostB,FinalUser,Salers," +
            "ContractTotalPrice,SignDate,ModifiedTime,TradeMethod," +
            "(SELECT wi.DisplayName FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = t.ObjectID " +
            "AND ic.state = '2'  UNION SELECT  wi.DisplayName FROM OT_InstanceContext ic" +
            " INNER JOIN OT_WorkItemFinished wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = t.ObjectID AND ic.state = '4' ) as con_state FROM  I_ContractMain t where 1=1";
        //合同号
        if (ContractNO != "")
        {
            sqls += " and ContractNO linke '%" + ContractNO + "%'";
        }
        //合同名称
        if (Contract_anme != "")
        {
            sqls += " and Contract_anme  like '%" + Contract_anme + "%'";
        }
        //合同签约时间-开始
        if (q_StartTime != "" && q_OverTime=="")
        {
            sqls += " and SignDate  > '" + q_StartTime + "'";
        }
        //合同签约时间-结束
        if (q_StartTime == "" &&  q_OverTime!="")
        {
            sqls += " and SignDate  < '" + q_OverTime + "'";
        }
        //合同签约开始和结束时间
        if (q_StartTime != "" &&  q_OverTime!="")
        {
            sqls += " and SignDate  > '" + q_OverTime + "' and SignDate  < '" + q_OverTime + "'";
        }
        //项目负责人
        if (Project_peo != "")
        {
            sqls += " and  PostA = '" + Project_peo + "' or  PostB = '" + Project_peo + "'";
        }
        //贸易方式
        if (trade_way != "") {
            sqls += " and TradeMethod  = '" + trade_way + "'";
        }
        //合同创建时间-开始
        if (c_StartTime != "" && c_OverTime=="")
        {
            sqls += " and CreatedTime  > '" + q_StartTime + "'";
        }
        //合同创建时间-结束
        if (c_StartTime == "" &&  c_OverTime!="")
        {
            sqls += " and CreatedTime  < '" + c_StartTime + "'";
        }
        //合同创建开始和结束时间
        if (c_StartTime != "" &&  c_OverTime!="")
        {
            sqls += " and CreatedTime  > '" + q_OverTime + "' and CreatedTime  < '" + q_OverTime + "'";
        }
        //最终用户
         if (End_user != "") {
            sqls += " and FinalUser  = '" + End_user + "'";
        }
        //合同性质
         if (contract_nature != "") {
            sqls += " and ContractProperty  = '" + contract_nature + "'";
        }
         //合同变更时间-开始
        if (b_StartTime != "" && b_OverTime=="")
        {
            sqls += " and ModifiedTime  > '" + b_StartTime + "'";
        }
        //合同变更时间-结束
        if (b_StartTime == "" &&  b_OverTime!="")
        {
            sqls += " and ModifiedTime  < '" + b_OverTime + "'";
        }
        //合同变更开始和结束时间
        if (b_StartTime != "" &&  b_OverTime!="")
        {
            sqls += " and ModifiedTime  > '" + b_OverTime + "' and ModifiedTime  < '" + b_OverTime + "'";
        }
        //合同卖方
         if (Contract_seller != "") {
            sqls += " and Salers  = '" + Contract_seller + "'";
        }
         //合同类型
         if (Contract_type != "") {
            sqls += " and ContractType  = '" + Contract_type + "'";
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
                Dictionary<string, string> dic = new Dictionary<string, string>();

                dic.Add("ContractNO", dr["ContractNO"].ToString());
                dic.Add("ContractName", dr["ContractName"].ToString());
                dic.Add("CreatedTime", dr["CreatedTime"].ToString());
                dic.Add("ContractType", dr["ContractType"].ToString());
                dic.Add("ContractProperty", dr["ContractProperty"].ToString());
                //dic.Add("Projecthead", dr["ContractName"].ToString());
                dic.Add("Projecthead", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["PostA"].ToString()) + '/' + OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["PostB"].ToString()));
                dic.Add("FinalUser", dr["FinalUser"].ToString());
                dic.Add("Salers", dr["Salers"].ToString());
                dic.Add("ContractTotalPrice", dr["ContractTotalPrice"].ToString());
                dic.Add("SignDate", dr["SignDate"].ToString());
                dic.Add("ModifiedTime", dr["ModifiedTime"].ToString());
                dic.Add("contract_state", dr["con_state"].ToString());
                dic.Add("aa", dr["con_state"].ToString());
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