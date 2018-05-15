using OThinker.H3.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace OThinker.H3.Portal.Sheets.DefaultEngine
{
    public partial class SEmployeeOvertimeApplication : OThinker.H3.Controllers.MvcPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {
            //this.ActionContext.InstanceData["RejectFlg"].Value
            if (this.ActionContext.IsOriginateMode)
            {
                this.ActionContext.InstanceData["Applicant"].Value = this.ActionContext.ParticipantId;
            }
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
