using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using OThinker.H3.Controllers;
using OThinker.H3.DataModel;
using OThinker.H3.Portal;
using OThinker.H3.BizBus.BizService;
using OThinker.H3.Sheet;
using OThinker.Data;
using OThinker.H3.Instance;
using OThinker.Organization;
using System.Collections.Generic;
using OThinker.H3.Acl;
using OThinker.H3.Portal.service;

namespace OThinker.H3.Portal.Sheets.DefaultEngine
{
    public partial class ZJPlanMy : OThinker.H3.Controllers.MvcPage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {
            //this.ActionContext.InstanceData["RejectFlg"].Value
            // 后台获取Url的参数（通过Request来获取）
            string url = Request.Url.ToString();
            string ContractNo = Common.getUrlParam(url, "ContractNo");
            string QKSubObjectIDs = Common.getUrlParam(url, "QKSubObjectIDs");
            if (!QKSubObjectIDs.Equals("")) {
                var arr = QKSubObjectIDs.Split(',');
                if (arr.Length > 0)
                {
                    // 获取传入的请款数据
                    var QKSeq = "";
                    var Currency = "";
                    System.Data.DataTable dt_qs = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                            " SELECT top 1 qs.Currency,qs.Amount,q.QKSeq " +
                            " FROM I_QKSubTbl qs " +
                            " INNER JOIN I_QK q on qs.ParentObjectID = q.ObjectID and qs.ObjectID = '" + arr[0] + "'");
                    if (dt_qs.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt_qs.Rows)
                        {
                            QKSeq = dr["QKSeq"].ToString();
                            Currency = dr["Currency"].ToString();
                        }
                    }
                    var contains = false;
                    // 原来有的资金计划明细
                    System.Data.DataTable dt_zjd = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                            " select pt.* " +
                            " from I_PlanTbl pt " +
                            " INNER JOIN I_ZJPlan p on pt.ParentObjectID = p.ObjectID and p.ContractNo =  '" + ContractNo + "'");
                    if (dt_zjd.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt_zjd.Rows)
                        {
                            var QKCurrency = dr["QKCurrency"].ToString();
                            var QKCurrencyArr = QKCurrency.Split(':');
                            if(QKCurrencyArr[0].Equals("批次"+ QKSeq) && QKCurrencyArr[1].Equals(Currency))
                            {
                                contains = true;
                            } 
                        }
                    }
                    BizObject[] bizObjects = new BizObject[contains? dt_zjd.Rows.Count: (dt_zjd.Rows.Count+1)];
                    // 给原来的数据赋好值
                    var j = 0;
                    if (dt_zjd.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt_zjd.Rows)
                        {
                            BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("PlanTbl").ChildSchema;
                            // 第一行
                            bizObjects[j] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                            bizObjects[j]["Content"] = dr["Content"];
                            bizObjects[j]["Amount"] = dr["Amount"];
                            bizObjects[j]["QKCurrency"] = dr["QKCurrency"];
                            bizObjects[j]["QKDetail"] = dr["QKDetail"];
                            bizObjects[j]["ExpirationFrom"] = dr["ExpirationFrom"];
                            bizObjects[j]["ExpirationTo"] = dr["ExpirationTo"];
                            bizObjects[j]["IsAfterDK"] = dr["IsAfterDK"];
                            j++;
                        }
                    }
                    if (!contains)
                    {
                        foreach (DataRow dr in dt_qs.Rows)
                        {
                            BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("PlanTbl").ChildSchema;
                            // 第一行
                            bizObjects[j] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                            bizObjects[j]["Content"] = "";
                            bizObjects[j]["Amount"] = dr["Amount"];
                            bizObjects[j]["QKCurrency"] = "批次"+dr["QKSeq"].ToString() + ":" + dr["Currency"].ToString();
                            bizObjects[j]["QKDetail"] = getQKDetailByCurrency2(ContractNo, dr["QKSeq"].ToString(), dr["Currency"].ToString());
                        }
                    }
                    this.ActionContext.InstanceData["PlanTbl"].Value = bizObjects;
                    
                }
            }
                

                return base.LoadDataFields();
        }

        public string getQKDetailByCurrency2(string ContractNo, string QKSeq, string Currency)
        {
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select qs.ZJMS+':'+qs.Currency+convert(varchar(20),convert(decimal(18,2),ISNULL(qs.Amount,0))) QKDetail " +
                    " from I_QK q, I_QKSubTbl qs" +
                    " where q.ContractNo = '" + ContractNo + "' and q.QKSeq = '" + QKSeq + "' and qs.Currency = '" + Currency + "' " +
                    " and q.ObjectID = qs.ParentObjectID ");
            string ret = "";
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    ret += dr["QKDetail"].ToString() + "\n";
                }
            }
            return ret;
        }

        /// <summary>
        /// 保存表单数据到引擎中
        /// </summary>
        /// <param name="Args"></param>
        public override void SaveDataFields(MvcPostValue MvcPost, MvcResult result)
        {

            // 保存后，后台执行事件
            base.SaveDataFields(MvcPost, result);

            
        }
        
    }
}
