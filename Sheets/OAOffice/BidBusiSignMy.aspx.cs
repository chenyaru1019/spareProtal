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
    public partial class BidBusiSignMy : OThinker.H3.Controllers.MvcPage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {
            if (this.ActionContext.IsOriginateMode)
            {
                BizObject[] bizObjects = new BizObject[3];
                BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("BidBusiTbl").ChildSchema;
                // 第一行
                bizObjects[0] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                bizObjects[0]["IsCheck"] = "";
                bizObjects[0]["Resources"] = "用车（辆）";
                bizObjects[0]["Num"] = 0;
                bizObjects[0]["ApplyFY"] = 0;
                bizObjects[0]["ConfirmFY"] = 0;
                // 第二行
                bizObjects[1] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                bizObjects[1]["IsCheck"] = "";
                bizObjects[1]["Resources"] = "用餐（人）";
                bizObjects[1]["Num"] = 0;
                bizObjects[1]["ApplyFY"] = 0;
                bizObjects[1]["ConfirmFY"] = 0;
                // 第三行
                bizObjects[2] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                bizObjects[2]["IsCheck"] = "";
                bizObjects[2]["Resources"] = "用工（人）";
                bizObjects[2]["Num"] = 0;
                bizObjects[2]["ApplyFY"] = 0;
                bizObjects[2]["ConfirmFY"] = 0;

                this.ActionContext.InstanceData["BidBusiTbl"].Value = bizObjects;
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
