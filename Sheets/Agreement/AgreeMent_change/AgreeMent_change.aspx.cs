using OThinker.H3.Controllers;
using OThinker.H3.DataModel;

using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OThinker.H3.Portal.service;

namespace OThinker.H3.Portal.Sheets.Agreement
{
    public partial class AgreeMent_change : OThinker.H3.Controllers.MvcPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {
            // 后台获取Url的参数（通过Request来获取）
            string url = Request.Url.ToString();

            string AgreeMent_number = Common.getUrlParam(url, "AgreeMent_number");
            string agency_type = Common.getUrlParam(url, "agency_type");
            //var AgreeMent_number = this.ActionContext.InstanceData["AgreeMent_number"].Value;
            if(!AgreeMent_number.Equals(""))
            {
                String sqls = "";
                if ("USD".Equals(agency_type))
                {
                    sqls = "SELECT am.Project_head_A,am.Project_head_B,am.AgreeMent_number,am.AgreeMent_name,am.Agreement_client,am.Pay_conditions,am.CreatedBy,am.CreatedTime, " +
                        " ar.agency_money,ar.agency_type,e1.EnumValue agency_type_name,ar.up_limit,ar.lower_limit " +
                        " FROM I_AircraftOilAgreement am  " +
                        " inner JOIN I_agency_rates_hy ar on am.ObjectID = ar.ParentObjectID " +
                        " inner JOIN OT_EnumerableMetadata e1 on e1.Code = ar.agency_type and e1.Category = '代理费费率／金额' " +
                        "  where am.AgreeMent_number='" + AgreeMent_number + "'";
                }
                else {
                    sqls = "SELECT am.Project_head_A,am.Project_head_B,am.AgreeMent_number,am.AgreeMent_name,am.Agreement_client,am.Pay_conditions,am.CreatedBy,am.CreatedTime, " +
                        " ar.agency_money,ar.agency_type,e1.EnumValue agency_type_name,ar.up_limit,ar.lower_limit " +
                        " FROM I_Agreement_mains am  " +
                        " inner JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID " +
                        " inner JOIN OT_EnumerableMetadata e1 on e1.Code = ar.agency_type and e1.Category = '代理费费率／金额' " +
                        "  where am.AgreeMent_number='" + AgreeMent_number + "'";
                }
                System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqls);
                if (dt.Rows.Count > 0)
                {

                    BizObject[] bizObjects = new BizObject[dt.Rows.Count];
                    BizObject[] bizObjects2 = new BizObject[dt.Rows.Count];
                    var i = 0;
                    foreach (DataRow dr in dt.Rows)
                    {
                        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("Old_agency_rates").ChildSchema;
                        BizObjectSchema childSchema2 = this.ActionContext.Schema.GetProperty("New_agency_rates").ChildSchema;
                        // 第一行
                        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                        bizObjects[i]["agency_money"] = dr["agency_money"].ToString();
                        bizObjects[i]["agency_type"] = dr["agency_type_name"].ToString();
                        bizObjects[i]["up_limit"] = dr["up_limit"].ToString();
                        bizObjects[i]["lower_limit"] = dr["lower_limit"].ToString();

                        bizObjects2[i] = new BizObject(this.ActionContext.Engine, childSchema2, this.ActionContext.User.UserID);
                        bizObjects2[i]["agency_money"] = dr["agency_money"].ToString();
                        bizObjects2[i]["agency_type"] = dr["agency_type"].ToString();
                        bizObjects2[i]["up_limit"] = dr["up_limit"].ToString();
                        bizObjects2[i]["lower_limit"] = dr["lower_limit"].ToString();
                        i++;
                    }
                    this.ActionContext.InstanceData["Old_agency_rates"].Value = bizObjects;
                    this.ActionContext.InstanceData["New_agency_rates"].Value = bizObjects2;
                }
            }
            
            return base.LoadDataFields();
        }



    }
}
