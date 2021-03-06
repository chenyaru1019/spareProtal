﻿<%@ WebService Language="C#" Class="OThinker.H3.Portal.BPMService" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using OThinker.H3.Acl;
using OThinker.H3.WorkflowTemplate;

namespace OThinker.H3.Portal
{
    /// <summary>
    /// 流程实例操作相关接口
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.None)]
    //若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。 
    // [System.Web.Script.Services.ScriptService]
    public class BPMService : System.Web.Services.WebService
    {
        /// <summary>
        /// 
        /// </summary>
        public BPMService()
        {
            //如果使用设计的组件，请取消注释以下行 
            //InitializeComponent(); 
        }

        private IEngine _Engine = null;
        /// <summary>
        /// 流程引擎的接口，该接口会比this.Engine的方式更快，因为其中使用了缓存
        /// </summary>
        public IEngine Engine
        {
            get
            {
                if (OThinker.H3.Controllers.AppConfig.ConnectionMode == ConnectionStringParser.ConnectionMode.Mono)
                {
                    return OThinker.H3.Controllers.AppUtility.Engine;
                }
                return _Engine;
            }
            set
            {
                _Engine = value;
            }
        }

        /// <summary>
        /// 查询对象
        /// </summary>
        protected Query Query
        {
            get
            {
                return this.Engine.Query;
            }
        }

        private System.Web.Script.Serialization.JavaScriptSerializer _JsSerializer = null;
        /// <summary>
        /// 获取JS序列化对象
        /// </summary>
        private System.Web.Script.Serialization.JavaScriptSerializer JSSerializer
        {
            get
            {
                if (_JsSerializer == null)
                {
                    _JsSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                }
                return _JsSerializer;
            }
        }

        /// <summary>
        /// 设置请款的累计到款 和 结算中的请款到款状态
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = "设置请款的累计到款")]
        //public void SetQKLJDK(string DKObjcetID)
        //{
        //    System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        //        " select dt.QKSeqHidden from I_DKTbl dt  " +
        //        " where dt.ParentObjectID = '"+DKObjcetID+"' " +
        //        " group by dt.QKSeqHidden ");
        //    if (dt1.Rows.Count > 0)
        //    {
        //        foreach (DataRow dr in dt1.Rows)
        //        {
        //            System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        //            " select dt.QKSeqHidden,dt.ParentIndex,dt.CurDKAmount,d.ContractNo from I_DKTbl dt " +
        //            " INNER JOIN I_DK d on dt.ParentObjectID=d.ObjectID  " +
        //            " where dt.ParentObjectID = '"+DKObjcetID+"'  and dt.QKSeqHidden = '"+dr["QKSeqHidden"]+"' " +
        //            " order By dt.QKSeqHidden,dt.ParentIndex ");
        //            var i = 0;
        //            if (dt2.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr2 in dt2.Rows)
        //                {
        //                    if((float)Convert.ToSingle(dr2["CurDKAmount"]) > 0)
        //                    {
        //                        System.Data.DataTable dt3 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        //                        " select qt.ObjectId from I_QKSubTbl qt,I_QK q " +
        //                        " where qt.ParentObjectID = q.ObjectID " +
        //                        " and q.ContractNo =  '"+dr2["ContractNo"]+"'  and q.QKSeq = '"+dr2["QKSeqHidden"]+"' " +
        //                        " order by q.QKSeq , qt.ParentIndex ");
        //                        if (dt3.Rows.Count >= i)
        //                        {
        //                                // 修改数据
        //                                OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
        //                                " update I_QKSubTbl set LJDKAmount = LJDKAmount + " + dr2["CurDKAmount"] + " where ObjectID = '" + dt3.Rows[i]["ObjectId"] + "'");
        //                        }
        //                    }

        //                    i++;
        //                }
        //            }

        //        }
        //    }

        //    return;
        //}
        public void SetQKLJDK(string DKObjcetID)
        {

            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select dt.QKSubObjectID QKSubObjectID,dt.CurDKAmount,dt.CurDKCurrency,dt.QKSeqHidden QKSeq, " +
            "  dt.QKCurrency,dt.QKTypeCode,d.ContractNo ContractNo,dt.Status " +
            " from I_DKTbl dt " +
            " INNER JOIN I_DK d on dt.ParentObjectID=d.ObjectID  " +
            " where dt.ParentObjectID = '"+DKObjcetID+"' and dt.CurDKAmount > 0 " +
            "  ");
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    // 修改请款中的累计到款金额
                    string upd = " update I_QKSubTbl set ";
                    if(dr["CurDKCurrency"].ToString().Equals("RMB"))
                    {
                        upd += " LJDKAmount = isnull(LJDKAmount,0) + " + dr["CurDKAmount"];
                    } else
                    {
                        upd += " LJDKAmountWB = isnull(LJDKAmountWB,0) + " + dr["CurDKAmount"];
                    }
                    upd += " where ObjectID = '" + dr["QKSubObjectID"] + "'";
                    OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(upd);
                    System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select t1.* " +
                    " from I_DKTbl t1 " +
                    " INNER JOIN I_DK d on t1.ParentObjectID=d.ObjectID  " +
                    " where t1.ParentObjectID = '"+DKObjcetID+"' " +
                    " and t1.QKSeqHidden = '"+dr["QKSeq"]+"' and t1.QKCurrency = '"+dr["QKCurrency"]+"' and t1.QKTypeCode = '"+dr["QKTypeCode"]+"' ");
                    if (dt2.Rows.Count > 0)
                    {
                        foreach (DataRow dr2 in dt2.Rows)
                        {
                            // 修改请款中的累计到款状态
                            string upd2 = " update I_QKSubTbl set ";
                            upd2 += " DKStatus = '" + dr["Status"] +"'";
                            upd2 += " where ObjectID = '" + dr2["QKSubObjectID"] + "'";
                            OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(upd2);
                        }
                    }
                    // 修改结算中的请款到款状态
                    OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " update I_JS set QK_FK_Status = 'QK_DK_OK' where ObjectID = ( " +
                    " select JSObjectID from I_QK where I_QK.QKSeq = '"+dr["QKSeq"]+"' and I_QK.ContractNo = '"+dr["ContractNo"]+"' " +
                    " ) and ObjectID != '' ");
                }
            }
            return;
        }


        /// <summary>
        /// 合同变更流程走完后修改合同数据
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = "合同变更流程走完后修改合同数据")]
        public void doBGContract(string BizObjcetID)
        {
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select b.* from I_BG b"
                //" inner join OT_InstanceContext ic on b.ObjectID = ic.BizObjectID where b.ObjectID = '"+BizObjcetID+"' "
                );
            System.Data.DataTable dt2 = null;

            if (dt.Rows.Count > 0)
            {

                var ContractNo = dt.Rows[0]["ContractNo"].ToString();
                var IsChangeAmountRMB = dt.Rows[0]["IsChangeAmountRMB"].ToString();
                var IsChangeAmountWB = dt.Rows[0]["IsChangeAmountWB"].ToString();
                var IsChangeDHDate = dt.Rows[0]["IsChangeDHDate"].ToString();
                var IsChangeAgency = dt.Rows[0]["IsChangeAgency"].ToString();
                var IsChangePayCondition = dt.Rows[0]["IsChangePayCondition"].ToString();
                var FinishTime = dt.Rows[0]["FinishTime"].ToString();
                string sql_update1 = " update I_ContractMain set ";
                string sql_update2 = " where ContractNo = '"+ContractNo+"'";
                string sql_t = "";
                if (IsChangeAmountRMB == "是")
                {
                    sql_t += " ,ContractTotalPrice=" + dt.Rows[0]["AmountRMBNew"].ToString();
                }
                if (IsChangeAmountWB == "是")
                {
                    sql_t += " ,JKTotalAmount=" + dt.Rows[0]["AmountWBNew"].ToString();
                }
                if (IsChangeDHDate == "是")
                {
                    sql_t += " ,ContractDHDate='" + dt.Rows[0]["DHDateNew"].ToString() + "'";
                }
                if (IsChangeAgency == "是")
                {
                    sql_t += " ,AgencyComputerNum=" + dt.Rows[0]["AgencyNumNew"].ToString();
                }
                if (IsChangePayCondition == "是")
                {
                    sql_t += " ,PayCondition='" + dt.Rows[0]["PayConditionNew"].ToString() + "'";
                }
                //if (FinishTime != "9999-12-31 23:59:59.000")
                //{
                //    sql_t += " ,BGFinishTime='" + dt.Rows[0]["FinishTime"].ToString() + "'";
                //}
                if(sql_t != "")
                {
                    dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        sql_update1 + sql_t.Substring(2) + sql_update2);
                }
            }
            return;
        }

        /// <summary>
        /// 协议变更流程走完后修改数据
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = "协议变更流程走完后修改数据")]
        public void doBGAgreement(string BizObjcetID)
        {
            // 支付条件变更
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select * from I_Agreenment_change where ObjectID = '"+BizObjcetID+"' ");

            if (dt.Rows.Count > 0)
            {

                var AgreenMent_number = dt.Rows[0]["AgreeMent_number"].ToString();
                var IsChangePayCondition = dt.Rows[0]["IsChangePayCondition"].ToString();
                var PayConditionNew = dt.Rows[0]["PayConditionNew"].ToString();
                string sql_update1 = " update I_Agreement_mains set ";
                string sql_update2 = " where AgreeMent_number = '"+AgreenMent_number+"'";
                string sql_t = "";
                if (IsChangePayCondition == "是")
                {
                    sql_t += " Pay_conditions='" + dt.Rows[0]["PayConditionNew"].ToString() + "'";
                }
                if(sql_t != "")
                {
                    System.Data.DataTable  dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        sql_update1 + sql_t + sql_update2);
                }
            }

            // 代理费变更
            System.Data.DataTable dt_rates = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select a.AgreenMent_number,a.IsChangeRates,ar.agency_money,ar.agency_type,ar.up_limit,ar.lower_limit " +
                " from I_Agreenment_change a " +
                " INNER JOIN I_New_agency_rates ar on a.ObjectID = ar.ParentObjectID " +
                " and a.ObjectID = '"+BizObjcetID+"' ");

            if (dt_rates.Rows.Count > 0)
            {

                var AgreenMent_number = dt_rates.Rows[0]["AgreeMent_number"].ToString();
                var IsChangeRates = dt_rates.Rows[0]["IsChangeRates"].ToString();
                foreach (DataRow dr in dt_rates.Rows)
                {
                    string sql_update1 = " update I_agency_rates set agency_money =" + dr["agency_money"].ToString() +
                                " where agency_type = '"+ dr["agency_type"].ToString() +"' and ParentObjectID =  " +
                                " (select ObjectID from I_Agreement_mains where AgreeMent_number = '"+AgreenMent_number+"')";
                    System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        sql_update1);
                }

            }
            return;
        }

        /// <summary>
        /// 获取请款对象列表
        /// </summary>
        /// <param name="ContractNo">ContractNo</param>
        /// <returns></returns>
        [WebMethod(Description = "获取请款对象列表")]
        public List<QKTarget> GetQKTarget2(string ContractNo)
        {
            List<QKTarget> listItems = new List<QKTarget>();
            System.Data.DataTable dt_FinalUser = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select FinalUser from I_ContractMain where ContractNo='"+ContractNo+"' ");
            System.Data.DataTable dt_Salers = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select Salers from I_ContractMain where ContractNo='"+ContractNo+"' ");
            QKTarget t;

            if (dt_Salers.Rows.Count > 0)
            {

                string [] Salers = dt_Salers.Rows[0]["Salers"].ToString().Split(',');
                foreach (string item in Salers)
                {
                    if(!item.Equals(""))
                    {
                        t = new QKTarget();
                        t.TargetName = item;
                        listItems.Add(t);
                    }
                }
            }
            if (dt_FinalUser.Rows.Count > 0)
            {
                t = new QKTarget();
                t.TargetName = dt_FinalUser.Rows[0]["FinalUser"].ToString();
                listItems.Add(t);
            }
            t = new QKTarget();
            t.TargetName = "其他";
            listItems.Add(t);
            return listItems;

        }



        /// <summary>
        /// 获取2个日期之间的总天数
        /// </summary>
        /// <param name="StartDate"></param>
        /// <param name="EndDate"></param>
        /// <returns></returns>
        [WebMethod(Description = "获取2个日期之间的天数")]
        public double GetDays(DateTime StartDate, DateTime EndDate)
        {
            bool existsDefault = this.Engine.WorkingCalendarManager.ExistsDefaultCalendar();
            if (existsDefault)
            {
                TimeSpan span = this.Engine.WorkingCalendarManager.GetUsedTimeByCompanyCalendar(StartDate, EndDate);
                return span.TotalHours / 8;
            }
            return EndDate.Subtract(StartDate).Days;
        }

        [WebMethod(Description = "获取发起流程模板")]
        public string GetWorkfowNodeByUser(string UserCode,
            bool ShowFavorite = true,
            bool IsMobile = false,
            string ParentCode = "",
            string SearchKey = "")
        {
            //ValidateSoapHeader();

            string Mode = "WorkflowTemplate";

            var CurrentUserValidator = OThinker.H3.Controllers.UserValidatorFactory.GetUserValidator(this.Engine, UserCode);
            if (CurrentUserValidator == null) { return null; }

            OThinker.H3.Controllers.WorkflowController workflowCtrl = new Controllers.WorkflowController();

            //获取所有有权限发起的流程模板
            DataTable dtworkflows = Engine.PortalQuery.QueryWorkflow(CurrentUserValidator.RecursiveMemberOfs, CurrentUserValidator.ValidateAdministrator());
            //根据可以发起的流程模板编码，倒推获取所有的节点集合
            List<string> aclWorkflowCodes = new List<string>();
            foreach (DataRow row in dtworkflows.Rows)
            {
                if (aclWorkflowCodes.Contains(row[WorkItem.WorkItem.PropertyName_WorkflowCode].ToString())) continue;
                aclWorkflowCodes.Add(row[WorkItem.WorkItem.PropertyName_WorkflowCode] + string.Empty);
            }
            //FunctionAclManager
            List<FunctionNode> nodes = Engine.WorkflowManager.GetParentNodesByWorkflowCodes(aclWorkflowCodes);
            //获取所有的流程模板头，用于获取发布时间
            //WorkflowTemplateManager
            Dictionary<string, PublishedWorkflowTemplateHeader> dicHeaders = Engine.WorkflowManager.GetDefaultWorkflowHeaders(aclWorkflowCodes.ToArray());
            List<PublishedWorkflowTemplateHeader> headers = new List<PublishedWorkflowTemplateHeader>();
            //移动端可发起的流程编码
            List<string> mobileVisibleWorkflowCodes = new List<string>();
            //图标集<WorkflowCode.ImagePath>
            Dictionary<string, string> workflowIcons = new Dictionary<string, string>();
            Dictionary<string, string> workflowIconFileNames = new Dictionary<string, string>();

            if (IsMobile)
            {
                #region 手机端 --------------
                // 检测是否允许手机端发起
                List<string> lstSchemaCodes = new List<string>();
                foreach (PublishedWorkflowTemplateHeader header in dicHeaders.Values)
                {
                    if (!lstSchemaCodes.Contains(header.BizObjectSchemaCode.ToLower()))
                    {
                        lstSchemaCodes.Add(header.BizObjectSchemaCode.ToLower());
                    }
                }
                Dictionary<string, WorkflowClause[]> dicClauses = this.Engine.WorkflowManager.GetClausesBySchemaCodes(lstSchemaCodes.ToArray());
                foreach (string key in dicClauses.Keys)
                {
                    foreach (WorkflowClause c in dicClauses[key])
                    {
                        if (c.MobileStart && !mobileVisibleWorkflowCodes.Contains(c.WorkflowCode.ToLower()))
                        {
                            mobileVisibleWorkflowCodes.Add(c.WorkflowCode.ToLower());
                            if (!string.IsNullOrEmpty(c.IconFileName))
                            {
                                workflowIconFileNames.Add(c.WorkflowCode.ToLower(), c.IconFileName);
                            }
                            else if (!string.IsNullOrEmpty(c.Icon))
                            {
                                workflowIcons.Add(c.WorkflowCode.ToLower(), c.Icon);
                            }
                        }
                    }
                }
                #endregion
            }

            foreach (PublishedWorkflowTemplateHeader header in dicHeaders.Values)
            {
                if (!IsMobile || mobileVisibleWorkflowCodes.Contains(header.WorkflowCode.ToLower()))
                {
                    headers.Add(header);
                }
            }
            //常用流程
            List<string> favoriteWorkflowCodes = this.Engine.WorkflowConfigManager.GetFavoriteWorkflowCodes(CurrentUserValidator.UserID);
            string parentCode = string.IsNullOrEmpty(ParentCode) ? OThinker.H3.Acl.FunctionNode.Category_ProcessModel_Code : ParentCode;
            var result = workflowCtrl.GetWorkflowNodeByParentCode(
                parentCode,
                SearchKey,
                Mode == "WorkflowTemplate" ? FunctionNodeType.BizWorkflow : FunctionNodeType.BizWorkflowPackage,
                ShowFavorite,
                nodes,
                favoriteWorkflowCodes,
                aclWorkflowCodes,
                headers,
                workflowIcons,
                workflowIconFileNames);

            return JSSerializer.Serialize(result);

        }



        /// <summary>
        /// 获取用户的待办任务总数
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = "获取用户未完成的任务总数")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public int GetUserUnfinishedWorkItemCount()
        {
            ValidateSoapHeader();

            int recordCounts;
            // 构造查询用户帐号的条件
            string[] conditions = Query.GetWorkItemConditions(
                UserValidator.UserID,
                true,
                H3.WorkItem.WorkItemState.Unfinished,
                H3.WorkItem.WorkItemType.Unspecified,
                OThinker.Data.BoolMatchValue.Unspecified,
                OThinker.Data.BoolMatchValue.Unspecified);

            // 获取总记录数，计算页码         
            recordCounts = this.Engine.Query.CountWorkItem(conditions);
            return recordCounts;
        }

        /// <summary>
        /// 获取用户的已办任务总数
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = "获取用户已完成的任务总数")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public int GetUserFinishedWorkItemCount()
        {
            ValidateSoapHeader();

            int recordCounts;
            // 构造查询用户帐号的条件
            string[] conditions = Query.GetWorkItemConditions(
                UserValidator.UserID,
                true,
                H3.WorkItem.WorkItemState.Finished,
                H3.WorkItem.WorkItemType.Unspecified,
                OThinker.Data.BoolMatchValue.Unspecified,
                OThinker.Data.BoolMatchValue.Unspecified);
            // 获取总记录数，计算页码
            recordCounts = this.Engine.Query.CountWorkItem(conditions);
            return recordCounts;
        }

        /// <summary>
        /// 获取用户的待阅任务总数
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = "获取用户待阅任务总数")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public int GetUserUnReadWorkItemCount()
        {
            ValidateSoapHeader();

            int recordCounts;
            // 构造查询用户帐号的条件
            string[] conditions = Query.GetWorkItemConditions(
                UserValidator.UserID,
                true,
                H3.WorkItem.WorkItemState.Unfinished,
                H3.WorkItem.WorkItemType.Unspecified,
                OThinker.Data.BoolMatchValue.Unspecified,
                OThinker.Data.BoolMatchValue.Unspecified);

            // 获取总记录数     
            recordCounts = this.Engine.PortalQuery.CountWorkItem(conditions, OThinker.H3.WorkItem.CirculateItem.TableName);
            return recordCounts;
        }

        /// <summary>
        /// 获取用户的已阅任务总数
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = "获取用户已阅任务总数")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public int GetUserReadedWorkItemCount()
        {
            ValidateSoapHeader();

            int recordCounts;
            // 构造查询用户帐号的条件
            string[] conditions = Query.GetWorkItemConditions(
                UserValidator.UserID,
                true,
                H3.WorkItem.WorkItemState.Finished,
                H3.WorkItem.WorkItemType.Unspecified,
                OThinker.Data.BoolMatchValue.Unspecified,
                OThinker.Data.BoolMatchValue.Unspecified);

            // 获取总记录数       
            recordCounts = this.Engine.PortalQuery.CountWorkItem(conditions, OThinker.H3.WorkItem.CirculateItemFinished.TableName);
            return recordCounts;
        }

        // <summary>
        /// 查询用户的已办
        /// </summary>
        /// <param name="userCode">用户编码</param>
        /// <param name="startTime">开始时间（可控）</param>
        /// <param name="endTime">结束时间</param>
        /// <param name="startIndex">开始索引</param>
        /// <param name="endIndex">结束索引</param>
        /// <param name="workflowCode">流程编码</param>
        /// <param name="instanceName">流程实例名称</param>
        /// <returns></returns>
        [WebMethod(Description = "查询用户的已办")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public List<Controllers.ViewModels.WorkItemViewModel> GetFinishWorkItems(string userCode, DateTime? startTime, DateTime? endTime, int startIndex, int endIndex, string workflowCode, string instanceName)
        {
            List<Controllers.ViewModels.WorkItemViewModel> listItems = new List<Controllers.ViewModels.WorkItemViewModel>();
            OThinker.Organization.User user = this.Engine.Organization.GetUserByCode(userCode);
            if (user == null) return listItems;

            string[] conditions = Engine.PortalQuery.GetWorkItemConditions(user.ObjectID,
                    startTime == null ? DateTime.MinValue : startTime.Value,
                    endTime == null ? DateTime.MaxValue : endTime.Value.AddDays(1),
                    WorkItem.WorkItemState.Finished,
                    instanceName,
                    OThinker.Data.BoolMatchValue.Unspecified,
                    workflowCode,
                    true,
                    WorkItem.WorkItemFinished.TableName);
            string OrderBy = "ORDER BY " +
                 WorkItem.WorkItemFinished.TableName + "." + WorkItem.WorkItemFinished.PropertyName_ReceiveTime + " DESC";
            DataTable dtWorkitem = Engine.PortalQuery.QueryWorkItem(conditions, startIndex, endIndex, OrderBy, WorkItem.WorkItemFinished.TableName);
            //int total = Engine.PortalQuery.CountWorkItem(conditions, WorkItem.WorkItemFinished.TableName); // 记录总数
            string[] columns = new string[] { WorkItem.WorkItemFinished.PropertyName_OrgUnit };

            Controllers.WorkItemController controller = new Controllers.WorkItemController();
            List<Controllers.ViewModels.WorkItemViewModel> griddata = controller.Getgriddata(dtWorkitem, columns);

            return griddata;
        }

        // <summary>
        /// 查询用户的待办
        /// </summary>
        /// <param name="userCode">用户编码</param>
        /// <param name="startTime">开始时间（可控）</param>
        /// <param name="endTime">结束时间</param>
        /// <param name="startIndex">开始索引</param>
        /// <param name="endIndex">结束索引</param>
        /// <param name="workflowCode">流程编码</param>
        /// <param name="instanceName">流程实例名称</param>
        /// <returns></returns>
        [WebMethod(Description = "查询用户的待办")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public List<Controllers.ViewModels.WorkItemViewModel> GetUnFinishWorkItems(string userCode, DateTime? startTime, DateTime? endTime, int startIndex, int endIndex, string workflowCode, string instanceName)
        {
            List<Controllers.ViewModels.WorkItemViewModel> listItems = new List<Controllers.ViewModels.WorkItemViewModel>();
            OThinker.Organization.User user = this.Engine.Organization.GetUserByCode(userCode);
            if (user == null) return listItems;

            string[] conditions = Engine.PortalQuery.GetWorkItemConditions(user.ObjectID,
                    startTime == null ? DateTime.MinValue : startTime.Value,
                    endTime == null ? DateTime.MaxValue : endTime.Value.AddDays(1),
                    WorkItem.WorkItemState.Unfinished,
                    instanceName,
                    OThinker.Data.BoolMatchValue.Unspecified,
                    workflowCode,
                    true,
                    WorkItem.WorkItem.TableName);
            string OrderBy = "ORDER BY " +
                 WorkItem.WorkItem.TableName + "." + WorkItem.WorkItem.PropertyName_ReceiveTime + " DESC";
            DataTable dtWorkitem = Engine.PortalQuery.QueryWorkItem(conditions, startIndex, endIndex, OrderBy, WorkItem.WorkItem.TableName);
            //int total = Engine.PortalQuery.CountWorkItem(conditions, WorkItem.WorkItemFinished.TableName); // 记录总数
            string[] columns = new string[] { WorkItem.WorkItem.PropertyName_OrgUnit };

            Controllers.WorkItemController controller = new Controllers.WorkItemController();
            List<Controllers.ViewModels.WorkItemViewModel> griddata = controller.Getgriddata(dtWorkitem, columns);

            return griddata;
        }


        /// <summary>
        /// 查询用户的已阅任务
        /// </summary>
        /// <param name="userCode">用户编码</param>
        /// <param name="startTime">开始时间（可控）</param>
        /// <param name="endTime">结束时间</param>
        /// <param name="startIndex">开始索引</param>
        /// <param name="endIndex">结束索引</param>
        /// <param name="workflowCode">流程编码</param>
        /// <param name="instanceName">流程实例名称</param>
        /// <returns></returns>
        [WebMethod(Description = "查询用户的已阅任务")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public List<Controllers.ViewModels.CirculateItemViewModel> GetReadWorkItems(string userCode, DateTime? startTime, DateTime? endTime, int startIndex, int endIndex, string workflowCode, string instanceName)
        {
            List<Controllers.ViewModels.CirculateItemViewModel> listItems = new List<Controllers.ViewModels.CirculateItemViewModel>();
            OThinker.Organization.User user = this.Engine.Organization.GetUserByCode(userCode);
            if (user == null) return listItems;
            string[] conditions = Engine.PortalQuery.GetWorkItemConditions(user.ObjectID,
                    startTime == null ? DateTime.MinValue : startTime.Value,
                    endTime == null ? DateTime.MaxValue : endTime.Value.AddDays(1),
                    WorkItem.WorkItemState.Finished,
                    instanceName,
                    OThinker.Data.BoolMatchValue.Unspecified,
                    workflowCode,
                    false,
                    WorkItem.CirculateItemFinished.TableName);
            DataTable dtWorkitem = Engine.PortalQuery.QueryWorkItem(conditions, startIndex, endIndex, string.Empty, WorkItem.CirculateItemFinished.TableName);

            int total = Engine.PortalQuery.CountWorkItem(conditions, WorkItem.CirculateItemFinished.TableName); // 记录总数
            string[] columns = new string[] { WorkItem.CirculateItemFinished.PropertyName_OrgUnit, Query.ColumnName_OriginateUnit };

            Controllers.CirculateItemController controller = new Controllers.CirculateItemController();
            listItems = controller.Getgriddata(dtWorkitem, columns, false);
            return listItems;

        }


        /// <summary>
        /// 查询用户的待阅任务
        /// </summary>
        /// <param name="userCode">用户编码</param>
        /// <param name="startTime">开始时间（可控）</param>
        /// <param name="endTime">结束时间</param>
        /// <param name="startIndex">开始索引</param>
        /// <param name="endIndex">结束索引</param>
        /// <param name="workflowCode">流程编码</param>
        /// <param name="instanceName">流程实例名称</param>
        /// <returns></returns>
        [WebMethod(Description = "查询用户的待阅任务")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public List<Controllers.ViewModels.CirculateItemViewModel> GetUnReadWorkItems(string userCode, DateTime? startTime, DateTime? endTime, int startIndex, int endIndex, string workflowCode, string instanceName)
        {
            List<Controllers.ViewModels.CirculateItemViewModel> listItems = new List<Controllers.ViewModels.CirculateItemViewModel>();
            OThinker.Organization.User user = this.Engine.Organization.GetUserByCode(userCode);
            if (user == null) return listItems;
            string[] conditions = Engine.PortalQuery.GetWorkItemConditions(user.ObjectID,
                    startTime == null ? DateTime.MinValue : startTime.Value,
                    endTime == null ? DateTime.MaxValue : endTime.Value.AddDays(1),
                    WorkItem.WorkItemState.Unfinished,
                    instanceName,
                    OThinker.Data.BoolMatchValue.Unspecified,
                    workflowCode,
                    false,
                    WorkItem.CirculateItem.TableName);
            DataTable dtWorkitem = Engine.PortalQuery.QueryWorkItem(conditions, startIndex, endIndex, string.Empty, WorkItem.CirculateItem.TableName);

            //int total = Engine.PortalQuery.CountWorkItem(conditions, WorkItem.CirculateItem.TableName); // 记录总数
            string[] columns = new string[] { WorkItem.CirculateItem.PropertyName_OrgUnit, Query.ColumnName_OriginateUnit };

            Controllers.CirculateItemController controller = new Controllers.CirculateItemController();
            listItems = controller.Getgriddata(dtWorkitem, columns, false);
            return listItems;

        }


        /// <summary>
        /// 提交(已阅)工作任务
        /// </summary>
        /// <param name="workItemId"></param>
        /// <param name="commentText"></param>
        /// <returns></returns>
        [WebMethod(Description = "提交(已阅)工作任务")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool SubmitWorkItem(string workItemId, string commentText)
        {
            // ValidateSoapHeader();
            // 获取操作的用户

            WorkItem.WorkItem item = this.Engine.WorkItemManager.GetWorkItem(workItemId);
            SubmitItem(workItemId, OThinker.Data.BoolMatchValue.True, commentText, OThinker.Organization.User.AdministratorID);//UserValidator.UserID);
            return true;
        }

        /// <summary>
        /// 驳回工作任务
        /// </summary>
        /// <param name="workItemId"></param>
        /// <param name="commentText"></param>
        /// <returns></returns>
        [WebMethod(Description = "驳回工作任务")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool ReturnWorkItem(string workItemId, string commentText)
        {
            ValidateSoapHeader();
            // 获取操作的用户

            WorkItem.WorkItem item = this.Engine.WorkItemManager.GetWorkItem(workItemId);
            ReturnItem(UserValidator.UserID, workItemId, commentText);

            return true;
        }

        /// <summary>
        /// 结束流程
        /// </summary>
        /// <param name="instanceId">流程实例ID</param>
        /// <returns></returns>
        [WebMethod(Description = "强制结束流程")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool FinishInstance(string instanceId)
        {
            ValidateSoapHeader();
            // 获取操作的用户

            Instance.InstanceContext context = this.Engine.InstanceManager.GetInstanceContext(instanceId);
            if (context == null) return false;

            WorkflowTemplate.PublishedWorkflowTemplate workflow = this.Engine.WorkflowManager.GetDefaultWorkflow(context.WorkflowCode);

            Messages.ActivateActivityMessage activateMessage = new Messages.ActivateActivityMessage(
                    Messages.MessageEmergencyType.High,
                    instanceId,
                    workflow.EndActivityCode,
                    OThinker.H3.Instance.Token.UnspecifiedID,
                    null,
                    null,
                    false,
                    WorkItem.ActionEventType.Adjust
                );
            this.Engine.InstanceManager.SendMessage(activateMessage);
            return true;
        }

        /// <summary>
        /// 激活流程
        /// </summary>
        /// <param name="instanceId">流程实例ID</param>
        /// <returns></returns>
        [WebMethod(Description = "激活流程")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool ActiveInstance(string instanceId)
        {
            ValidateSoapHeader();
            // 获取操作的用户

            OThinker.H3.Messages.ActivateInstanceMessage activateMessage = new OThinker.H3.Messages.ActivateInstanceMessage(instanceId);
            this.Engine.InstanceManager.SendMessage(activateMessage);

            return true;
        }

        /// <summary>
        /// 激活指定的活动节点
        /// </summary>
        /// <param name="instanceId">流程实例ID</param>
        /// <param name="activityCode">活动节点</param>
        /// <param name="participants">活动参与者,可以指定参与者，如果为空那么取流程默认配置</param>
        /// <returns></returns>
        [WebMethod(Description = "激活指定的活动节点")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool ActiveToken(string instanceId, string activityCode, string[] participants)
        {
            ValidateSoapHeader();

            // 准备触发后面Activity的消息
            OThinker.H3.Messages.ActivateActivityMessage activateMessage
                = new OThinker.H3.Messages.ActivateActivityMessage(
                    OThinker.H3.Messages.MessageEmergencyType.Normal,
                    instanceId,
                    activityCode,
                    OThinker.H3.Instance.Token.UnspecifiedID,
                    participants,
                    null,
                    false,
                    H3.WorkItem.ActionEventType.Adjust);
            this.Engine.InstanceManager.SendMessage(activateMessage);
            return true;
        }

        /// <summary>
        /// 取消指定的活动节点
        /// </summary>
        /// <param name="instanceId">流程实例ID</param>
        /// <param name="activityCode">活动节点</param>
        /// <returns></returns>
        [WebMethod(Description = "取消指定的活动节点")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool CancelToken(string instanceId, string activityCode)
        {
            ValidateSoapHeader();

            // 准备触发后面Activity的消息
            OThinker.H3.Messages.CancelActivityMessage cancelMessage
                = new Messages.CancelActivityMessage(Messages.MessageEmergencyType.Normal,
                    instanceId,
                    activityCode,
                    false);
            this.Engine.InstanceManager.SendMessage(cancelMessage);
            return true;
        }

        /// <summary>
        /// 取回工作任务
        /// </summary>
        /// <param name="workitemId">工作任务ID</param>
        /// <returns></returns>
        [WebMethod(Description = "取回工作任务")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool RetrieveWorkItem(string workitemId)
        {
            ValidateSoapHeader();

            //获取工作项信息
            OThinker.H3.WorkItem.WorkItem workItem = this.Engine.WorkItemManager.GetWorkItem(workitemId);

            // 检查是否能够取回
            if (workItem == null) return false;
            OThinker.H3.Instance.InstanceContext context = this.Engine.InstanceManager.GetInstanceContext(workItem.InstanceId);
            // 获得当前的Token是否存在多个分支
            OThinker.H3.Instance.IToken currentToken = context.GetToken(workItem.TokenId);
            if (currentToken == null) return false;

            // 获得后继的Token
            int[] postTokenIds = context.GetPostTokens(workItem.TokenId);

            // 发送回退消息
            if (postTokenIds == null || postTokenIds.Length == 0) return false;
            else if (postTokenIds.Length > 1) return false;

            int postTokenId = postTokenIds[0];
            OThinker.H3.Instance.IToken postToken = context.GetToken(postTokenId);
            if (!postToken.Retrievable) return false;

            // 具备取回的条件
            // 记录操作日志
            //无此用户
            OThinker.H3.WorkflowTemplate.PublishedWorkflowTemplateHeader worflowTemplate = this.Engine.WorkflowManager.GetPublishedTemplateHeader(workItem.WorkflowCode, workItem.WorkflowVersion);

            // 记录操作用户ID 
            OThinker.H3.Tracking.UserLog log = new OThinker.H3.Tracking.UserLog(
                Tracking.UserLogType.Retrieve,
                UserValidator.UserID,
                "",
                worflowTemplate.BizObjectSchemaCode,
                workItem.InstanceId,
                workItem.WorkItemID,
                workItem.DisplayName,
                null,
                null,
                null,
                null);
            this.Engine.UserLogWriter.Write(log);

            // 发送取回消息
            OThinker.H3.Messages.CancelActivityMessage rollback
                    = new OThinker.H3.Messages.CancelActivityMessage(
                        OThinker.H3.Messages.MessageEmergencyType.Normal,
                        workItem.InstanceId,
                        postToken.Activity,
                        true);
            this.Engine.InstanceManager.SendMessage(rollback);

            return true;
        }

        /// <summary>
        /// 启动H3流程实例，设置主键数据项的值(私有云接口)
        /// </summary>
        /// <param name="workflowCode"></param>
        /// <param name="userAlias"></param>
        /// <param name="finishStart"></param>
        /// <param name="keyName"></param>
        /// <param name="keyValue"></param>
        /// <returns></returns>
        [WebMethod(Description = "启动H3流程实例，设置主键数据项的值")]
        public BPMServiceResult StartWorkflowWithKey(
            string workflowCode,
            string userAlias,
            bool finishStart,
            string keyName,
            string keyValue)
        {
            List<DataItemParam> paramValues = new List<DataItemParam>();
            if (!string.IsNullOrEmpty(keyName))
            {
                paramValues.Add(new DataItemParam()
                {
                    ItemName = keyName,
                    ItemValue = keyValue
                });
            }

            return startWorkflow(workflowCode, userAlias, finishStart, paramValues);
        }

        /// <summary>
        /// 启动H3流程实例
        /// </summary>
        /// <param name="workflowCode">流程模板编码</param>
        /// <param name="userCode">启动流程的用户编码</param>
        /// <param name="finishStart">是否结束第一个活动</param>
        /// <param name="paramValues">流程实例启动初始化数据项集合</param>
        /// <returns></returns>
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        [WebMethod(Description = "启动H3流程实例")]
        public BPMServiceResult StartWorkflow(
            string workflowCode,
            string userCode,
            bool finishStart,
            List<DataItemParam> paramValues)
        {
            ValidateSoapHeader();
            return startWorkflow(workflowCode, userCode, finishStart, paramValues);
        }

        /// <summary>
        /// 设置单个流程数据项的值
        /// </summary>
        /// <param name="bizObjectSchemaCode"></param>
        /// <param name="bizObjectId"></param>
        /// <param name="keyName"></param>
        /// <param name="keyValue"></param>
        /// <returns></returns>
        [WebMethod(Description = "设置单个流程数据项的值")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool SetItemValue(string bizObjectSchemaCode, string bizObjectId, string keyName, object keyValue)
        {
            ValidateSoapHeader();
            List<DataItemParam> keyValues = new List<DataItemParam>();
            keyValues.Add(new DataItemParam()
            {
                ItemName = keyName,
                ItemValue = keyValue
            });
            return SetItemValues(bizObjectSchemaCode, bizObjectId, keyValues);
        }

        /// <summary>
        /// 设置批量流程数据项的值
        /// </summary>
        /// <param name="bizObjectSchemaCode"></param>
        /// <param name="bizObjectId"></param>
        /// <param name="keyValues"></param>
        /// <returns></returns>
        [WebMethod(Description = "设置批量流程数据项的值")]
        [System.Web.Services.Protocols.SoapHeader("authentication")]
        public bool SetItemValues(string bizObjectSchemaCode, string bizObjectId, List<DataItemParam> keyValues)
        {
            ValidateSoapHeader();
            // 获取操作的用户
            if (keyValues == null || keyValues.Count == 0) return false;
            Dictionary<string, object> values = new Dictionary<string, object>();
            foreach (DataItemParam param in keyValues)
            {
                values.Add(param.ItemName, param.ItemValue);
            }
            return this.Engine.BizObjectManager.SetPropertyValues(bizObjectSchemaCode, bizObjectId, OThinker.H3.Controllers.UserValidatorFactory.CurrentUser.UserID, values);
        }

        /// <summary>
        /// 输出日志至引擎服务器
        /// </summary>
        /// <param name="message"></param>
        [WebMethod(Description = "输出日志至引擎服务器")]
        public void WriteLog(string message)
        {
            this.Engine.LogWriter.Write(message);
        }

        #region 工作任务私有方法 ----------------
        /// <summary>
        /// 提交工作项
        /// </summary>
        /// <param name="workItemId">工作项ID</param>
        /// <param name="approval">审批结果</param>
        /// <param name="commentText">审批意见</param>
        /// <param name="userId">处理人</param>
        private void SubmitItem(string workItemId, OThinker.Data.BoolMatchValue approval, string commentText, string userId)
        {
            // 获取工作项
            OThinker.H3.WorkItem.WorkItem item = this.Engine.WorkItemManager.GetWorkItem(workItemId);
            OThinker.H3.Instance.InstanceContext instance = this.Engine.InstanceManager.GetInstanceContext(item.InstanceId);
            // 添加意见
            this.AppendComment(instance, item, OThinker.Data.BoolMatchValue.Unspecified, commentText);

            // 结束工作项
            this.Engine.WorkItemManager.FinishWorkItem(
                item.ObjectID,
                userId,
                OThinker.H3.WorkItem.AccessPoint.ExternalSystem,

                null,
                approval,
                commentText,
                null,
                OThinker.H3.WorkItem.ActionEventType.Forward,
                (int)OThinker.H3.Controllers.SheetButtonType.Submit);
            // 需要通知实例事件管理器结束事件
            Messages.AsyncEndMessage endMessage = new OThinker.H3.Messages.AsyncEndMessage(
                    Messages.MessageEmergencyType.Normal,
                    item.InstanceId,
                    item.ActivityCode,
                    item.TokenId,
                    approval,
                    false,
                    approval,
                    true,
                    null);
            this.Engine.InstanceManager.SendMessage(endMessage);
        }

        /// <summary>
        /// 驳回工作任务
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="workItemId"></param>
        /// <param name="commentText"></param>
        /// <returns></returns>
        private bool ReturnItem(string userId, string workItemId, string commentText)
        {
            Organization.User user = this.Engine.Organization.GetUnit(userId) as Organization.User;
            if (user == null) return false;
            // 获取工作项
            OThinker.H3.WorkItem.WorkItem item = this.Engine.WorkItemManager.GetWorkItem(workItemId);
            OThinker.H3.Instance.InstanceContext context = this.Engine.InstanceManager.GetInstanceContext(item.InstanceId);
            // ToKen
            OThinker.H3.Instance.IToken Token = context.GetToken(item.TokenId);
            int PreToken = int.Parse(Token.PreTokens[0].ToString());
            OThinker.H3.Instance.IToken PreToken1 = context.GetToken(PreToken);
            string activityName = PreToken1.Activity;
            // 添加意见
            this.AppendComment(context, item, OThinker.Data.BoolMatchValue.False, commentText);
            // 结束工作项
            this.Engine.WorkItemManager.FinishWorkItem(
                  item.ObjectID,
                  user.ObjectID,
                  H3.WorkItem.AccessPoint.ExternalSystem,

                  null,
                  OThinker.Data.BoolMatchValue.False,
                  commentText,
                  null,
                  H3.WorkItem.ActionEventType.Backward,
                  (int)OThinker.H3.Controllers.SheetButtonType.Return);
            // 准备触发后面Activity的消息
            OThinker.H3.Messages.ActivateActivityMessage activateMessage
                = new OThinker.H3.Messages.ActivateActivityMessage(
                OThinker.H3.Messages.MessageEmergencyType.Normal,
                item.InstanceId,
                activityName,
                OThinker.H3.Instance.Token.UnspecifiedID,
                null,
                new int[] { item.TokenId },
                false,
                H3.WorkItem.ActionEventType.Backward);

            // 通知该Activity已经完成
            OThinker.H3.Messages.AsyncEndMessage endMessage =
                new OThinker.H3.Messages.AsyncEndMessage(
                    OThinker.H3.Messages.MessageEmergencyType.Normal,
                    item.InstanceId,
                    item.ActivityCode,
                    item.TokenId,
                    OThinker.Data.BoolMatchValue.False,
                    true,
                    OThinker.Data.BoolMatchValue.False,
                    false,
                    activateMessage);
            this.Engine.InstanceManager.SendMessage(endMessage);
            return true;
        }

        private BPMServiceResult startWorkflow(
            string workflowCode,
            string userCode,
            bool finishStart,
            List<DataItemParam> paramValues)
        {
            //ValidateSoapHeader();
            string workItemID, keyItem, errorMessage;
            workItemID = keyItem = errorMessage = string.Empty;
            BPMServiceResult result;

            try
            {
                // 获取模板
                OThinker.H3.WorkflowTemplate.PublishedWorkflowTemplateHeader workflowTemplate = GetWorkflowTemplate(workflowCode);
                if (workflowTemplate == null)
                {
                    result = new BPMServiceResult(false, "流程启动失败,流程模板不存在，模板编码:" + workflowCode + "。");
                    return result;
                }
                // 查找流程发起人
                OThinker.Organization.User user = this.Engine.Organization.GetUserByCode(userCode) as Organization.User;
                if (user == null)
                {
                    result = new BPMServiceResult(false, "流程启动失败,用户{" + userCode + "}不存在。");
                    return result;
                }

                OThinker.H3.DataModel.BizObjectSchema schema = this.Engine.BizObjectManager.GetPublishedSchema(workflowTemplate.BizObjectSchemaCode);
                OThinker.H3.DataModel.BizObject bo = new DataModel.BizObject(
                    this.Engine.Organization,
                    this.Engine.MetadataRepository,
                    this.Engine.BizObjectManager,
                    this.Engine.BizBus,
                    schema,
                    OThinker.Organization.User.AdministratorID,
                    OThinker.Organization.OrganizationUnit.DefaultRootID);

                if (paramValues != null)
                {
                    // 这里可以在创建流程的时候赋值
                    foreach (DataItemParam param in paramValues)
                    {

                        if (bo.Schema.ContainsField(param.ItemName))
                        {
                            bo[param.ItemName] = param.ItemValue;
                        }
                    }
                }

                bo.Create();

                // 创建流程实例
                string InstanceId = this.Engine.InstanceManager.CreateInstance(
                     bo.ObjectID,
                     workflowTemplate.WorkflowCode,
                     workflowTemplate.WorkflowVersion,
                     null,
                     null,
                     user.UnitID,
                     null,
                     false,
                     Instance.InstanceContext.UnspecifiedID,
                     null,
                     Instance.Token.UnspecifiedID);

                // 设置紧急程度为普通
                OThinker.H3.Messages.MessageEmergencyType emergency = Messages.MessageEmergencyType.Normal;
                // 这里也可以在启动流程的时候赋值
                Dictionary<string, object> paramTables = new Dictionary<string, object>();

                // 启动流程的消息
                OThinker.H3.Messages.StartInstanceMessage startInstanceMessage
                    = new OThinker.H3.Messages.StartInstanceMessage(
                        emergency,
                        InstanceId,
                        null,
                        paramTables,
                        Instance.PriorityType.Normal,
                        true,
                        null,
                        false,
                        OThinker.H3.Instance.Token.UnspecifiedID,
                        null);
                Engine.InstanceManager.SendMessage(startInstanceMessage);
                result = new BPMServiceResult(true, InstanceId, workItemID, "流程实例启动成功！", "");
            }
            catch (Exception ex)
            {
                result = new BPMServiceResult(false, "流程实例启动失败！错误：" + ex.ToString());
            }
            return result;
        }

        /// <summary>
        /// 给工作项添加审批意见
        /// </summary>
        /// <param name="item">工作项</param>
        /// <param name="approval">审批结果</param>
        /// <param name="commentText">审批意见</param>
        private void AppendComment(OThinker.H3.Instance.InstanceContext Instance, OThinker.H3.WorkItem.WorkItem item, OThinker.Data.BoolMatchValue approval, string commentText)
        {
            // 添加一个审批意见
            WorkflowTemplate.PublishedWorkflowTemplate workflow = this.Engine.WorkflowManager.GetPublishedTemplate(
                item.WorkflowCode,
                item.WorkflowVersion);
            // 审批字段
            string approvalDataItem = null;
            if (workflow != null)
            {
                OThinker.H3.DataModel.BizObjectSchema schema = this.Engine.BizObjectManager.GetPublishedSchema(item.WorkflowCode);
                approvalDataItem = workflow.GetDefaultCommentDataItem(schema, item.ActivityCode);
            }
            if (approvalDataItem != null)
            {
                // 创建审批
                OThinker.H3.Data.Comment comment = new Data.Comment();
                comment.Activity = item.ActivityCode;
                comment.Approval = approval;
                comment.CreatedTime = System.DateTime.Now;
                comment.DataField = approvalDataItem;
                comment.InstanceId = item.InstanceId;
                comment.BizObjectId = Instance.BizObjectId;
                comment.BizObjectSchemaCode = Instance.BizObjectSchemaCode;
                comment.OUName = this.Engine.Organization.GetName(this.Engine.Organization.GetParent(item.Participant));
                comment.Text = commentText;
                comment.TokenId = item.TokenId;
                comment.UserID = item.Participant;

                // 设置用户的默认签章
                Organization.Signature[] signs = this.Engine.Organization.GetSignaturesByUnit(item.Participant);
                if (signs != null && signs.Length > 0)
                {
                    foreach (Organization.Signature sign in signs)
                    {
                        if (sign.IsDefault)
                        {
                            comment.SignatureId = sign.ObjectID;
                            break;
                        }
                    }
                }
                this.Engine.BizObjectManager.AddComment(comment);
            }
        }
        #endregion

        /// <summary>
        /// 获取最新的流程模板
        /// </summary>
        /// <param name="workflowCode">流程模板编码</param>
        /// <returns></returns>
        private OThinker.H3.WorkflowTemplate.PublishedWorkflowTemplateHeader GetWorkflowTemplate(string workflowCode)
        {
            // 获取最新版本号
            int workflowVersion = this.Engine.WorkflowManager.GetWorkflowDefaultVersion(workflowCode);
            return GetWorkflowTemplate(workflowCode, workflowVersion);
        }

        /// <summary>
        /// 获取指定版本号的流程模板对象
        /// </summary>
        /// <param name="workflowCode">流程模板编码</param>
        /// <param name="workflowVersion">流程模板版本号</param>
        /// <returns></returns>
        private OThinker.H3.WorkflowTemplate.PublishedWorkflowTemplateHeader GetWorkflowTemplate(string workflowCode, int workflowVersion)
        {
            // 获取模板
            OThinker.H3.WorkflowTemplate.PublishedWorkflowTemplateHeader workflowTemplate = this.Engine.WorkflowManager.GetPublishedTemplateHeader(
                    workflowCode,
                    workflowVersion);
            return workflowTemplate;
        }

        public Authentication authentication;
        public OThinker.H3.Controllers.UserValidator UserValidator = null;

        /// <summary>
        /// 验证当前用户是否正确
        /// </summary>
        /// <returns></returns>
        public void ValidateSoapHeader()
        {
            if (authentication == null)
            {
                throw new Exception("请输入身份认证信息!");
            }
            UserValidator = OThinker.H3.Controllers.UserValidatorFactory.Validate(authentication.UserCode, authentication.Password);
            if (UserValidator == null)
            {
                throw new Exception("帐号或密码不正确!");
            }
            this.Engine = UserValidator.Engine;
            // this.Engine = OThinker.H3.WorkSheet.AppUtility.Engine;
        }

        [WebMethod]
        public List<Employee> LoadAuths(string SystemCode)
        {
            List<Employee> result = new List<Employee>();
            result.Add(new Employee()
            {
                UserCode = "ZhangS",
                Password = "000000"
            });
            return result;
        }
    }


    public class Employee
    {
        public Employee() { }
        public Employee(string UserCode, string Password)
        {
            this.UserCode = UserCode;
            this.Password = Password;
        }

        public string UserCode { get; set; }
        public string Password { get; set; }
    }

    public class QKTarget
    {

        public QKTarget() { }
        public QKTarget(string TargetName)
        {
            this.TargetName = TargetName;
        }

        public string TargetName { get; set; }
    }

    /// <summary>
    /// 身份验证类
    /// </summary>
    public class Authentication : System.Web.Services.Protocols.SoapHeader
    {
        public Authentication() { }
        public Authentication(string UserCode, string Password)
        {
            this.UserCode = UserCode;
            this.Password = Password;
        }

        public string UserCode { get; set; }
        public string Password { get; set; }
    }

    /// <summary>
    /// 流程服务返回消息类
    /// </summary>
    public class BPMServiceResult
    {
        /// <summary>
        /// 消息类构造函数
        /// </summary>
        /// <param name="success"></param>
        /// <param name="instanceId"></param>
        /// <param name="workItemId"></param>
        /// <param name="message"></param>
        public BPMServiceResult(bool success, string instanceId, string workItemId, string message, string WorkItemUrl)
        {
            this.Success = success;
            this.InstanceID = instanceId;
            this.Message = message;
            this.WorkItemID = workItemId;
            this.WorkItemUrl = WorkItemUrl;
        }

        /// <summary>
        /// 消息类构造函数
        /// </summary>
        /// <param name="success"></param>
        /// <param name="message"></param>
        public BPMServiceResult(bool success, string message)
            : this(success, string.Empty, string.Empty, message, string.Empty)
        {

        }

        public BPMServiceResult() { }

        private bool success = false;
        /// <summary>
        /// 获取或设置流程启动是否成功
        /// </summary>
        public bool Success
        {
            get { return success; }
            set { success = value; }
        }
        private string instanceId = string.Empty;
        /// <summary>
        /// 获取或设置启动的流程实例ID
        /// </summary>
        public string InstanceID
        {
            get { return instanceId; }
            set { this.instanceId = value; }
        }
        private string message = string.Empty;
        /// <summary>
        /// 获取或设置系统返回消息
        /// </summary>
        public string Message
        {
            get { return message; }
            set { this.message = value; }
        }
        private string workItemId = string.Empty;
        /// <summary>
        /// 获取或设置第一个节点的ItemID
        /// </summary>
        public string WorkItemID
        {
            get { return workItemId; }
            set { this.workItemId = value; }
        }
        private string workItemUrl = string.Empty;
        /// <summary>
        /// 获取或设置第一个节点的url
        /// </summary>
        public string WorkItemUrl
        {
            get { return workItemUrl; }
            set { this.workItemUrl = value; }
        }
    }

    /// <summary>
    /// 提交任务后返回对象
    /// </summary>
    [Serializable]
    public class ReturnWorkItemInfo
    {
        public ReturnWorkItemInfo() { }
        private bool isSuccess = false;
        /// <summary>
        /// 是否提交成功
        /// </summary>
        public bool IsSuccess
        {
            get { return isSuccess; }
            set { this.isSuccess = value; }
        }
        private string workItemUrl = string.Empty;
        /// <summary>
        /// 当前表单地址
        /// </summary>
        public string WorkItemUrl
        {
            get { return workItemUrl; }
            set { this.workItemUrl = value; }
        }
    }

    /// <summary>
    /// 数据项参数
    /// </summary>
    [Serializable]
    public class DataItemParam
    {
        private string itemName = string.Empty;
        /// <summary>
        /// 获取或设置数据项名称
        /// </summary>
        public string ItemName
        {
            get { return itemName; }
            set { this.itemName = value; }
        }

        private object itemValue = string.Empty;
        /// <summary>
        /// 获取或设置数据项的值
        /// </summary>
        public object ItemValue
        {
            get { return itemValue; }
            set { this.itemValue = value; }
        }
    }

}