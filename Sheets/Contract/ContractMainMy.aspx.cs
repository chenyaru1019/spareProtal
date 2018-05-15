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
            if (this.ActionContext.IsOriginateMode)
            {
                //this.ActionContext.InstanceData["PostA"].Value = this.ActionContext.ParticipantId;
            }
            // 合同号
            var ContractNo = "";
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT c.ContractNo FROM OT_InstanceContext ic INNER JOIN I_ContractMain c on ic.BizObjectId = c.ObjectID and ic.ObjectID = '"+ this.ActionContext.InstanceId+ "'");
            if (dt.Rows.Count > 0)
            {
                ContractNo = dt.Rows[0]["ContractNo"].ToString();
            }
            
            if (ContractNo != "")
            {
                //System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //    "SELECT UpdateNoFlg," +
                //    " ApproveFlg," +
                //    " OperateFlg," +
                //    " CompleteFlg " +
                //    " FROM I_ContractStatus where ContractNo = '" + ContractNo + "' "
                //    );
                //if (dt.Rows.Count > 0)
                //{
                //    this.ActionContext.InstanceData["UpdateNoFlg"].Value = dt.Rows[0]["UpdateNoFlg"].ToString();
                //    this.ActionContext.InstanceData["ApproveFlg"].Value = dt.Rows[0]["ApproveFlg"].ToString();
                //    this.ActionContext.InstanceData["OperateFlg"].Value = dt.Rows[0]["OperateFlg"].ToString();
                //    this.ActionContext.InstanceData["CompleteFlg"].Value = dt.Rows[0]["CompleteFlg"].ToString();
                //}
                // 合同创建节点时
                //if (this.ActionContext.ActivityCode.Equals("ActivityCreate"))
                //{
                // 解决缓存问题（合同号修改时）
                ContractMain con = Common.getContractByBizId(this.ActionContext.BizObjectID);
                this.ActionContext.InstanceData["ContractNo"].Value = con.ContractNo;
                this.ActionContext.InstanceData["ContractTotalPrice"].Value = con.ContractTotalPrice;
                this.ActionContext.InstanceData["JKTotalAmount"].Value = con.JKTotalAmount;
                this.ActionContext.InstanceData["ContractDHDate"].Value = con.ContractDHDate;
                this.ActionContext.InstanceData["AgencyComputerNum"].Value = con.AgencyComputerNum;
                this.ActionContext.InstanceData["PayCondition"].Value = con.PayCondition;

                // 获取取回子流程的版本号
                int versionBack = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("GetBackContract");
                this.ActionContext.InstanceData["WorkflowVersion_Back"].Value = versionBack;
                // 获取终止合同子流程的版本号
                int versionCancel = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Cancel");
                this.ActionContext.InstanceData["WorkflowVersion_Cancel"].Value = versionCancel;

                // 获取申请修改合同号子流程的版本号
                int versionUpdateContractNo = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("UpdateContractNo");
                this.ActionContext.InstanceData["WorkflowVersion_Update"].Value = versionUpdateContractNo;

                // 获取合同号修改记录
                System.Data.DataTable dt_upno = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    //" SELECT ins.OriginatorName Approver,CONVERT(varchar(12),ins.StartTime,111) ApproveDate,upd.ContractNoNew,ins.State Status,ins.ObjectID" +
                    //" FROM I_UpdateContractNo upd, OT_InstanceContext ins " +
                    //" where upd.ContractNoNew = '" + ContractNo + "' and upd.ObjectID = ins.BizObjectId and ins.State = '4'" +
                    //" Union " +
                    //" SELECT ins.OriginatorName Approver,CONVERT(varchar(12),ins.StartTime,111) ApproveDate,upd.ContractNoNew,ins.State Status,ins.ObjectID" +
                    //" FROM I_UpdateContractNo upd, OT_InstanceContext ins " +
                    //" where upd.ContractNoOld = '" + ContractNo + "' and upd.ObjectID = ins.BizObjectId and ins.State = '2'"
                    " SELECT ins.OriginatorName Approver,CONVERT(varchar(12),ins.StartTime,111) ApproveDate,upd.ContractNoNew,ins.State Status,ins.ObjectID" +
                    " FROM I_UpdateContractNo upd, OT_InstanceContext ins " +
                    " where upd.ContractObjectID = '" + this.ActionContext.BizObjectID + "' and upd.ObjectID = ins.BizObjectId " 
                    );
                if (dt_upno.Rows.Count > 0)
                {
                    BizObject[] bizObjects = new BizObject[dt_upno.Rows.Count];
                    var i = 0;
                    foreach (DataRow dr in dt_upno.Rows)
                    {
                        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("UpdateNoTbl").ChildSchema;
                        // 第一行
                        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                        bizObjects[i]["Approver"] = dr["Approver"].ToString();
                        bizObjects[i]["ApproveDate"] = dr["ApproveDate"].ToString();
                        bizObjects[i]["ContractNoNew"] = dr["ContractNoNew"].ToString();
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
                        bizObjects[i]["Status"] = st == "2" ? "审批中" : (st == "4" ? "审批完了" : "");
                        bizObjects[i]["Operate"] = "";
                        i++;
                    }
                    this.ActionContext.InstanceData["UpdateNoTbl"].Value = bizObjects;
                }


                //}
                // 合同审签节点时
                //if (this.ActionContext.ActivityCode.Equals("ActivityApprove"))
                //{
                // 获取合同审签子流程的版本号
                int versionApprove = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("ContractApprove");
                this.ActionContext.InstanceData["WorkflowVersion_Approve"].Value = versionApprove;
                // 获取审签记录
                System.Data.DataTable dt_approve = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    "SELECT ins.OriginatorName Approver,CONVERT(varchar(12),ins.StartTime,111) ApproveDate,ins.State Status,ins.ObjectID" +
                    " FROM I_ContractApprove app, OT_InstanceContext ins " +
                    " where app.ContractNo = '" + ContractNo + "' and app.ObjectID = ins.BizObjectId");
                if (dt_approve.Rows.Count > 0)
                {
                    BizObject[] bizObjects = new BizObject[1];
                    BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("ContractApproveTbl").ChildSchema;
                    // 第一行
                    bizObjects[0] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                    bizObjects[0]["Approver"] = dt_approve.Rows[0]["Approver"].ToString();
                    bizObjects[0]["ApproveDate"] = dt_approve.Rows[0]["ApproveDate"].ToString();
                    var st = dt_approve.Rows[0]["Status"].ToString();
                    Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dt_approve.Rows[0]["ObjectID"].ToString(), st, this.ActionContext.User.UserID);
                    foreach (var item in workItemDic)
                    {
                        Console.WriteLine(item.Key + item.Value);
                        if (item.Key.Equals("workItemId"))
                        {
                            bizObjects[0]["WorkItemId"] = item.Value;
                        }
                        
                    }
                    bizObjects[0]["Status"] = st == "2" ? "审批中" : (st == "4" ? "审批完了" : "");
                    bizObjects[0]["Operate"] = "";

                    this.ActionContext.InstanceData["ContractApproveTbl"].Value = bizObjects;
                }
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
                        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("GetBackMainTbl").ChildSchema;
                        // 第一行
                        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                        bizObjects[i]["Approver"] = dr["Approver"].ToString();
                        bizObjects[i]["ApproveDate"] = dr["ApproveDate"].ToString();
                        bizObjects[i]["Remark"] = dr["Remark"].ToString();
                        bizObjects[i]["OldInstanceActivityName"] = dr["OldInstanceActivityName"].ToString();
                        bizObjects[i]["InstanceActivityName"] = dr["InstanceActivityName"].ToString();

                        var st = dr["Status"].ToString();
                        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["ObjectID"].ToString(), st, this.ActionContext.User.UserID);
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
                    this.ActionContext.InstanceData["GetBackMainTbl"].Value = bizObjects;
                }
                //}
                //PortalControl.PortalPage.GetReadAttachmentUrl()
                // 合同执行节点时
                //if (this.ActionContext.ActivityCode.Equals("ActivityOperate"))
                //{
                // 获取请款子流程的版本号
                int versionQK = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("QK");
                this.ActionContext.InstanceData["WorkflowVersion_QK"].Value = versionQK;
                // 获取到款子流程的版本号
                int versionDK = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("DK");
                this.ActionContext.InstanceData["WorkflowVersion_DK"].Value = versionDK;
                // 获取付款子流程的版本号
                int versionFK = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("FK");
                this.ActionContext.InstanceData["WorkflowVersion_FK"].Value = versionFK;
                // 获取结算子流程的版本号
                int versionJS = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("JS");
                this.ActionContext.InstanceData["WorkflowVersion_JS"].Value = versionJS;
                //// 获取请款记录
                //var qksql =
                //    "   SELECT max(qk.ObjectId) id,qk.QKSeq QKSeq,sum(tbl.Amount) Amount,sum(tbl.ConvertAmount) ConvertAmount,max(qk.QKTarget) QKTarget,tbl.Currency,MAX (ic.ObjectID) icObjectId,MAX (qk.RejectFlg) RejectFlg " +
                //    "   FROM I_QK qk " +
                //    "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID " +
                //    "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID " +
                //    "   and qk.ContractNo =  '" + ContractNo + "'" +
                //    "   group by qk.QKSeq,tbl.Currency";
                //var qksql2 = " select ic.state Status,t.icObjectId IcObjectId,t.RejectFlg,t.QKSeq,t.cnt SeqCnt," +
                //    " convert(varchar(20),convert(decimal(18,2),t.Amount))+e.EnumValue Amount,convert(varchar(20),convert(decimal(18,2),t.ConvertAmount))+'人民币' ConvertAmount,QKTarget " +
                //    " from(" +
                //    "  select t1.id,t1.QKSeq,t1.Amount" +
                //    " ,( " +
                //    "  select sum(t2.ConvertAmount) from (" +
                //       qksql +
                //    "  ) t2 where t2.QKSeq = t1.QKSeq" +
                //    "  ) ConvertAmount" +
                //    " ,( " +
                //    "  select count(t2.QKSeq) from (" +
                //       qksql +
                //    "  ) t2 where t2.QKSeq = t1.QKSeq" +
                //    "  ) cnt" +
                //    " ,t1.Currency " +
                //    " ,t1.QKTarget" +
                //    " ,t1.icObjectId" +
                //    " ,t1.RejectFlg" +
                //    " from (" +
                //      qksql +
                //    "  ) t1" +
                //    " ) t LEFT JOIN OT_EnumerableMetadata e on t.Currency = e.Code and e.Category = '币种' " +
                //    " LEFT JOIN OT_InstanceContext ic on ic.BizObjectId = t.id " +
                //    " order by t.QKSeq";
                //System.Data.DataTable dt_qk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(qksql2);
                //if (dt_qk.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_qk.Rows.Count];
                //    var i = 0;
                //    foreach (DataRow dr in dt_qk.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("QKMainTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[i]["QKSeq"] = dr["QKSeq"].ToString();
                //        bizObjects[i]["QKAmount"] = dr["Amount"].ToString();
                //        bizObjects[i]["QKTotalAmount"] = dr["ConvertAmount"].ToString().Replace("人民币","").Equals("0.00")?"": dr["ConvertAmount"].ToString();
                //        bizObjects[i]["QKTarget"] = dr["QKTarget"].ToString();
                        
                //        bizObjects[i]["SeqCnt"] = dr["SeqCnt"].ToString();
                //        var ActivityCode = "";
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), this.ActionContext.User.UserID);
                //        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                //        ActivityCode = workItemDic["ActivityCode"];
                //        var Mode = workItemDic["Mode"];
                //        string st = "";
                //        if (dr["Status"].ToString().Equals("4"))
                //        {
                //            st = "审批完成";
                //        }
                //        else if (dr["Status"].ToString().Equals("2"))
                //        {
                //            if (dr["RejectFlg"].ToString().Equals("1"))
                //            {
                //                st = "驳回";
                //            }
                //            else
                //            {
                //                if(ActivityCode.Equals("ActivityOrig"))
                //                {
                //                    st = "草稿";
                //                } else
                //                {
                //                    st = "申请中";
                //                }
                //            }
                //        }
                //        if(Mode.Equals("Work"))
                //        {
                //            st += " ";
                //        }
                //        bizObjects[i]["Status"] = st;
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        i++;
                //    }
                //    this.ActionContext.InstanceData["QKMainTbl"].Value = bizObjects;
                //}
                //// 获取到款记录
                //var dksql = " select (select top 1 dk.QKTargetCode from I_DKTbl dk where d.ObjectID = dk.ParentObjectID) QKTarget,  " +
                //    " CONVERT(varchar(12),d.DKDate,111) DKDate," +
                //    " convert(varchar(20),convert(decimal(18,2),d.DKAmount))+e1.EnumValue DKTotalAmount," +
                //    " d.RejectFlg," +
                //    " ic.ObjectID IcObjectID, " +
                //    " ic.State Status," +
                //    " case ic.State " +
                //    "	when '2' THEN" +
                //    "		case d.RejectFlg " +
                //    "			when '1' then '驳回'" +
                //    "			else '确认中'" +
                //    "		END" +
                //    "	when '4' then '已确认'" +
                //    " end DisplayName" +
                //    " from I_DK d" +
                //    " INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectId" +
                //    " INNER JOIN OT_EnumerableMetadata e1 ON d.DKCurrency = e1.Code AND e1.Category = '币种'" +
                //    " and d.ContractNo = '" + ContractNo + "'  " +
                //    " order by d.ModifiedTime ";
                //System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dksql);
                //if (dt_dk.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_dk.Rows.Count];
                //    var i = 0;
                //    foreach (DataRow dr in dt_dk.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("DKRecordTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[i]["QKTarget"] = dr["QKTarget"].ToString();
                //        if(dr["Status"].ToString().Equals("4"))
                //        {
                //            bizObjects[i]["DKDate"] = dr["DKDate"].ToString();
                //        }
                //        bizObjects[i]["DKTotalAmount"] = dr["DKTotalAmount"].ToString();

                //        bizObjects[i]["DisplayName"] = dr["DisplayName"].ToString();
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), this.ActionContext.User.UserID);
                //        foreach (var item in workItemDic)
                //        {
                //            Console.WriteLine(item.Key + item.Value);
                //            if (item.Key.Equals("workItemId"))
                //            {
                //                bizObjects[i]["WorkItemId"] = item.Value;
                //            }
                //        }
                //        var st = dr["Status"].ToString();
                //        if (workItemDic["Mode"].Equals("Work"))
                //        {
                //            st += " ";
                //        }
                //        bizObjects[i]["Status"] = st;
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        i++;
                //    }
                //    this.ActionContext.InstanceData["DKRecordTbl"].Value = bizObjects;
                //}

                //// 获取到款状态
                //var dkst_sql = " select d.ContractNo,dk.QKSeqHidden, " +
                //    " Min(ic.State) Status" +
                //    " from I_DK d" +
                //    " INNER JOIN I_DKTbl dk on dk.ParentObjectID = d.ObjectID " +
                //    " INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectId" +
                //    " and d.ContractNo = '" + ContractNo + "' and dk.CurDKAmount > 0 " +
                //    " group by d.ContractNo,dk.QKSeqHidden";
                //System.Data.DataTable dt_dkst2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dkst_sql);
                //Dictionary<string, string> dkst_dic = new Dictionary<string, string>();
                //if (dt_dkst2.Rows.Count > 0)
                //{
                //    var i = 0;
                //    foreach (DataRow dr in dt_dkst2.Rows)
                //    {
                //        dkst_dic.Add(dr["QKSeqHidden"].ToString(), dr["Status"].ToString());
                //        i++;
                //    }
                //}
                //var dkst_sql2 = " select t1.*,t2.cnt SeqCnt,convert(varchar(20),convert(decimal(18,2),t3.ConvertAmountSum))+'人民币' QKConvertAmount from ( " +
                //                " SELECT " +
                //                " 	qk.QKSeq QKSeq, " +
                //                "   tbl.ParentIndex, " +
                //                " 	qk.QKTarget, " +
                //                " 	e2.EnumValue ZJKX, " +
                //                " 	tbl.ZJMS, " +
                //                " 	tbl.Amount QKAmount, " +
                //                "   tbl.Currency QKCurrencyCode, " +
                //                "   tbl.LJDKAmount LJDKAmount, " +
                //                "   tbl.LJDKAmountWB LJDKAmountWB, " +
                //                "   tbl.DKStatus Status, " +
                //                " 	e1.EnumValue QKCurrency " +
                //                " FROM " +
                //                " 	I_QK qk " +
                //                " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID " +
                //                " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4' and qk.ContractNo = '" + ContractNo + "'" +
                //                " LEFT JOIN OT_EnumerableMetadata e1 ON tbl.Currency = e1.Code AND e1.Category = '币种' " +
                //                " LEFT JOIN OT_EnumerableMetadata e2 ON tbl.ZJKX = e2.Code AND e2.Category = '资金款项' " +
                //                " LEFT JOIN OT_EnumerableMetadata e3 ON tbl.QKType = e3.Code AND e3.Category = '请款类型' " +
                //                " ) t1, " +
                //                " (select QKSeq,count(1) cnt FROM " +
                //                " 	I_QK qk " +
                //                " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID " +
                //                " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4' " +
                //                " and qk.ContractNo = '" + ContractNo + "' " +
                //                " group by qk.QKSeq " +
                //                " ) t2, " +
                //                " (select QKSeq,sum(tbl.ConvertAmount) ConvertAmountSum FROM " +
                //                " 	I_QK qk " +
                //                " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID " +
                //                " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4' " +
                //                " and qk.ContractNo = '" + ContractNo + "' " +
                //                " group by qk.QKSeq " +
                //                " ) t3 " +
                //                " where t1.QKSeq = t2.QKSeq and t1.QKSeq = t3.QKSeq " +
                //                " order BY t1.QKSeq,t1.ParentIndex ";
                //System.Data.DataTable dt_dk2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dkst_sql2);
                //if (dt_dk2.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_dk2.Rows.Count];
                //    var i = 0;
                //    //var QKSeq = "";
                //    //var SeqCnt = 0;
                //    //var LJDKAmount = "";
                //    foreach (DataRow dr in dt_dk2.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("DKStatusTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        // 累计到款
                //        // 进行累加
                //        //if (QKSeq == "" || QKSeq.Equals(dr["QKSeq"].ToString()))
                //        //{
                //        //    var lj = (double)Convert.ToSingle(dr["LJDKAmount"].ToString());
                //        //    var cu = dr["QKCurrency"].ToString();
                //        //    LJDKAmount = Common.getLJDK(LJDKAmount, lj, cu);
                //        //}
                //        //// 赋值
                //        //else
                //        //{
                //        //    for (var j = 0; j < SeqCnt; j++)
                //        //    {
                //        //        bizObjects[i - j - 1]["LJDKTotalAmount"] = LJDKAmount;
                //        //    }
                //        //    LJDKAmount = "";
                //        //}

                //        bizObjects[i]["QKSeq"] = dr["QKSeq"].ToString();
                //        bizObjects[i]["SeqCnt"] = dr["SeqCnt"].ToString();
                //        bizObjects[i]["ZJKX"] = dr["ZJKX"].ToString();
                //        bizObjects[i]["ZJMS"] = dr["ZJMS"].ToString();
                //        bizObjects[i]["QKAmount"] = dr["QKAmount"].ToString();
                //        bizObjects[i]["QKCurrency"] = dr["QKCurrency"].ToString();
                //        bizObjects[i]["QKConvertAmount"] = dr["QKConvertAmount"].ToString().Replace("人民币", "").Equals("0.00") ? "" : dr["QKConvertAmount"].ToString();
                //        bizObjects[i]["QKTarget"] = dr["QKTarget"].ToString();

                //        var LJDKTotalAmount = "";
                //        if (dr["LJDKAmount"].ToString() != "" && Convert.ToDouble(dr["LJDKAmount"].ToString()) != 0)
                //        {
                //            LJDKTotalAmount += dr["LJDKAmount"].ToString() + "人民币 ";
                //        }
                //        if (dr["LJDKAmountWB"].ToString() != "" && Convert.ToDouble(dr["LJDKAmountWB"].ToString()) != 0)
                //        {
                //            LJDKTotalAmount += dr["LJDKAmountWB"].ToString() + Common.getDicValue("币种", con.Currency);
                //        }
                //        bizObjects[i]["LJDKTotalAmount"] = LJDKTotalAmount;
                //        var st = dr["Status"].ToString() == "" ? "未到款" : dr["Status"].ToString();
                //        st += getStatus(dkst_dic, dr["QKSeq"].ToString());
                //        bizObjects[i]["DisplayName"] = st;

                //        //QKSeq = dr["QKSeq"].ToString();
                //        //SeqCnt = (int)Convert.ToSingle(dr["SeqCnt"]);

                //        //
                //        //bizObjects[i]["DisplayName"] = dr["DisplayName"].ToString();
                //        i++;
                //    }
                //    //for (var j = 0; j < SeqCnt; j++)
                //    //{
                //    //    bizObjects[dt_dk2.Rows.Count - j - 1]["LJDKTotalAmount"] = LJDKAmount;
                //    //}
                //    this.ActionContext.InstanceData["DKStatusTbl"].Value = bizObjects;
                //}

                //// 获取付款记录
                //var fksql =
                //    " select t1.ObjectID,t1.ZKMS,convert(varchar(20),convert(decimal(18,2),t1.Amount)) as Amount,convert(varchar(20),convert(decimal(18,2),t1.OutTaxAmount)) as OutTaxAmount," +
                //    "t1.Currency,e1.EnumValue CurrencyName, " +
                //    " CONVERT(varchar(12),t1.FKDate,111) FKDate,t1.ConvertAmount, " +
                //    " convert(varchar(20),convert(decimal(18,2),t2.AmountSum))+e1.EnumValue as AmountSum,t2.Cnt, t1.Content,ISNULL(e2.EnumValue, '信用证') PayType," +
                //    " t1.Receiver,t1.OtherReceiver,t1.State Status,t1.IcObjectID,t1.RejectFlg,t1.ZFOperate " +
                //    " from  " +
                //    " ( " +
                //    " 	SELECT f.ObjectID,ft.ZKMS,ft.Amount,ft.OutTaxAmount,f.Currency,f.FKDate,f.ConvertAmount,f.ModifiedTime ,ft.ParentIndex,f.Content,f.PayType,f.Receiver,f.OtherReceiver, " +
                //    " 	ic.State,ic.ObjectID IcObjectID,f.RejectFlg ,f.ZFOperate" +
                //    " 	FROM I_FK f " +
                //    " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID " +
                //    " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID " +
                //    " 	and f.ContractNo = '" + ContractNo + "' and (f.ZFOperate = '' or f.ZFOperate = 'ZFOperate_ZF')" +
                //    " ) t1 INNER JOIN  " +
                //    " ( " +
                //    " 	SELECT f.ObjectID,sum(ft.Amount) AmountSum,count(ft.ObjectID) Cnt " +
                //    " 	FROM I_FK f " +
                //    " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID " +
                //    " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID " +
                //    " 	and f.ContractNo = '" + ContractNo + "' and (f.ZFOperate = '' or f.ZFOperate = 'ZFOperate_ZF')" +
                //    " 	GROUP BY f.ObjectID " +
                //    " ) t2 on t1.ObjectID = t2.ObjectID " +
                //    " LEFT JOIN OT_EnumerableMetadata e1 on t1.Currency = e1.Code and e1.Category = '币种' " +
                //    " LEFT JOIN OT_EnumerableMetadata e2 on t1.PayType = e2.Code and e2.Category = '支付方式' " +
                //    " order by ModifiedTime ,ObjectID,ParentIndex ";
                //;// 获取拒付付款记录
                //var fk_jfsql =
                //    " select t1.ObjectID,t1.ZKMS,convert(varchar(20),convert(decimal(18,2),t1.Amount))+e1.EnumValue as Amount,t1.Currency,e1.EnumValue CurrencyName, " +
                //    " CONVERT(varchar(12),t1.FKDate,111) FKDate,t1.ConvertAmount, " +
                //    " cast(t2.AmountSum as varchar)+e1.EnumValue as AmountSum,t2.Cnt, t1.Content,ISNULL(e2.EnumValue, '信用证') PayType," +
                //    " t1.Receiver,t1.OtherReceiver,t1.State Status,t1.IcObjectID,t1.RejectFlg,t1.ZFOperate " +
                //    " from  " +
                //    " ( " +
                //    " 	SELECT f.ObjectID,ft.ZKMS,ft.Amount,f.Currency,f.FKDate,f.ConvertAmount,f.ModifiedTime ,ft.ParentIndex,f.Content,f.PayType,f.Receiver,f.OtherReceiver, " +
                //    " 	ic.State,ic.ObjectID IcObjectID,f.RejectFlg ,f.ZFOperate" +
                //    " 	FROM I_FK f " +
                //    " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID " +
                //    " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID " +
                //    " 	and f.ContractNo = '" + ContractNo + "' and (f.ZFOperate = 'ZFOperate_JF')" +
                //    " ) t1 INNER JOIN  " +
                //    " ( " +
                //    " 	SELECT f.ObjectID,sum(ft.Amount) AmountSum,count(ft.ObjectID) Cnt " +
                //    " 	FROM I_FK f " +
                //    " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID " +
                //    " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID " +
                //    " 	and f.ContractNo = '" + ContractNo + "' and ( f.ZFOperate = 'ZFOperate_JF')" +
                //    " 	GROUP BY f.ObjectID " +
                //    " ) t2 on t1.ObjectID = t2.ObjectID " +
                //    " LEFT JOIN OT_EnumerableMetadata e1 on t1.Currency = e1.Code and e1.Category = '币种' " +
                //    " LEFT JOIN OT_EnumerableMetadata e2 on t1.PayType = e2.Code and e2.Category = '支付方式' " +
                //    " order by ModifiedTime ,ObjectID,ParentIndex ";
                //System.Data.DataTable dt_fk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(fksql);
                //System.Data.DataTable dt_fk_jf = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(fk_jfsql);
                //if (dt_fk.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_fk.Rows.Count];
                //    var i = 0;
                //    var TheNo = 0;
                //    var ObjectIDBak = "";
                //    foreach (DataRow dr in dt_fk.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("FKRecordTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        if (!ObjectIDBak.Equals(dr["ObjectID"].ToString()))
                //        {
                //            TheNo++;
                //        }
                //        ObjectIDBak = dr["ObjectID"].ToString();
                //        bizObjects[i]["TheNo"] = TheNo;
                //        bizObjects[i]["ZKMS"] = dr["ZKMS"].ToString();
                //        string Amount = "";
                //        if (dr["OutTaxAmount"].ToString().Equals("0.00"))
                //        {
                //            Amount = dr["Amount"].ToString() + dr["CurrencyName"].ToString();
                //        } else
                //        {
                //            Amount = dr["Amount"].ToString() + dr["CurrencyName"].ToString() + " \n代扣外税：" + dr["OutTaxAmount"].ToString() + dr["CurrencyName"].ToString();
                //        }
                //        bizObjects[i]["Amount"] = Amount;
                //        // 如果是人民币，直接拿人民币合计作为折算金额
                //        if(dr["Currency"].ToString().Equals("RMB"))
                //        {
                //            bizObjects[i]["ConvertAmount"] = dr["AmountSum"].ToString();
                //        } else
                //        {
                //            // 如果有折算金额，则取之，不然就是没有折算金额
                //            var ConvertAmount = Convert.ToDouble(dr["ConvertAmount"]);
                //            if(ConvertAmount > 0)
                //            {
                //                bizObjects[i]["ConvertAmount"] = dr["ConvertAmount"].ToString()+"人民币";
                //            } 
                            
                //        }

                //        bizObjects[i]["Content"] = dr["Content"].ToString();
                //        bizObjects[i]["PayType"] = dr["PayType"].ToString();
                //        bizObjects[i]["Receiver"] = dr["Receiver"].ToString().Equals("其他")? dr["OtherReceiver"].ToString(): dr["Receiver"].ToString();

                //        bizObjects[i]["Cnt"] = dr["Cnt"].ToString();
                //        var ActivityCode = "";
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), this.ActionContext.User.UserID);
                //        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                //        ActivityCode = workItemDic["ActivityCode"];
                //        var Mode = workItemDic["Mode"];
                //        string st = "";
                //        if (dr["Status"].ToString().Equals("4"))
                //        {
                //            st = "已付";
                //            bizObjects[i]["FKDate"] = dr["FKDate"].ToString();
                //        }
                //        else if (dr["Status"].ToString().Equals("2"))
                //        {
                //            if (dr["RejectFlg"].ToString().Equals("1"))
                //            {
                //                st = "驳回";
                //            }
                //            else
                //            {
                //                if (ActivityCode.Equals("ActivityOrig"))
                //                {
                //                    st = "草稿";
                //                }
                //                else if (ActivityCode.Equals("ActivityConfirm"))
                //                {
                //                    st = "确认中";
                //                }
                //                else
                //                {
                //                    st = "申请中";
                //                }

                //            }
                //        }
                //        if (Mode.Equals("Work"))
                //        {
                //            st += " ";
                //        }
                //        bizObjects[i]["DisplayName"] = st;
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        i++;
                //    }
                //    this.ActionContext.InstanceData["FKRecordTbl"].Value = bizObjects;
                //}

                //if (dt_fk_jf.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_fk_jf.Rows.Count];
                //    var i = 0;
                //    var TheNo = 0;
                //    var ObjectIDBak = "";
                //    foreach (DataRow dr in dt_fk_jf.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("FKJFRecordTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        if (!ObjectIDBak.Equals(dr["ObjectID"].ToString()))
                //        {
                //            TheNo++;
                //        }
                //        ObjectIDBak = dr["ObjectID"].ToString();
                //        bizObjects[i]["TheNo"] = TheNo;
                //        bizObjects[i]["ZKMS"] = dr["ZKMS"].ToString();
                //        bizObjects[i]["Amount"] = dr["Amount"].ToString();
                //        // 如果是人民币，直接拿人民币合计作为折算金额
                //        if (dr["Currency"].ToString().Equals("RMB"))
                //        {
                //            bizObjects[i]["ConvertAmount"] = dr["AmountSum"].ToString();
                //        }
                //        else
                //        {
                //            // 如果有折算金额，则取之，不然就是没有折算金额
                //            var ConvertAmount = Convert.ToDouble(dr["ConvertAmount"]);
                //            if (ConvertAmount > 0)
                //            {
                //                bizObjects[i]["ConvertAmount"] = dr["ConvertAmount"].ToString() + "人民币";
                //            }

                //        }

                //        bizObjects[i]["Content"] = dr["Content"].ToString();
                //        bizObjects[i]["PayType"] = dr["PayType"].ToString();
                //        bizObjects[i]["Receiver"] = dr["Receiver"].ToString().Equals("其他") ? dr["OtherReceiver"].ToString() : dr["Receiver"].ToString();

                //        bizObjects[i]["Cnt"] = dr["Cnt"].ToString();
                //        var ActivityCode = "";
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), this.ActionContext.User.UserID);
                //        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                //        ActivityCode = workItemDic["ActivityCode"];
                //        var Mode = workItemDic["Mode"];
                //        string st = "";
                //        if (dr["Status"].ToString().Equals("4"))
                //        {
                //            st = "已拒付";
                //        }
                //        else if (dr["Status"].ToString().Equals("2"))
                //        {
                //            if (dr["RejectFlg"].ToString().Equals("1"))
                //            {
                //                st = "驳回";
                //            }
                //            else
                //            {
                //                if (ActivityCode.Equals("ActivityOrig"))
                //                {
                //                    st = "草稿";
                //                }
                //                else
                //                {
                //                    st = "申请中";
                //                }

                //            }
                //        }
                //        if (Mode.Equals("Work"))
                //        {
                //            st += " ";
                //        }
                //        bizObjects[i]["DisplayName"] = st;
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        i++;
                //    }
                //    this.ActionContext.InstanceData["FKJFRecordTbl"].Value = bizObjects;
                //}

                //// 获取结算中的付款记录
                //// 获取已经进行过结算处理的数据
                //var jfksql_ok = " select dj.FKObjectID,Max(ic.State) Status  " +
                //           " from I_JS j  " +
                //           " INNER JOIN I_FKTblOfJS dj on dj.ParentObjectID = j.ObjectID  " +
                //           " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId " +
                //           " and j.ContractNo = '" + ContractNo + "'  and dj.IsCheck = '是;'" +
                //           " group by dj.FKObjectID ";
                //System.Data.DataTable dt_fkj_ok = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jfksql_ok);
                //Dictionary<string, string> dic_fkj_ok = new Dictionary<string, string>();
                //if (dt_fkj_ok.Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dt_fkj_ok.Rows)
                //    {
                //        dic_fkj_ok.Add(dr["FKObjectID"].ToString(), dr["Status"].ToString());
                //    }
                //}
                //var jfksql = " select t1.ObjectID,t1.ZKMS,e3.EnumValue ZKType,convert(varchar(20),convert(decimal(18,2),t1.Amount)) as Amount,convert(varchar(20),convert(decimal(18,2),t1.OutTaxAmount)) as OutTaxAmount," +
                //                " t1.Currency,e1.EnumValue CurrencyName, " +
                //                " CONVERT(varchar(12),t1.FKDate,111) FKDate,t1.ConvertAmount, " +
                //                " convert(varchar(20),convert(decimal(18,2),t2.AmountSum))+e1.EnumValue as AmountSum,t2.Cnt, t1.Content,e2.EnumValue PayType,t1.Receiver,t1.State Status,t1.IcObjectID,t1.RejectFlg " +
                //                " from  " +
                //                " ( " +
                //                " 	SELECT f.ObjectID,ft.ZKMS,ft.Amount,ft.OutTaxAmount,f.Currency,f.ZKType,f.FKDate,f.ConvertAmount,f.ModifiedTime ,ft.ParentIndex,f.Content,f.PayType,f.Receiver, " +
                //                " 	ic.State,ic.ObjectID IcObjectID,f.RejectFlg " +
                //                " 	FROM I_FK f " +
                //                " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID and (f.ZFOperate = '' or f.ZFOperate = 'ZFOperate_ZF')" +
                //                " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID and ic.State='4' " +
                //                " 	and f.ContractNo = '" + ContractNo + "' " +
                //                " ) t1 INNER JOIN  " +
                //                " ( " +
                //                " 	SELECT f.ObjectID,sum(ft.Amount) AmountSum,count(ft.ObjectID) Cnt " +
                //                " 	FROM I_FK f " +
                //                " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID and (f.ZFOperate = '' or f.ZFOperate = 'ZFOperate_ZF')" +
                //                " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID and ic.State='4' " +
                //                " 	and f.ContractNo = '" + ContractNo + "' " +
                //                " 	GROUP BY f.ObjectID " +
                //                " ) t2 on t1.ObjectID = t2.ObjectID " +
                //                " LEFT JOIN OT_EnumerableMetadata e1 on t1.Currency = e1.Code and e1.Category = '币种' " +
                //                " LEFT JOIN OT_EnumerableMetadata e2 on t1.PayType = e2.Code and e2.Category = '支付方式' " +
                //                " LEFT JOIN OT_EnumerableMetadata e3 on t1.ZKType = e3.Code and e3.Category = '付款类型' " +
                //                " order by ModifiedTime ,ObjectID,ParentIndex ";
                //System.Data.DataTable dt_jfk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jfksql);
                //if (dt_jfk.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_jfk.Rows.Count];
                //    var i = 0;
                //    var ObjectIDBak = "";
                //    var TheNo = 0;
                //    foreach (DataRow dr in dt_jfk.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("FKRecordTblOfJS").ChildSchema;
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        // 第一行
                //        if (!ObjectIDBak.Equals(dr["ObjectID"].ToString()))
                //        {
                //            TheNo++;
                //        }
                //        ObjectIDBak = dr["ObjectID"].ToString();
                //        bizObjects[i]["TheNo"] = TheNo;
                //        bizObjects[i]["Receiver"] = dr["Receiver"].ToString();
                //        bizObjects[i]["ZKMS"] = dr["ZKMS"].ToString();
                //        string Amount = "";
                //        if (dr["OutTaxAmount"].ToString().Equals("0.00"))
                //        {
                //            Amount = dr["Amount"].ToString() + dr["CurrencyName"].ToString();
                //        }
                //        else
                //        {
                //            Amount = dr["Amount"].ToString() + dr["CurrencyName"].ToString() + " \n代扣外税：" + dr["OutTaxAmount"].ToString() + dr["CurrencyName"].ToString();
                //        }
                //        bizObjects[i]["Amount"] = Amount;
                //        // 如果是人民币，直接拿人民币合计作为折算金额
                //        if (dr["Currency"].ToString().Equals("RMB"))
                //        {
                //            bizObjects[i]["ConvertAmount"] = dr["AmountSum"].ToString();
                //        }
                //        else
                //        {
                //            // 如果有折算金额，则取之，不然就是没有折算金额
                //            var ConvertAmount = Convert.ToDouble(dr["ConvertAmount"]);
                //            if (ConvertAmount > 0)
                //            {
                //                bizObjects[i]["ConvertAmount"] = dr["ConvertAmount"].ToString() + "人民币";
                //            }

                //        }
                //        bizObjects[i]["Content"] = dr["Content"].ToString();
                        
                //        bizObjects[i]["Cnt"] = dr["Cnt"].ToString();
                //        // 根据到款ID获取对应的到款结算状态
                //        if (dr["ZKType"].ToString().Equals("结算付款"))
                //        {
                //            bizObjects[i]["Status"] = "不必结算";
                //        }
                //        else
                //        {
                //            bizObjects[i]["Status"] = getStatusOfDKJ(dic_fkj_ok, dr["ObjectID"].ToString());
                //        }

                //        i++;
                //    }
                //    this.ActionContext.InstanceData["FKRecordTblOfJS"].Value = bizObjects;
                //}

                //// 获取结算中的到款记录
                //// 获取已经进行过结算处理的数据
                //var jdksql_ok = " select dj.DKObjectID,Max(ic.State) Status  " +
                //           " from I_JS j  " +
                //           " INNER JOIN I_DKTblOfJS dj on dj.ParentObjectID = j.ObjectID  " +
                //           " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId " +
                //           " and j.ContractNo = '" + ContractNo + "'  and dj.IsCheck = '是;'" +
                //           " group by dj.DKObjectID ";
                //System.Data.DataTable dt_dkj_ok = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jdksql_ok);
                //Dictionary<string, string> dic_dkj_ok = new Dictionary<string, string>();
                //if (dt_dkj_ok.Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dt_dkj_ok.Rows)
                //    {
                //        dic_dkj_ok.Add(dr["DKObjectID"].ToString(), dr["Status"].ToString());
                //    }
                //}
                //var jdksql = " select d.ObjectID, " +
                //                " (select top 1 dk.QKTargetCode from I_DKTbl dk where d.ObjectID = dk.ParentObjectID) QKTarget,  " +
                //                " e2.EnumValue DKType, " +
                //                " CONVERT(varchar(12),d.DKDate,111) DKDate, " +
                //                " convert(varchar(20),convert(decimal(18,2),d.DKAmount))+e1.EnumValue DKTotalAmount " +
                //                " from I_DK d " +
                //                " INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectId " +
                //                " INNER JOIN OT_EnumerableMetadata e1 ON d.DKCurrency = e1.Code AND e1.Category = '币种' " +
                //                " INNER JOIN OT_EnumerableMetadata e2 ON d.DKType = e2.Code AND e2.Category = '到款类型' " +
                //                " and d.ContractNo = '" + ContractNo + "'  and d.DKAmount > 0 and ic.State = '4' " +
                //                " order by d.ModifiedTime  ";
                //System.Data.DataTable dt_jdk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jdksql);
                //if (dt_jdk.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_jdk.Rows.Count];
                //    var i = 0;
                //    foreach (DataRow dr in dt_jdk.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("DKRecordTblOfJS").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[i]["QKTarget"] = dr["QKTarget"].ToString();
                //        bizObjects[i]["DKType"] = dr["DKType"].ToString();
                //        bizObjects[i]["DKDate"] = dr["DKDate"].ToString();
                //        bizObjects[i]["DKTotalAmount"] = dr["DKTotalAmount"].ToString();
                //        // 根据到款ID获取对应的到款结算状态
                //        if (dr["DKType"].ToString().Equals("结算到款"))
                //        {
                //            bizObjects[i]["Status"] = "不必结算";
                //        }
                //        else
                //        {
                //            bizObjects[i]["Status"] = getStatusOfDKJ(dic_dkj_ok, dr["ObjectID"].ToString());
                //        }

                //        i++;
                //    }
                //    this.ActionContext.InstanceData["DKRecordTblOfJS"].Value = bizObjects;
                //}

                //// 获取结算记录
                //// 获取已经进行过结算处理的数据
                //var jssql = " select j.ObjectID JSObjectID,  " +
                //            " convert(varchar(20),convert(decimal(18,2),j.LJDKAmountRMB))+j.CurrencyRMB LJDKAmountRMB,  " +
                //            " convert(varchar(20),convert(decimal(18,2),j.LJFKAmountRMB))+j.CurrencyRMB LJFKAmountRMB, " +
                //            " convert(varchar(20),convert(decimal(18,2),j.BankFY))+j.CurrencyRMB BankFY, " +
                //            " convert(varchar(20),convert(decimal(18,2),j.AgencyFY))+j.CurrencyRMB + '\n(' + convert(varchar(20),convert(decimal(18,2),j.AgencyFYWB))+j.CurrencyWB + ')' AgencyFY, " +
                //            " convert(varchar(20),convert(decimal(18,2),j.OtherFY))+j.CurrencyRMB OtherFY, " +
                //            " j.JSResult JSResultNum, " +
                //            " j.JSStatus+CONVERT(VARCHAR,j.JSResult)+j.CurrencyRMB JSResult, " +
                //            " j.JSStatus, " +
                //            " j.CurrencyRMB, " +
                //            " j.CurrencyWB,  " +
                //            " j.ModifiedTime, " +
                //            " ic.ObjectID IcObjectId ,ic.State Status ,j.RejectFlg RejectFlg ,j.QK_FK_Status QK_FK_Status  " +
                //            " from I_JS j " +
                //            " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId  " +
                //            " and j.ContractNo = '" + ContractNo + "' " +
                //            " order BY j.ModifiedTime ";
                //System.Data.DataTable dt_js = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jssql);
                //if (dt_js.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_js.Rows.Count];
                //    var i = 0;
                //    foreach (DataRow dr in dt_js.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("JSRecordTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[i]["LJDKAmountRMB"] = dr["LJDKAmountRMB"].ToString();
                //        bizObjects[i]["LJFKAmountRMB"] = dr["LJFKAmountRMB"].ToString();
                //        bizObjects[i]["BankFY"] = dr["BankFY"].ToString();
                //        bizObjects[i]["AgencyFY"] = dr["AgencyFY"].ToString();
                //        bizObjects[i]["OtherFY"] = dr["OtherFY"].ToString();
                //        bizObjects[i]["JSResult"] = dr["JSResult"].ToString();
                //        bizObjects[i]["JSResultNum"] = dr["JSResultNum"].ToString();
                //        var ActivityCode = "";
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), this.ActionContext.User.UserID);
                //        foreach (var item in workItemDic)
                //        {
                //            Console.WriteLine(item.Key + item.Value);
                //            if (item.Key.Equals("workItemId"))
                //            {
                //                bizObjects[i]["WorkItemId"] = item.Value;
                //            }
                //            else if (item.Key.Equals("ActivityCode"))
                //            {
                //                ActivityCode = item.Value;
                //            }
                //        }
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        bizObjects[i]["JSObjectID"] = dr["JSObjectID"].ToString();
                //        bizObjects[i]["Status"] = dr["QK_FK_Status"].ToString();
                //        // 根据到款ID获取对应的到款结算状态
                //        if (dr["Status"].ToString().Equals("2"))
                //        {
                //            if(ActivityCode == "ActivityOrig")
                //            {
                //                bizObjects[i]["DisplayName"] = "草稿";
                //            } else
                //            {
                //                bizObjects[i]["DisplayName"] = "申请中";
                //            }
                //        }
                //        else
                //        {
                //            if (dr["RejectFlg"].ToString() == "1")
                //            {
                //                bizObjects[i]["DisplayName"] = "驳回";
                //            }
                //            else
                //            {
                //                var JSResultNum = Convert.ToDouble(dr["JSResultNum"]);
                //                if (JSResultNum == 0)
                //                {
                //                    bizObjects[i]["DisplayName"] = "结算完成";
                //                }
                //                else
                //                {
                //                    // 请付款状态一览：
                //                    // QK_Start:请款开始、QK_OK:请款成功、QK_DK_OK:请款且到款成功、FK_Start:付款开始、FK_OK:付款成功、
                //                    // BatchQK_Start:批量请款开始、BatchDK_OK:批量到款成功
                //                    // BatchFK_Start:批量付款开始、BatchFK_OK:批量付款成功
                //                    // BatchJQ_Start:批量结清开始、BatchJQ_OK:批量结清成功
                //                    if (dr["QK_FK_Status"].ToString() == "QK_DK_OK" || dr["QK_FK_Status"].ToString() == "FK_OK")
                //                    {
                //                        bizObjects[i]["DisplayName"] = "结算完成";
                //                    } else if (dr["QK_FK_Status"].ToString() == "BatchQK_Start"
                //                         || dr["QK_FK_Status"].ToString() == "BatchFK_Start"
                //                         || dr["QK_FK_Status"].ToString() == "BatchJQ_Start")
                //                    {
                //                        bizObjects[i]["DisplayName"] = "批量结算中";
                //                    }
                //                    else if (dr["QK_FK_Status"].ToString() == "BatchDK_OK"
                //                        || dr["QK_FK_Status"].ToString() == "BatchFK_OK"
                //                        || dr["QK_FK_Status"].ToString() == "BatchJQ_OK")
                //                    {
                //                        bizObjects[i]["DisplayName"] = "批量结算完成";
                //                    }
                //                    else
                //                    {
                //                        if (dr["JSStatus"].ToString() == "应收")
                //                        {
                //                            bizObjects[i]["DisplayName"] = "待请款";
                //                        }
                //                        else if (dr["JSStatus"].ToString() == "应退")
                //                        {
                //                            bizObjects[i]["DisplayName"] = "待付款";
                //                        }
                //                    }
                //                }
                //            }  
                //        }

                //        i++;
                //    }
                //    this.ActionContext.InstanceData["JSRecordTbl"].Value = bizObjects;
                //}


                // 获取信用证子流程的版本号
                int versionPayment = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("PaymentSub");
                this.ActionContext.InstanceData["WorkflowVersion_Payment"].Value = versionPayment;
                // 获取信用证改证子流程的版本号
                int versionPaymentUpdate = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("PaymentUpdateSub");
                this.ActionContext.InstanceData["WorkflowVersion_PaymentUpdate"].Value = versionPaymentUpdate;
                // 获取进口许可证子流程的版本号
                int versionImportLicense = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("ImportLicenseSub");
                this.ActionContext.InstanceData["WorkflowVersion_ImportLicense"].Value = versionImportLicense;
                // 获取到货（非航油）子流程的版本号
                int versionDH = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("DH");
                this.ActionContext.InstanceData["WorkflowVersion_DH"].Value = versionDH;
                // 获取到货（航油）子流程的版本号
                int versionDHHY = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("DHHY");
                this.ActionContext.InstanceData["WorkflowVersion_DHHY"].Value = versionDHHY;
                // 获取合同变更子流程的版本号
                int versionBG = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("BG");
                this.ActionContext.InstanceData["WorkflowVersion_BG"].Value = versionBG;
                // 获取保函子流程的版本号
                int versionBH = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("BH");
                this.ActionContext.InstanceData["WorkflowVersion_BH"].Value = versionBH;
                int versionBHInput = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("BHInput");
                this.ActionContext.InstanceData["WorkflowVersion_BHInput"].Value = versionBHInput;
                // 获取归档子流程的版本号
                int versionGD = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("GD");
                this.ActionContext.InstanceData["WorkflowVersion_GD"].Value = versionGD;
                // 获取归档子流程的版本号
                int versionGDChange = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("GDChange");
                this.ActionContext.InstanceData["WorkflowVersion_GDChange"].Value = versionGDChange;
                // 获取资金计划子流程的版本号
                int versionPlan = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("ZJPlan");
                this.ActionContext.InstanceData["WorkflowVersion_Plan"].Value = versionPlan;

                // 获取资金计划记录
                System.Data.DataTable dt_plan = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        " SELECT top 1 p.Remark ,ic.ObjectID icObjectId,p.ObjectID BizObjectId,ic.State " +
                        " FROM I_ZJPlan p, OT_InstanceContext ic " +
                        " where p.ObjectID = ic.BizObjectId and p.ContractNo = '" + ContractNo + "'");

                if (dt_plan.Rows.Count > 0)
                {
                    // 获取资金计划记录
                    System.Data.DataTable dt_planDetail = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                            " SELECT pt.Content,pt.QKCurrency, CONVERT(varchar(12),pt.ExpirationFrom,111) ExpirationFrom,CONVERT(varchar(12),pt.ExpirationTo,111) ExpirationTo,pt.IsAfterDK,pt.Amount " +
                            " FROM I_ZJPlan p, I_PlanTbl pt " +
                            " where p.ObjectID = pt.ParentObjectID " +
                            " and p.ObjectID = '"+ dt_plan.Rows[0]["BizObjectId"].ToString() + "' " +
                            " order by pt.parentIndex ");

                    BizObject[] bizObjects = new BizObject[dt_planDetail.Rows.Count];
                    var i = 0;
                    foreach (DataRow dr in dt_planDetail.Rows)
                    {
                        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("ZJPlanMainTbl").ChildSchema;
                        // 第一行
                        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                        bizObjects[i]["Content"] = dr["Content"].ToString();
                        bizObjects[i]["ExpirationFrom"] = dr["ExpirationFrom"].ToString();
                        bizObjects[i]["ExpirationTo"] = dr["ExpirationTo"].ToString();
                        bizObjects[i]["IsAfterDK"] = dr["IsAfterDK"].ToString();
                        bizObjects[i]["Amount"] = dr["Amount"].ToString();
                        bizObjects[i]["QKCurrency"] = dr["QKCurrency"].ToString();
                        i++;
                    }
                    this.ActionContext.InstanceData["ZJPlanMainTbl"].Value = bizObjects;
                    Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dt_plan.Rows[0]["icObjectId"].ToString(), dt_plan.Rows[0]["State"].ToString(), this.ActionContext.User.UserID);
                    this.ActionContext.InstanceData["PlanWorkItemId"].Value = workItemDic["workItemId"];
                    this.ActionContext.InstanceData["ZJPlanRemark"].Value = dt_plan.Rows[0]["Remark"].ToString();
                }
                else
                {
                    this.ActionContext.InstanceData["PlanWorkItemId"].Value = "";
                }

                //// 获取信用证记录
                //System.Data.DataTable dt_payment = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //        " select * from ( " +
                //        " SELECT p.BankName,convert(varchar(20),convert(decimal(18,2),p.PaymentAmount))+e1.EnumValue PaymentAmount,ic.State Status,p.CreatedTime,ic.ObjectID,p.ObjectID PaymentId, p.changePaymentFlg, p.RejectFlg " +
                //        " FROM I_PaymentSub p " +
                //        " INNER JOIN OT_InstanceContext ic on p.ObjectID = ic.BizObjectId and p.ContractNo = '" + ContractNo + "' and ic.State = '4' " +
                //        " LEFT JOIN OT_EnumerableMetadata e1 on p.Currency = e1.Code and e1.Category = '币种'  " +
                //        " Union All " +
                //        " SELECT p.BankName,CONVERT(VARCHAR,p.PaymentAmount)+e1.EnumValue PaymentAmount,ic.State Status,p.CreatedTime,ic.ObjectID,p.ObjectID PaymentId, p.changePaymentFlg, p.RejectFlg " +
                //        " FROM I_PaymentSub p " +
                //        " INNER JOIN OT_InstanceContext ic on p.ObjectID = ic.BizObjectId and p.ContractNo = '" + ContractNo + "' and ic.State = '2' " +
                //        " LEFT JOIN OT_EnumerableMetadata e1 on p.Currency = e1.Code and e1.Category = '币种'  " +
                //        " ) t ORDER BY t.CreatedTime ");

                //if (dt_payment.Rows.Count > 0)
                //{
                //    //BizObject[] bizObjects = new BizObject[dt_payment.Rows.Count];
                //    List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
                //    var i = 0;
                //    var TheNo = 0;
                //    foreach (DataRow dr in dt_payment.Rows)
                //    {
                //        //BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("PaymentTbl").ChildSchema;
                //        Dictionary<string, string> dic = new Dictionary<string, string>();
                //        // 第一行
                //        //bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        //bizObjects[i]["Bank"] = dr["BankName"].ToString();
                //        //bizObjects[i]["TotalAmount"] = dr["PaymentAmount"].ToString();
                //        //var st = dr["Status"].ToString();
                //        //bizObjects[i]["Status"] = dr["DisplayName"].ToString();
                //        //var workItemId = Common.getWorkItemId(dr["ObjectID"].ToString(), st);
                //        //bizObjects[i]["WorkItemId"] = workItemId;
                //        //bizObjects[i]["PaymentId"] = dr["PaymentId"].ToString();
                //        //bizObjects[i]["changePaymentFlg"] = dr["changePaymentFlg"].ToString();
                //        TheNo++;
                //        dic.Add("TheNo", TheNo.ToString());
                //        dic.Add("Bank", dr["BankName"].ToString());
                //        dic.Add("TotalAmount", dr["PaymentAmount"].ToString());
                //        var st = dr["Status"].ToString();
                        
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["ObjectID"].ToString(), st, this.ActionContext.User.UserID);
                //        dic.Add("WorkItemId", workItemDic["workItemId"]);
                //        dic.Add("Status", st.Equals("4")?"已开证":workItemDic["DisplayName"]);
                //        dic.Add("PaymentId", dr["PaymentId"].ToString());
                //        dic.Add("changePaymentFlg", dr["changePaymentFlg"].ToString());
                //        dic.Add("RejectFlg", dr["RejectFlg"].ToString());
                //        ls.Add(dic);
                //        i++;

                //        System.Data.DataTable dtu = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //            " SELECT p.BankName, " +
                //            " convert(varchar(20),convert(decimal(18,2),up.PaymentAmount))+e1.EnumValue as PaymentAmount, " +
                //            " ic.State Status, " +
                //            " case ic.State  " +
                //            " when '4' then '已开证'  " +
                //            " when '2' then  " +
                //            "  case up.RejectFlg  " +
                //            "  WHEN '1' THEN '驳回'  " +
                //            "  else '审批中'   " +
                //            "  end " +
                //            " end DisplayName,   " +
                //            " up.CreatedTime, " +
                //            " ic.ObjectID, " +
                //            " up.ObjectID PaymentId,  " +
                //            " up.RejectFlg,  " +
                //            " up.changePaymentFlg   " +
                //            " FROM I_PaymentUpdateSub up  " +
                //            " INNER JOIN OT_InstanceContext ic on up.ObjectID = ic.BizObjectId " +
                //            " INNER JOIN I_PaymentSub p on p.paymentNo = up.paymentno and p.ObjectID ='" + dr["PaymentId"].ToString() + "'  " +
                //            " LEFT JOIN OT_EnumerableMetadata e1 on p.Currency = e1.Code and e1.Category = '币种'  " +
                //            " order by CreatedTime  ");
                //        if (dtu.Rows.Count > 0)
                //        {
                //            foreach (DataRow dr2 in dtu.Rows)
                //            {
                //                Dictionary<string, string> dic2 = new Dictionary<string, string>();
                //                dic2.Add("TheNo", "");
                //                dic2.Add("Bank", dr2["BankName"].ToString());
                //                dic2.Add("TotalAmount", dr2["PaymentAmount"].ToString());
                //                var st2 = dr2["Status"].ToString();
                //                dic2.Add("Status", dr2["DisplayName"].ToString());
                //                Dictionary<string, string> workItemDic2 = Common.getWorkItemIdNew(dr2["ObjectID"].ToString(), st2, this.ActionContext.User.UserID);
                //                foreach (var item in workItemDic2)
                //                {
                //                    Console.WriteLine(item.Key + item.Value);
                //                    if (item.Key.Equals("workItemId"))
                //                    {
                //                        dic2.Add("WorkItemId", item.Value);
                //                    }
                //                }
                //                dic2.Add("PaymentId", dr2["PaymentId"].ToString());
                //                dic2.Add("changePaymentFlg", dr2["changePaymentFlg"].ToString());
                //                dic2.Add("RejectFlg", dr2["RejectFlg"].ToString());
                //                ls.Add(dic2);
                //                i++;
                //            }

                //        }
                //    }

                //    BizObject[] bizObjects = new BizObject[ls.Count];
                //    var j = 0;
                //    foreach (Dictionary<string, string> dic in ls)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("PaymentTbl").ChildSchema;
                //        bizObjects[j] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[j]["TheNo"] = dic["TheNo"].ToString();
                //        bizObjects[j]["Bank"] = dic["Bank"].ToString();
                //        bizObjects[j]["TotalAmount"] = dic["TotalAmount"].ToString();
                //        bizObjects[j]["Status"] = dic["Status"].ToString();
                //        bizObjects[j]["WorkItemId"] = dic["WorkItemId"].ToString();
                //        bizObjects[j]["PaymentId"] = dic["PaymentId"].ToString();
                //        bizObjects[j]["changePaymentFlg"] = dic["changePaymentFlg"].ToString();
                //        bizObjects[j]["RejectFlg"] = dic["RejectFlg"].ToString();
                //        j++;
                //    }
                //    this.ActionContext.InstanceData["PaymentTbl"].Value = bizObjects;
                //}

                //// 获取信用证付款状态记录
                //System.Data.DataTable dt_paymentst = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //        " SELECT p.ObjectID,p.BankName Bank,convert(varchar(20),convert(decimal(18,2),p.PaymentAmount)) as PaymentAmount,ISNULL(p.AfterChangeAmount, 0) AfterChangeAmount,e1.EnumValue Currency " +
                //        " FROM I_PaymentSub p" +
                //        " INNER JOIN OT_InstanceContext ic on p.ObjectID = ic.BizObjectId and p.ContractNo = '" + ContractNo + "' and ic.State = '4' " +
                //        " LEFT JOIN OT_EnumerableMetadata e1 on p.Currency = e1.Code and e1.Category = '币种' " +
                //        "  ORDER BY p.CreatedTime");

                //if (dt_paymentst.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_paymentst.Rows.Count];
                //    var i = 0;
                //    foreach (DataRow dr in dt_paymentst.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("PaymentFKStatus").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[i]["Bank"] = dr["Bank"].ToString();
                //        var Amount = "";
                //        if (Convert.ToDouble(dr["AfterChangeAmount"].ToString()) > 0)
                //        {
                //            Amount = dr["AfterChangeAmount"].ToString();
                //        } else
                //        {
                //            Amount = dr["PaymentAmount"].ToString();
                //        }
                //        System.Data.DataTable dt_paymentfk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //        " select ISNULL(SUM(CurZJAmount), 0) CurZJAmount " +
                //        " from I_FK f" +
                //        " INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectId and f.PayType = '" + dr["ObjectID"].ToString() + "' and ic.State = '4' ");
                //        var PayedAmount = "";
                //        if (dt_paymentfk.Rows.Count > 0)
                //        {
                //            PayedAmount = dt_paymentfk.Rows[0]["CurZJAmount"].ToString();
                //        }
                //        var RemainAmount = (Convert.ToDouble(Amount) - Convert.ToDouble(PayedAmount)).ToString();
                //        bizObjects[i]["Amount"] = Amount + dr["Currency"].ToString();
                //        bizObjects[i]["PayedAmount"] = PayedAmount + dr["Currency"].ToString();
                //        bizObjects[i]["RemainAmount"] = RemainAmount + dr["Currency"].ToString();
                //        i++;
                //    }
                //    this.ActionContext.InstanceData["PaymentFKStatus"].Value = bizObjects;
                //}


                //// 获取进口许可证记录
                //System.Data.DataTable dt_importlicense = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //        " SELECT p.GoodName,p.GoodCode,ic.State Status," +
                //        " case ic.State  " +
                //        "	when '2' then  " +
                //        "		case p.RejectFlg " +
                //        "			when '1' then '驳回' " +
                //        "			else " +
                //        "               case (select DisplayName from OT_WorkItem wi where wi.InstanceId = ic.ObjectID) " +
                //        "					when '发起申请' then '草稿'" +
                //        "					else '办理中' " +
                //        "				end" +
                //        "		end " +
                //        "  when '4' then " +
                //        "		case p.CancelFlg  " +
                //        "			when '1' then '已废除' " +
                //        "			else '已办证' " +
                //        "		end  " +
                //        "  else '草稿'" +
                //        " end DisplayName, " +
                //        " p.CreatedTime," +
                //        " ic.ObjectID IcObjectId," +
                //        " p.ObjectID ImportLicenseId, " +
                //        " p.RejectFlg , " +
                //        " p.CancelFlg " +
                //        " FROM I_ImportLicenseSub p, OT_InstanceContext ic " +
                //        " where p.ObjectID = ic.BizObjectId " +
                //        " and p.ContractNo = '" + ContractNo + "' " +
                //        " order by p.CreatedTime  ");

                //if (dt_importlicense.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_importlicense.Rows.Count];
                //    var i = 0;
                //    foreach (DataRow dr in dt_importlicense.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("ImportLicenceTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[i]["GoodName"] = dr["GoodName"].ToString();
                //        bizObjects[i]["GoodCode"] = dr["GoodCode"].ToString();
                //        var st = dr["Status"].ToString();
                //        bizObjects[i]["DisplayName"] = dr["DisplayName"].ToString();
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, this.ActionContext.User.UserID);
                //        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                //        var Mode = workItemDic["Mode"];
                //        if (Mode.Equals("Work"))
                //        {
                //            st += " ";
                //        }
                //        bizObjects[i]["Status"] = st;
                //        bizObjects[i]["ImportLicenseId"] = dr["ImportLicenseId"].ToString();
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        bizObjects[i]["CancelFlg"] = dr["CancelFlg"].ToString();
                //        i++;
                //    }
                //    this.ActionContext.InstanceData["ImportLicenceTbl"].Value = bizObjects;
                //}

                //// 获取到货记录
                //System.Data.DataTable dt_dh = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //        " select ContractNo,e1.EnumValue as DHType,DHSeq,e2.EnumValue as ShippingType,GoodName,Num,Amount,e3.EnumValue as Currency,Supplier,State,RejectFlg,DisplayName,t.ObjectID,t.BizObjectID from (" +
                //        " 	SELECT d.ContractNo,d.DHType,d.DHSeq,d.ShippingType,g.GoodName,g.Num,g.Amount,g.Currency,d.Supplier,ic.State,d.RejectFlg,ic.ObjectID,d.ObjectID BizObjectID  " +
                //        "	,case d.RejectFlg " +
                //        "		when '1' then '驳回' " +
                //        "		else " +
                //        "			case wi.DisplayName " +
                //        "				when '到货申请' then '草稿'" +
                //        " 				else wi.DisplayName+'中'" +
                //        "			end " +
                //        "	end DisplayName " +
                //        "	FROM I_DH d " +
                //        "	LEFT JOIN I_DHGoodsTbl g on d.ObjectID = g.ParentObjectID " +
                //        "	LEFT JOIN OT_InstanceContext ic on d.ObjectId = ic.BizObjectID" +
                //        "	LEFT JOIN OT_WorkItem wi on ic.ObjectID = wi.instanceId" +
                //        "	where d.ContractNo = '" + ContractNo + "' and ic.State = '2'" +
                //        "	UNION" +
                //        " 	SELECT d.ContractNo,d.DHType,d.DHSeq,d.ShippingType,g.GoodName,g.Num,g.Amount,g.Currency,d.Supplier,ic.State,d.RejectFlg,ic.ObjectID,d.ObjectID BizObjectID " +
                //        " 	,'已到货' DisplayName " +
                //        "	FROM I_DH d" +
                //        "	LEFT JOIN I_DHGoodsTbl g on d.ObjectID = g.ParentObjectID" +
                //        " 	LEFT JOIN OT_InstanceContext ic on d.ObjectId = ic.BizObjectID" +
                //        "	where d.ContractNo = '" + ContractNo + "' and ic.State = '4'" +
                //        " )t " +
                //        " LEFT JOIN OT_EnumerableMetadata e1 on t.DHType = e1.Code and e1.Category = '到货类别'" +
                //        " LEFT JOIN OT_EnumerableMetadata e2 on t.ShippingType = e2.Code and e2.Category = '运输方式'" +
                //        " LEFT JOIN OT_EnumerableMetadata e3 on t.Currency = e3.Code and e3.Category = '币种'" +
                //        " order by t.DHSeq,t.GoodName");

                //if (dt_dh.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_dh.Rows.Count];
                //    var i = 0;
                //    var TheNo = 0;
                //    var SeqCnt = 1;
                //    string DHSeqBak = "";
                //    foreach (DataRow dr in dt_dh.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("DHTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        if (!DHSeqBak.Equals(dr["DHSeq"].ToString()))
                //        {
                //            TheNo++;
                //            if (i > 0)
                //            {
                //                for (var j = 1; j <= SeqCnt; j++)
                //                {
                //                    bizObjects[i - j]["SeqCnt"] = SeqCnt;
                //                }
                //                SeqCnt = 1;
                //            }
                //        }
                //        else
                //        {
                //            SeqCnt++;
                //        }
                //        bizObjects[i]["TheNo"] = TheNo;
                //        bizObjects[i]["DHType"] = dr["DHType"].ToString();
                //        bizObjects[i]["DHSeq"] = dr["DHSeq"].ToString();
                //        bizObjects[i]["ShippingType"] = dr["ShippingType"].ToString();
                //        bizObjects[i]["GoodName"] = dr["GoodName"].ToString();
                //        bizObjects[i]["Num"] = dr["Num"].ToString();
                //        bizObjects[i]["Amount"] = dr["Amount"].ToString();
                //        bizObjects[i]["Currency"] = dr["Currency"].ToString();
                //        bizObjects[i]["Supplier"] = dr["Supplier"].ToString();
                //        var st = dr["State"].ToString();
                //        bizObjects[i]["DisplayName"] = dr["DisplayName"].ToString();
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["ObjectId"].ToString(), st, this.ActionContext.User.UserID);
                //        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                //        var Mode = workItemDic["Mode"];
                //        if (Mode.Equals("Work"))
                //        {
                //            st += " ";
                //        }
                //        bizObjects[i]["Status"] = st;
                //        bizObjects[i]["BizObjectID"] = dr["BizObjectID"].ToString();
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        DHSeqBak = dr["DHSeq"].ToString();
                //        i++;
                //    }
                //    for (var j = 1; j <= SeqCnt; j++)
                //    {
                //        bizObjects[dt_dh.Rows.Count - j]["SeqCnt"] = SeqCnt;
                //    }
                //    this.ActionContext.InstanceData["DHTbl"].Value = bizObjects;
                //}

                //// 获取合同变更记录
                //System.Data.DataTable dt_bg = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //        " SELECT convert(varchar(20),convert(decimal(18,2),b.AmountRMBOld))+b.CurrencyRMBOld+' '+convert(varchar(20),convert(decimal(18,2),b.AmountWBOld))+b.CurrencyWBOld as AmountOld, " +
                //        "  convert(varchar(20),convert(decimal(18,2),ISNULL(b.AmountRMBNew,0)))+b.CurrencyRMBNew as AmountRMBNew, " +
                //        "  convert(varchar(20),convert(decimal(18,2),ISNULL(b.AmountWBNew,0)))+b.CurrencyWBNew as AmountWBNew, " +
                //        "  b.IsChangeAmountRMB," +
                //        "  b.IsChangeAmountWB, " +
                //        " b.DHDateOld,b.DHDateNew, " +
                //        " CONVERT(varchar, b.AgencyNumOld)+'('+AgencyTypeOld+')' AgencyOld,  " +
                //        " CONVERT(varchar, b.AgencyNumNew)+'('+( " +
                //        " select enum1.EnumValue from OT_EnumerableMetadata enum1 where b.AgencyTypeNew = enum1.Code and enum1.Category = '代理费费率／金额'  " +
                //        " )+')' AgencyNew, " +
                //        " b.PayConditionOld,b.PayConditionNew, " +
                //        " ic.State Status, " +
                //        " case ic.State   " +
                //        "	when '2' then   " +
                //        "		case b.RejectFlg  " +
                //        "			when '1' then '驳回'  " +
                //        "			else  " +
                //        "          case (select top 1 DisplayName from OT_WorkItem wi where wi.InstanceId = ic.ObjectID)  " +
                //        "					when '变更发起' then '草稿' " +
                //        "					when '航油部门审批' then '审批中' " +
                //        "					when '非航油部门审批' then '审批中' " +
                //        "					when '航油领导审批' then '审批中' " +
                //        "					when '非航油领导审批' then '审批中' " +
                //        "					when '确认' then '确认中' " +
                //        "				end " +
                //        "		end  " +
                //        "  when '4' then  " +
                //        "		'已变更'  " +
                //        " end DisplayName,  " +
                //        " b.CreatedTime, " +
                //        " ic.ObjectID IcObjectId, " +
                //        " b.ObjectID BizObjectId,  " +
                //        " b.RejectFlg  " +
                //        " FROM I_BG b, OT_InstanceContext ic  " +
                //        " where b.ObjectID = ic.BizObjectId  " +
                //        " and b.ContractNo = '" + ContractNo + "'  " +
                //        " order by b.CreatedTime   ");

                //if (dt_bg.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_bg.Rows.Count];
                //    var i = 0;
                //    foreach (DataRow dr in dt_bg.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("BGTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[i]["AmountOld"] = dr["AmountOld"].ToString();
                //        string AmountNew = "";
                //        if(dr["IsChangeAmountRMB"].ToString().Equals("是"))
                //        {
                //            AmountNew += dr["AmountRMBNew"].ToString();
                //        }
                //        if (dr["IsChangeAmountWB"].ToString().Equals("是"))
                //        {
                //            AmountNew += dr["AmountWBNew"].ToString();
                //        }
                //        bizObjects[i]["AmountNew"] = AmountNew;
                //        bizObjects[i]["DHDateOld"] = dr["DHDateOld"].ToString();
                //        bizObjects[i]["DHDateNew"] = dr["DHDateNew"].ToString();
                //        var st = dr["Status"].ToString();
                //        bizObjects[i]["DisplayName"] = dr["DisplayName"].ToString();
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, this.ActionContext.User.UserID);
                //        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                //        var Mode = workItemDic["Mode"];
                //        if (Mode.Equals("Work"))
                //        {
                //            st += " ";
                //        }
                //        bizObjects[i]["Status"] = st;
                //        bizObjects[i]["BizObjectId"] = dr["BizObjectId"].ToString();
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        i++;
                //    }
                //    this.ActionContext.InstanceData["BGTbl"].Value = bizObjects;
                //}

                //// 获取保函数据
                //System.Data.DataTable dt_bh = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //        " SELECT " +
                //        " e1.EnumValue BHTypeName, " +
                //        " e2.EnumValue BHPropertyName, " +
                //        " CONVERT(varchar, b.BHAmount)+e3.EnumValue as BHAmount, " +
                //        " b.ReceiveDate, " +
                //        " b.ExpirationDate, " +
                //        " ic.State Status,  " +
                //        " case ic.State    " +
                //        "	when '2' then    " +
                //        "		case b.RejectFlg   " +
                //        "			when '1' then '驳回'   " +
                //        "			else   " +
                //        "          case (select top 1 DisplayName from OT_WorkItem wi where wi.InstanceId = ic.ObjectID)   " +
                //        "					when '发起申请' then '未退'  " +
                //        "					when '财务审批' then '确认中'  " +
                //        "					when '办公室审批' then '确认中'  " +
                //        "					else '审批中'  " +
                //        "				end  " +
                //        "		end   " +
                //        "  when '4' then   " +
                //        "		case b.TBType " +
                //        "		when 'TB_TB' then '已退' " +
                //        "		when 'TB_MS' then '没收' " +
                //        "		end  " +
                //        " end DisplayName,   " +
                //        " b.CreatedTime,  " +
                //        " ic.ObjectID IcObjectId,  " +
                //        " b.ObjectID BizObjectId,   " +
                //        " b.RejectFlg   " +
                //        " FROM I_BH b " +
                //        " INNER JOIN OT_InstanceContext ic on b.ObjectID = ic.BizObjectId and b.ContractNo = '" + ContractNo + "'  " +
                //        " LEFT JOIN OT_EnumerableMetadata e1 on b.BHType = e1.Code and e1.Category = '保函类型' " +
                //        " LEFT JOIN OT_EnumerableMetadata e2 on b.BHProperty = e2.Code and e2.Category = '保函性质' " +
                //        " LEFT JOIN OT_EnumerableMetadata e3 on b.Currency = e3.Code and e3.Category = '币种' " +
                //        " order by b.CreatedTime   " );

                //if (dt_bh.Rows.Count > 0)
                //{
                //    BizObject[] bizObjects = new BizObject[dt_bh.Rows.Count];
                //    var i = 0;
                //    foreach (DataRow dr in dt_bh.Rows)
                //    {
                //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("BHTbl").ChildSchema;
                //        // 第一行
                //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                //        bizObjects[i]["BHType"] = dr["BHTypeName"].ToString();
                //        bizObjects[i]["BHProperty"] = dr["BHPropertyName"].ToString();
                //        bizObjects[i]["BHAmount"] = dr["BHAmount"].ToString();
                //        bizObjects[i]["ReceiveDate"] = dr["ReceiveDate"].ToString();
                //        bizObjects[i]["ExpirationDate"] = dr["ExpirationDate"].ToString();
                //        var st = dr["Status"].ToString();
                //        bizObjects[i]["TBStatus"] = dr["DisplayName"].ToString();
                //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, this.ActionContext.User.UserID);
                //        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                //        var Mode = workItemDic["Mode"];
                //        if (Mode.Equals("Work"))
                //        {
                //            st += " ";
                //        }
                //        bizObjects[i]["Status"] = st;
                //        bizObjects[i]["BizObjectId"] = dr["BizObjectId"].ToString();
                //        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                //        i++;
                //    }
                //    this.ActionContext.InstanceData["BHTbl"].Value = bizObjects;
                //}

                // 获取合同文件归档文件名数据
                System.Data.DataTable dt_gdfn = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        " select g.ContractFileSignVer,g.AgencyFileSignVer from I_GD g  " +
                        " where g.ContractNo = '" + ContractNo + "'" );
                if (dt_gdfn.Rows.Count > 0)
                {
                    var i = 0;
                    string ContractFileSignVer = "";
                    string AgencyFileSignVer = "";
                    foreach (DataRow dr in dt_gdfn.Rows)
                    {
                        ContractFileSignVer = dr["ContractFileSignVer"].ToString();
                        AgencyFileSignVer = dr["AgencyFileSignVer"].ToString();
                        i++;
                    }
                    this.ActionContext.InstanceData["ContractFileNameSignVer"].Value = ContractFileSignVer;
                    this.ActionContext.InstanceData["AgencyFileNameSignVer"].Value = AgencyFileSignVer;
                }
                // 获取合同文件归档数据
                System.Data.DataTable dt_gd = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        " SELECT " +
                        " g.OwnerId," +
                        " CONVERT(varchar(12),g.CreatedTime,111) CreatedTime," +
                        " ic.State Status,  " +
                        " case ic.State    " +
                        "	when '2' then    " +
                        "		case g.RejectFlg   " +
                        "			when '1' then '驳回'   " +
                        "			else   " +
                        "				'审批中'  " +
                        "		end   " +
                        "  when '4' then   " +
                        "		'审批完了' " +
                        " end DisplayName,   " +
                        " g.CreatedTime,  " +
                        " ic.ObjectID IcObjectId,  " +
                        " g.ObjectID BizObjectId,   " +
                        " g.RejectFlg   " +
                        " FROM I_GD g" +
                        " INNER JOIN OT_InstanceContext ic on g.ObjectID = ic.BizObjectId and g.ContractNo = '" + ContractNo + "'  " +
                        " order by g.CreatedTime   " );

                if (dt_gd.Rows.Count > 0)
                {
                    BizObject[] bizObjects = new BizObject[dt_gd.Rows.Count];
                    var i = 0;
                    foreach (DataRow dr in dt_gd.Rows)
                    {
                        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("ContractFileArchiveTbl").ChildSchema;
                        // 第一行
                        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                        bizObjects[i]["Applyer"] = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["OwnerId"].ToString());
                        bizObjects[i]["ApplyDate"] = dr["CreatedTime"].ToString();
                        var st = dr["Status"].ToString();
                        
                        bizObjects[i]["DisplayName"] = dr["DisplayName"].ToString();
                        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, this.ActionContext.User.UserID);
                        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                        var Mode = workItemDic["Mode"];
                        if (Mode.Equals("Work"))
                        {
                            st += " ";
                        }
                        bizObjects[i]["Status"] = st;
                        bizObjects[i]["BizObjectId"] = dr["BizObjectId"].ToString();
                        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                        i++;
                    }
                    this.ActionContext.InstanceData["ContractFileArchiveTbl"].Value = bizObjects;
                }

                // 获取合同文件归档文件名数据
                System.Data.DataTable dt_gdchangefn = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        " select g.ContractChangeFileSignVer, g.AgencyChangeFileSignVer from I_GDChange g  " +
                        " where g.ContractNo = '" + ContractNo + "'" );
                if (dt_gdchangefn.Rows.Count > 0)
                {
                    var i = 0;
                    string ContractChangeFileNameSignVer = "";
                    string AgencyChangeFileNameSignVer = "";
                    foreach (DataRow dr in dt_gdchangefn.Rows)
                    {
                        ContractChangeFileNameSignVer = dr["ContractChangeFileSignVer"].ToString();
                        AgencyChangeFileNameSignVer = dr["AgencyChangeFileSignVer"].ToString();
                        i++;
                    }
                    this.ActionContext.InstanceData["ContractChangeFileNameSignVer"].Value = ContractChangeFileNameSignVer;
                    this.ActionContext.InstanceData["AgencyChangeFileNameSignVer"].Value = AgencyChangeFileNameSignVer;
                }
                // 获取合同变更归档数据
                System.Data.DataTable dt_gdchange = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                        " SELECT " +
                        " g.OwnerId," +
                        " CONVERT(varchar(12),g.CreatedTime,111) CreatedTime," +
                        " ic.State Status,  " +
                        " case ic.State    " +
                        "	when '2' then    " +
                        "		case g.RejectFlg   " +
                        "			when '1' then '驳回'   " +
                        "			else   " +
                        "				'审批中'  " +
                        "		end   " +
                        "  when '4' then   " +
                        "		'审批完了' " +
                        " end DisplayName,   " +
                        " g.CreatedTime,  " +
                        " ic.ObjectID IcObjectId,  " +
                        " g.ObjectID BizObjectId,   " +
                        " g.RejectFlg   " +
                        " FROM I_GDChange g" +
                        " INNER JOIN OT_InstanceContext ic on g.ObjectID = ic.BizObjectId and g.ContractNo = '" + ContractNo + "'  " +
                        " order by g.CreatedTime   ");

                if (dt_gdchange.Rows.Count > 0)
                {
                    BizObject[] bizObjects = new BizObject[dt_gdchange.Rows.Count];
                    var i = 0;
                    foreach (DataRow dr in dt_gdchange.Rows)
                    {
                        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("ChangeArchiveTbl").ChildSchema;
                        // 第一行
                        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                        bizObjects[i]["Applyer"] = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["OwnerId"].ToString());
                        bizObjects[i]["ApplyDate"] = dr["CreatedTime"].ToString();
                        var st = dr["Status"].ToString();
                        
                        bizObjects[i]["DisplayName"] = dr["DisplayName"].ToString();
                        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, this.ActionContext.User.UserID);
                        bizObjects[i]["WorkItemId"] = workItemDic["workItemId"];
                        var Mode = workItemDic["Mode"];
                        if (Mode.Equals("Work"))
                        {
                            st += " ";
                        }
                        bizObjects[i]["Status"] = st;
                        bizObjects[i]["BizObjectId"] = dr["BizObjectId"].ToString();
                        bizObjects[i]["RejectFlg"] = dr["RejectFlg"].ToString();
                        i++;
                    }
                    this.ActionContext.InstanceData["ChangeArchiveTbl"].Value = bizObjects;
                }


            }


            
            return base.LoadDataFields();
        }

        public class LinkUrl
        {
            public string NavigateUrl { get; set; }
            public string NavigateUrlDataField { get; set; }
            public string Text { get; set; }
            public string TextDataField { get; set; }

        }


        /// <summary>
        /// 保存表单数据到引擎中
        /// </summary>
        /// <param name="Args"></param>
        public override void SaveDataFields(MvcPostValue MvcPost, MvcResult result)
        {

            try
            {
                //if (this.ActionContext.IsOriginateMode)
                //{
                //    var ContractNo = this.ActionContext.InstanceData["ContractNo"].Value;
                //    // var ContractNo2 = ActionContext.BizObject.GetValue("ContractNo");
                //    var ContractName = this.ActionContext.InstanceData["ContractName"].Value;
                //    System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                //    " insert into I_ContractStatus  " +
                //    " (ContractNo, ContractName, UpdateNoFlg, ApproveFlg, OperateFlg, CompleteFlg) " +
                //    "  VALUES('" + ContractNo + "', '" + ContractName + "', '0', '', '', '')  "
                //    );
                //    DataRowCollection dr = dt.Rows;
                //    this.ActionContext.InstanceData.Submit();
                //}
                //UserValidator u = this.ActionContext.Participant;


            }
            catch (Exception exp)
            {

            }
            // 保存后，后台执行事件
            base.SaveDataFields(MvcPost, result);

        }

        public string getStatus(Dictionary<string, string> dkst, string QKSeq)
        {
            string ret = "";
            string st = "";
            foreach (KeyValuePair<string, string> kv in dkst)
            {
                if(kv.Key.Equals(QKSeq))
                {
                    st = kv.Value;
                }
            }
            if(st == "2")
            {
                ret = "\n(到款流程中)";
            }
            return ret;
        }
        // 获取结算的到款中的状态
        public static string getStatusOfDKJ(Dictionary<string, string> dic, string objKey)
        {
            string ret = "";
            string st = "";
            foreach (KeyValuePair<string, string> kv in dic)
            {
                if (kv.Key.Equals(objKey))
                {
                    st = kv.Value;
                }
            }
            if (st == "4")
            {
                ret = "已结算";
            } else if(st == "2")
            {
                ret = "结算中";
            } else
            {
                ret = "未结算";
            }
            return ret;
        }
    }
}
