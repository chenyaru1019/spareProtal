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

namespace OThinker.H3.Portal.Sheets.Agreement
{
    public partial class AircraftOilAgreement : OThinker.H3.Controllers.MvcPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

  

        public override MvcViewContext LoadDataFields()
        {
            var AgreeMent_number = this.ActionContext.InstanceData["AgreeMent_number"].Value;
            //var AgreeMent_number = "17SPIAIE34-001US";
            //String sqls1 = "SELECT am.Project_head_A,am.Project_head_B,am.AgreeMent_number,am.AgreeMent_name,am.Agreement_client,am.Pay_conditions,am.CreatedBy,am.CreatedTime, " +
            //        " ar.agency_money,e1.EnumValue agency_type,ar.up_limit,ar.lower_limit " +
            //        " FROM I_Agreement_mains am  " +
            //        " inner JOIN I_agency_rates ar on am.ObjectID = ar.ParentObjectID " +
            //        " inner JOIN OT_EnumerableMetadata e1 on e1.Code = ar.agency_type and e1.Category = '代理费费率／金额' " +
            //        "  where am.AgreeMent_number='" + ContractNo + "'";
            //String sql = "SELECT cm.AgencyComputerNum agency_money,e1.EnumValue agency_type  " +
            //        " FROM I_ContractMain cm " +
            //        " inner JOIN OT_EnumerableMetadata e1 on e1.Code = cm.AgencyComputerType and e1.Category = '代理费费率／金额' " +
            //        "  where cm.ContractNo='" + AgreeMent_number + "'";
            //System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
            //if (dt.Rows.Count > 0)
            //{

            //    BizObject[] bizObjects = new BizObject[dt.Rows.Count];
            //    var i = 0;
            //    foreach (DataRow dr in dt.Rows)
            //    {
            //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("agency_rates_hy").ChildSchema;
            //        // 第一行
            //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
            //        bizObjects[i]["agency_money"] = dr["agency_money"].ToString();
            //        bizObjects[i]["agency_type"] = dr["agency_type"].ToString();
            //        bizObjects[i]["up_limit"] = "";
            //        bizObjects[i]["lower_limit"] = "";
            //        i++;
            //    }
            //    this.ActionContext.InstanceData["agency_rates_hy"].Value = bizObjects;
            //}
            ////协议号缓存
            var ReceiveAgencyFeeHidden = "0";
            System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT a.AgreeMent_number,a.ReceiveAgencyFeeHidden FROM OT_InstanceContext ic INNER JOIN I_Agreement_mains a on ic.BizObjectId = a.ObjectID and ic.ObjectID = '" + this.ActionContext.InstanceId + "'");
            if (dt1.Rows.Count > 0)
            {
                AgreeMent_number = dt1.Rows[0]["AgreeMent_number"].ToString();
                ReceiveAgencyFeeHidden = dt1.Rows[0]["ReceiveAgencyFeeHidden"].ToString();
            }
            this.ActionContext.InstanceData["AgreeMent_number"].Value = AgreeMent_number;
            this.ActionContext.InstanceData["ReceiveAgencyFeeHidden"].Value = ReceiveAgencyFeeHidden;
            //协议号修改的版本号
            int versionBack = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Update_agreement_number");
            this.ActionContext.InstanceData["Process_version"].Value = versionBack;
            //协议变更的版本号
            int Agreement_changeNumbers = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Agreenment_change");
            this.ActionContext.InstanceData["Agreement_changeNumber"].Value = Agreement_changeNumbers;
            //协议归档版本号
            int Agreement_files = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Agreement_file");
            this.ActionContext.InstanceData["AgreementGD_file"].Value = Agreement_files;
            //收退款版本号
            int st_moneys = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Charge_back");
            this.ActionContext.InstanceData["st_money"].Value = st_moneys;
            
            // 获取取回协议子流程的版本号
            //int GetBackAgreement = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("GetBackAgreement");
            //this.ActionContext.InstanceData["WorkflowVersion_Back"].Value = GetBackAgreement;


            // 获取审签记录
            //System.Data.DataTable dt_approve = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            //    "SELECT ins.OriginatorName Approver,CONVERT(varchar(12),ins.StartTime,111) ApproveDate,ins.State Status,ins.ObjectID " +
            //    " FROM I_Agreement_sign s, OT_InstanceContext ins " +
            //    " where s.AgreeMent_number = '"+ AgreeMent_number + "' and s.ObjectID = ins.BizObjectId");
            //if (dt_approve.Rows.Count > 0)
            //{
            //    BizObject[] bizObjects = new BizObject[1];
            //    BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("Agreement_signTbl").ChildSchema;
            //    // 第一行
            //    bizObjects[0] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
            //    bizObjects[0]["Approver"] = dt_approve.Rows[0]["Approver"].ToString();
            //    bizObjects[0]["ApproveDate"] = dt_approve.Rows[0]["ApproveDate"].ToString();
            //    var st = dt_approve.Rows[0]["Status"].ToString();
            //    Dictionary<string, string> workItemDic = Common.getWorkItemId(dt_approve.Rows[0]["ObjectID"].ToString(), st);
            //    foreach (var item in workItemDic)
            //    {
            //        Console.WriteLine(item.Key + item.Value);
            //        if (item.Key.Equals("workItemId"))
            //        {
            //            bizObjects[0]["WorkItemId"] = item.Value;
            //        }

            //    }
            //    bizObjects[0]["Status"] = st == "2" ? "审批中" : (st == "4" ? "审批完了" : "");
            //    bizObjects[0]["Operate"] = "";

            //    this.ActionContext.InstanceData["Agreement_signTbl"].Value = bizObjects;
            //}

            // 获取协议归档文件名数据
            System.Data.DataTable dt_gdfn = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select a.CreatedTime,a.DataField,a.FileName from I_Agreement_file g,OT_Attachment a  " +
                    " where  g.ObjectID = a.BizObjectID" +
                    " and g.Agreement_Number = '" + AgreeMent_number + "'" +
                    " order by a.CreatedTime ");
            if (dt_gdfn.Rows.Count > 0)
            {
                var i = 0;
                string FileSignVer = "";
                string BGFileSignVer = "";
                foreach (DataRow dr in dt_gdfn.Rows)
                {
                    if (dr["DataField"].ToString().Equals("Agency_original"))
                    {
                        FileSignVer += dr["FileName"].ToString() + ",";
                    }
                    else if (dr["DataField"].ToString().Equals("Agency_change"))
                    {
                        BGFileSignVer += dr["FileName"].ToString() + ",";
                    }
                    i++;
                }
                this.ActionContext.InstanceData["FileSignVersion"].Value = FileSignVer;
                this.ActionContext.InstanceData["BGFileSignVersion"].Value = BGFileSignVer;
            }
            // 获取文件归档数据
            System.Data.DataTable dt_gd = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " SELECT " +
                    " g.OwnerId," +
                    " CONVERT(varchar(12),g.CreatedTime,111) CreatedTime," +
                    " ic.State Status,  " +
                    " case ic.State    " +
                    "	when '2' then    " +
                    "		'审批中'  " +
                    "  when '4' then   " +
                    "		'审批完了' " +
                    " end DisplayName,   " +
                    " g.CreatedTime,  " +
                    " ic.ObjectID IcObjectId " +
                    " FROM I_Agreement_file g" +
                    " INNER JOIN OT_InstanceContext ic on g.ObjectID = ic.BizObjectId and g.AgreeMent_number = '" + AgreeMent_number + "'  " +
                    " order by g.CreatedTime   ");

            if (dt_gd.Rows.Count > 0)
            {
                BizObject[] bizObjects = new BizObject[dt_gd.Rows.Count];
                var i = 0;
                foreach (DataRow dr in dt_gd.Rows)
                {
                    BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("AgreementFileRecordhy").ChildSchema;
                    // 第一行
                    bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                    bizObjects[i]["Applyer"] = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["OwnerId"].ToString());
                    bizObjects[i]["ApplyDate"] = dr["CreatedTime"].ToString();
                    var st = dr["Status"].ToString();
                    bizObjects[i]["Status"] = dr["DisplayName"].ToString();
                    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), st);
                    foreach (var item in workItemDic)
                    {
                        Console.WriteLine(item.Key + item.Value);
                        if (item.Key.Equals("workItemId"))
                        {
                            bizObjects[i]["WorkItemId"] = item.Value;
                        }
                    }
                    i++;
                }
                this.ActionContext.InstanceData["AgreementFileRecordhy"].Value = bizObjects;
            }

            // 获取变更数据
            System.Data.DataTable dt_bg = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                   " SELECT ac.PayConditionOld, ac.PayConditionNew, " +
                    "  old.agency_money old_agency_money,old.agency_type old_agency_type, " +
                    "  new.agency_money new_agency_money,new.agency_type new_agency_type, " +
                    "  ins.State Status,ins.ObjectID IcObjectId " +
                    "  FROM I_Agreenment_change ac,I_Old_agency_rates old, I_New_agency_rates new, OT_InstanceContext ins ,OT_EnumerableMetadata e " +
                    "  where ac.AgreenMent_number = '" + AgreeMent_number + "' and ac.ObjectID = ins.BizObjectId  " +
                    "  and old.ParentObjectID = ac.ObjectId and new.ParentObjectID = ac.ObjectId and new.agency_type = e.Code and e.Category = '代理费费率／金额' " +
                    "  and e.EnumValue = old.agency_type " +
                    "  ORDER BY ac.CreatedTime  ");
            List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
            if (dt_bg.Rows.Count > 0)
            {
                var i = 0;
                var IcObjectIdBak = "";
                var PayConditionOld = "";
                var PayConditionNew = "";
                var old_agency = "";
                var new_agency = "";
                var Status = "";
                var WorkItemId = "";
                foreach (DataRow dr in dt_bg.Rows)
                {
                    if(dr["IcObjectId"].ToString() != IcObjectIdBak && IcObjectIdBak != "")
                    {
                        Dictionary<string, string> dic = new Dictionary<string, string>();
                        dic.Add("IcObjectId", IcObjectIdBak);
                        dic.Add("PayConditionOld", PayConditionOld);
                        dic.Add("PayConditionNew", PayConditionNew);
                        dic.Add("old_agency", old_agency);
                        dic.Add("new_agency", new_agency);
                        dic.Add("Status", Status);
                        dic.Add("WorkItemId", WorkItemId);
                        ls.Add(dic);
                        old_agency = "";
                        new_agency = "";
                    }
                    PayConditionOld = dr["PayConditionOld"].ToString();
                    PayConditionNew = dr["PayConditionNew"].ToString();
                    old_agency += dr["old_agency_money"].ToString() + "("+ dr["old_agency_type"].ToString() + ")\n";
                    new_agency += dr["new_agency_money"].ToString() + "(" + dr["old_agency_type"].ToString() + ")\n";

                    var st = dr["Status"].ToString();
                    Status = st == "2" ? "审批中" : (st == "4" ? "审批完了" : "");
                    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), st);
                    foreach (var item in workItemDic)
                    {
                        Console.WriteLine(item.Key + item.Value);
                        if (item.Key.Equals("workItemId"))
                        {
                            WorkItemId = item.Value;
                        }
                    }
                    IcObjectIdBak = dr["IcObjectId"].ToString();
                    i++;
                }
                if (IcObjectIdBak != "")
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("IcObjectId", IcObjectIdBak);
                    dic.Add("PayConditionOld", PayConditionOld);
                    dic.Add("PayConditionNew", PayConditionNew);
                    dic.Add("old_agency", old_agency);
                    dic.Add("new_agency", new_agency);
                    dic.Add("Status", Status);
                    dic.Add("WorkItemId", WorkItemId);
                    ls.Add(dic);
                }
            }

            if (ls.Count > 0)
            {
                BizObject[] bizObjects = new BizObject[ls.Count];
                var i = 0;
                foreach (Dictionary<string, string> dic in ls)
                {
                    BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("Agreement_bg_hy").ChildSchema;
                    // 第一行
                    bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                    
                    foreach (var item in dic)
                    {
                        if (item.Key.Equals("PayConditionOld"))
                        {
                            bizObjects[i]["PayConditionOld"] = item.Value;
                        }
                        if (item.Key.Equals("PayConditionNew"))
                        {
                            bizObjects[i]["PayConditionNew"] = item.Value;
                        }
                        if (item.Key.Equals("old_agency"))
                        {
                            bizObjects[i]["old_agency"] = item.Value;
                        }
                        if (item.Key.Equals("new_agency"))
                        {
                            bizObjects[i]["new_agency"] = item.Value;
                        }
                        if (item.Key.Equals("Status"))
                        {
                            bizObjects[i]["Status"] = item.Value;
                        }
                        if (item.Key.Equals("WorkItemId"))
                        {
                            bizObjects[i]["WorkItemId"] = item.Value;
                        }
                    }
                    i++;
                }
                this.ActionContext.InstanceData["Agreement_bg_hy"].Value = bizObjects;
            }

            // 获取合同项目关联数据
            // 1、协议与项目的关联数据
            System.Data.DataTable dt_AgrAndProj = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                   " select ib.ObjectID,min(ib.projectName) projectName,min(ib.BiddingCode) BiddingCode " +
                    " from I_AircraftOilAgreement am " +
                    " INNER JOIN I_AgencyAgreements aa on am.AgreeMent_number = aa.AgreementCode " +
                    " INNER JOIN I_InviteBids ib on aa.ParentObjectID = ib.ObjectID " +
                    " and am.AgreeMent_number = '" + AgreeMent_number + "'  " +
                    " group by ib.ObjectID ");
            // 2、协议与合同的关联数据
            System.Data.DataTable dt_AgrAndCont = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                   " select cm.ContractNo,cm.ContractName,e.EnumValue ContractType " +
                    " from I_AircraftOilAgreement am " +
                    " INNER JOIN I_ContractMain cm on cm.ContractNo = am.AgreeMent_number " +
                    " INNER JOIN OT_EnumerableMetadata e on e.Code = cm.ContractType and e.Category = '合同类型' " +
                    " and am.AgreeMent_number = '" + AgreeMent_number + "' ");
            // 3、项目与合同的关联数据
            string sql_ProjAndCont = 
                   " select cm.ContractNo " +
                    " from I_InviteBids ib " +
                    " INNER JOIN I_ContractMain cm on ib.BiddingCode = cm.BidNo " +
                    " and ib.BiddingCode = 'BidCodeReplace' " +
                    " GROUP BY cm.ContractNo ";
            List<Dictionary<string, string>> ls_AgrAndProj = new List<Dictionary<string, string>>();
            if (dt_AgrAndProj.Rows.Count > 0)
            {
                foreach (DataRow dr in dt_AgrAndProj.Rows)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("projectName", dr["projectName"].ToString());
                    dic.Add("BiddingCode", dr["BiddingCode"].ToString());
                    ls_AgrAndProj.Add(dic);
                }
            }
            List<Dictionary<string, string>> ls_AgrAndCont = new List<Dictionary<string, string>>();
            if (dt_AgrAndCont.Rows.Count > 0)
            {
                foreach (DataRow dr in dt_AgrAndCont.Rows)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("ContractNo", dr["ContractNo"].ToString());
                    dic.Add("ContractName", dr["ContractName"].ToString());
                    dic.Add("ContractType", dr["ContractType"].ToString());
                    ls_AgrAndCont.Add(dic);
                }
            }

            List<Dictionary<string, string>> ls_All = new List<Dictionary<string, string>>();
            List<int> indexs = new List<int>();
            if (ls_AgrAndProj.Count > 0)
            {
                foreach (Dictionary<string, string> item in ls_AgrAndProj)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    int index = -1;
                    dic.Add("projectName", item["projectName"].ToString());
                    dic.Add("BiddingCode", item["BiddingCode"].ToString());
                    System.Data.DataTable dt_ProjAndCont = 
                        OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_ProjAndCont.Replace("BidCodeReplace", item["BiddingCode"].ToString()));
                    if(dt_ProjAndCont.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt_ProjAndCont.Rows)
                        {
                            
                            foreach (Dictionary<string, string> item_AgrAndCont in ls_AgrAndCont)
                            {
                                int i = 0;
                                if (dr["ContractNo"].ToString() == item_AgrAndCont["ContractNo"].ToString())
                                {
                                    index = i;
                                    break;
                                }
                                i++;
                            }
                            if (index >= 0)
                            {
                                break;
                            }
                        }
                    }
                    if (index >= 0)
                    {
                        dic.Add("ContractNo", ls_AgrAndCont[index]["ContractNo"].ToString());
                        dic.Add("ContractName", ls_AgrAndCont[index]["ContractName"].ToString());
                        dic.Add("ContractType", ls_AgrAndCont[index]["ContractType"].ToString());
                        indexs.Add(index);
                    }else
                    {
                        dic.Add("ContractNo", "");
                        dic.Add("ContractName", "");
                        dic.Add("ContractType", "");
                    }
                    ls_All.Add(dic);
                }
            }

            if (ls_AgrAndCont.Count > 0)
            {
                int j = 0;
                foreach (Dictionary<string, string> item in ls_AgrAndCont)
                {
                    if(indexs.Contains(j++))
                    {
                        continue;
                    } else
                    {
                        Dictionary<string, string> dic = new Dictionary<string, string>();
                        dic.Add("projectName", "");
                        dic.Add("BiddingCode", "");
                        dic.Add("ContractNo", item["ContractNo"].ToString());
                        dic.Add("ContractName", item["ContractName"].ToString());
                        dic.Add("ContractType", item["ContractType"].ToString());
                        ls_All.Add(dic);
                    }
                }
            }

            if (ls_All.Count > 0)
            {
                BizObject[] bizObjects = new BizObject[ls_All.Count];
                var i = 0;
                foreach (Dictionary<string, string> dic in ls_All)
                {
                    BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("Project_contracts_hy").ChildSchema;
                    // 第一行
                    bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                    bizObjects[i]["project_names"] = dic["projectName"].ToString();
                    bizObjects[i]["tender_number"] = dic["BiddingCode"].ToString();
                    bizObjects[i]["contact_no"] = dic["ContractNo"].ToString();
                    bizObjects[i]["contact_name"] = dic["ContractName"].ToString();
                    bizObjects[i]["contract_type"] = dic["ContractType"].ToString();

                    i++;
                }
                this.ActionContext.InstanceData["Project_contracts_hy"].Value = bizObjects;
            }

            // 获取收款RMB记录
            System.Data.DataTable dt_skrmb = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select CONVERT(varchar(12),c.CreatedTime,111) CreatedTime,CurrentSKTotalRMB,CONVERT(varchar(12),c.SKDate,111) SKDate " +
                " ,ic.State Status,ic.ObjectID IcObjectID " +
                " from I_Charge_back c" +
                " INNER JOIN OT_InstanceContext ic on c.ObjectID = ic.BizObjectId " +
                " where c.agency_type = 'RMB' and c.AgreeMent_number = '" + AgreeMent_number + "' ");
            if (dt_skrmb.Rows.Count > 0)
            {
                BizObject[] bizObjects = new BizObject[dt_skrmb.Rows.Count];
                var i = 0;
                foreach (DataRow dr in dt_skrmb.Rows)
                {
                    BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("SKRecordsRMB").ChildSchema;
                    // 第一行
                    bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                    bizObjects[i]["ApplyDate"] = dr["CreatedTime"].ToString();
                    bizObjects[i]["SKAmount"] = dr["CurrentSKTotalRMB"].ToString();
                    bizObjects[i]["DKDate"] = dr["SKDate"].ToString()== "1753/01/01" ? "": dr["SKDate"].ToString();
                    var st = dr["Status"].ToString();
                    bizObjects[i]["Status"] = st == "2" ? "收款中" : (st == "4" ? "收款完了" : "");
                    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), st);
                    foreach (var item in workItemDic)
                    {
                        Console.WriteLine(item.Key + item.Value);
                        if (item.Key.Equals("workItemId"))
                        {
                            bizObjects[i]["WorkItemId"] = item.Value;
                        }
                    }
                    i++;
                }
                this.ActionContext.InstanceData["SKRecordsRMB"].Value = bizObjects;
            }

            //// 获取收款USD记录
            //System.Data.DataTable dt_skusd = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            //    " select CONVERT(varchar(12),c.CreatedTime,111) CreatedTime,CurrentSKTotalUSD,CONVERT(varchar(12),c.SKDate,111) SKDate " +
            //    " ,ic.State Status,ic.ObjectID IcObjectID " +
            //    " from I_Charge_back c" +
            //    " INNER JOIN OT_InstanceContext ic on c.ObjectID = ic.BizObjectId " +
            //    " where c.agency_type = 'USD' and c.AgreeMent_number = '" + AgreeMent_number + "' ");
            //if (dt_skusd.Rows.Count > 0)
            //{
            //    BizObject[] bizObjects = new BizObject[dt_skusd.Rows.Count];
            //    var i = 0;
            //    foreach (DataRow dr in dt_skrmb.Rows)
            //    {
            //        BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("SKRecordsUSD").ChildSchema;
            //        // 第一行
            //        bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
            //        bizObjects[i]["ApplyDate"] = dr["CreatedTime"].ToString();
            //        bizObjects[i]["SKAmount"] = dr["CurrentSKTotalUSD"].ToString();
            //        bizObjects[i]["DKDate"] = dr["SKDate"].ToString() == "1753/01/01" ? "" : dr["SKDate"].ToString();
            //        var st = dr["Status"].ToString();
            //        bizObjects[i]["Status"] = st == "2" ? "收款中" : (st == "4" ? "收款完了" : "");
            //        Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), st);
            //        foreach (var item in workItemDic)
            //        {
            //            Console.WriteLine(item.Key + item.Value);
            //            if (item.Key.Equals("workItemId"))
            //            {
            //                bizObjects[i]["WorkItemId"] = item.Value;
            //            }
            //        }
            //        i++;
            //    }
            //    this.ActionContext.InstanceData["SKRecordsUSD"].Value = bizObjects;
            //}
            // 获取收款Percent记录
            System.Data.DataTable dt_skpercent = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select CONVERT(varchar(12),c.CreatedTime,111) CreatedTime,CurrentSKTotalRMB,CONVERT(varchar(12),c.SKDate,111) SKDate " +
                " ,ic.State Status,ic.ObjectID IcObjectID " +
                " from I_Charge_back c" +
                " INNER JOIN OT_InstanceContext ic on c.ObjectID = ic.BizObjectId " +
                " where c.agency_type = 'Percent' and c.AgreeMent_number = '" + AgreeMent_number + "' ");
            if (dt_skpercent.Rows.Count > 0)
            {
                BizObject[] bizObjects = new BizObject[dt_skpercent.Rows.Count];
                var i = 0;
                foreach (DataRow dr in dt_skpercent.Rows)
                {
                    BizObjectSchema childSchema = this.ActionContext.Schema.GetProperty("SKRecordsPercent").ChildSchema;
                    // 第一行
                    bizObjects[i] = new BizObject(this.ActionContext.Engine, childSchema, this.ActionContext.User.UserID);
                    bizObjects[i]["ApplyDate"] = dr["CreatedTime"].ToString();
                    bizObjects[i]["SKAmount"] = dr["CurrentSKTotalRMB"].ToString();
                    bizObjects[i]["DKDate"] = dr["SKDate"].ToString() == "1753/01/01" ? "" : dr["SKDate"].ToString();
                    var st = dr["Status"].ToString();
                    bizObjects[i]["Status"] = st == "2" ? "收款中" : (st == "4" ? "收款完了" : "");
                    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), st);
                    foreach (var item in workItemDic)
                    {
                        Console.WriteLine(item.Key + item.Value);
                        if (item.Key.Equals("workItemId"))
                        {
                            bizObjects[i]["WorkItemId"] = item.Value;
                        }
                    }
                    i++;
                }
                this.ActionContext.InstanceData["SKRecordsPercent"].Value = bizObjects;
            }



            return base.LoadDataFields();
        }


    }
}
