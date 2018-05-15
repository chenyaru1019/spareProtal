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

namespace OThinker.H3.Portal.Sheets.DefaultEngine
{
    public partial class AdminPageMy : OThinker.H3.Controllers.MvcPage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public override MvcViewContext LoadDataFields()
        {
            try { 
                // 解决缓存问题
                System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        " SELECT * " +
                        " FROM I_DKTbl " +
                        " where ParentObjectID = '" + this.ActionContext.BizObjectID + "'" +
                        " order By ParentIndex ");
                if (dt.Rows.Count > 0)
                {
                    BizObject[] bizObjects = new BizObject[dt.Rows.Count];
                    var i = 0;
                    foreach (DataRow dr in dt.Rows)
                    {
                        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("DKTbl").ChildSchema;
                        // 第一行
                        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                        bizObjects[i]["QKSeq"] = dr["QKSeq"].ToString();
                        bizObjects[i]["QKObjectID"] = dr["QKObjectID"].ToString();
                        bizObjects[i]["QKSeqHidden"] = dr["QKSeqHidden"].ToString();
                        bizObjects[i]["QKType"] = dr["QKType"].ToString();
                        bizObjects[i]["QKTypeCode"] = dr["QKTypeCode"].ToString();
                        bizObjects[i]["QKTarget"] = dr["QKTarget"].ToString();
                        bizObjects[i]["QKTargetCode"] = dr["QKTargetCode"].ToString();
                        bizObjects[i]["QKDate"] = dr["QKDate"].ToString();
                        bizObjects[i]["ZJKX"] = dr["ZJKX"].ToString();
                        bizObjects[i]["ZJMS"] = dr["ZJMS"].ToString();
                        bizObjects[i]["QKAmount"] = dr["QKAmount"].ToString();
                        bizObjects[i]["QKCurrency"] = dr["QKCurrency"].ToString();
                        bizObjects[i]["QKCurrencyCode"] = dr["QKCurrencyCode"].ToString();
                        bizObjects[i]["QKConvertAmount"] = dr["QKConvertAmount"].ToString();
                        bizObjects[i]["SeqCnt"] = dr["SeqCnt"].ToString();
                        bizObjects[i]["LJDKAmount"] = dr["LJDKAmount"].ToString();
                        bizObjects[i]["CurDKAmount"] = dr["CurDKAmount"].ToString();
                        bizObjects[i]["CurDKCurrency"] = dr["CurDKCurrency"].ToString();
                        bizObjects[i]["Status"] = dr["Status"].ToString();
                        i++;
                    }
                    this.ActionContext.InstanceData["DKTbl"].Value = bizObjects;
                }
            }
            catch (Exception e)
            {
                ;
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
