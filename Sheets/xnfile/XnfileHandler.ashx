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
            case "UploadFile":
                UploadFile(context);
                break;
            case "IsFileExists":
                IsFileExists(context);
                break;
            case "DownloadFile":
                DownloadFile(context);
                break;
            case "LoadFiles":
                LoadFiles(context);
                break;
            case "GetBigFileList":
                GetBigFileList(context);
                break;
        }
    }

    private void UploadFile(HttpContext context) {
        context.Response.Expires = -1;
        Dictionary<string, string> d = new Dictionary<string, string>();
        try {
            HttpFileCollection Files = System.Web.HttpContext.Current.Request.Files;
            for (int i = 0; i < Files.Count; i++) {
                HttpPostedFile postedFile = Files[i];
                string basePath = context.Request["base-path"];
                string uploadPath = context.Server.MapPath("~/uploads");
                uploadPath = uploadPath + "\\" + basePath;
                if (!Directory.Exists(uploadPath))
                    Directory.CreateDirectory(uploadPath);
                postedFile.SaveAs(uploadPath + @"\" + postedFile.FileName);
            }
            d.Add("success", "true");
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
		string basePath = context.Request["basePath"];
        Dictionary<string, string> d = new Dictionary<string, string>();
        string filepath = context.Server.MapPath("~/uploads/") + basePath + "\\" + filename;
        if (File.Exists(filepath)) {
            d.Add("found", "true");
            d.Add("filename", filename);
        }
        else {
            d.Add("found", "false");
        }
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void DownloadFile(HttpContext context) {
        string file = context.Request["file"];
        string filename = "";
        bool isbigfile = false;
        if (file.Contains(".bigfile")) {
            isbigfile = true;
            int index = file.LastIndexOf(".bigfile");
            file = file.Remove(index);
        }
        if (isbigfile) {
            filename = context.Server.MapPath("~/bigfiles/" + file);
        }
        else {
            filename = context.Server.MapPath("~/uploads/" + file);
        }
        
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

    private void GetBigFileList(HttpContext context) {
        ArrayList result = new ArrayList();

        //大文件文件夹
        string path = context.Server.MapPath("~/bigfiles/");

        //初始化目录
        DirectoryInfo dir = new DirectoryInfo(path);

        //获取文件
        FileInfo[] bigFiles = dir.GetFiles();

        foreach (FileInfo fi in bigFiles)
        {
            Dictionary<string, string> item = new Dictionary<string, string>();
            string fn = System.IO.Path.GetFileName(fi.FullName);
            string url = System.IO.Path.GetFileName(fi.FullName);
            string size = "" + System.Math.Ceiling(fi.Length / (1024.0*1024.0)) + "MB";
            
            item.Add("fn", fn);
            item.Add("url", url);
            item.Add("size", size);           
            result.Add(item);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void LoadFiles(HttpContext context) {
        string ParentObjectId = context.Request["ParentObjectId"];
        System.Data.DataTable dt = Engine.Query.QueryTable(
            "select FinalBiddingDoc, OverviewSheet, BiddingNotice from I_BidOpening where ParentObjectID='"
                + ParentObjectId + "'"
        );
        ArrayList BiddingDocs = new ArrayList();
        ArrayList OverviewSheets = new ArrayList();
        ArrayList BiddingNotices = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            BiddingDocs.Add(dr["FinalBiddingdoc"]);
            OverviewSheets.Add(dr["OverviewSheet"]);
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
            "select NoticeOfBidding from I_Tenders where ParentObjectID='"
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

}
