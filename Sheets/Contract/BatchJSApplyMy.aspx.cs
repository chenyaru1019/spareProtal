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

namespace OThinker.H3.Portal.Sheets.DefaultEngine
{
    public partial class BatchJSApplyMy : OThinker.H3.Controllers.MvcPage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {
            // 获取批量请款子流程的版本号
            int versionBatchQK = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("BatchJS_QK");
            this.ActionContext.InstanceData["WorkflowVersion_BatchQK"].Value = versionBatchQK;
            // 获取批量付款子流程的版本号
            int versionBatchFK = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("BatchJS_FK");
            this.ActionContext.InstanceData["WorkflowVersion_BatchFK"].Value = versionBatchFK;
            // 获取批量结清子流程的版本号
            int versionBatchJQ = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("BatchJS_JQ");
            this.ActionContext.InstanceData["WorkflowVersion_BatchJQ"].Value = versionBatchJQ;


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

            
        }
        
    }
}
