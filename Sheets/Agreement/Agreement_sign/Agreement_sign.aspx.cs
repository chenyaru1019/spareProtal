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
    public partial class Agreement_sign : OThinker.H3.Controllers.MvcPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        //public override MvcViewContext LoadDataFields()
        //{
        //        var AgreeMent_number = this.ActionContext.InstanceData["AgreeMent_number"].Value;
        //        String sqls = "SELECT am.Project_head_A,am.Project_head_B,am.AgreeMent_number,am.AgreeMent_name,am.Agreement_client,am.Pay_conditions,am.CreatedBy,am.CreatedTime, " +
        //                " ar.agency_money,e1.EnumValue agency_type,ar.up_limit,ar.lower_limit " +
        //                " FROM I_Agreement_mains am  " +
        //                " inner JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID " +
        //                " inner JOIN OT_EnumerableMetadata e1 on e1.Code = ar.agency_type and e1.Category = '代理费费率／金额' " +
        //                "  where am.AgreeMent_number='" + AgreeMent_number + "'";
        //        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
        //        if (dt.Rows.Count > 0)
        //        {

        //            BizObject[] bizObjects = new BizObject[dt.Rows.Count];
        //            var i = 0;
        //            foreach (DataRow dr in dt.Rows)
        //            {
        //                BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("agency_rates_inApprove").ChildSchema;
        //                // 第一行
        //                bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
        //                bizObjects[i]["agency_money"] = dr["agency_money"].ToString();
        //                bizObjects[i]["agency_type"] = dr["agency_type"].ToString();
        //                bizObjects[i]["up_limit"] = dr["up_limit"].ToString();
        //                bizObjects[i]["lower_limit"] = dr["lower_limit"].ToString();
        //                i++;
        //            }
        //            this.ActionContext.InstanceData["agency_rates_inApprove"].Value = bizObjects;
        //        }
        //    return base.LoadDataFields();
        //}




    }
}
