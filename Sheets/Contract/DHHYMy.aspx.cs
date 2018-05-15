﻿using System;
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
    public partial class DHHYMy : OThinker.H3.Controllers.MvcPage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {

            // 获取取回子流程的版本号
            int versionBack = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("GetBackContract");
            this.ActionContext.InstanceData["WorkflowVersion_Back"].Value = versionBack;
            // 获取回退记录
            System.Data.DataTable dt_back = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " SELECT ins.OriginatorName Approver,ins.StartTime ApproveDate,ins.State Status,ins.ObjectID, " +
                        " gb.OldInstanceActivityName,gb.InstanceActivityName,c.[Text] Remark  " +
                        " FROM I_GetBackContract gb, OT_InstanceContext ins, OT_Comment c " +
                        " where gb.NeedInstanceId = '" + this.ActionContext.InstanceId + "' and gb.ObjectID = ins.BizObjectId and ins.ObjectID = c.InstanceId");
            if (dt_back.Rows.Count > 0)
            {
                BizObject[] bizObjects = new BizObject[dt_back.Rows.Count];
                var i = 0;
                foreach (DataRow dr in dt_back.Rows)
                {
                    BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("GetBackDHHYTbl").ChildSchema;
                    // 第一行
                    bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                    bizObjects[i]["Approver"] = dr["Approver"].ToString();
                    bizObjects[i]["ApproveDate"] = dr["ApproveDate"].ToString();
                    bizObjects[i]["Remark"] = dr["Remark"].ToString();
                    bizObjects[i]["OldInstanceActivityName"] = dr["OldInstanceActivityName"].ToString();
                    bizObjects[i]["InstanceActivityName"] = dr["InstanceActivityName"].ToString();

                    var st = dr["Status"].ToString();
                    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["ObjectID"].ToString(), st);
                    foreach (var item in workItemDic)
                    {
                        Console.WriteLine(item.Key + item.Value);
                        if (item.Key.Equals("workItemId"))
                        {
                            bizObjects[i]["WorkItemId"] = item.Value;
                        }
                    }
                    bizObjects[i]["Status"] = st == "2" ? "审批中" : (st == "4" ? "已回退" : "");
                    i++;
                }
                this.ActionContext.InstanceData["GetBackDHHYTbl"].Value = bizObjects;
            }

            //this.ActionContext.InstanceData["RejectFlg"].Value
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
