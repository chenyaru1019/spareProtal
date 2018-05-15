<%@ WebHandler Language="C#" Class="InviteBidsHandler" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using System.Collections;
using Newtonsoft.Json;
using System.Runtime.Serialization;
using System.IO;
using System.Web.Helpers;

public class InviteBidsHandler : IHttpHandler {

    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();

    public bool IsReusable {
        get {
            return false;
        }
    }

    private IEngine _Engine = null;

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

    public void ProcessRequest(HttpContext context) {
        string command = context.Request["Command"];
        switch (command) {
            case "GenerateBiddingCode":
                GenerateBiddingCode(context);
                break;
            case "GetBiddingCodeAudits":
                GetBiddingCodeAudits(context);
                break;
            case "LoadMetaData":
                LoadMetaData(context);
                break;
            case "LoadExperts":
                LoadExperts(context);
                break;
            case "LoadAllExperts":
                LoadAllExperts(context);
                break;
            case "LoadProjects":
                LoadProjects(context);
                break;
            case "GetBiddingDocAudits":
                GetBiddingDocAudits(context);
                break;
            case "GetBiddingNoticeAudits":
                GetBiddingNoticeAudits(context);
                break;
            case "UploadFile":
                UploadFile(context);
                break;
            case "IsFileExists":
                IsFileExists(context);
                break;
            case "DownloadFile":
                DownloadFile(context);
                break;
            case "SaveBidPackages":
                SaveBidPackages(context);
                break;
            case "LoadTenderRecord":
                LoadTenderRecord(context);
                break;
            case "GetBiddingCode":
                GetBiddingCode(context);
                break;
            case "GetApprovedBiddingCode":
                GetApprovedBiddingCode(context);
                break;
            case "SaveExpertSelection":
                SaveExpertSelection(context);
                break;
            case "LoadBidPackages":
                LoadBidPackages(context);
                break;
            case "SaveTenderPrice":
                SaveTenderPrice(context);
                break;
            case "SaveAuditExpert":
                SaveAuditExpert(context);
                break;
            case "LoadTenderPrice":
                LoadTenderPrice(context);
                break;
            case "LoadTenders":
                LoadTenders(context);
                break;
            case "LoadTenders2":
                LoadTenders2(context);
                break;
            case "LoadAgencyAgreement":
                LoadAgencyAgreement(context);
                break;
            case "LoadAuditExpert":
                LoadAuditExpert(context);
                break;
            case "SaveRefundState":
                SaveRefundState(context);
                break;
            case "LoadRefundAudit":
                LoadRefundAudit(context);
                break;
            case "LoadFileAudit":
                LoadFileAudit(context);
                break;
            case "LoadWorkflowVersion":
                LoadWorkflowVersion(context);
                break;
            case "LoadFiles":
                LoadFiles(context);
                break;
            case "GetCustomerObjectId":
                GetCustomerObjectId(context);
                break;
            case "GetCustomerDetail":
                GetCustomerDetail(context);
                break;
        }
    }
    public string getMaxContNumOfPro(string prefix,string year)
    {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "select BiddingCode from I_InviteBids where BiddingCode like '"+prefix+"%-"+year+"%' ");

        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                try
                {
                    //String abc = dr["BiddingCode"].ToString().Substring(dr["BiddingCode"].ToString().Length - 3);
                    int curnum = (int)Convert.ToSingle(dr["BiddingCode"].ToString().Substring(dr["BiddingCode"].ToString().Length-3));

                    if (curnum > num)
                    {
                        num = curnum;
                    }

                }
                catch (Exception exp)
                {
                    continue;
                }

            }
            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }
    private void GenerateBiddingCode(HttpContext context) {
        string Scope = context.Request["scope"];
        string Method = context.Request["method"];
        string Code = "国内";
        int Year = DateTime.Now.Year % 100;
        string year = string.Format("{0:00}", Year);
        string prefix = "";

        //int SequenceNumber = 0;
        //System.Data.DataTable dt = Engine.Query.QueryTable("select SequenceNumber from I_BiddingNumber");
        //if (dt.Rows.Count == 1) {
        //    DataRow dr = dt.Rows[0];
        //    SequenceNumber = (int)dr["SequenceNumber"];
        //}
        if(Scope.Equals("国外") && Method.Equals("公开招标")) {
            prefix = "0681";
            int curContnum = (int)Convert.ToSingle(getMaxContNumOfPro(prefix,year)) + 1;
            Code = "0681-" + Year + "40ZBJ" + Year + string.Format("{0:000}", curContnum);
        }
        else {
            prefix = "SPIAIE-";
            int curContnum = (int)Convert.ToSingle(getMaxContNumOfPro(prefix,year)) + 1;
            Code = "SPIAIE-";
            if (Method.Equals("公开招标")) {
                Code += "ZB";
            }
            else if (Method.Equals("邀请招标")) {
                Code += "YQ";
            }
            else if (Method.Equals("竞争性谈判")) {
                Code += "JT";
            }
            else {
                Code += "XJ";
            }
            if (Scope.Equals("国外")) {
                Code += "J";
            }
            else {
                Code += "N";
            }

            Code += "-" + Year + string.Format("{0:000}", curContnum);
        }
        //Engine.Query.QueryTable("update I_BiddingNumber set SequenceNumber="
        //    + (SequenceNumber + 1));

        Dictionary<string, string> Result = new Dictionary<string, string>();
        Result.Add("code", Code);
        object jobj = JsonConvert.SerializeObject(Result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void GetBiddingCodeAudits(HttpContext context) {
        string objectId = context.Request["object_id"];
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select a.OriginatorName, left(convert(varchar, a.StartTime, 120), 10) as StartTime, "
            + "a.InitiativeTokenId, "
            + "a.State "
            + "from OT_InstanceContext a, I_BiddingNumberAuditFlow b "
            + "where a.BizObjectId=b.ObjectID "
            + "and b.IssueObjectID='" + objectId + "'"
        );
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, string> item = new Dictionary<string, string>();
            item.Add("originatorName", (string)dr["OriginatorName"]);
            item.Add("startTime", (string)dr["StartTime"]);
            int State = (int)dr["State"];
            string StateMessage = "通过";
            if (State == 2) {
                StateMessage = "审批";
            }
            item.Add("state", StateMessage);
            result.Add(item);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadBiddingNoticeAudits(HttpContext context) {
        // TODO
        // 招标公告审批记录
    }

    private void GetBiddingDocAudits(HttpContext context) {
        string objectId = context.Request["object_id"];
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select a.OriginatorName, left(convert(varchar, a.StartTime, 120), 10) as StartTime, "
            + "a.InitiativeTokenId, "
            + "a.State "
            + "from OT_InstanceContext a, I_BiddingDocAudit b "
            + "where a.BizObjectId=b.ObjectID "
            + "and b.IssueObjectID='" + objectId + "'"
        );
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, string> item = new Dictionary<string, string>();
            item.Add("originatorName", (string)dr["OriginatorName"]);
            item.Add("startTime", (string)dr["StartTime"]);
            int State = (int)dr["State"];
            string StateMessage = "通过";
            if (State == 2) {
                StateMessage = "审批";
            }
            item.Add("state", StateMessage);
            result.Add(item);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void GetBiddingNoticeAudits(HttpContext context) {
        string objectId = context.Request["object_id"];
        string packageName = "";
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select a.OriginatorName, left(convert(varchar, a.StartTime, 120), 10) as StartTime, "
            + "a.InitiativeTokenId, "
            + "a.State "
            + "from OT_InstanceContext a, I_BiddingNotice b "
            + "where a.BizObjectId=b.ObjectID "
            + "and b.IssueObjectID='" + objectId + "' "
            + "and b.PackageName='" + packageName + "'"
        );
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, string> item = new Dictionary<string, string>();
            item.Add("originatorName", (string)dr["OriginatorName"]);
            item.Add("startTime", (string)dr["StartTime"]);
            int State = (int)dr["State"];
            string StateMessage = "通过";
            if (State == 2) {
                StateMessage = "审批";
            }
            item.Add("state", StateMessage);
            result.Add(item);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadMetaData(HttpContext context) {
        string Category = context.Request["category"];
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select EnumValue as Name, Code as Value "
            + "from OT_EnumerableMetadata "
            + "where [Category]='" + Category + "'");
        ArrayList Result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, string> item = new Dictionary<string, string>();
            item.Add("name", (string)dr["Name"]);
            item.Add("value", (string)dr["Value"]);
            Result.Add(item);
        }

        object jobj = JsonConvert.SerializeObject(Result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadExperts(HttpContext context) {
        string area = context.Request["area"];
        string domain = context.Request["domain"];
        int count = Convert.ToInt32(context.Request["count"], 10);
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select ExpertsNames as name, District as area, unit as company, "
            + "ProfessionField as domain, DateOfBirth as birthday, "
            + "isnull(Phone,'') as mobilePhone, isnull(Email,'') as Email "
            + "from I_ExpertDatabaseManagement "
            + "where [District]='" + area
            + "' and [ProfessionField] like '%" + domain
            + "%'"
        );
        ArrayList result = new ArrayList();
        string time = System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, object> item = new Dictionary<string, object>();
            item.Add("time", time);
            item.Add("name", (string)dr["name"]);
            item.Add("area", (string)dr["area"]);
            item.Add("company", (string)dr["company"]);
            item.Add("domain", (string)dr["domain"]);
            item.Add("birthday", dr["birthday"]);
            item.Add("mobilePhone", (string)dr["mobilePhone"]);
            item.Add("email", (string)dr["Email"]);
            result.Add(item);
        }
        result = ReduceResult(result, count);

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private ArrayList ReduceResult(ArrayList input, int count) {
        if (input.Count <= count) {
            return input;
        }
        ArrayList result = new ArrayList();
        Random rand = new Random();
        for (int i = 0; i < count; i++) {
            int index = rand.Next(input.Count);
            object obj = input[index];
            result.Add(obj);
            input.Remove(obj);
        }
        return result;
    }

    private void LoadProjects(HttpContext context) {
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select ProjectName from I_ProjectTbl order by ProjectName"
        );
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, string> item = new Dictionary<string, string>();
            item.Add("name", (string)dr["ProjectName"]);
            result.Add(item);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void UploadFile(HttpContext context) {
        context.Response.Expires = -1;
        Dictionary<string, string> d = new Dictionary<string, string>();
        try {
            HttpPostedFile postedFile = context.Request.Files["file"];
            string uploadPath = context.Server.MapPath("~/uploads");
            if (!Directory.Exists(uploadPath))
                Directory.CreateDirectory(uploadPath);
            postedFile.SaveAs(uploadPath + @"\" + postedFile.FileName);
            d.Add("success", "true");
            d.Add("filename", postedFile.FileName);
        }
        catch(Exception e) {
            d.Add("success", "false");
            d.Add("message", e.Message);
        }
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void IsFileExists(HttpContext context) {
        string filename = context.Request["file"];
        Dictionary<string, string> d = new Dictionary<string, string>();
        string filepath = context.Server.MapPath("~/uploads/") + filename;
        if (File.Exists(filepath))
            d.Add("found", "true");
        else
            d.Add("found", "false");
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void DownloadFile(HttpContext context) {
        string file = context.Request["file"];
        string filename = context.Server.MapPath("~/uploads/" + file);
        FileInfo fileInfo = new FileInfo(filename);

        try {
            if (fileInfo.Exists) {
                context.Response.Clear();
                context.Response.AddHeader("Content-Disposition", "attachment;filename=\"" + fileInfo.Name + "\"");
                context.Response.AddHeader("Content-Length", fileInfo.Length.ToString());
                context.Response.ContentType = "application/octet-stream";
                context.Response.TransmitFile(fileInfo.FullName);
                context.Response.Flush();
            }
            else {
                throw new Exception("File not found");
            }
        }
        catch (Exception ex) {
            context.Response.ContentType = "text/plain";
            context.Response.Write(ex.Message);
        }
        finally {
            context.Response.End();
        }
    }

    private void SaveBidPackages(HttpContext context) {
        string jvalue = context.Request["jvalue"];
        string ParentObjectId = context.Request["parent_object_id"];
        Engine.Query.QueryTable(
            "delete from I_BiddingTender where ParentObjectID='"
            + ParentObjectId + "'"
        );
        Engine.Query.QueryTable(
            "delete from I_Tenders where GranfatherObjectId='"
            + ParentObjectId + "'"
        );
        dynamic bidPackages = Json.Decode(jvalue);
        ArrayList result = new ArrayList();
        foreach(dynamic bp in bidPackages) {
            var packageName = bp.name;
            foreach(dynamic rec in bp.tenders) {
                string ObjectId = Guid.NewGuid().ToString();
                string sql = "insert into I_BiddingTender(ObjectID, ParentObjectID, "
                    + "PackageName, Address, Telephone, Fax, Contact, MobilePhone, Email, "
                    + "TenderPrice1, TenderPrice2, TenderPrice1Unit, TenderPrice2Unit, "
                    + "Supplier, SupplierCountry, Remark, PurchaseBiddingDocForm, "
                    + "TenderDoc, Receipts) values('"
                    + ObjectId
                    + "', '"
                    + ParentObjectId
                    + "', '"
                    + packageName
                    + "', '"
                    + rec.address
                    + "', '"
                    + rec.telephone
                    + "', '"
                    + rec.fax
                    + "', '"
                    + rec.contact
                    + "', '"
                    + rec.mobilePhone
                    + "', '"
                    + rec.email
                    + "', "
                    + rec.bidPrice1
                    + ", "
                    + rec.bidPrice2
                    + ", '"
                    + rec.bidPrice1Unit
                    + "', '"
                    + rec.bidPrice2Unit
                    + "', '"
                    + rec.supplier
                    + "', '"
                    + rec.supplierCountry
                    + "', '"
                    + rec.remark
                    + "', '"
                    + rec.biddingDocPurchaseRecord
                    + "', '"
                    + rec.tenderDoc
                    + "', '"
                    + rec.receipts
                    + "')";
                result.Add(sql);
                Engine.Query.QueryTable(sql);
                foreach (dynamic tender in rec.tenders) {
                    sql = "insert into I_Tenders(ObjectId, ParentObjectID, TenderName, "
                        + "TenderCountry, CashType, CashDeposit, CashDepositUnit, GranfatherObjectId) "
                        + "values('"
                        + Guid.NewGuid().ToString()
                        + "', '"
                        + ObjectId
                        + "', '"
                        + tender.name
                        + "', '"
                        + tender.country
                        + "', '"
                        + tender.cashType
                        + "', "
                        + tender.cash
                        + ", '"
                        + tender.cashUnit
                        + "', '"
                        + ParentObjectId
                        + "')";
                    result.Add(sql);
                    Engine.Query.QueryTable(sql);
                }
            }
        }

        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("success", "true");
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadBidPackages(HttpContext context) {
        string ObjectId = context.Request["object_id"];
        string sql = "select * from I_BidOpening where ParentObjectID='"
            + ObjectId + "' order by PackageName";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, object> bp = new Dictionary<string, object>();
            bp.Add("issueDate", ((DateTime)dr["IssueDate"]).ToString("yyyy-MM-dd"));
            bp.Add("openingDate", ((DateTime)dr["OpeningDate"]).ToString("yyyy-MM-dd"));
            bp.Add("timeAndPlace", (string)dr["TimeAndPlace"]);
            bp.Add("finalBiddingDoc", (string)dr["FinalBiddingDoc"]);
            bp.Add("biddingNotice", (string)dr["BiddingNotice"]);
            bp.Add("biddingFaq", (string)dr["BiddingFaq"]);
            bp.Add("overviewSheet", (string)dr["OverviewSheet"]);
            bp.Add("name", (string)dr["PackageName"]);

            sql = "select * from I_BiddingTender where ParentObjectID='"
                + ObjectId + "' and PackageName='"
                + (string)dr["PackageName"] + "'";
            System.Data.DataTable dt2 = Engine.Query.QueryTable(sql);
            ArrayList records = new ArrayList();
            foreach (DataRow dr2 in dt2.Rows) {
                Dictionary<string, object> rec = new Dictionary<string, object>();
                rec.Add("address", (string)dr2["Address"]);
                rec.Add("telephone", (string)dr2["Telephone"]);
                rec.Add("fax", (string)dr2["Fax"]);
                rec.Add("contact", (string)dr2["Contact"]);
                rec.Add("mobilePhone", (string)dr2["MobilePhone"]);
                rec.Add("email", (string)dr2["Email"]);
                rec.Add("bidPrice1", (int)dr2["TenderPrice1"]);
                rec.Add("bidPrice2", (int)dr2["TenderPrice2"]);
                rec.Add("bidPrice1Unit", (string)dr2["TenderPrice1Unit"]);
                rec.Add("bidPrice2Unit", (string)dr2["TenderPrice2Unit"]);
                rec.Add("supplier", (string)dr2["Supplier"]);
                rec.Add("supplierCountry", (string)dr2["SupplierCountry"]);
                rec.Add("remark", (string)dr2["Remark"]);
                rec.Add("biddingDocPurchaseRecord", dr2["PurchaseBiddingDocForm"]);
                rec.Add("tenderDoc", dr2["tenderDoc"]);
                rec.Add("receipts", dr2["receipts"]);

                sql = "select * from I_Tenders where ParentObjectID='"
                    + (string)dr2["ObjectID"] + "'";
                System.Data.DataTable dt3 = Engine.Query.QueryTable(sql);
                ArrayList tenders = new ArrayList();
                foreach (DataRow dr3 in dt3.Rows) {
                    Dictionary<string, object> tender = new Dictionary<string, object>();
                    tender.Add("name", (string)dr3["TenderName"]);
                    tender.Add("country", (string)dr3["TenderCountry"]);
                    tender.Add("cashType", (string)dr3["CashType"]);
                    tender.Add("cash", (int)dr3["CashDeposit"]);
                    tender.Add("cashUnit", (string)dr3["CashDepositUnit"]);
                    tenders.Add(tender);
                }
                rec.Add("tenders", tenders);
                records.Add(rec);
            }
            bp.Add("tenders", records);
            result.Add(bp);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadTenderRecord(HttpContext context) {
        string ObjectId = context.Request["object_id"];
        string PackageName = context.Request["package_name"];
        string sql = "select * from I_BiddingTender where ParentObjectID='"
            + ObjectId + "' and PackageName='"
            + PackageName + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList records = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, object> rec = new Dictionary<string, object>();
            rec.Add("address", (string)dr["Address"]);
            rec.Add("telephone", (string)dr["Telephone"]);
            rec.Add("fax", (string)dr["Fax"]);
            rec.Add("contact", (string)dr["Contact"]);
            rec.Add("mobilePhone", (string)dr["MobilePhone"]);
            rec.Add("email", (string)dr["Email"]);
            rec.Add("bidPrice1", (int)dr["TenderPrice1"]);
            rec.Add("bidPrice2", (int)dr["TenderPrice2"]);
            rec.Add("bidPrice1Unit", (string)dr["TenderPrice1Unit"]);
            rec.Add("bidPrice2Unit", (string)dr["TenderPrice2Unit"]);
            rec.Add("supplier", (string)dr["Supplier"]);
            rec.Add("supplierCountry", (string)dr["SupplierCountry"]);
            rec.Add("remark", (string)dr["Remark"]);
            rec.Add("biddingDocPurchaseRecord", dr["PurchaseBiddingDocForm"]);
            rec.Add("tenderDoc", dr["tenderDoc"]);
            rec.Add("receipts", dr["receipts"]);

            sql = "select * from I_Tenders where ParentObjectID='"
                + (string)dr["ObjectID"] + "'";
            System.Data.DataTable dt2 = Engine.Query.QueryTable(sql);
            ArrayList tenders = new ArrayList();
            foreach (DataRow dr2 in dt2.Rows) {
                Dictionary<string, object> tender = new Dictionary<string, object>();
                tender.Add("name", (string)dr2["TenderName"]);
                tender.Add("country", (string)dr2["TenderCountry"]);
                tender.Add("cashType", (string)dr2["CashType"]);
                tender.Add("cash", (int)dr2["CashDeposit"]);
                tender.Add("cashUnit", (string)dr2["CashDepositUnit"]);
                tenders.Add(tender);
            }
            rec.Add("tenders", tenders);
            records.Add(rec);
        }

        object jobj = JsonConvert.SerializeObject(records);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }


    private ArrayList LoadBiddingTenders(string ParentObjectId) {
        string sql = "select * from I_BiddingTender where ParentObjectID='"
            + ParentObjectId + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, object> item = new Dictionary<string, object>();
            item.Add("objectId", (string)dr["ObjectID"]);
            item.Add("tenders", LoadTenders((string)dr["ObjectID"]));
            item.Add("address", (string)dr["Address"]);
            item.Add("telephone", (string)dr["Telephone"]);
            item.Add("mobilePhone", (string)dr["MibilePhone"]);
            item.Add("fax", (string)dr["Fax"]);
            item.Add("contract", (string)dr["Contract"]);
            item.Add("email", (string)dr["Email"]);
            item.Add("tenderPrice1", (int)dr["TenderPrice1"]);
            item.Add("tenderPrice1Unit", (string)dr["TenderPrice1Unit"]);
            item.Add("tenderPrice2", (int)dr["TenderPrice2"]);
            item.Add("tenderPrice2Unit", (string)dr["TenderPrice2Unit"]);
            item.Add("supplier", (string)dr["Supplier"]);
            item.Add("supplierCountry", (string)dr["SupplierCountry"]);
            item.Add("remark", (string)dr["Remark"]);
            item.Add("BidResult", (string)dr["BidResult"]);
            result.Add(item);
        }
        return result;
    }

    private ArrayList LoadTenders(string ParentObjectId) {
        string sql = "select * from I_Tenders where ParentObjectID='"
            + ParentObjectId + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, string> item = new Dictionary<string, string>();
            item.Add("name", (string)dr["TenderName"]);
            item.Add("country", (string)dr["TenderCountry"]);
            item.Add("cash", (string)dr["CashDeposit"]);
            item.Add("cashType", (string)dr["CashType"]);
            item.Add("cashUnit", (string)dr["CashDepositUnit"]);
            result.Add(item);
        }
        return result;
    }


    private void GetBiddingCode(HttpContext context) {
        string ObjectId = context.Request["object_id"];
        string BiddingCode = "";
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select * from I_InviteBids where ObjectID='"
            + ObjectId + "'");
        foreach (DataRow dr in dt.Rows) {
            BiddingCode = (string)dr["BiddingCode"];
        }
        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("code", BiddingCode);

        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void GetApprovedBiddingCode(HttpContext context) {
        string ObjectId = context.Request["object_id"];
        string BiddingCode = "";
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select * from I_BiddingNumberAuditFlow where IssueObjectID='"
            + ObjectId + "'");
        foreach (DataRow dr in dt.Rows) {
            BiddingCode = (string)dr["BiddingNumber"];
        }
        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("code", BiddingCode);

        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void SaveExpertSelection(HttpContext context) {
        string ObjectId = context.Request["object_id"];
        string ActivityCode = context.Request["activity_code"];
        string Selection = context.Request["selection"];
        string sql = "insert into I_RandomExpertSelection(ObjectId, "
            + "CreatedTime, IssueObjectId, ActivityCode, Selection) values('"
            + Guid.NewGuid().ToString()
            + "', "
            + "SYSDATETIME(), '"
            + ObjectId
            + "', '"
            + ActivityCode
            + "', '"
            + Selection
            + "')";
        Engine.Query.QueryTable(sql);
    }

    private void SaveTenderPrice(HttpContext context) {
        string ObjectId = context.Request["object_id"];
        string PackageName = context.Request["package_name"];
        string data = context.Request["data"];
        var sql = "delete from I_TenderPrice where "
            + "ParentObjectId='" + ObjectId
            + "' and PackageName='" + PackageName
            + "'";
        Engine.Query.QueryTable(sql);
        dynamic tps = Json.Decode(data);
        for (var i = 0; i < tps.Length; i++) {
            var tp = tps[i];
            sql = "insert into I_TenderPrice(ObjectID, ParentObjectId, i, j, TenderPrice1, TenderPrice1Unit, TenderPrice1ExchangeRate, RelatedAgreement, AgreementCode, AgencyFeeType, AgreementIndex, IsBiddingAgency, PackageName) values('"
                + Guid.NewGuid() + "', '"
                + ObjectId + "', "
                + tp.i + ", "
                + tp.j + ", "
                + tp.price + ", '"
                + tp.priceUnit + "', "
                + tp.exchangeRate + ", '"
                + tp.associatedAgreement + "', '"
                + tp.agreementCode + "', '"
                + tp.agreementType + "', "
                + tp.agreementIndex + ", "
                + (tp.hasAssociatedAgreement ? 1 : 0) + ", '"
                + PackageName + "')";
            Engine.Query.QueryTable(sql);
        }

        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("success", "true");
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void SaveAuditExpert(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        string PackageName = context.Request["PackageName"];
        string Data = context.Request["Data"];
        var sql = "delete from I_BiddingTenderAuditExperts where ParentObjectID='"
            + ParentObjectId + "' and PackageName='"
            + PackageName + "'";
        Engine.Query.QueryTable(sql);
        dynamic e = Json.Decode(Data);
        for (var i = 0; i < e.Length; i++) {
            sql = "insert into I_BiddingTenderAuditExperts(ParentObjectID, PackageName, "
                + "Company, ExpertName, MobilePhone, ObjectID) values('"
                + ParentObjectId
                + "', '"
                + PackageName
                + "', '"
                + e[i].company
                + "', '"
                + e[i].name
                + "', '"
                + e[i].mobilePhone
                + "', '"
                + Guid.NewGuid()
                + "')";
            Engine.Query.QueryTable(sql);
        }

        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("success", "true");
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadAuditExpert(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        string PackageName = context.Request["PackageName"];
        string sql = "select * from I_BiddingTenderAuditExperts where ParentObjectID='"
            + ParentObjectId + "' and PackageName='" + PackageName + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("name", dr["ExpertName"]);
            d.Add("company", dr["Company"]);
            d.Add("mobilePhone", dr["MobilePhone"]);
            result.Add(d);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadTenderPrice(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        string PackageName = context.Request["PackageName"];
        string sql = "select * from I_TenderPrice where ParentObjectID='"
            + ParentObjectId + "' and PackageName='"
            + PackageName + "' order by i, j";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            Dictionary<string, object> item = new Dictionary<string, object>();
            item.Add("i", (dr["i"] == DBNull.Value ? 0 : (int)dr["i"]));
            item.Add("j", (dr["j"] == DBNull.Value ? 0 : (int)dr["j"]));
            item.Add("price", (int)dr["TenderPrice1"]);
            item.Add("priceUnit", (string)dr["TenderPrice1Unit"]);
            item.Add("exchangeRate", dr["TenderPrice1ExchangeRate"]);
            int IsBiddingAgency = 0;
            if (dr["IsBiddingAgency"] != DBNull.Value) {
                IsBiddingAgency = (int)dr["IsBiddingAgency"];
            }
            item.Add("hasAssociatedAgreement", IsBiddingAgency);
            item.Add("associatedAgreement", (string)dr["RelatedAgreement"]);
            item.Add("agreementCode", dr["AgreementCode"] == DBNull.Value ? "" : (string)dr["AgreementCode"]);
            item.Add("agreementType", dr["AgencyFeeType"] == DBNull.Value ? "" : (string)dr["AgencyFeeType"]);
            item.Add("agreementIndex", dr["AgreementIndex"] == DBNull.Value ? 0 : (int)dr["AgreementIndex"]);
            item.Add("packageName", (string)dr["PackageName"]);
            result.Add(item);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadTenders(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        string PackageName = context.Request["PackageName"];
        string sql = "select BidWinner from I_BiddingEvaluation where ParentObjectID='"
            + ParentObjectId + "' and PackageName='" + PackageName + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        HashSet<string> s = new HashSet<string>();
        foreach (DataRow dr in dt.Rows) {
            if (dr["BidWinner"] != DBNull.Value)
                s.Add((string)dr["BidWinner"]);
        }

        dt = Engine.Query.QueryTable("select a.Tender, a.CreatedTime from I_RefundCashDeposit a, OT_InstanceContext b "
            + "where a.ObjectID=b.BizObjectID "
            + "and b.State=4 "
            + "and a.IssueObjectId='"
            + ParentObjectId + "'");
        Hashtable s2 = new Hashtable();
        foreach (DataRow dr in dt.Rows) {
            s2.Add((string)dr["Tender"], ((DateTime)dr["CreatedTime"]).ToString("yyyy-MM-dd"));
        }

        sql = "select b.ObjectID, b.Address, b.Telephone, b.MobilePhone, b.Fax, b.Contact, b.Email, "
            + "b.TenderPrice1, b.TenderPrice1Unit, b.TenderPrice2, b.TenderPrice2Unit, "
            + "b.Supplier, b.SupplierCountry, b.Remark, b.PurchaseBiddingDocForm, b.TenderDoc, "
            + "b.Receipts, a.TenderName, a.TenderCountry, "
            + "a.CashDeposit, a.CashType, a.CashDepositUnit, b.NoticeOfBidding "
            + "from I_BiddingTender b, I_Tenders a where b.ObjectID=a.ParentObjectID "
            + "and b.ParentObjectID='" + ParentObjectId + "' "
            + "and b.PackageName='" + PackageName + "'";
        dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, object> item = new Dictionary<string, object>();
            item.Add("objectId", (string)dr["ObjectID"]);
            item.Add("packageName", PackageName);
            item.Add("address", (string)dr["Address"]);
            item.Add("telephone", (string)dr["Telephone"]);
            item.Add("mobilePhone", (string)dr["MobilePhone"]);
            item.Add("fax", (string)dr["Fax"]);
            item.Add("contact", (string)dr["Contact"]);
            item.Add("email", (string)dr["Email"]);
            item.Add("price1", (int)dr["TenderPrice1"]);
            item.Add("price1Unit", (string)dr["TenderPrice1Unit"]);
            item.Add("price2", (int)dr["TenderPrice2"]);
            item.Add("price2Unit", (string)dr["TenderPrice2Unit"]);
            item.Add("supplier", (string)dr["Supplier"]);
            item.Add("supplierCountry", (string)dr["SupplierCountry"]);
            item.Add("purchaseBiddingDocForm", (string)dr["PurchaseBiddingDocForm"]);
            item.Add("tenderDoc", (string)dr["TenderDoc"]);
            item.Add("receipts", (string)dr["Receipts"]);
            item.Add("remark", (string)dr["Remark"]);
            string name = (string)dr["TenderName"];
            item.Add("name", name);
            item.Add("country", (string)dr["TenderCountry"]);
            item.Add("cash", (int)dr["CashDeposit"]);
            item.Add("cashType", (string)dr["CashType"]);
            item.Add("cashUnit", (string)dr["CashDepositUnit"]);
            item.Add("noticeOfBidding", dr["NoticeOfBidding"]);
            item.Add("bidResult", s.Contains(name) ? "中标" : "落标");
            item.Add("refundState", s2[name] == null ? "未退" : "已退 " + s2[name]);
            result.Add(item);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadTenders2(HttpContext context) {
        string objectId = context.Request["objectId"];
        string packageName = context.Request["packageName"];
        string sql = "select b.TenderName from I_BiddingTender a, I_Tenders b where a.ObjectID=b.ParentObjectID and a.ParentObjectID='" + objectId + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, string> d = new Dictionary<string, string>();
            d.Add("value", (string)dr["TenderName"]);
            d.Add("name", (string)dr["TenderName"]);
            result.Add(d);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadAgencyAgreement(HttpContext context) {
        string sql = "select * from I_AgencyAgreements";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, string> d = new Dictionary<string, string>();
            d.Add("value", (string)dr["AgreementName"]);
            d.Add("name", (string)dr["AgreementName"]);
            result.Add(d);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void SaveRefundState(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        string PackageName = context.Request["PackageName"];
        string TenderDoc = context.Request["TenderDoc"];
        string NoticeOfBidding = context.Request["NoticeOfBidding"];
        string PurchaseRecord = context.Request["PurchaseRecord"];
        string Receipts = context.Request["Receipts"];
        var sql = "update I_BiddingTender set "
            + "NoticeOfBidding='" + NoticeOfBidding 
            + "', PurchaseBiddingDocForm='" + PurchaseRecord 
            + "', Receipts='" + Receipts 
            + "', TenderDoc='" + TenderDoc + "' "
            + "where ParentObjectID='"
            + ParentObjectId + "' and PackageName='" + PackageName + "'";
        Engine.Query.QueryTable(sql);

        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("success", "true");
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadRefundAudit(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        string TenderName = context.Request["TenderName"];
        string sql = "select a.Name, left(convert(varchar, b.CreatedTime, 120), 10) as time, "
            + "b.CashDepositType, b.CashDeposit, c.State "
            + "from OT_User a, I_RefundCashDeposit b, OT_InstanceContext c "
            + "where a.ObjectID=b.CreatedBy "
            + "and c.BizObjectID=b.ObjectID "
            + "and b.IssueObjectId='" + ParentObjectId
            + "' and b.Tender='" + TenderName
            + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("originator", dr["Name"]);
            d.Add("time", dr["time"]);
            d.Add("cashType", dr["CashDepositType"]);
            d.Add("cash", dr["CashDeposit"]);
            if ((int)dr["State"] == 2) {
                d.Add("state", "审批");
            }
            else {
                d.Add("state", "通过");
            }
            result.Add(d);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadFileAudit(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        string sql = "select a.Name, left(convert(varchar, b.CreatedTime, 120), 10) as time, "
            + "c.State "
            + "from OT_User a, I_FileBidding b, OT_InstanceContext c "
            + "where a.ObjectID=b.CreatedBy "
            + "and c.BizObjectID=b.ObjectID "
            + "and b.IssueObjectId='" + ParentObjectId
            + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("originator", dr["Name"]);
            d.Add("time", dr["time"]);
            if ((int)dr["State"] == 2) {
                d.Add("state", "审批");
            }
            else {
                d.Add("state", "通过");
            }
            result.Add(d);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadWorkflowVersion(HttpContext context) {
        System.Data.DataTable dt = Engine.Query.QueryTable("select WorkflowCode, DefaultVersion from OT_WorkflowClause");
        ArrayList result = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("code", (string)dr["WorkflowCode"]);
            d.Add("version", (int)dr["DefaultVersion"]);
            result.Add(d);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadFiles(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select OverviewSheet from I_BidOpening where ParentObjectID='"
                + ParentObjectId + "'"
        );
        ArrayList OverviewSheets = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            OverviewSheets.Add(dr["OverviewSheet"]);
        }
        dt = Engine.Query.QueryTable(
            "select FinalBiddingDoc, BiddingNotice from I_InviteBids where ObjectId='"
            + ParentObjectId + "'"
        );
        ArrayList BiddingNotices = new ArrayList();
        ArrayList BiddingDocs = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            BiddingDocs.Add(dr["FinalBiddingdoc"]);
            BiddingNotices.Add(dr["BiddingNotice"]);
        }
 
        dt = Engine.Query.QueryTable(
            "select TenderDoc from I_BiddingTender where ParentObjectID='"
                + ParentObjectId + "'"
        );
        ArrayList TenderDocs = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            TenderDocs.Add(dr["TenderDoc"]);
        }

        dt = Engine.Query.QueryTable(
            "select EvaluationReport, Clarification, OwnerComment from I_BiddingEvaluation where ParentObjectID='"
                + ParentObjectId + "'"
        );
        ArrayList EvaluationReports = new ArrayList();
        ArrayList Clarifications = new ArrayList();
        ArrayList OwnerComments = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            EvaluationReports.Add(dr["EvaluationReport"]);
            Clarifications.Add(dr["Clarification"]);
            OwnerComments.Add(dr["OwnerComment"]);
        }

        dt = Engine.Query.QueryTable(
            "select NoticeOfBidding from I_BiddingTender where ParentObjectID='"
                + ParentObjectId + "'"
        );
        ArrayList NoticeOfBiddings = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            NoticeOfBiddings.Add(dr["NoticeOfBidding"]);
        }

        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("biddingDocs", BiddingDocs);
        d.Add("overviewSheets", OverviewSheets);
        d.Add("biddingNotices", BiddingNotices);
        d.Add("tenderDocs", TenderDocs);
        d.Add("evaluationReports", EvaluationReports);
        d.Add("clarifications", Clarifications);
        d.Add("ownerComments", OwnerComments);
        d.Add("noticeOfBiddings", NoticeOfBiddings);

        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void GetCustomerObjectId(HttpContext context) {
        string name = context.Request["name"];
        var sql = "select ObjectID from I_CustomerList where CompanyName='"
            + name + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        string objectId = "";
        foreach(DataRow dr in dt.Rows) {
            objectId = (string)dr["ObjectID"];
        }

        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("objectId", objectId);
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void GetCustomerDetail(HttpContext context) {
        string parentObjectId = context.Request["parentObjectId"];
        string name = context.Request["name"];
        string sql = "select a.TenderName as CompanyName, b.Address, b.Telephone, b.Fax, b.Contact, b.MobilePhone, b.Email from I_Tenders a, I_BiddingTender b where a.ParentObjectID=b.ObjectID and b.ParentObjectId='" + parentObjectId + "' and a.TenderName='" + name + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        Dictionary<string, object> d = new Dictionary<string, object>();
        foreach(DataRow dr in dt.Rows) {
            d.Add("name", dr["CompanyName"]);
            d.Add("address", dr["Address"]);
            d.Add("telephone", dr["Telephone"]);
            d.Add("fax", dr["Fax"]);
            d.Add("contact", dr["Contact"]);
            d.Add("mobilePhone", dr["MobilePhone"]);
            d.Add("email", dr["Email"]);
        }

        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
     }

    private void LoadAllExperts(HttpContext context) {
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select ExpertsNames as name, District as area, unit as company, "
            + "ProfessionField as domain, DateOfBirth as birthday, "
            + "isnull(Phone,'') as mobilePhone, isnull(Email,'') as Email "
            + "from I_ExpertDatabaseManagement");
        ArrayList result = new ArrayList();
        string time = System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        foreach (DataRow dr in dt.Rows) {
            Dictionary<string, object> item = new Dictionary<string, object>();
            item.Add("time", time);
            item.Add("name", (string)dr["name"]);
            item.Add("area", (string)dr["area"]);
            item.Add("company", (string)dr["company"]);
            item.Add("domain", (string)dr["domain"]);
            item.Add("birthday", dr["birthday"]);
            item.Add("mobilePhone", (string)dr["mobilePhone"]);
            item.Add("email", (string)dr["Email"]);
            result.Add(item);
        }
       
        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }    

}
