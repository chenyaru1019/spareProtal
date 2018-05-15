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
using OThinker.H3.Portal.Entity;

namespace OThinker.H3.Portal.Sheets.DefaultEngine
{
    public partial class ContractMainMy : OThinker.H3.Controllers.MvcPage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {
            //string flg = "";
            var ContractNo = this.ActionContext.InstanceData["ContractNo"].Value;
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                "SELECT UpdateNoFlg," +
                " ApproveFlg," +
                " OperateFlg," +
                " CompleteFlg " +
                " FROM I_ContractStatus where ContractNo = '" + ContractNo + "' "
                );
            if (dt.Rows.Count > 0)
            {
                this.ActionContext.InstanceData["UpdateNoFlg"].Value = dt.Rows[0]["UpdateNoFlg"].ToString();
                this.ActionContext.InstanceData["ApproveFlg"].Value = dt.Rows[0]["ApproveFlg"].ToString();
                this.ActionContext.InstanceData["OperateFlg"].Value = dt.Rows[0]["OperateFlg"].ToString();
                this.ActionContext.InstanceData["CompleteFlg"].Value = dt.Rows[0]["CompleteFlg"].ToString();
            }

            ContractMain con = Common.getContractByBizId(this.ActionContext.BizObjectID);
            this.ActionContext.InstanceData["ContractNo"].Value = con.ContractNo;

            //if ("4".Equals(flg))
            //{
            //    this.ActionContext.InstanceData["flgapply"].Value = "1";
            //}
            //else
            //{
            //    this.ActionContext.InstanceData["flgapply"].Value = "00";
            //}
            // 获取合同主流程状态表数据

            // 获取申请修改合同号子流程的版本号
            int versionUpdateContractNo = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("UpdateContractNo");
            this.ActionContext.InstanceData["WorkflowVersion_Update"].Value = versionUpdateContractNo;

            this.ActionContext.InstanceData.Submit();
            return base.LoadDataFields();
        }

        /// <summary>
        /// 保存表单数据到引擎中
        /// </summary>
        /// <param name="Args"></param>
        public override void SaveDataFields(MvcPostValue MvcPost, MvcResult result)
        {
            // 保存后，后台执行事件
            base.SaveDataFields(MvcPost, result);

            try
            {
                if (this.ActionContext.IsOriginateMode)
                {
                    var ContractNo = this.ActionContext.InstanceData["ContractNo"].Value;
                    // var ContractNo2 = ActionContext.BizObject.GetValue("ContractNo");
                    var ContractName = this.ActionContext.InstanceData["ContractName"].Value;
                    System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " insert into I_ContractStatus  " +
                    " (ContractNo, ContractName, UpdateNoFlg, ApproveFlg, OperateFlg, CompleteFlg) " +
                    "  VALUES('" + ContractNo + "', '" + ContractName + "', '0', '', '', '')  "
                    );
                    DataRowCollection dr = dt.Rows;
                    this.ActionContext.InstanceData.Submit();
                }

            }
            catch (Exception exp)
            {

            }

        }

        //public List<string> GetBackAction()
        //{
        //    List<string> acts = new List<string>();
        //    var ContractNo = this.ActionContext.InstanceData["ContractNo"].Value;
        //    ActionContext ac = this.ActionContext;
        //    this.ActionContext.Engine.InstanceManager.ReloadInstance(ac.InstanceId);
        //    acts.Add("A001-节点1");
        //    acts.Add("A002-节点2");
        //    acts.Add("A003-节点3");
        //    return acts;
        //    //if (ContractNo.Equals(""))
        //    //{
        //    //    return "error";
        //    //}
        //    //else
        //    //{
        //    //    return "success";
        //    //}

        //}
    }
}
