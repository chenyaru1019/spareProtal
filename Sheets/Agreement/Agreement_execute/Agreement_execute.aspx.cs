using OThinker.H3.Controllers;
using OThinker.H3.DataModel;

using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace OThinker.H3.Portal.Sheets.Agreement
{
    public partial class Agreement_execute : OThinker.H3.Controllers.MvcPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        //public override MvcViewContext LoadDataFields()
        //{
        //    /**
        //     * 关于流程查询 OT_InstanceContext 表， 关于流程中的节点查询 OT_WorkItem 表，审批建议表是OT_Comment
        //     * */

        //    //List<Dictionary<string, string>> dic = new List<Dictionary<string, string>>();

        //    //协议变更记录
        //    String sqls = "SELECT am.agency_rate AS agencyrate,am.Pay_conditions AS Payconditions," +
        //        "ach.New_money AS Newmoney,ach.Change_pay_content AS paycontent,ot.State AS status FROM I_AgreeMent_main am" +
        //        " LEFT JOIN I_Agreenment_change ach ON am.AgreeMent_number = ach.Agreenment_number " +
        //        "LEFT JOIN OT_InstanceContext ot ON ot.BizObjectId = ach.ObjectID WHERE am.AgreeMent_number = 'SPIAIE-XY17-012'";
        //    System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        //    if (dt.Rows.Count > 0)
        //    {

        //        BizObject[] Agreement = new BizObject[1];
        //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("Agreement_alteration").ChildSchema;
        //        Agreement[0] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
        //        Agreement[0]["old_agency_money"] = dt.Rows[0]["agencyrate"].ToString();
        //        Agreement[0]["new_agency_money"] = dt.Rows[0]["Newmoney"].ToString();
        //        Agreement[0]["old_pay_condition"] = dt.Rows[0]["Payconditions"].ToString();
        //        Agreement[0]["new_agency_conditon"] = dt.Rows[0]["paycontent"].ToString();
        //        Agreement[0]["ag_state"] = dt.Rows[0]["status"].ToString()=="2"?"审批中":"审批完成";
              
        //        this.ActionContext.InstanceData["Agreement_alteration"].Value = Agreement;
        //    }
        //    //协议文件
        //    //String sql_file = "";

        //    //关联项目合同
        //    //String contract_project = "";
        //    return base.LoadDataFields();

        //}


        
    }
}
