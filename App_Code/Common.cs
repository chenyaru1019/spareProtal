using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OThinker.H3.Portal.Entity;
using System.Data;
using System.Globalization;
using System.Net;
using System.Text;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI;
using Microsoft.Win32;

/// <summary>
/// Class1 的摘要说明
/// </summary>
namespace OThinker.H3.Portal.service
{
    public class Common
    {
        public static OThinker.Organization.User getUserById(string id)
        {
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT * " +
            " FROM OT_User " +
            " where ObjectID = '" + id + "'");
            OThinker.Organization.User u = new OThinker.Organization.User();
            if (dt.Rows.Count > 0)
            {
                u.Code = dt.Rows[0]["Code"].ToString();
                u.Name = dt.Rows[0]["Name"].ToString();
            }
            return u;
        }

        public static OThinker.Organization.User getUserByName(string name)
        {
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT * " +
            " FROM OT_User " +
            " where Name = '" + name + "'");
            OThinker.Organization.User u = new OThinker.Organization.User();
            if (dt.Rows.Count > 0)
            {
                u.ObjectID = dt.Rows[0]["ObjectID"].ToString();
                u.Name = dt.Rows[0]["Name"].ToString();
            }
            return u;
        }

        public static string getUrlParam(string url, string key)
        {
            string value = "";
            var uri = new Uri(url);
            var queryString = uri.Query;
            var regPattern = @"" + key + "=([^&]*)?";
            var regMatch = System.Text.RegularExpressions.Regex.Match(url, regPattern);
            value = regMatch.Groups[1].ToString();
            return value;
        }

        // 传入id或者ContractNo
        public static ContractMain getContractByBizId(string id)
        {
            // 国内合同
            ContractMain con = new ContractMain();
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT * FROM I_ContractMain con" +
                " where con.ObjectID = '" + id + "' or con.ContractNo = '" + id + "'");
            if (dt.Rows.Count > 0)
            {
                con.ContractNo = dt.Rows[0]["ContractNo"].ToString();
                con.ContractTotalPrice = dt.Rows[0]["ContractTotalPrice"].ToString();
                con.JKTotalAmount = dt.Rows[0]["JKTotalAmount"].ToString();
                con.ContractDHDate = dt.Rows[0]["ContractDHDate"].ToString();
                con.AgencyComputerNum = dt.Rows[0]["AgencyComputerNum"].ToString();
                con.PayCondition = dt.Rows[0]["PayCondition"].ToString();
                con.Currency = dt.Rows[0]["Currency"].ToString();
            }

            return con;
        }

        // 根据key和catagory获取数据字典的值
        public static string getDicValue(string catagory, string code)
        {
            string value = "";

            System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select EnumValue from OT_EnumerableMetadata where Category = '" + catagory + "' and Code = '" + code + "'  ");
            if (dt_wi.Rows.Count > 0)
            {
                value = dt_wi.Rows[0]["EnumValue"].ToString();
            }

            return value;
        }

        // 根据流程id获取workitemid
        public static Dictionary<string, string> getWorkItemId(string instanceid, string status)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            //var workItemId = "";
            if ("2".Equals(status))
            {
                System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select top 1 ObjectID,ActivityCode,DisplayName from OT_WorkItem  " +
                    " where InstanceId = '" + instanceid + "' " +
                    " order by FinishTime desc");
                if (dt_wi.Rows.Count > 0)
                {
                    dic.Add("workItemId", dt_wi.Rows[0]["ObjectID"].ToString());
                    dic.Add("ActivityCode", dt_wi.Rows[0]["ActivityCode"].ToString());
                    dic.Add("DisplayName", dt_wi.Rows[0]["DisplayName"].ToString());
                } else
                {
                    dic.Add("workItemId", "");
                    dic.Add("ActivityCode", "");
                    dic.Add("DisplayName", "");
                }
            }
            else if ("4".Equals(status))
            {
                System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select top 1 ObjectID,ActivityCode,DisplayName from OT_WorkItemFinished  " +
                    " where InstanceId = '" + instanceid + "' " +
                    " order by FinishTime desc");
                if (dt_wi.Rows.Count > 0)
                {
                    dic.Add("workItemId", dt_wi.Rows[0]["ObjectID"].ToString());
                    dic.Add("ActivityCode", dt_wi.Rows[0]["ActivityCode"].ToString());
                    dic.Add("DisplayName", dt_wi.Rows[0]["DisplayName"].ToString());
                }
                else
                {
                    dic.Add("workItemId", "");
                    dic.Add("ActivityCode", "");
                    dic.Add("DisplayName", "");
                }
            }
            else
            {
                dic.Add("workItemId", "");
                dic.Add("ActivityCode", "");
                dic.Add("DisplayName", "");
            }
            return dic;
        }

        // 根据流程id获取workitemid
        public static Dictionary<string, string> getWorkItemIdNew(string instanceid, string status, string CurrentUser)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            //var workItemId = "";
            if ("2".Equals(status))
            {
                System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select  ObjectID,ActivityCode,DisplayName,Participant from OT_WorkItem  " +
                    " where InstanceId = '" + instanceid + "' " +
                    " order by FinishTime desc");
                if (dt_wi.Rows.Count > 0)
                {
                    var workItemId = "";
                    var Mode = "View";
                    foreach (DataRow dr in dt_wi.Rows)
                    {
                        if (dr["Participant"].ToString().Equals(CurrentUser))
                        {
                            workItemId = dr["ObjectID"].ToString();
                            Mode = "Work";
                        }
                    }
                    dic.Add("workItemId", workItemId.Equals("") ? dt_wi.Rows[0]["ObjectID"].ToString() : workItemId);
                    dic.Add("ActivityCode", dt_wi.Rows[0]["ActivityCode"].ToString());
                    dic.Add("DisplayName", dt_wi.Rows[0]["DisplayName"].ToString());
                    dic.Add("Mode", Mode);
                }
                else
                {
                    dic.Add("workItemId", "");
                    dic.Add("ActivityCode", "");
                    dic.Add("DisplayName", "");
                    dic.Add("Mode", "");
                }
            }
            else if ("4".Equals(status))
            {
                System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select top 1 ObjectID,ActivityCode,DisplayName from OT_WorkItemFinished  " +
                    " where InstanceId = '" + instanceid + "' " +
                    " order by FinishTime desc");
                if (dt_wi.Rows.Count > 0)
                {
                    dic.Add("workItemId", dt_wi.Rows[0]["ObjectID"].ToString());
                    dic.Add("ActivityCode", dt_wi.Rows[0]["ActivityCode"].ToString());
                    dic.Add("DisplayName", dt_wi.Rows[0]["DisplayName"].ToString());
                    dic.Add("Mode", "View");
                }
                else
                {
                    dic.Add("workItemId", "");
                    dic.Add("ActivityCode", "");
                    dic.Add("DisplayName", "");
                    dic.Add("Mode", "");
                }
            }
            else
            {
                dic.Add("workItemId", "");
                dic.Add("ActivityCode", "");
                dic.Add("DisplayName", "");
                dic.Add("Mode", "");
            }
            return dic;
        }

        // 根据流程id,状态，当前人来获取workitemid
        public static Dictionary<string, string> getWorkItemId2(string instanceid, string status, string CurrentUser)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            //var workItemId = "";
            if ("2".Equals(status))
            {
                System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    "  select wi.ObjectID,wi.ActivityCode,wi.DisplayName,wi.Participant,u.Name ParticipantName from OT_WorkItem wi" +
                    "  left JOIN OT_User u on wi.Participant = u.ObjectID  " +
                    "  where wi.InstanceId = '" + instanceid + "' ");
                if (dt_wi.Rows.Count > 0)
                {
                    var workItemId = "";
                    var ParticipantName = "";
                    var Mode = "View";
                    foreach (DataRow dr in dt_wi.Rows)
                    {
                        if (dr["Participant"].ToString().Equals(CurrentUser))
                        {
                            workItemId = dr["ObjectID"].ToString();
                            Mode = "Work";
                        }
                        ParticipantName += dr["ParticipantName"].ToString() + ",";
                    }
                    dic.Add("workItemId", workItemId.Equals("") ? dt_wi.Rows[0]["ObjectID"].ToString() : workItemId);
                    dic.Add("DisplayName", dt_wi.Rows[0]["DisplayName"].ToString());
                    dic.Add("ParticipantName", ParticipantName);
                    dic.Add("Mode", Mode);
                }
                else
                {
                    dic.Add("workItemId", "");
                    dic.Add("DisplayName", "");
                    dic.Add("ParticipantName", "");
                    dic.Add("Mode", "");
                }
            }
            else if ("4".Equals(status))
            {
                System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select top 1 ObjectID,ActivityCode,DisplayName from OT_WorkItemFinished  " +
                    " where InstanceId = '" + instanceid + "' " +
                    " order by FinishTime desc");
                if (dt_wi.Rows.Count > 0)
                {
                    dic.Add("workItemId", dt_wi.Rows[0]["ObjectID"].ToString());
                    dic.Add("DisplayName", "");
                    dic.Add("ParticipantName", "");
                    dic.Add("Mode", "View");
                }
                else
                {
                    dic.Add("workItemId", "");
                    dic.Add("DisplayName", "");
                    dic.Add("ParticipantName", "");
                    dic.Add("Mode", "");
                }
            }
            else
            {
                dic.Add("workItemId", "");
                dic.Add("DisplayName", "");
                dic.Add("ParticipantName", "");
                dic.Add("Mode", "");
            }
            return dic;
        }

        // 获取累计到款（到款模块）
        // param1：100 人民币, 50 美元
        // param2：20
        // param3：美元
        public static string getLJDK(string LJDKAmount, double lj, string cu)
        {
            var ret = "";
            if (!LJDKAmount.Equals(""))
            {
                string[] ls = LJDKAmount.Split(',');
                int eqflg = 0;
                foreach (string item in ls)
                {
                    string[] ljitem = item.Split(' ');
                    if (ljitem[1].Equals(cu))
                    {
                        var ljvar = lj + (double)Convert.ToSingle(ljitem[0]);
                        ret += ljvar + " " + cu + ",";
                        eqflg++;
                    }
                    else
                    {
                        ret += item + ",";
                    }
                }
                if (eqflg == 0)
                {
                    if (lj != 0)
                    {
                        ret += lj + " " + cu + ",";
                    }

                }
            }
            else
            {
                if (lj != 0)
                {
                    ret = lj + " " + cu + ",";
                }
            }
            return ret != "" ? ret.Substring(0, ret.Length - 1) : "";
        }

        // 判断List中包含每个值
        public static bool Contains(List<Dictionary<string, string>> ls, string value)
        {
            foreach (Dictionary<string, string> dic in ls)
            {
                foreach (var item in dic)
                {
                    if (item.Key.Equals("DKObjectID") || item.Key.Equals("FKObjectID"))
                    {
                        if (value.Equals(item.Value))
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }

        // 判断dt中包含每个值
        public static bool Contains(System.Data.DataTable dt, string QKObjectID, string QKType, string QKCurrency)
        {
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["QKObjectID"].ToString().Equals(QKObjectID) &&
                        dr["QKType"].ToString().Equals(QKType) &&
                        dr["QKCurrency"].ToString().Equals(QKCurrency))
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        public static string getStatus(Dictionary<string, string> dkst, string QKSeq)
        {
            string ret = "";
            string st = "";
            foreach (KeyValuePair<string, string> kv in dkst)
            {
                if (kv.Key.Equals(QKSeq))
                {
                    st = kv.Value;
                }
            }
            if (st == "2")
            {
                ret = "\n(到款流程中)";
            }
            return ret;
        }

        // 获取结算的到款中的状态
        public static string getStatusOfDKJ(Dictionary<string, string> dic, string objKey)
        {
            string ret = "";
            string st = "";
            foreach (KeyValuePair<string, string> kv in dic)
            {
                if (kv.Key.Equals(objKey))
                {
                    st = kv.Value;
                }
            }
            if (st == "4")
            {
                ret = "已结算";
            }
            else if (st == "2")
            {
                ret = "结算中";
            }
            else
            {
                ret = "未结算";
            }
            return ret;
        }

        public static List<Dictionary<string, string>> Subs(List<Dictionary<string, string>> ls, List<Dictionary<string, string>> ls_sub)
        {
            List<Dictionary<string, string>> ret = new List<Dictionary<string, string>>();
            foreach (Dictionary<string, string> dic in ls)
            {
                string ContractNo1 = "";
                string QKSeq1 = "";
                bool IsSub = false;
                foreach (var item in dic)
                {
                    if (item.Key.Equals("ContractNo"))
                    {
                        ContractNo1 = item.Value;
                    }
                    if (item.Key.Equals("QKSeq"))
                    {
                        QKSeq1 = item.Value;
                    }
                }
                foreach (Dictionary<string, string> dic2 in ls_sub)
                {
                    string ContractNo2 = "";
                    string QKSeq2 = "";
                    foreach (var item2 in dic2)
                    {
                        if (item2.Key.Equals("ContractNo"))
                        {
                            ContractNo2 = item2.Value;
                        }
                        if (item2.Key.Equals("QKSeq"))
                        {
                            QKSeq2 = item2.Value;
                        }
                    }
                    if (ContractNo1.Equals(ContractNo2) && QKSeq1.Equals(QKSeq2))
                    {
                        IsSub = true;
                        break;
                    }
                    else
                    {
                        IsSub = false;
                    }
                }
                if (IsSub == true)
                {
                    Dictionary<string, string> dictmp = new Dictionary<string, string>();
                    foreach (var item in dic)
                    {
                        if (item.Key.Equals("ContractNo"))
                        {
                            dictmp.Add("ContractNo", item.Value);
                        }
                        if (item.Key.Equals("QKSeq"))
                        {
                            dictmp.Add("QKSeq", item.Value);
                        }
                        if (item.Key.Equals("QKType"))
                        {
                            dictmp.Add("QKType", item.Value);
                        }
                        if (item.Key.Equals("QKTarget"))
                        {
                            dictmp.Add("QKTarget", item.Value);
                        }
                        if (item.Key.Equals("QKDate"))
                        {
                            dictmp.Add("QKDate", item.Value);
                        }
                        if (item.Key.Equals("ZJKX"))
                        {
                            dictmp.Add("ZJKX", item.Value);
                        }
                        if (item.Key.Equals("ZJMS"))
                        {
                            dictmp.Add("ZJMS", item.Value);
                        }
                        if (item.Key.Equals("QKAmount"))
                        {
                            dictmp.Add("QKAmount", item.Value);
                        }
                        if (item.Key.Equals("QKCurrency"))
                        {
                            dictmp.Add("QKCurrency", item.Value);
                        }
                        if (item.Key.Equals("QKConvertAmount"))
                        {
                            dictmp.Add("QKConvertAmount", item.Value);
                        }
                        if (item.Key.Equals("SeqCnt"))
                        {   // 过滤掉ContractNo、Seq相同的数据后，对应的Cnt要减去1
                            dictmp.Add("SeqCnt", ((int)Convert.ToSingle(item.Value) - 1).ToString());
                        }
                        if (item.Key.Equals("QKCurrencyCode"))
                        {
                            dictmp.Add("QKCurrencyCode", item.Value);
                        }
                        if (item.Key.Equals("LJDKAmount"))
                        {
                            dictmp.Add("LJDKAmount", item.Value);
                        }
                        if (item.Key.Equals("QKSeqHidden"))
                        {
                            dictmp.Add("QKSeqHidden", item.Value);
                        }
                        if (item.Key.Equals("QKTypeCode"))
                        {
                            dictmp.Add("QKTypeCode", item.Value);
                        }
                        if (item.Key.Equals("QKObjectID"))
                        {
                            dictmp.Add("QKObjectID", item.Value);
                        }
                    }
                    ret.Add(dictmp);
                }
                else
                {
                    ret.Add(dic);
                }
            }

            return ret;
        }

        // Http get请求
        public static string HttpGet(string url, Encoding encode = null)
        {
            string result;

            try
            {
                var webClient = new WebClient { Encoding = Encoding.UTF8 };

                if (encode != null)
                    webClient.Encoding = encode;

                result = webClient.DownloadString(url);
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            return result;
        }

        /// <summary>  
        ///  Http同步Post同步请求  
        /// </summary>  
        /// <param name="url">Url地址</param>  
        /// <param name="postStr">请求Url数据</param>  
        /// <param name="encode">编码(默认UTF8)</param>  
        /// <returns></returns>  
        public static string HttpPost(string url, string postStr = "", Encoding encode = null)
        {
            string result;

            try
            {
                var webClient = new WebClient { Encoding = Encoding.UTF8 };

                if (encode != null)
                    webClient.Encoding = encode;

                var sendData = Encoding.GetEncoding("GB2312").GetBytes(postStr);

                webClient.Headers.Add("Content-Type", "application/x-www-form-urlencoded");
                webClient.Headers.Add("ContentLength", sendData.Length.ToString(CultureInfo.InvariantCulture));

                var readData = webClient.UploadData(url, "POST", sendData);

                result = Encoding.GetEncoding("GB2312").GetString(readData);

            }
            catch (Exception ex)
            {
                result = ex.Message;
            }

            return result;
        }

        public static void outExcel()
        {
            DataTable dtData = new DataTable();// (DataTable)Session["datatable"];
            string shtnl = "";
            shtnl = "<table border='1' cellspacing='1' cellpadding='1'>";
            shtnl = shtnl + "<thead>";
            for (int j = 0; j < dtData.Columns.Count; j++)
            {
                shtnl = shtnl + "<th>" + j + "</th>";
            }
            shtnl = shtnl + "</thead><tbody>";
            for (int i = 0; i < dtData.Rows.Count; i++)
            {
                shtnl = shtnl + "<tr>";
                for (int j = 0; j < dtData.Columns.Count; j++)
                {
                    shtnl = shtnl + "<td>" + dtData.Rows[i][j] + "</td>";
                }
                shtnl = shtnl + "</tr>";
            }
            shtnl = shtnl + "</tbody></table>";
            ExportToExcel("application/vnd.ms-excel", "123.xls", shtnl);
        }
        public static void ExportToExcel(string FieldType, string FileName, string dt)
        {
            System.Web.HttpContext.Current.Response.Charset = "utf-8";
            System.Web.HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(FileName, System.Text.Encoding.UTF8).ToString());
            System.Web.HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
            System.Web.HttpContext.Current.Response.ContentType = FieldType;
            StringWriter tw = new StringWriter();
            System.Web.HttpContext.Current.Response.Output.Write(dt);
            System.Web.HttpContext.Current.Response.Flush();
            System.Web.HttpContext.Current.Response.End();
        }

        public static void ExportToExcel(DataTable dataList, string[] fields, string[] headTexts, string title, string TableName)
        {
            GridView gvw = new GridView();
            int ColCount, i;
            //如果筛选的字段和对应的列头名称个数相对的情况下只导出指定的字段
            if (fields.Length != 0 && fields.Length == headTexts.Length)
            {
                ColCount = fields.Length;
                gvw.AutoGenerateColumns = false;

                for (i = 0; i < ColCount; i++)
                {
                    BoundField bf = new BoundField();
                    bf.DataField = fields[i];
                    bf.HeaderText = headTexts[i];
                    gvw.Columns.Add(bf);
                }
            }
            else
            {
                gvw.AutoGenerateColumns = true;
            }
            gvw.DataSource = dataList;
            SetStype(gvw);
            gvw.DataBind();
            ExportToExcel(gvw, title, TableName);
        }
        /// <summary>
        /// 导出数据到Excel
        /// </summary>
        /// <param name="DataList">IList Data</param>
        /// <param name="Fields">要导出的字段</param>
        /// <param name="HeadName">字段对应显示的名称</param>
        /// <param name="TableName">导出Excel的名称</param>
        public static void ExportToExcel(DataTable dataList, string[] fields, string[] headTexts, string TableName)
        {
            ExportToExcel(dataList, fields, headTexts, string.Empty, TableName);
        }

        /// <summary>
        /// 设置样式
        /// </summary>
        /// <param name="gvw"></param>
        private static void SetStype(GridView gvw)
        {
            gvw.Font.Name = "Verdana";
            gvw.BorderStyle = System.Web.UI.WebControls.BorderStyle.Solid;
            gvw.HeaderStyle.BackColor = System.Drawing.Color.LightCyan;
            gvw.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            gvw.HeaderStyle.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            gvw.HeaderStyle.Wrap = false;
            gvw.HeaderStyle.Font.Bold = true;
            gvw.HeaderStyle.Font.Size = 10;
            gvw.RowStyle.Font.Size = 10;
        }
        /// <summary>
        /// 导出GridView中的数据到Excel
        /// </summary>
        /// <param name="gvw"></param>
        /// <param name="DataList"></param>
        private static void ExportToExcel(GridView gvw, string title, string TableName)
        {

            //int coun = ExistsRegedit();
            //string fileName = string.Format("DataInfo{0:yyyy-MM-dd_HH_mm}.xls", DateTime.Now);
            //if (coun >0)
            //{
            //    fileName = string.Format("DataInfo{0:yyyy-MM-dd_HH_mm}.xls", DateTime.Now);
            //    //HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF7;
            //}
            //else
            //{
            //    HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.UTF8;
            //    //Page.RegisterStartupScript("mess", "<script>alert('该机器没有安装任何office软件');</script>");
            //    //return;
            //}

            for (int i = 0; i < gvw.Rows.Count; i++)
            {
                for (int j = 0; j < gvw.HeaderRow.Cells.Count; j++)
                {
                    //这里给指定的列编辑格式，将数字输出为文本，防止数字溢出  
                    gvw.Rows[i].Cells[j].Attributes.Add("style", "vnd.ms-excel.numberformat:@");
                }
            }
            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.ClearHeaders();
            //fileName = string.Format("DataInfo{0:yyyy-MM-dd_HH_mm}.xls", DateTime.Now);
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + TableName + System.Web.HttpUtility.UrlEncode(title) + DateTime.Now.ToShortDateString() + ".xls");
            HttpContext.Current.Response.Charset = "UTF-8";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");


            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.Write("<html><head><style type='text/css'>h1 {font-family: Arial, sans-serif;font-size: 24px;margin: 5px;color: #369;text-align:center}h3 {text-align:center;color:#0099FF;}table{border-collapse: collapse;font-family: 'Lucida Sans Unicode','Lucida Grande',Sans-Serif;font-size: 12px;margin: 20px;text-align: left;width: 97%}td {padding: 8px;}th{text-align:center;}</style></head><body>");
            StringWriter tw = new System.IO.StringWriter();
            HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            gvw.RenderControl(hw);
            if (!string.IsNullOrEmpty(title))
            {
                //HttpContext.Current.Response.Write("<b><center><font size=3 face=Verdana color=#0000FF>" + title + "</font></center></b>");
            }
            HttpContext.Current.Response.Write(tw.ToString());
            HttpContext.Current.Response.Write("</body></html>");
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.Close();
            HttpContext.Current.Response.End();
            gvw.Dispose();
            tw.Dispose();
            hw.Dispose();
            gvw = null;
            tw = null;
            hw = null;
        }

        //检查office的版本
        public static int ExistsRegedit()
        {
            int ifused = 0;
            RegistryKey rk = Registry.LocalMachine;
            RegistryKey akey = rk.OpenSubKey(@"SOFTWARE\Microsoft\Office\11.0\Excel\InstallRoot\");//查询2003
            RegistryKey akey07 = rk.OpenSubKey(@"SOFTWARE\Microsoft\Office\12.0\Excel\InstallRoot\");//查询2007
            RegistryKey akeytwo = rk.OpenSubKey(@"SOFTWARE\Kingsoft\Office\6.0\common\");//查询wps
                                                                                         //检查本机是否安装Office2003
            if (akey != null)
            {
                string file03 = akey.GetValue("Path").ToString();
                if (File.Exists(file03 + "Excel.exe"))
                {
                    ifused += 1;
                }
            }

            //检查本机是否安装Office2007

            //if (akey07 != null)
            //{
            //    string file07 = akey.GetValue("Path").ToString();
            //    if (File.Exists(file07 + "Excel.exe"))
            //    {
            //        ifused += 2;
            //    }
            //}
            ////检查本机是否安装wps
            //if (akeytwo != null)
            //{
            //    string filewps = akeytwo.GetValue("InstallRoot").ToString();
            //    if (File.Exists(filewps + @"\office6\et.exe"))
            //    {
            //        ifused += 4;
            //    }
            //}
            return ifused;
        }

        public static string getActivityName(string BizObjectSchemaCode, string Activity)
        {
            string ret = "";
            if (Activity.Equals("ActivityOrig"))
            {
                ret = "发起申请";
            }
             else if (Activity.Equals("ActivityHYManager"))
            {
                ret = "航油部门审批";
            } else if (Activity.Equals("ActivityManager"))
            {
                ret = "非航油部门审批";
            } else if (Activity.Equals("ActivityHYCompanyLeader") || Activity.Equals("ActivityHYCompanyManager"))
            {
                ret = "航油领导审批";
            }
            else if (Activity.Equals("ActivityCompanyLeader") || Activity.Equals("ActivityCompanyManager"))
            {
                ret = "非航油领导审批";
            }
            else if (Activity.Equals("ActivityConfirm") )
            {
                ret = "确认";
            }
            // 特殊场合处理
            if (BizObjectSchemaCode.Equals("QK") 
                || BizObjectSchemaCode.Equals("DK")
                || BizObjectSchemaCode.Equals("FK")
                || BizObjectSchemaCode.Equals("JS")
                )
            {
                
            }

            if ( BizObjectSchemaCode.Equals("FK")
                )
            {
                if (Activity == "ConfirmReceipt")
                {
                    return "确认上传发票";
                }
            }

            if (BizObjectSchemaCode.Equals("ContractApprove"))
            {
                if (Activity == "ActivityFinance")
                {
                    return "财务会审";
                }
            }
            if (BizObjectSchemaCode == "ContractMain")
            {
                if (Activity == "ActivityCreate")
                {
                    return "创建合同";
                }
                else if (Activity == "ActivityApprove")
                {
                    return "合同审签";
                }
                else if (Activity == "ActivityOperate")
                {
                    return "合同执行";
                }
                else if (Activity == "End")
                {
                    return "合同完成";
                }
            }
            else if (BizObjectSchemaCode == "QK" || BizObjectSchemaCode == "BatchQK")
            {
                if (Activity == "ActivityOrig" && BizObjectSchemaCode == "QK")
                {
                    return "发起申请";
                }
                else if (Activity == "ActivityOrig" && BizObjectSchemaCode == "BatchQK")
                {
                    return "批量请款申请";
                }
                else if (Activity == "ActivityHYManager")
                {
                    return "航油部门审批";
                }
                else if (Activity == "ActivityManager")
                {
                    return "非航油部门审批";
                }
                else if (Activity == "ActivityHYCompanyLeader")
                {
                    return "公司领导审批";
                }
                else if (Activity == "ActivityCompanyLeader")
                {
                    return "非航油领导审批";
                }
                else if (Activity == "ActivityConfirm" && BizObjectSchemaCode == "QK")
                {
                    return "请款送达确认";
                }
                else if (Activity == "ActivityConfirm" && BizObjectSchemaCode == "BatchQK")
                {
                    return "批量请款送达确认";
                }
                else if (Activity == "ActivityDKConfirm" && BizObjectSchemaCode == "BatchQK")
                {
                    return "到款确认";
                }
            }
            else if (BizObjectSchemaCode == "DK" || BizObjectSchemaCode == "BatchDK")
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起申请";
                }
                else if (Activity == "ActivityConfirm")
                {
                    return "复核";
                }
            }
            else if (BizObjectSchemaCode == "FK" || BizObjectSchemaCode == "BatchFK")
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起申请";
                }
                else if (Activity == "ActivityHYManager")
                {
                    return "航油部门审批";
                }
                else if (Activity == "ActivityManager")
                {
                    return "非航油部门审批";
                }
                else if (Activity == "ActivityHYCompanyManager")
                {
                    return "航油领导审批";
                }
                else if (Activity == "ActivityCompanyManager")
                {
                    return "非航油领导审批";
                }
                else if (Activity == "ActivityConfirm")
                {
                    return "财务确认";
                }
            }
            else if (BizObjectSchemaCode == "BatchJQ")
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起批量结清";
                }
                else if (Activity == "ActivityHYManager")
                {
                    return "航油部门审批";
                }
                else if (Activity == "ActivityManager")
                {
                    return "非航油部门审批";
                }
                else if (Activity == "ActivityHYCompanyManager")
                {
                    return "航油领导审批";
                }
                else if (Activity == "ActivityCompanyManager")
                {
                    return "非航油领导审批";
                }
            }
            else if (BizObjectSchemaCode == "GD" || BizObjectSchemaCode == "GDChange")
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起申请";
                }
                else if (Activity == "ActivityConfirm")
                {
                    return "审批";
                }
            }
            else if (BizObjectSchemaCode == "BH")
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起申请";
                }
                else if (Activity == "ActivityHYManager")
                {
                    return "航油部门审批";
                }
                else if (Activity == "ActivityManager")
                {
                    return "非航油部门审批";
                }
                else if (Activity == "ActivityHYCompanyLeader")
                {
                    return "航油领导审批";
                }
                else if (Activity == "ActivityCompanyLeader")
                {
                    return "非航油领导审批";
                }
                else if (Activity == "ActivityFinance")
                {
                    return "财务审批";
                }
                else if (Activity == "ActivityOffice")
                {
                    return "办公室审批";
                }
            }
            else if (BizObjectSchemaCode == "BG")
            {
                if (Activity == "ActivityOrig")
                {
                    return "变更发起";
                }
                else if (Activity == "ActivityHYManager")
                {
                    return "航油部门审批";
                }
                else if (Activity == "ActivityManager")
                {
                    return "非航油部门审批";
                }
                else if (Activity == "ActivityHYCompanyLeader")
                {
                    return "航油领导审批";
                }
                else if (Activity == "ActivityCompanyLeader")
                {
                    return "非航油领导审批";
                }
                else if (Activity == "ActivityConfirm")
                {
                    return "确认";
                }
            }
            else if (BizObjectSchemaCode == "DH" || BizObjectSchemaCode == "DHHY")
            {
                if (Activity == "ActivityApply")
                {
                    return "到货申请";
                }
                else if (Activity == "ActivityCheck")
                {
                    return "复核";
                }
                else if (Activity == "ActivityEntrust")
                {
                    return "报关委托";
                }
                else if (Activity == "ActivityConfirm")
                {
                    return "确认";
                }
                else if (Activity == "ActivityComplete")
                {
                    return "报关完成";
                }
                else if (Activity == "ActivityXB")
                {
                    return "销保";
                }
            }
            else if (BizObjectSchemaCode == "ImportLicenseSub")
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起申请";
                }
                else if (Activity == "ActivityApprove")
                {
                    return "审批";
                }
            }
            else if (BizObjectSchemaCode == "PaymentSub" || BizObjectSchemaCode == "PaymentUpdateSub")
            {
                if (BizObjectSchemaCode == "PaymentSub" && Activity == "ActivityOrig")
                {
                    return "信用证发起";
                }
                else if (BizObjectSchemaCode == "PaymentUpdateSub" && Activity == "ActivityOrig")
                {
                    return "信用证改证发起";
                }
                else if (Activity == "ActivityBankApprove")
                {
                    return "开证行确认";
                }
                else if (Activity == "ActivityPaymentApprove")
                {
                    return "信用证申请";
                }
                else if (Activity == "ActivityHYManager")
                {
                    return "航油部门经理审批";
                }
                else if (Activity == "ActivityHYCompanyLeader")
                {
                    return "航油公司领导审批";
                }
                else if (Activity == "ActivityManager")
                {
                    return "非航油部门经理审批";
                }
                else if (Activity == "ActivityCompanyLeader")
                {
                    return "非航油公司领导审批";
                }
                else if (Activity == "ActivityOperate")
                {
                    return "开证执行";
                }
            }
            else if (BizObjectSchemaCode == "ContractApprove")
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起申请";
                }
                else if (Activity == "ActivityHYManager")
                {
                    return "航油部门经理审批";
                }
                else if (Activity == "ActivityHYCompanyLeader")
                {
                    return "航油公司领导审批";
                }
                else if (Activity == "ActivityManager")
                {
                    return "非航油部门经理审批";
                }
                else if (Activity == "ActivityCompanyLeader")
                {
                    return "非航油公司领导审批";
                }
                else if (Activity == "ActivityFinance")
                {
                    return "财务会审";
                }
            }
            else if (BizObjectSchemaCode == "UpdateContractNo")
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起申请";
                }
                else if (Activity == "ActivityApprove")
                {
                    return "审批";
                }
            }
            // 项目
            if ("BiddingNumberAuditFlow".Equals(BizObjectSchemaCode))
            {
                if (Activity == "ActivityOrig")
                {
                    return "手工";
                }
                else if (Activity == "ActivityApprove")
                {
                    return "审批";
                }
            }

            // 协议
            if ("Update_agreement_number".Equals(BizObjectSchemaCode))
            {
                if (Activity == "ActivityOrig")
                {
                    return "协议号申请修改";
                }
                else if (Activity == "Activity11")
                {
                    return "协议号审批";
                }
            }
            if ("Agreement_sign".Equals(BizObjectSchemaCode))
            {
                if (Activity == "ActivityOrig")
                {
                    return "提交协议";
                }
                else if (Activity == "Activity3")
                {
                    return "部门经理审批";
                }
                else if (Activity == "Activity8")
                {
                    return "领导审批";
                }
            }
            if ("Charge_back".Equals(BizObjectSchemaCode))
            {

                if (Activity == "ActivityOrig")
                {
                    return "提交收/退款单";
                }
                else if (Activity == "Activity3")
                {
                    return "经理审批";
                }
                else if (Activity == "Activity10")
                {
                    return "领导审批";
                }
                else if (Activity == "ActivityFinanceConfirm")
                {
                    return "财务确认审批";
                }
            }
            if ("Agreenment_change".Equals(BizObjectSchemaCode))
            {
                if (Activity == "ActivityOrig")
                {
                    return "发起协议变更";
                }
                else if (Activity == "Activity3")
                {
                    return "部门审批";
                }
                else if (Activity == "Activity9")
                {
                    return "领导审批";
                }
                else if (Activity == "Activity14")
                {
                    return "申请人确认协议变更签约日期";
                }
                else if (Activity == "End")
                {
                    return "结束";
                }
            }
            if ("Agreement_file".Equals(BizObjectSchemaCode))
            {
                if (Activity == "ActivityOrig")
                {
                    return "提交文档";
                }
                else if (Activity == "Activity3")
                {
                    return "资料管理员";
                }
                else if (Activity == "End")
                {
                    return "结束";
                }
            }

            if (BizObjectSchemaCode.Equals("PaymentSub") || BizObjectSchemaCode.Equals("PaymentUpdateSub"))
            {
                if (Activity.Equals("ActivityBankApprove"))
                {
                    ret = "开证行确认";
                } else if (Activity.Equals("ActivityPaymentApprove"))
                {
                    ret = "信用证申请";
                }
                else if (Activity.Equals("ActivityOperate"))
                {
                    ret = "开证执行";
                }
                
            }
            
            if (BizObjectSchemaCode.Equals("InviteBids")) {
                if (Activity.Equals("CreateActivity")) {
                    ret = "创建项目";
                }
                else if (Activity.Equals("PrepareActivity")) {
                    ret = "招标准备";
                }
                else if (Activity.Equals("BiddingActivity")) {
                    ret = "招标";
                }
                else if (Activity.Equals("FileActivity")) {
                    ret = "资料归档";
                }
            }

            if (BizObjectSchemaCode.Equals("FileBidding")) {
                if (Activity.Equals("Activity2")) {
                    ret = "手工";
                }
                else if (Activity.Equals("Activity3")) {
                    ret = "资料管理员审批";
                }
            }

            if (BizObjectSchemaCode.Equals("RefundCashDeposit")) {
                if (Activity.Equals("Activity2")) {
                    ret = "发起申请";
                }
                else if (Activity.Equals("Activity10")) {
                    ret = "部门经理审批";
                }
                else if (Activity.Equals("Activity12")) {
                    ret = "公司领导审批";
                }
                else if (Activity.Equals("Activity13")) {
                    ret = "财务人员审批";
                }
                else if (Activity.Equals("Activity14")) {
                    ret = "办公室人员确认";
                }
            }

            if (BizObjectSchemaCode.Equals("BiddingNumberAuditFlow")) {
                if (Activity.Equals("Activity2")) {
                    ret = "手工";
                }
                else if (Activity.Equals("Activity3")) {
                    ret = "审批";
                }
            }

            if (BizObjectSchemaCode.Equals("BiddingNotice")) {
                if (Activity.Equals("Activity2")) {
                    ret = "手工";
                }
                else if (Activity.Equals("Activity3")) {
                    ret = "审批";
                }
            }

            if (BizObjectSchemaCode.Equals("BiddingDocAudit")) {
                 if (Activity.Equals("Activity2")) {
                    ret = "手工";
                }
                else if (Activity.Equals("Activity3")) {
                    ret = "审批";
                }
            }

            return ret;
        }
    }
}