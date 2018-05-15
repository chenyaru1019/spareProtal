<%@ WebHandler Language="C#" Class="BudgetingHandler" %>

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

public class BudgetingHandler : IHttpHandler {

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
            case "LoadYears": 
				LoadYears(context); 
				break;
            case "IsConfirmed":
                IsConfirmed(context);
                break;
            case "Save":
                Save(context);
                break;
            case "Load":
                Load(context);
                break;
            case "Confirm":
                Confirm(context);
                break;
            case "CancelConfirm":
                CancelConfirm(context);
                break;
            case "LoadBudget":
                LoadBudget(context);
                break;
            case "GetBudget":
                GetBudget(context);
                break;
            case "GenExecuteAdminBudgetId":
                GenExecuteAdminBudgetId(context);
                break;
            case "GenExecuteAdminBudgetTitle":
                GenExecuteAdminBudgetTitle(context);
                break;
            case "GenExecutingAmountofBudget":
                GenExecutingAmountofBudget(context);
                break;                
        }
    }

    private void LoadYears(HttpContext context) {
        var sql = "select distinct TheYear from I_Budgeting order by TheYear";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            result.Add((int)dr["TheYear"]);
        }
        int thisYear = DateTime.Now.Year;
        if (result.Count > 0) {
            if ((int)result[result.Count - 1] < thisYear) {
                result.Add(thisYear);
            }
        }
        else {
            result.Add(thisYear);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);        
    }

    private void IsConfirmed(HttpContext context) {
        String year = context.Request["year"];
        String sql = "select * from I_Budgeting where TheYear=" + year;
        bool confirmed = false;
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        foreach(DataRow dr in dt.Rows) {
            confirmed = (int)dr["IsConfirmed"] == 1;
        }

        Dictionary<string, bool> d = new Dictionary<string, bool>();
        d.Add("confirmed", confirmed);
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);        
    }

    private void Save(HttpContext context) {
        string year = context.Request["year"];
        string jdata = context.Request["data"];
        dynamic data = Json.Decode(jdata);
        string sql = "delete from I_Budgeting where TheYear=" + year;
        Engine.Query.QueryTable(sql);
        foreach(dynamic item in data) {
            sql = "insert into I_Budgeting(ObjectID, TheYear, ThePosition,"
                + "Category, IsChild, Budget, Spent, IsConfirmed) values('"
                + Guid.NewGuid()
                + "', " + year
                + ", " + item.position
                + ", '" + item.name
                + "', " + (item.isChild ? 1 : 0)
                + ", " + item.budget
                + ", " + item.spent
                + ", 0"
                + ")";
            Engine.Query.QueryTable(sql);
        }
        Dictionary<string, bool> d = new Dictionary<string, bool>();
        d.Add("success", true);
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);        
     }

     private void Load(HttpContext context) {
         string year = context.Request["year"];
         string sql = "select * from I_Budgeting where TheYear="
            + year
            + " order by ThePosition";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("position", dr["ThePosition"]);
            d.Add("year", dr["TheYear"]);
            d.Add("name", dr["Category"]);
            d.Add("budget", dr["Budget"]);
            d.Add("spent", dr["Spent"]);
            d.Add("isChild", (int)dr["IsChild"] == 1);
            result.Add(d);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);        
     }

     private void Confirm(HttpContext context) {
        string year = context.Request["year"];
        string sql = "update I_Budgeting set IsConfirmed=1 where TheYear="
            + year;
        Engine.Query.QueryTable(sql);
        Dictionary<string, bool> d = new Dictionary<string, bool>();
        d.Add("success", true);
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);        
    }

    private void CancelConfirm(HttpContext context) {
        string year = context.Request["year"];
        string sql = "update I_Budgeting set IsConfirmed=0 where TheYear="
            + year;
        Engine.Query.QueryTable(sql);
        Dictionary<string, bool> d = new Dictionary<string, bool>();
        d.Add("success", true);
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);        
    }

    private void LoadBudget(HttpContext context) {
        string year = context.Request["year"];
        string sql = "select * from I_Budgeting where TheYear="
            + year + " order by ThePosition";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        ArrayList result = new ArrayList();
        foreach(DataRow dr in dt.Rows) {
            Dictionary<string, object> d = new Dictionary<string, object>();
            d.Add("name", dr["Category"]);
            d.Add("isChild", dr["IsChild"]);
            result.Add(d);
        }

        object jobj = JsonConvert.SerializeObject(result);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);        
    }

    private void GetBudget(HttpContext context) {
        string year = context.Request["year"];
        string name = context.Request["name"];
        string sql = "select Budget from I_Budgeting where TheYear="
            + year
            + " and Category='" + name + "'";
        System.Data.DataTable dt = Engine.Query.QueryTable(sql);
        object budget = null;
        foreach(DataRow dr in dt.Rows) {
            budget = dr["Budget"];
        }

        Dictionary<string, object> d = new Dictionary<string, object>();
        d.Add("budget", budget);
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);        
    }

    public string getMaxContNumOfBudget(string year) {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "select count(ObjectID) as maxrows from I_ExecuteAdminBudget where TheYear=" + year);
        DataRow dr = dt.Rows[0];
        int maxrow = (int)dr["maxrows"];
        num = maxrow + 1;    

        return num.ToString().PadLeft(3,'0');
    }

    private void GenExecuteAdminBudgetId(HttpContext context) {
        //string year = context.Request["year"];
        string ExecuteAdminBudgetId = "YSZX" + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + getMaxContNumOfBudget(DateTime.Now.Year.ToString());
        

        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("code", ExecuteAdminBudgetId);
        d.Add("year", DateTime.Now.Year.ToString());
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    private void GenExecuteAdminBudgetTitle(HttpContext context) {
        string user = context.Request["user"];
        string subject = context.Request["subject"];
        string title = user + "[" + DateTime.Now.ToString("yyyy-MM-dd") + "](" + subject + ")";
        

        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("title", title);
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }

    public string getExecutingAmountOfBudget(string year, string subject) {
        string num = "0";
        string sql = "";
        sql = "select isnull(sum(a.CurrentExecutingAmount),0) as amount " +
            "from I_ExecuteAdminBudgetDetail a left join I_ExecuteAdminBudget b on a.ParentObjectID=b.ObjectID " + 
            "left join OT_InstanceContext c on b.ObjectID=c.BizObjectId " +
            "where c.State=4 and a.Subject='" + subject + "' and b.TheYear=" + year;
        
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
            
        DataRow dr = dt.Rows[0];
        num = Convert.ToString(dr[0]);
        //num = dt.Columns.Count;
        return num;
    }

    private void GenExecutingAmountofBudget(HttpContext context) {
        string executing;
        string theyear = context.Request["theyear"];
        string subject = context.Request["subject"];
        if (theyear == "") {
            theyear = DateTime.Now.Year.ToString();
        }

        executing = getExecutingAmountOfBudget(theyear, subject);

        Dictionary<string, string> d = new Dictionary<string, string>();
        d.Add("executing", executing);
        object jobj = JsonConvert.SerializeObject(d);
        context.Response.ContentType = "application/json";
        context.Response.Write(jobj);
    }
}