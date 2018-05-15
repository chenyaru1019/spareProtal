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
    public partial class HYContractSet : OThinker.H3.Controllers.MvcPage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {

            Dictionary<string, string> dic = new Dictionary<string, string>();
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT top 1 h.* from I_HYContractSet h,OT_InstanceContext ic where h.ObjectID = ic.BizObjectID order by h.modifiedTime desc ");
            if (dt.Rows.Count > 0)
            {
                this.ActionContext.InstanceData["Country"].Value = dt.Rows[0]["Country"].ToString();
                this.ActionContext.InstanceData["TradeMethod"].Value = dt.Rows[0]["TradeMethod"].ToString();
            }
            return base.LoadDataFields();
        }

        /// <summary>
        /// 保存表单数据到引擎中
        /// </summary>
        /// <param name="Args"></param>
        public override void SaveDataFields(MvcPostValue MvcPost, MvcResult result)
        {
            //OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            //    " delete from I_HYContractSet" 
            //    );
            //OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            //    " delete from I_SalerTblOfHY"
            //    );
            
            // 保存后，后台执行事件
            base.SaveDataFields(MvcPost, result);

            
        }
        
    }
}
