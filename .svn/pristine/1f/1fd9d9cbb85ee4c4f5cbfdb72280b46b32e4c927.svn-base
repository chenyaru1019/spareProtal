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
    public partial class My_agreement : OThinker.H3.Controllers.MvcPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {
            //int versionBack = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Update_agreement_number");
            //this.ActionContext.InstanceData["Process_version"].Value = versionBack;
            return base.LoadDataFields();
        }


        public String generateContractNo()
        {
            string year = DateTime.Now.Year.ToString().Substring(2, 2);
            String numberid = "SELECT MAX(Numberid) as num FROM I_AgreeMent_main";
            string ContractNo = "";
            string Number = "009";
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
           numberid);
            if (dt.Rows.Count > 0)
            {
                Number = dt.Rows[0]["num"].ToString();
            }
            else
            {
                Number = "001";
            }

            ContractNo = "SPIAIE-XY" + year + "-" + Number;
            /*object JSONObj = JsonConvert.SerializeObject(ContractNo);
       	 	Response.ContentType = "application/json";
        	Response.Write(JSONObj);*/
            return ContractNo;

        }
        //判断协议号是否存在
        public String checkNumber()
        {
            string ContractNo =  Request["AgreeMent_number"];
            // string year = DateTime.Now.Year.ToString().Substring(2, 2);
            // String numberid = "SELECT MAX(Numberid) as num FROM I_AgreeMent_main";
            //string ContractNo = "22222";
            //string Number = "009";
            // System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            //numberid);

            /*object JSONObj = JsonConvert.SerializeObject(ContractNo);
       	 	Response.ContentType = "application/json";
        	Response.Write(JSONObj);*/
            return ContractNo;

        }
    }
}
