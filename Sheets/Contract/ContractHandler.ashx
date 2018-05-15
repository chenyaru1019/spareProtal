﻿<%@ WebHandler Language="C#" Class="ContractHandler" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;
using OThinker.H3.Portal.Entity;
using OThinker.H3.Portal.service;
using System.Net.Http;

public class ContractHandler : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "generateContractNo": generateContractNo(context); break;
            case "getMasterByType": getMasterByType(context); break;
            case "getByContractNo": getByContractNo(context); break;
            case "getContactsByCompany": getContactsByCompany(context); break;
            case "getPaymentByID": getPaymentByID(context); break;
            case "getHYData": getHYData(context); break;
            case "getSalesHYData": getSalesHYData(context); break;
            case "getBidsHYData": getBidsHYData(context); break;
            case "getBizStatusOfContract": getBizStatusOfContract(context); break;
            case "getWorkItemIDByICPID": getWorkItemIDByICPID(context); break;
            case "getWorkItemIDByContractNo": getWorkItemIDByContractNo(context); break;
            case "getWorkItemIDAndInsNameByOID": getWorkItemIDAndInsNameByOID(context); break;
            case "getWorkItemByOID": getWorkItemByOID(context); break;
            case "getMaxQKSeqByContractNo": getMaxQKSeqByContractNo(context); break;
            case "setChangePayment": setChangePayment(context); break;
            case "getPaymentUpdateByPID": getPaymentUpdateByPID(context); break;
            case "cancelImportLicence": cancelImportLicence(context); break;
            case "getDHSeq": getDHSeq(context); break;
            case "getDHSeqCnt": getDHSeqCnt(context); break;
            case "getGoodNum": getGoodNum(context); break;
            case "getHGBZJ": getHGBZJ(context); break;
            case "getDHByBizObjectID": getDHByBizObjectID(context); break;
            case "getFKById": getFKById(context); break;
            case "getDKTbl": getDKTbl(context); break;
            case "getDKTblOfJS": getDKTblOfJS(context); break;
            case "getFKTblOfJS": getFKTblOfJS(context); break;
            case "getApplyZJAmount": getApplyZJAmount(context); break;
            case "getZFGLData": getZFGLData(context); break;
            case "getPayManager": getPayManager(context); break;
            case "insertOrUpdatePayManager": insertOrUpdatePayManager(context); break;
            case "getCountByConId": getCountByConId(context); break;
            case "getApplyingCountOfOper": getApplyingCountOfOper(context); break;
            case "getDataOfOper": getDataOfOper(context); break;
            case "getInstanceById": getInstanceById(context); break;
            case "getFinalUserTree": getFinalUserTree(context); break;
            case "getBidNoTree": getBidNoTree(context); break;
            case "getCurActivity": getCurActivity(context); break;
            case "getDataByInstanceId": getDataByInstanceId(context); break;
            case "getUnfinishedTask": getUnfinishedTask(context); break;
            case "getFinishedTask": getFinishedTask(context); break;
            case "getUnfinishedTaskCount": getUnfinishedTaskCount(context); break;
            case "getMyInstanceSub": getMyInstanceSub(context); break;
            case "getApprovalTblData": getApprovalTblData(context); break;
            case "getFullTextSearchData": getFullTextSearchData(context); break;
            case "getSubInstanceName": getSubInstanceName(context); break;
            case "getQKDetailByCurrency": getQKDetailByCurrency(context); break;
            case "getByInputBizObjectID": getByInputBizObjectID(context); break;
            case "getBHNo": getBHNo(context); break;
            case "IsDKRole": IsDKRole(context); break;
            case "setJKTotalAmount": setJKTotalAmount(context); break;

            // 批量
            case "getJSLSData": getJSLSData(context); break;
            case "getDKLSData": getDKLSData(context); break;
            case "getCustomerById": getCustomerById(context); break;
            case "setJS_Status": setJS_Status(context); break;
            case "getBatchJS_QKData": getBatchJS_QKData(context); break;
            case "getBatchJS_FKData": getBatchJS_FKData(context); break;
            case "getBatchJS_JQData": getBatchJS_JQData(context); break;
            case "getBatchDK_DKData": getBatchDK_DKData(context); break;
            case "getCurrencys": getCurrencys(context); break;
            case "SetQKLJDK": SetQKLJDK(context); break;

            //case "doBGContract": doBGContract(context); break;

            // admin 弃用
            // 获取流程节点数据
            case "PullInstanceNode": PullInstanceNode(context); break;

            // 合同主流程中各个Tab获取数据接口
            case "getPaymentStatusData": getPaymentStatusData(context); break; // 信用证状态
            case "getPaymentData": getPaymentData(context); break; // 信用证
            case "getImportData": getImportData(context); break; // 进口许可证        
            case "getDHData": getDHData(context); break; // 到货       
            case "getBGData": getBGData(context); break; // 合同变更       
            case "getBHData": getBHData(context); break; // 保函       
            case "getQKData": getQKData(context); break; // 请款     
            case "getDKStatusData": getDKStatusData(context); break; // 到款状态      
            case "getDKData": getDKData(context); break; // 到款
            case "getFKData": getFKData(context); break; // 付款       
            case "getFKJFData": getFKJFData(context); break; // 付款 
            case "getDKRecordTblOfJSData": getDKRecordTblOfJSData(context); break; // 到款结算状态       
            case "getFKRecordTblOfJSData": getFKRecordTblOfJSData(context); break; // 付款结算状态      
            case "getJSData": getJSData(context); break; // 结算     
            case "getPayManagerData": getPayManagerData(context); break; // 支付管理             
        }
    }

    public void generateContractNo (HttpContext context) {

        string ContractType = context.Request["ContractType"];
        string ContractProperty = context.Request["ContractProperty"];
        string ProjectCode = context.Request["ProjectCode"];
        string SubProjectCode = context.Request["SubProjectCode"];
        string Country = context.Request["Country"];
        string ContractNo = "";
        string year = DateTime.Now.Year.ToString().Substring(2,2);
        string projectStr = ""; // 工程编码
        // 国内合同
        if(ContractType.Equals("GN"))
        {
            //SPIAIE - 17028-PK-TILC II 01 015
            //SPIAIE：固定公司名称
            //17 : 当前年份
            //028 ：国内合同当年累积流水号
            //PK-TILC II ：最终用户对应的工程编码  ProjectCode+"-"+SubProjectCode+"II"
            //01 :  国内合同
            //015 : 对应工程下国内合同流水号（国内／进口分开）
            int curyearnum = (int)Convert.ToSingle(getMaxContNumOfCurYear(year)) + 1;
            if(!ProjectCode.Equals(""))
            {
                projectStr += "-" + ProjectCode;
            }
            if(!SubProjectCode.Equals(""))
            {
                projectStr += "-" + SubProjectCode;
            }
            if(!projectStr.Equals(""))
            {
                projectStr += "II";
            }
            int gnpronum = (int)Convert.ToSingle(getMaxContNumOfGNPro(projectStr,"01")) + 1;
            ContractNo = "SPIAIE-" + year + string.Format("{0:000}", curyearnum);// + "-" + SubProjectCode + "01" + string.Format("{0:000}",gnpronum);
            if(!projectStr.Equals(""))
            {
                ContractNo += projectStr + "01" + string.Format("{0:000}",gnpronum);
            }
            // 进口合同
        } else if (ContractType.Equals("JK"))
        {
            //17SPIAIE56-855BE-PK-5PDII 02 002
            //17 ：当前年份
            //SPIAIE：固定公司名称
            //56 ：合同性质，56对应货物、技术合同；34对应航空煤油
            //855 ：航油／非航油进口合同累积流水号（航油、非航油分开累计）
            //BE ：国别编码
            //PK－5PDII ：最终用户对应的工程编码
            //02 ：进口合同
            //002: 工程下进口合同流水号
            //备注：航油合同没有-PK-5PDII 02 002 
            string type = "";
            if(ContractProperty.Equals("ContractProperty_HKMY"))
            {
                type = "34";
            }else if(ContractProperty.Equals("ContractProperty_JS") || ContractProperty.Equals("ContractProperty_HW"))
            {
                type = "56";
            }
            if(!ProjectCode.Equals(""))
            {
                projectStr += "-" + ProjectCode;
            }
            if(!SubProjectCode.Equals(""))
            {
                projectStr += "-" + SubProjectCode;
            }
            if(!projectStr.Equals(""))
            {
                projectStr += "II";
            }
            int curyearnum = (int)Convert.ToSingle(getMaxContNumOfHY(year,type)) + 1;
            int gnpronum = (int)Convert.ToSingle(getMaxContNumOfGNPro(projectStr,"02")) + 1;
            if (ContractProperty.Equals("ContractProperty_HKMY"))
            {
                ContractNo = year + "SPIAIE" + type + "-" + string.Format("{0:000}",curyearnum) + Country;
            }else
            {
                ContractNo = year + "SPIAIE" + type + "-" + string.Format("{0:000}", curyearnum) + Country;
                if (!projectStr.Equals(""))
                {
                    ContractNo += projectStr + "02" + string.Format("{0:000}",gnpronum);
                }
            }

        }

        object JSONObj = JsonConvert.SerializeObject(ContractNo);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取Master的数据
    public void getMasterByType(HttpContext context)
    {
        string Type = context.Request["Type"];
        var sql = " select * from PD_Master where type = '"+Type+"' order by attr3";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 获取Master的数据
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("id", dr["id"].ToString());
                dic.Add("type", dr["type"].ToString());
                dic.Add("key", dr["key"].ToString());
                dic.Add("value", dr["value"].ToString());
                dic.Add("attr1", dr["attr1"].ToString());
                dic.Add("attr2", dr["attr2"].ToString());
                dic.Add("attr3", dr["attr3"].ToString());
                dic.Add("attr4", dr["attr4"].ToString());
                dic.Add("attr5", dr["attr5"].ToString());
                ls.Add(dic);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取国内合同当年累积流水号
    public string getMaxContNumOfCurYear(string year)
    {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ContractNo FROM I_ContractMain where ContractNo like 'SPIAIE-"+year+"%' ");
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                try
                {
                    int curnum = (int)Convert.ToSingle(dr["ContractNo"].ToString().Split('-')[1].Substring(2));
                    if (curnum > num)
                    {
                        num = curnum;
                    }
                }
                catch (Exception exp)
                {
                    continue;
                }

            }
            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }

    // 获取对应工程下国内合同流水号（国内／进口分开）
    public string getMaxContNumOfGNPro(string projectStr, string countrytype)
    {
        int num = 0;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ContractNo FROM I_ContractMain where ContractNo like '%"+projectStr+countrytype+"%' ");
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        int len = (projectStr + countrytype).Length;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                try
                {
                    int curnum = (int)Convert.ToSingle(dr["ContractNo"].ToString().Split('-')[2].Substring(len));
                    if (curnum > num)
                    {
                        num = curnum;
                    }

                }
                catch (Exception exp)
                {
                    continue;
                }

            }
            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }

    // 获取航油、非航油合同累积流水号
    public string getMaxContNumOfHY(string year, string type)
    {
        int num = 0;

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "SELECT ContractNo FROM I_ContractMain where ContractNo like '"+year+"SPIAIE"+type+"-%' ");
        List<Dictionary<string, string>> mList = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                try
                {
                    string tp = dr["ContractNo"].ToString().Split('-')[1];
                    int curnum = (int)Convert.ToSingle(tp.Substring(0, tp.Length - 2));
                    if (curnum > num)
                    {
                        num = curnum;
                    }

                }
                catch (Exception exp)
                {
                    continue;
                }
            }
            return num.ToString();
        } else
        {
            return num.ToString();
        }
    }

    public void getByContractNo (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        string ContractObjectID = context.Request["ContractObjectID"];
        // 国内合同
        ContractMain con = new ContractMain();
        string sql = " SELECT ContractNo,ContractName,PostA,PostB";
        sql += " ,ContractType,enum1.EnumValue as ContractTypeName" ;
        sql += " ,Country,enum2.EnumValue as CountryName" ;
        sql += " ,ContractProperty ,enum3.EnumValue as ContractPropertyName" ;
        sql += " ,Salers " ;
        sql += " ,FinalUser " ;
        sql += " ,BidNo " ;
        sql += " ,ContractRemark " ;
        sql += " ,enum4.EnumValue as AgencyTypeName " ;
        sql += " ,ProjectName " ;
        sql += " ,SubProjectName " ;
        sql += " ,SubProjectCode " ;
        sql += " ,TradeMethod " ;
        sql += " ,enum7.EnumValue as TradeMethodName " ;
        sql += " ,Country " ;
        sql += " ,ContractRemark " ;
        sql += " ,Salers " ;
        sql += " ,Currency " ;
        sql += " ,enum5.EnumValue  CurrencyName" ;
        sql += " ,ContractTotalPrice" ;
        sql += " ,JKTotalAmount" ;
        sql += " ,ContractDHDate" ;
        sql += " ,AgencyComputerNum" ;
        sql += " ,AgencyComputerType" ;
        sql += " ,enum6.EnumValue AgencyComputerTypeName" ;
        sql += " ,AgencyReturnType" ;
        sql += " ,AgencyReturnNumber" ;
        sql += " ,PayCondition" ;
        sql += " ,ContractFile" ;
        sql += " ,TalkFile" ;
        sql += " ,SignDayExchangeRate" ;
        sql += " ,ValuationType" ;
        sql += " ,Agio" ;
        sql += " FROM I_ContractMain con" ;
        sql += " LEFT JOIN OT_EnumerableMetadata enum1 on con.ContractType = enum1.Code and enum1.Category = '合同类型' " ;
        sql += " LEFT JOIN OT_EnumerableMetadata enum2 on con.Country = enum2.Code and enum2.Category = '国别'" ;
        sql += " LEFT JOIN OT_EnumerableMetadata enum3 on con.ContractProperty = enum3.Code and enum3.Category like '合同性质%'" ;
        sql += " LEFT JOIN OT_EnumerableMetadata enum4 on con.AgencyType = enum4.Code and enum4.Category = '合同审签_代理协议类型'" ;
        sql += " LEFT JOIN OT_EnumerableMetadata enum5 on con.Currency = enum5.Code and enum5.Category = '币种'" ;
        sql += " LEFT JOIN OT_EnumerableMetadata enum6 on con.AgencyComputerType = enum6.Code and enum6.Category = '代理费费率／金额'" ;
        sql += " LEFT JOIN OT_EnumerableMetadata enum7 on con.TradeMethod = enum7.Code and enum7.Category = '贸易方式'" ;
        if(ContractNo!=null && !ContractNo.Equals(""))
        {
            sql +=  " where con.ContractNo = '" + ContractNo + "'";
        }else if(ContractObjectID!=null && !ContractObjectID.Equals(""))
        {
            sql +=  " where con.ObjectID = '" + ContractObjectID + "'";
        }
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            con.ContractNo = dt.Rows[0]["ContractNo"].ToString();
            con.ContractName = dt.Rows[0]["ContractName"].ToString();
            //OThinker.Organization.User ua = Common.getUserById(dt.Rows[0]["PostA"].ToString());
            //OThinker.Organization.User ub = Common.getUserById(dt.Rows[0]["PostB"].ToString());
            con.PostA = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["PostA"].ToString());
            con.PostB = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["PostB"].ToString());
            con.PostACode = dt.Rows[0]["PostA"].ToString();
            con.PostBCode = dt.Rows[0]["PostB"].ToString();
            con.ContractType = dt.Rows[0]["ContractTypeName"].ToString();
            con.TradeMethod = dt.Rows[0]["TradeMethod"].ToString();
            con.TradeMethodName = dt.Rows[0]["TradeMethodName"].ToString();
            con.Country = dt.Rows[0]["CountryName"].ToString();
            con.ContractProperty = dt.Rows[0]["ContractPropertyName"].ToString();
            con.Salers = dt.Rows[0]["Salers"].ToString();
            con.FinalUser = dt.Rows[0]["FinalUser"].ToString();
            con.BidNo = dt.Rows[0]["BidNo"].ToString();
            con.ContractRemark = dt.Rows[0]["ContractRemark"].ToString();
            con.AgencyType = dt.Rows[0]["AgencyTypeName"].ToString();
            con.Currency = dt.Rows[0]["Currency"].ToString();
            con.CurrencyName = dt.Rows[0]["CurrencyName"].ToString();
            con.ContractTotalPrice = dt.Rows[0]["ContractTotalPrice"].ToString();
            con.JKTotalAmount = dt.Rows[0]["JKTotalAmount"].ToString();
            con.ContractDHDate = dt.Rows[0]["ContractDHDate"].ToString();
            con.AgencyComputerNum = dt.Rows[0]["AgencyComputerNum"].ToString();
            con.AgencyComputerType = dt.Rows[0]["AgencyComputerType"].ToString();
            con.AgencyComputerTypeName = dt.Rows[0]["AgencyComputerTypeName"].ToString();
            con.AgencyReturnType = dt.Rows[0]["AgencyReturnType"].ToString();
            con.AgencyReturnNumber = dt.Rows[0]["AgencyReturnNumber"].ToString();
            con.PayCondition = dt.Rows[0]["PayCondition"].ToString();
            con.ContractFile = dt.Rows[0]["ContractFile"].ToString();
            con.TalkFile = dt.Rows[0]["TalkFile"].ToString();
            con.SignDayExchangeRate = dt.Rows[0]["SignDayExchangeRate"].ToString();
            con.ValuationType = dt.Rows[0]["ValuationType"].ToString();
            con.Agio = dt.Rows[0]["Agio"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(con);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void getContactsByCompany (HttpContext context) {
        string Company = context.Request["Company"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT ct.ContactName,ct.Telephone,ct.Mobile,ct.Fax FROM I_CustomerList cl" +
            " INNER JOIN I_ContactsTbl ct on cl.ObjectID = ct.ParentObjectID and cl.CompanyName = '"+Company+"'" );
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("ContactName", dr["ContactName"].ToString());
                dic.Add("Telephone", dr["Telephone"].ToString());
                dic.Add("Fax", dr["Fax"].ToString());
                ls.Add(dic);
            }
        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    public void getByInputBizObjectID (HttpContext context) {
        string InputBizObjectID = context.Request["InputBizObjectID"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select BHTarget,e1.EnumValue BHType," +
            " e2.EnumValue BHProperty," +
            " CONVERT(varchar(12),ReceiveDate,111) ReceiveDate," +
            " BHAmount," +
            " CONVERT(varchar(12),ExpirationDate,111) ExpirationDate,Attachment,BHGDQX," +
            " CONVERT(varchar(12),RemindDate,111) RemindDate," +
            " CONVERT(varchar(12),ReturnAmountDate,111) ReturnAmountDate," +
            " e3.EnumValue Currency " +
            " from I_BHInput b" +
            " INNER JOIN OT_InstanceContext ic on b.ObjectID = ic.BizObjectId  and  b.ObjectID = '"+InputBizObjectID+"' " +
            " LEFT JOIN OT_EnumerableMetadata e1 on b.BHType = e1.Code and e1.Category = '保函类型' " +
            " LEFT JOIN OT_EnumerableMetadata e2 on b.BHProperty = e2.Code and e2.Category = '保函性质'" +
            " LEFT JOIN OT_EnumerableMetadata e3 on b.Currency = e3.Code and e3.Category = '币种'  " );
        System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select c.* " +
            " from OT_Comment c" +
            " INNER JOIN OT_InstanceContext ic on c.instanceId = ic.ObjectID" +
            " INNER JOIN I_BHInput bi on bi.ObjectID = ic.BizObjectID and bi.ObjectID = '"+InputBizObjectID+"'" +
            " ORDER BY c.CreatedTime desc " );
        if (dt.Rows.Count > 0)
        {
            dic.Add("BHTarget",dt.Rows[0]["BHTarget"].ToString());
            dic.Add("BHType",dt.Rows[0]["BHType"].ToString());
            dic.Add("BHProperty",dt.Rows[0]["BHProperty"].ToString());
            dic.Add("ReceiveDate",dt.Rows[0]["ReceiveDate"].ToString());
            dic.Add("BHAmount",dt.Rows[0]["BHAmount"].ToString());
            dic.Add("ExpirationDate",dt.Rows[0]["ExpirationDate"].ToString());
            dic.Add("Attachment",dt.Rows[0]["Attachment"].ToString());
            dic.Add("BHGDQX",dt.Rows[0]["BHGDQX"].ToString());
            dic.Add("RemindDate",dt.Rows[0]["RemindDate"].ToString());
            dic.Add("ReturnAmountDate",dt.Rows[0]["ReturnAmountDate"].ToString());
            dic.Add("Currency",dt.Rows[0]["Currency"].ToString());
        }
        if (dt2.Rows.Count > 0)
        {
            dic.Add("ApproveRemark",dt2.Rows[0]["Text"].ToString());
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void getPaymentByID (HttpContext context) {
        string PaymentObjectID = context.Request["PaymentObjectID"];
        Payment con = new Payment();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT top 1 * from I_PaymentSub where ObjectID = '"+PaymentObjectID+"'");
        if (dt.Rows.Count > 0)
        {
            con.PaymentNo = dt.Rows[0]["PaymentNo"].ToString();
            con.PaymentDate = dt.Rows[0]["PaymentDate"].ToString();
            con.ExpirationDate = dt.Rows[0]["ExpirationDate"].ToString();
            con.RemindDate = dt.Rows[0]["RemindDate"].ToString();
            //con.OperateRemark = dt.Rows[0]["OperateRemark"].ToString();
            con.PaymentAmount = dt.Rows[0]["PaymentAmount"].ToString();
            con.Currency = dt.Rows[0]["Currency"].ToString();
        } else
        {
            System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT top 1 * from I_PaymentUpdateSub where ObjectID = '"+PaymentObjectID+"'");
            if (dt2.Rows.Count > 0)
            {
                con.PaymentNo = dt2.Rows[0]["PaymentNo"].ToString();
                con.PaymentDate = dt2.Rows[0]["PaymentUpdateDate"].ToString();
                con.ExpirationDate = dt2.Rows[0]["ExpirationDate"].ToString();
                con.RemindDate = dt2.Rows[0]["RemindDate"].ToString();
                //con.OperateRemark = dt2.Rows[0]["OperateRemark"].ToString();
                con.PaymentAmount = dt2.Rows[0]["PaymentAmount"].ToString();
                con.Currency = dt2.Rows[0]["Currency"].ToString();
            }
        }

        object JSONObj = JsonConvert.SerializeObject(con);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void getDHByBizObjectID (HttpContext context) {
        string BizObjectID = context.Request["BizObjectID"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT top 1 * from I_DH where ObjectID = '"+BizObjectID+"'");
        if (dt.Rows.Count > 0)
        {
            dic.Add("ObjectID",dt.Rows[0]["ObjectID"].ToString());
            dic.Add("DHSeq",dt.Rows[0]["DHSeq"].ToString());
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void getFKById (HttpContext context) {
        string InsObjectID = context.Request["InsObjectID"];
        string BizObjectID = context.Request["BizObjectID"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        string sql = " SELECT f.ObjectID,Receiver,Content,BankName,BankAccount,CurZJAmount,Currency,e.EnumValue CurrencyName,c.[Text] Remark,f.FinalUser,";
        sql += " f.ContractNo,f.ContractName,ft.Amount,ft.ZKMS ";
        sql += " FROM I_FK f ";
        sql += " inner JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID ";
        sql += " inner JOIN OT_EnumerableMetadata e on f.Currency = e.Code and e.Category = '币种' ";
        sql += " INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectId ";
        if(InsObjectID != null && InsObjectID.ToString() != "")
        {
            sql += "  and ic.ObjectID = '" + InsObjectID + "' ";
        } else if (BizObjectID != null && BizObjectID.ToString() != "")
        {
            sql += "  and f.ObjectID = '" + BizObjectID + "' ";
        }
        sql += " left JOIN OT_Comment c on ic.ObjectID = c.InstanceId ";
        sql += "  ORDER BY c.CreatedTime desc ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            dic.Add("ObjectID",dt.Rows[0]["ObjectID"].ToString());
            dic.Add("Currency",dt.Rows[0]["Currency"].ToString());
            dic.Add("Receiver",dt.Rows[0]["Receiver"].ToString());
            dic.Add("Content",dt.Rows[0]["Content"].ToString());
            //dic.Add("DKRemark",dt.Rows[0]["DKRemark"].ToString());
            dic.Add("RightRemark","备注："+dt.Rows[0]["Remark"].ToString()+"\n"+"最终用户："+dt.Rows[0]["FinalUser"].ToString());
            dic.Add("BankName",dt.Rows[0]["BankName"].ToString());
            dic.Add("BankAccount",dt.Rows[0]["BankAccount"].ToString());
            dic.Add("CurZJAmount",dt.Rows[0]["CurZJAmount"].ToString());
            dic.Add("CurrencyName",dt.Rows[0]["CurrencyName"].ToString());
            var LeftRemark = dt.Rows[0]["ContractNo"].ToString() + " "+ dt.Rows[0]["ContractName"].ToString()+"\n";
            var tmp = "";
            foreach (DataRow dr in dt.Rows)
            {
                tmp += dt.Rows[0]["Currency"].ToString() + dr["Amount"] + " " + dr["ZKMS"]+"\n" ;
            }
            LeftRemark += tmp;
            dic.Add("LeftRemark",LeftRemark);
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    public void getHYData (HttpContext context) {
        Dictionary<string,string> dic = new Dictionary<string,string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT top 1 h.* from I_HYContractSet h,OT_InstanceContext ic where h.ObjectID = ic.BizObjectID order by h.modifiedTime desc ");
        if (dt.Rows.Count > 0) {
            dic.Add("ObjectID",dt.Rows[0]["ObjectID"].ToString());
            dic.Add("PostB",dt.Rows[0]["PostB"].ToString());
            dic.Add("FinalUser",dt.Rows[0]["FinalUser"].ToString());
            dic.Add("BidType",dt.Rows[0]["BidType"].ToString());
            dic.Add("BidNo",dt.Rows[0]["BidNo"].ToString());
            dic.Add("ContractType",dt.Rows[0]["ContractType"].ToString());
            dic.Add("ContractName",dt.Rows[0]["ContractName"].ToString());
            dic.Add("ContractShortName",dt.Rows[0]["ContractShortName"].ToString());
            dic.Add("ProjectName",dt.Rows[0]["ProjectName"].ToString());
            dic.Add("SubProjectName",dt.Rows[0]["SubProjectName"].ToString());
            dic.Add("SubProjectCode",dt.Rows[0]["SubProjectCode"].ToString());
            dic.Add("TradeMethod",dt.Rows[0]["TradeMethod"].ToString());
            dic.Add("Country",dt.Rows[0]["Country"].ToString());
            dic.Add("ContractRemark",dt.Rows[0]["ContractRemark"].ToString());
            dic.Add("Salers",dt.Rows[0]["Salers"].ToString());
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void getBidsHYData (HttpContext context) {
        // 
        string ObjectID = context.Request["ObjectID"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT bhy.* FROM I_BidTblOfHY bhy, I_HYContractSet hy where bhy.ParentObjectID = hy.ObjectID and hy.ObjectID = '"+ObjectID+"'");
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("ObjectID",dr["ObjectID"].ToString());
                dic.Add("ProjectShortName",dr["ProjectShortName"].ToString());
                dic.Add("BidPrice",dr["BidPrice"].ToString());
                ls.Add(dic);
            }

        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void getSalesHYData (HttpContext context) {
        // 
        string ObjectID = context.Request["ObjectID"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT shy.* FROM I_SalerTblOfHY shy, I_HYContractSet hy where shy.ParentObjectID = hy.ObjectID and hy.ObjectID = '"+ObjectID+"'");
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("ObjectID",dr["ObjectID"].ToString());
                dic.Add("CompanyName",dr["CompanyName"].ToString());
                dic.Add("ContactName",dr["ContactName"].ToString());
                dic.Add("Telephone",dr["Telephone"].ToString());
                dic.Add("Mobile",dr["Mobile"].ToString());
                dic.Add("Fax",dr["Fax"].ToString());
                dic.Add("Email",dr["Email"].ToString());
                ls.Add(dic);
            }

        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }



    // 获取业务子流程的状态，和合同号相关
    public void getBizStatusOfContract (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        string BizNo = context.Request["BizNo"];
        string ret = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT ic.State FROM I_"+BizNo+" tbl, OT_InstanceContext ic where tbl.ObjectID = ic.BizObjectId and tbl.ContractNo = '"+ContractNo+"'");
        if (dt.Rows.Count > 0) {
            ret = dt.Rows[0]["State"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    // 根据InstanceContext父节点id获取workItem的id
    public void getWorkItemIDByICPID (HttpContext context) {
        string InstanceId = context.Request["InstanceId"];
        // workItem的id
        string ObjectId = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select top 1 wi.ObjectId"+
            " from OT_InstanceContext ic,OT_WorkItem wi"+
            " where ic.ParentInstanceId = '"+InstanceId+"'"+
            " and ic.ObjectID = wi.InstanceId"+
            " order by ic.CreatedTime desc ");
        if (dt.Rows.Count > 0)
        {
            ObjectId = dt.Rows[0]["ObjectId"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(ObjectId);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 根据ContractNo获取workItem的id
    public void getWorkItemIDByContractNo (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        string CurrentUser = context.Request["CurrentUser"];
        Dictionary<string, string> workItemDic = new Dictionary<string, string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT top 1 ic.ObjectID ,ic.State "+
            " from I_ContractMain c "+
            " INNER JOIN OT_InstanceContext ic on c.ObjectID = ic.BizObjectId "+
            " and c.ContractNo = '"+ContractNo+"'");
        if (dt.Rows.Count > 0)
        {
            workItemDic = Common.getWorkItemIdNew(dt.Rows[0]["ObjectId"].ToString(),dt.Rows[0]["State"].ToString(),CurrentUser);
        }

        object JSONObj = JsonConvert.SerializeObject(workItemDic["workItemId"]);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    // 根据InstanceContext的Objectid获取workItem的id
    public void getWorkItemIDAndInsNameByOID (HttpContext context) {
        string InstanceId = context.Request["InstanceId"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        string InstanceName = "";
        string WorkItemId = "";
        string TokenID = "";
        string ParentInstanceName = "";
        string ParentWorkItemId = "";
        string ReturnFlg = "";
        string ApproveFlg = "";
        // workItem的id
        for(var time=0;time<6;time++)
        {
            System.Threading.Thread.Sleep(500);
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select top 1 ic.InstanceName,wi.ObjectId,wi.TokenID,wi.DisplayName"+
                " from OT_InstanceContext ic,OT_WorkItem wi"+
                " where ic.ObjectID = '"+InstanceId+"'"+
                " and ic.ObjectID = wi.InstanceId"+
                " order by ic.CreatedTime desc ");
            if (dt.Rows.Count > 0)
            {
                InstanceName = dt.Rows[0]["InstanceName"].ToString();
                WorkItemId = dt.Rows[0]["ObjectId"].ToString();
                TokenID = dt.Rows[0]["TokenID"].ToString();
                ApproveFlg = "进行中";
            }
            else
            {
                // workItem的id
                System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select top 1 ic.InstanceName,wi.ObjectId,wi.TokenID,wi.DisplayName" +
                    " from OT_InstanceContext ic,OT_WorkItemFinished wi" +
                    " where ic.ObjectID = '" + InstanceId + "'" +
                    " and ic.ObjectID = wi.InstanceId" +
                    " order by ic.CreatedTime desc ");
                if (dt2.Rows.Count > 0)
                {
                    InstanceName = dt2.Rows[0]["InstanceName"].ToString();
                    WorkItemId = dt2.Rows[0]["ObjectId"].ToString();
                    TokenID = dt2.Rows[0]["TokenID"].ToString();
                }
            }
            if (InstanceName.Equals(""))
            {
                System.Threading.Thread.Sleep(500);
            } else
            {
                break;
            }
        }
        // 如果是第一个节点，则认为是主流程中开启的子流程进行的提交操作，则返回到主流程，否则使用默认提交操作（关闭页面）
        if(ApproveFlg == "进行中" && TokenID.Equals("2")) //提交之后为2，提交之前的节点则为第一个
        {
            ReturnFlg = "Main";
        }


        InstanceName = InstanceName.IndexOf('.') > 0 ? InstanceName.Substring(0, InstanceName.IndexOf('.')) : InstanceName;
        System.Data.DataTable dt3 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT type,[key],attr1 FROM PD_Master "+
                " where attr1 = '"+InstanceName+"'");
        if (dt3.Rows.Count > 0)
        {
            foreach (DataRow dr in dt3.Rows)
            {
                if(dr["type"].ToString().Equals("ContractMain"))
                {
                    ParentInstanceName = "合同主流程";
                    string sql4 = "select top 1 wi.ObjectId ";
                    sql4 += " from I_" + dr["key"].ToString() + " t ";
                    sql4 += " INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId and ic.ObjectID = '" + InstanceId + "' ";
                    if(dr["key"].ToString().Equals("UpdateContractNo"))
                    {
                        sql4 += " INNER JOIN I_ContractMain mt on t.ContractObjectID = mt.ObjectID ";
                    } else
                    {
                        sql4 += " INNER JOIN I_ContractMain mt on t.ContractNo = mt.ContractNo ";

                    }
                    sql4 += " INNER JOIN OT_InstanceContext ic2 on mt.ObjectID = ic2.BizObjectId ";
                    sql4 += " INNER JOIN OT_WorkItem wi on ic2.ObjectID = wi.InstanceId ";

                    System.Data.DataTable dt_t = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql4);
                    if (dt_t.Rows.Count > 0)
                    {
                        ParentWorkItemId = dt_t.Rows[0]["ObjectId"].ToString();
                    }
                    break;
                }
                if(dr["type"].ToString().Equals("InviteBids"))
                {
                    ParentInstanceName = "招标项目主流程";break;
                }
                if(dr["type"].ToString().Equals("Agreement_mains"))
                {
                    ParentInstanceName = "协议主流程";break;
                }
            }
        }
        dic.Add("InstanceName",InstanceName);
        dic.Add("WorkItemId",WorkItemId);
        dic.Add("ParentInstanceName",ParentInstanceName);
        dic.Add("ParentWorkItemId",ParentWorkItemId);
        dic.Add("ReturnFlg",ReturnFlg);
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 根据InstanceContext的Objectid获取workItem的
    public void getWorkItemByOID (HttpContext context) {
        string InstanceId = context.Request["InstanceId"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        // workItem的id
        System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " select top 1 ObjectID,ActivityCode,DisplayName from OT_WorkItem  " +
                    " where InstanceId = '" + InstanceId + "' " +
                    " order by FinishTime desc");
        if (dt_wi.Rows.Count > 0)
        {
            dic.Add("workItemId", dt_wi.Rows[0]["ObjectID"].ToString());
            dic.Add("ActivityCode", dt_wi.Rows[0]["ActivityCode"].ToString());
            dic.Add("DisplayName", dt_wi.Rows[0]["DisplayName"].ToString());
        } else
        {
            System.Data.DataTable dt_wi2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select top 1 ObjectID,ActivityCode,DisplayName from OT_WorkItemFinished  " +
                " where InstanceId = '" + InstanceId + "' " +
                " order by FinishTime desc");
            if (dt_wi2.Rows.Count > 0)
            {
                dic.Add("workItemId", dt_wi2.Rows[0]["ObjectID"].ToString());
                dic.Add("ActivityCode", "End");
                dic.Add("DisplayName", "合同完成");
            }
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取合同号对应的请款最大批次
    public void getMaxQKSeqByContractNo (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        // workItem的id
        string QKSeq = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT Max(QKSeq) QKSeq FROM I_QK "+
            " where ContractNo = '"+ContractNo+"'");
        if (dt.Rows.Count > 0)
        {
            QKSeq = dt.Rows[0]["QKSeq"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(QKSeq);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void setChangePayment (HttpContext context) {
        string PaymentObjectID = context.Request["PaymentObjectID"];
        string Status = context.Request["Status"];
        string PaymentAmount = context.Request["PaymentAmount"];

        string sql1 = " update I_PaymentSub set ";
        sql1 += " changePaymentFlg = '"+Status+"', ";
        if(Status.Equals("4"))
        {
            sql1 += " AfterChangeAmount = "+PaymentAmount;
        }
        sql1 += " where ObjectID = '"+PaymentObjectID+"' ";

        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql1);

        System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " update I_PaymentUpdateSub set changePaymentFlg = '"+Status+"' where ObjectID = '"+PaymentObjectID+"' ");

        object JSONObj = JsonConvert.SerializeObject("");
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public void cancelImportLicence (HttpContext context) {
        string ImportLicenseId = context.Request["ImportLicenseId"];
        string flg = context.Request["flg"];
        string cancelFlg = "";
        if(flg.Equals("cancel"))
        {
            cancelFlg = "1";
        } else if(flg.Equals("undocancel"))
        {
            cancelFlg = "0";
        }

        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " update I_ImportLicenseSub set cancelFlg = '"+cancelFlg+"' where ObjectID = '"+ImportLicenseId+"' ");

        object JSONObj = JsonConvert.SerializeObject("");
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    public void getPaymentUpdateByPID (HttpContext context) {
        // 
        string PObjectID = context.Request["PObjectID"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT p.BankName," +
            " up.PaymentAmount," +
            " ic.State Status," +
            " case ic.State when '2' then '审批中' when '4' then '已开证' end DisplayName, " +
            " up.CreatedTime," +
            " ic.ObjectID," +
            " p.PaymentNo PaymentId, " +
            " case up.changePaymentFlg when '2' then '改证中' when '4' then '已改证' end changePaymentFlg " +
            " FROM I_PaymentUpdateSub up ,OT_InstanceContext ic ,I_PaymentSub p " +
            " where p.ObjectID ='603ea6c6-054e-4eff-8dd9-9a961b248e45' " +
            " and up.ObjectID = ic.BizObjectId and p.paymentNo = up.paymentno " +
            " order by CreatedTime desc ");
        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("BankName",dr["BankName"].ToString());
                dic.Add("PaymentAmount",dt.Rows[0]["PaymentAmount"].ToString());
                dic.Add("DisplayName",dt.Rows[0]["DisplayName"].ToString());
                dic.Add("changePaymentFlg",dt.Rows[0]["changePaymentFlg"].ToString());

                ls.Add(dic);
            }

        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取到货批次
    public void getDHSeq (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        string DHSeq = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select ISNULL(Max(DHSeq),0) + 1 DHSeq from I_DH dh" +
            " where ContractNo = '"+ContractNo+"' ");
        if (dt.Rows.Count > 0)
        {
            DHSeq = dt.Rows[0]["DHSeq"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(DHSeq);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取到货批次的数量
    public void getDHSeqCnt (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        string DHSeq = context.Request["DHSeq"];
        string Cnt = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select Count(1) Cnt from I_DH" +
            " where ContractNo = '"+ContractNo+"' and DHSeq = '"+DHSeq+"'  ");
        if (dt.Rows.Count > 0)
        {
            Cnt = dt.Rows[0]["Cnt"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(Cnt);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取商品数量
    public void getGoodNum (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        string DHSeq = context.Request["DHSeq"];
        string GoodName = context.Request["GoodName"];
        string Num = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select g.Num from I_DHGoodsTbl g, I_DH d " +
            " where d.ContractNo = '"+ContractNo+"' " +
            " and d.DHSeq = '"+DHSeq+"' " +
            " and g.GoodName = '"+GoodName+"'" +
            " and g.parentObjectId = d.ObjectId" );
        if (dt.Rows.Count > 0)
        {
            Num = dt.Rows[0]["Num"].ToString();
        }

        object JSONObj = JsonConvert.SerializeObject(Num);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取海关保证金
    public void getHGBZJ (HttpContext context) {
        string ContractNo = context.Request["ContractNo"];
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select e1.EnumValue as ZJKX,  " +
            " convert(varchar(20),convert(decimal(18,2),ft.Amount))+e2.EnumValue as Amount, " +
            " convert(varchar(20),convert(decimal(18,2),f.ConvertAmount))+'人民币' as ConvertAmount,  " +
            " f.Content as PayContent, e3.EnumValue as PayType,f.Receiver as Receiver " +
            " from I_FK f " +
            " INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID and f.ContractNo = '"+ContractNo+"' and ft.ZJKX = 'ZJKX_HGBZJ_FY' " +
            " INNER JOIN OT_EnumerableMetadata e1 on ft.ZJKX=e1.Code and e1.Category='资金款项' " +
            " INNER JOIN OT_EnumerableMetadata e2 on f.Currency=e2.Code and e2.Category='币种' " +
            " INNER JOIN OT_EnumerableMetadata e3 on f.PayType=e3.Code and e3.Category='支付方式' "
            );

        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                dic.Add("ZJKX",dr["ZJKX"].ToString());
                dic.Add("Amount",dr["Amount"].ToString());
                dic.Add("ConvertAmount",dr["ConvertAmount"].ToString());
                dic.Add("PayContent",dr["PayContent"].ToString());
                dic.Add("PayType",dr["PayType"].ToString());
                dic.Add("Receiver",dr["Receiver"].ToString());
                ls.Add(dic);
            }

        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取到款记录（到款模块中）
    public void getDKTbl(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];
        //var dksql = " select t1.*,t2.cnt SeqCnt,t3.ConvertAmountSum QKConvertAmount from ( "+
        //                " SELECT "+
        //                " 	tbl.ObjectID QKObjectID," +
        //                "   qk.QKSeq QKSeq, "+
        //                "   tbl.ParentIndex, "+
        //                " 	tbl.QKType QKTypeCode, "+
        //                " 	e3.EnumValue QKType, "+
        //                " 	qk.QKTarget, "+
        //                " 	CONVERT(varchar(12),qk.ModifiedTime,111) QKDate, "+
        //                " 	e2.EnumValue ZJKX, "+
        //                " 	tbl.ZJMS, "+
        //                " 	tbl.Amount QKAmount, " +
        //                "   tbl.Rate QKRate,"+
        //                " 	tbl.LJDKAmount LJDKAmount, " +
        //                "   tbl.LJDKAmountWB LJDKAmountWB,"+
        //                " 	tbl.Currency QKCurrencyCode, "+
        //                " 	e1.EnumValue QKCurrency "+
        //                " FROM "+
        //                " 	I_QK qk "+
        //                " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款') "+
        //                " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4' and qk.ContractNo = '"+ContractNo+"'  "+
        //                " LEFT JOIN OT_EnumerableMetadata e1 ON tbl.Currency = e1.Code AND e1.Category = '币种' "+
        //                " LEFT JOIN OT_EnumerableMetadata e2 ON tbl.ZJKX = e2.Code AND e2.Category = '资金款项' " +
        //                " LEFT JOIN OT_EnumerableMetadata e3 ON tbl.QKType = e3.Code AND e3.Category = '请款类型'"+
        //                " ) t1, "+
        //                " (select QKSeq,count(1) cnt FROM "+
        //                " 	I_QK qk "+
        //                " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款') "+
        //                " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4' "+
        //                " and qk.ContractNo = '"+ContractNo+"' "+
        //                " group by qk.QKSeq "+
        //                " ) t2, "+
        //                " (select QKSeq,sum(tbl.ConvertAmount) ConvertAmountSum FROM "+
        //                " 	I_QK qk "+
        //                " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款') "+
        //                " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4' "+
        //                " and qk.ContractNo = '"+ContractNo+"' "+
        //                " group by qk.QKSeq "+
        //                " ) t3 "+
        //                " where t1.QKSeq = t2.QKSeq  and t1.QKSeq = t3.QKSeq "+
        //                " order BY t1.QKSeq,t1.ParentIndex ";
        var ContractProperty = "";
        System.Data.DataTable dt_hy = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select top 1 ContractProperty from I_ContractMain where ContractNo = '"+ContractNo+"'");
        if (dt_hy.Rows.Count > 0)
        {
            ContractProperty = dt_hy.Rows[0]["ContractProperty"].ToString();
        }
        // 获取请款记录
        var dksql = "";
        //航油请款的折算金额不按币种分开，非航油的折算金额按币种分开
        //if (ContractProperty != "ContractProperty_HKMY")
        //{
        dksql =
        "   SELECT qk.ObjectId QKObjectID," +
        "   tbl.ObjectId QKSubObjectID, "+
        "	qk.QKSeq QKSeq,	 "+
        "	tbl.QKType QKTypeCode, "+
        "	e2.EnumValue QKType, "+
        "	e3.EnumValue ZJKX, "+
        "	tbl.ZJMS ZJMS, "+
        "	tbl.Amount Amount, "+
        "	tbl.Rate QKRate," +
        "   CONVERT(varchar(12),qk.ModifiedTime,111) QKDate, "+
        "	tbl.ConvertAmount ConvertAmount,  "+
        "	tbl.LJDKAmount LJDKAmount, "+
        "	tbl.LJDKAmountWB LJDKAmountWB, "+
        "	qk.QKTarget QKTarget, "+
        "	tbl.Currency QKCurrency, "+
        "	e1.EnumValue QKCurrencyName  "+
        "   FROM I_QK qk   "+
        "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID   "+
        "   and qk.ContractNo =  '"+ContractNo+"' and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款') "+
        "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4'  "+
        "   LEFT JOIN OT_EnumerableMetadata e1 on tbl.Currency = e1.Code and e1.Category = '币种'  "+
        "   LEFT JOIN OT_EnumerableMetadata e2 on tbl.QKType = e2.Code and e2.Category = '请款类型'  "+
        "   LEFT JOIN OT_EnumerableMetadata e3 ON tbl.ZJKX = e3.Code AND e3.Category = '资金款项' "+
        "   order by qk.QKSeq,e2.SortKey,tbl.Currency,tbl.ParentIndex  ";
        //} else
        //    {
        //        dksql =
        //        "   SELECT qk.ObjectId QKObjectID," +
        //        "   tbl.ObjectId QKSubObjectID, "+
        //        "	qk.QKSeq QKSeq,	 "+
        //        "	tbl.QKType QKTypeCode, "+
        //        "	e3.EnumValue ZJKX, "+
        //        "	tbl.ZJMS ZJMS, "+
        //        "	tbl.Amount Amount, "+
        //        "	tbl.Rate QKRate," +
        //        "   CONVERT(varchar(12),qk.ModifiedTime,111) QKDate, "+
        //        "	tbl.ConvertAmount ConvertAmount,  "+
        //        "	tbl.LJDKAmount LJDKAmount, "+
        //        "	tbl.LJDKAmountWB LJDKAmountWB, "+
        //        "	qk.QKTarget QKTarget, "+
        //        //"	tbl.Currency QKCurrencyCode, "+
        //        "	e1.EnumValue QKCurrencyName" +
        //        "   ,'' QKType,'' QKCurrency  "+
        //        "   FROM I_QK qk   "+
        //        "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID   "+
        //        "   and qk.ContractNo =  '"+ContractNo+"' and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款') "+
        //        "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4'  "+
        //        "   LEFT JOIN OT_EnumerableMetadata e1 on tbl.Currency = e1.Code and e1.Category = '币种'  "+
        //        "   LEFT JOIN OT_EnumerableMetadata e3 ON tbl.ZJKX = e3.Code AND e3.Category = '资金款项' "+
        //        "   order by qk.QKSeq,tbl.ParentIndex  ";
        //    }

        // 正在审批中的 到款 和 批量到款 的QKObjectID
        var sql_dk = " select dt.QKObjectID,dt.QKType,dt.QKCurrency,dt.CurDKAmount "+
                        " from I_DK d "+
                        " INNER JOIN I_DKTbl dt on d.ObjectID = dt.ParentObjectID and dt.CurDKAmount > 0 and d.ContractNo ='"+ContractNo+"'"+
                        " INNER JOIN OT_InstanceContext ic ON d.ObjectId = ic.BizObjectID and ic.State = '2'  "+
                        " Union "+
                        " select bdt.QKObjectID,bdt.QKType,bdt.QKCurrency,bdt.CurDKAmount "+
                        " from I_BatchDK_DK bd "+
                        " INNER JOIN I_BatchDKTblOfDK bdt on bd.ObjectID = bdt.ParentObjectID and cast(bdt.CurDKAmount as DECIMAL) > 0  "+
                        " INNER JOIN OT_InstanceContext ic ON bd.ObjectId = ic.BizObjectID and ic.State = '2'  " ;
        System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dksql);
        System.Data.DataTable dt_dk2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_dk);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //if (dt_dk.Rows.Count > 0)
        //{
        //    foreach (DataRow dr in dt_dk.Rows)
        //    {
        //        if(!Common.Contains(dt_dk2,dr["QKObjectID"].ToString()))
        //        {
        //            Dictionary<string, string> dic = new Dictionary<string, string>();
        //            dic.Add("ContractNo", ContractNo);
        //            dic.Add("QKSeq", dr["QKSeq"].ToString());
        //            dic.Add("QKObjectID", dr["QKObjectID"].ToString());
        //            dic.Add("QKType", dr["QKType"].ToString());
        //            dic.Add("QKTypeCode", dr["QKTypeCode"].ToString());
        //            dic.Add("QKTarget", dr["QKTarget"].ToString());
        //            dic.Add("QKDate", dr["QKDate"].ToString());
        //            dic.Add("ZJKX", dr["ZJKX"].ToString());
        //            dic.Add("ZJMS", dr["ZJMS"].ToString());
        //            dic.Add("QKAmount", dr["QKAmount"].ToString());
        //            dic.Add("QKCurrencyCode", dr["QKCurrencyCode"].ToString());
        //            dic.Add("QKCurrency", dr["QKCurrency"].ToString());
        //            dic.Add("QKRate", dr["QKRate"].ToString());
        //            dic.Add("QKConvertAmount", dr["QKConvertAmount"].ToString());
        //            dic.Add("SeqCnt", dr["SeqCnt"].ToString());
        //            dic.Add("LJDKAmount", dr["LJDKAmount"].ToString());
        //            dic.Add("LJDKAmountWB", dr["LJDKAmountWB"].ToString());
        //            ls.Add(dic);
        //        } else{
        //            Dictionary<string, string> dic = new Dictionary<string, string>();
        //            dic.Add("ContractNo", ContractNo);
        //            dic.Add("QKSeq", dr["QKSeq"].ToString());
        //            ls_sub.Add(dic);
        //        }
        //    }
        //}
        //ret = Common.Subs(ls,ls_sub);
        if (dt_dk.Rows.Count > 0)
        {
            var i = 0;
            var QKSeq = "";
            var QKType = "";
            var QKCurrency = "";
            var QKConvertAmount = 0.0;
            var QKObjectID = "";
            int QKCnt = 0;
            int QKCurrencyCnt = 0;
            foreach (DataRow dr in dt_dk.Rows)
            {
                if(!Common.Contains(dt_dk2, dr["QKObjectID"].ToString() , dr["QKType"].ToString() , dr["QKCurrency"].ToString() ))
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    if (ContractProperty != "ContractProperty_HKMY")
                    {
                        if (!(QKSeq + QKType + QKCurrency).Equals(dr["QKSeq"].ToString() + dr["QKType"].ToString() + dr["QKCurrency"].ToString()))
                        {
                            // 设置请款单币种数量
                            setDic(ls,"QKCurrencyCnt",QKCurrencyCnt.ToString(),QKSeq,QKType,QKCurrency);
                            QKCurrencyCnt = 0;
                            // 设置请款折算金额合计
                            setDic(ls,"QKConvertAmount",QKConvertAmount.ToString(),QKSeq,QKType,QKCurrency);
                            QKConvertAmount = 0.0;
                        }
                        if (QKObjectID!="" && !(QKObjectID).Equals(dr["QKObjectID"].ToString()))
                        {
                            // 设置请款批次数量
                            setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
                            QKCnt = 0;
                        }
                    } else
                    {
                        if (QKObjectID!="" && !(QKObjectID).Equals(dr["QKObjectID"].ToString()))
                        {
                            // 设置请款批次数量
                            setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
                            QKCnt = 0;
                            // 设置请款单币种数量
                            setDic(ls,"QKCurrencyCnt3",QKCurrencyCnt.ToString(),QKObjectID,"","");
                            QKCurrencyCnt = 0;
                            // 设置请款折算金额合计
                            setDic(ls,"QKConvertAmount3",QKConvertAmount.ToString(),QKObjectID,"","");
                            QKConvertAmount = 0.0;
                        }
                    }

                    QKCurrencyCnt++;
                    QKCnt++;
                    QKObjectID = dr["QKObjectID"].ToString();
                    QKSeq = dr["QKSeq"].ToString();
                    QKType = dr["QKType"].ToString();
                    QKCurrency = dr["QKCurrency"].ToString();
                    QKConvertAmount += Convert.ToDouble(dr["ConvertAmount"].ToString()==""?"0":dr["ConvertAmount"].ToString());

                    dic.Add("QKObjectID",QKObjectID);
                    dic.Add("QKSubObjectID",dr["QKSubObjectID"].ToString());
                    dic.Add("QKSeq",QKSeq);
                    dic.Add("ZJKX",dr["ZJKX"].ToString());
                    dic.Add("ZJMS",dr["ZJMS"].ToString());
                    dic.Add("QKTarget",dr["QKTarget"].ToString());
                    dic.Add("QKAmount",dr["Amount"].ToString());
                    dic.Add("QKRate", dr["QKRate"].ToString());
                    dic.Add("QKDate", dr["QKDate"].ToString());
                    dic.Add("QKCurrency", QKCurrency);
                    dic.Add("QKCurrencyName",dr["QKCurrencyName"].ToString());
                    dic.Add("QKType",QKType);
                    dic.Add("QKTypeCode",dr["QKTypeCode"].ToString());
                    dic.Add("LJDKAmount", dr["LJDKAmount"].ToString());
                    dic.Add("LJDKAmountWB", dr["LJDKAmountWB"].ToString());
                    ls.Add(dic);
                    i++;
                }

            }
            if (ContractProperty != "ContractProperty_HKMY")
            {
                setDic(ls,"QKCurrencyCnt",QKCurrencyCnt.ToString(),QKSeq,QKType,QKCurrency);
                setDic(ls,"QKConvertAmount",QKConvertAmount.ToString(),QKSeq,QKType,QKCurrency);
            } else
            {
                setDic(ls,"QKCurrencyCnt3",QKCurrencyCnt.ToString(),QKObjectID,"","");
                setDic(ls,"QKConvertAmount3",QKConvertAmount.ToString(),QKObjectID,"","");
            }

            setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取到款记录（结算模块中）
    public void getDKTblOfJS(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        // 从到款模块中取数据
        //var dksql = " select d.ObjectID DKObjectID, (select top 1 dk.QKTargetCode from I_DKTbl dk where d.ObjectID = dk.ParentObjectID) QKTarget," +
        //            " e2.EnumValue DKType,  "+
        //            " CONVERT(varchar(12),d.DKDate,111) DKDate, "+
        //            " convert(varchar(20),convert(decimal(18,2),d.DKAmount)) DKAmount,e1.EnumValue DKCurrency,d.ModifiedTime,ic.ObjectID IcObjectId ,ic.State Status "+
        //            " from I_DK d "+
        //            " INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectId "+
        //            " INNER JOIN OT_EnumerableMetadata e1 ON d.DKCurrency = e1.Code AND e1.Category = '币种' "+
        //            " INNER JOIN OT_EnumerableMetadata e2 ON d.DKType = e2.Code AND e2.Category = '到款类型' "+
        //            " and d.ContractNo = '"+ContractNo+"'  and (d.DKAmount > 0 ) and ic.State = '4' order by d.CreatedTime ";
        var ContractProperty = "";
        System.Data.DataTable dt_hy = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select top 1 ContractProperty from I_ContractMain where ContractNo = '"+ContractNo+"'");
        if (dt_hy.Rows.Count > 0)
        {
            ContractProperty = dt_hy.Rows[0]["ContractProperty"].ToString();
        }
        // 获取到款记录
        var dksql = "";
        //航油请款的折算金额不按币种分开，非航油的折算金额按币种分开
        dksql =
        " select d.ObjectID DKObjectID, "+
        " dt.QKObjectID, " +
        " dt.QKSeqHidden QKSeq, "+
        " dt.QKTarget, "+
        " dt.QKType, "+
        " dt.ZJKX, "+
        " dt.ZJMS, "+
        " dt.QKAmount, "+
        " dt.QKCurrencyName, "+
        " dt.QKConvertAmount, "+
        " dt.DKType, "+
        " dt.CurDKAmount, "+
        " dt.CurDKAmountHidden, " +
        " CONVERT(varchar(12),d.DKDate,111) DKDate," +
        " dt.QKCurrencyCnt, " +
        " dt.SeqCnt, "+
        " e1.EnumValue CurDKCurrency," +
        " ic.ObjectID IcObjectId ,ic.State Status "+
        " from I_DK d "+
        " INNER JOIN I_DKTbl dt on d.ObjectID = dt.ParentObjectID and d.ContractNo = '"+ContractNo+"' and dt.CurDKAmountHidden > 0 "+
        " INNER JOIN OT_InstanceContext ic ON d.ObjectId = ic.BizObjectID and ic.State = '4'  "+
        " Left JOIN OT_EnumerableMetadata e1 ON dt.CurDKCurrency = e1.Code AND e1.Category = '币种' "+
        " order by d.DKDate,d.ObjectID,dt.ParentIndex ";

        Dictionary<string, string> dic_dkj_ok = new Dictionary<string, string>();
        if(ContractProperty != "航空煤油")
        {
            // 获取结算中的到款记录
            // 获取已经进行过结算处理的数据
            var jdksql_ok = " select dj.DKObjectID,dj.QKObjectID,dj.QKType,dj.QKCurrencyName,Max(ic.State) Status  " +
                        " from I_JS j  " +
                        " INNER JOIN I_DKTblOfJS dj on dj.ParentObjectID = j.ObjectID  " +
                        " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId " +
                        " and j.ContractNo = '" + ContractNo + "'  and dj.IsCheck = '是;'" +
                        " group by dj.DKObjectID,dj.QKObjectID,dj.QKType,dj.QKCurrencyName ";
            System.Data.DataTable dt_dkj_ok = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jdksql_ok);

            if (dt_dkj_ok.Rows.Count > 0)
            {
                foreach (DataRow dr in dt_dkj_ok.Rows)
                {
                    dic_dkj_ok.Add(dr["DKObjectID"].ToString()+dr["QKObjectID"].ToString()+dr["QKType"].ToString()+dr["QKCurrencyName"].ToString(), dr["Status"].ToString());
                }
            }
        } else
        {
            // 获取结算中的到款记录
            // 获取已经进行过结算处理的数据
            var jdksql_ok = " select dj.DKObjectID,dj.QKObjectID,Max(ic.State) Status  " +
                        " from I_JS j  " +
                        " INNER JOIN I_DKTblOfJS dj on dj.ParentObjectID = j.ObjectID  " +
                        " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId " +
                        " and j.ContractNo = '" + ContractNo + "'  and dj.IsCheck = '是;'" +
                        " group by dj.DKObjectID,dj.QKObjectID ";
            System.Data.DataTable dt_dkj_ok = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jdksql_ok);

            if (dt_dkj_ok.Rows.Count > 0)
            {
                foreach (DataRow dr in dt_dkj_ok.Rows)
                {
                    dic_dkj_ok.Add(dr["DKObjectID"].ToString()+dr["QKObjectID"].ToString(), dr["Status"].ToString());
                }
            }
        }
        //// 获取已经进行结算的到款数据，包含保存和提交和审批过的数据
        //var jdksql = " select dj.DKObjectID DKObjectID,dj.DKAmount from I_JS j  "+
        //           " INNER JOIN I_DKTblOfJS dj on dj.ParentObjectID = j.ObjectID  "+
        //           " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId "+
        //           " and j.ContractNo = '"+ContractNo+"'  and dj.IsCheck = '是;' "+
        //           " order by dj.ParentIndex ";
        System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dksql);
        //System.Data.DataTable dt_dkj = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jdksql);
        List<Dictionary<string, string>> ls_dk = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> ls_dkj = new List<Dictionary<string, string>>();
        //if (dt_dkj.Rows.Count > 0)
        //{
        //    var i = 0;
        //    foreach (DataRow dr in dt_dkj.Rows)
        //    {
        //        i++;
        //        Dictionary<string, string> dic = new Dictionary<string, string>();
        //        dic.Add("DKObjectID", dr["DKObjectID"].ToString());
        //        ls_dkj.Add(dic);
        //    }
        //}
        //if (dt_dk.Rows.Count > 0)
        //{
        //    var i = 0;
        //    foreach (DataRow dr in dt_dk.Rows)
        //    {
        //        // 如果已经结算过，那么跳过
        //        if(Common.Contains(ls_dkj,dr["DKObjectID"].ToString()))
        //        {
        //            continue;
        //        }
        //        i++;
        //        Dictionary<string, string> dic = new Dictionary<string, string>();
        //        dic.Add("TheNo", i.ToString());
        //        dic.Add("QKTarget", dr["QKTarget"].ToString());
        //        dic.Add("DKType", dr["DKType"].ToString());
        //        dic.Add("DKAmount", dr["DKAmount"].ToString());
        //        dic.Add("DKCurrency", dr["DKCurrency"].ToString());
        //        dic.Add("DKDate", dr["DKDate"].ToString());
        //        Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
        //        foreach (var item in workItemDic)
        //        {
        //            if (item.Key.Equals("workItemId"))
        //            {
        //                dic.Add("WorkItemId", item.Value);
        //            }
        //        }
        //        dic.Add("DKObjectID", dr["DKObjectID"].ToString());
        //        ls_dk.Add(dic);
        //    }
        //}
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_dk.Rows.Count > 0)
        {
            var i = 0;
            var DKObjectID = "";
            var QKObjectID = "";
            var QKCnt = 0;
            foreach (DataRow dr in dt_dk.Rows)
            {
                string key = "";
                if(ContractProperty != "航空煤油")
                {
                    key = dr["DKObjectID"].ToString() + dr["QKObjectID"].ToString()+ dr["QKType"].ToString() + dr["QKCurrencyName"].ToString();
                } else
                {
                    key = dr["DKObjectID"].ToString() + dr["QKObjectID"].ToString() ;
                }
                // 只对未结算的数据进行结算处理
                if(Common.getStatusOfDKJ(dic_dkj_ok, key)!="未结算")
                {
                    continue;
                }
                Dictionary<string, string> dic = new Dictionary<string, string>();
                if (DKObjectID!="" && QKObjectID!="" && !(DKObjectID + QKObjectID).Equals(dr["DKObjectID"].ToString() + dr["QKObjectID"].ToString()))
                {
                    // 设置请款批次数量
                    setDic(ls,"SeqCnt2",QKCnt.ToString(),DKObjectID,QKObjectID,"");
                    QKCnt = 0;
                }
                QKCnt++;
                DKObjectID = dr["DKObjectID"].ToString();
                QKObjectID = dr["QKObjectID"].ToString();
                dic.Add("DKObjectID",DKObjectID);
                dic.Add("QKObjectID",QKObjectID);
                dic.Add("QKSeq",dr["QKSeq"].ToString());
                dic.Add("QKTarget",dr["QKTarget"].ToString());
                dic.Add("QKType",dr["QKType"].ToString());
                dic.Add("ZJKX",dr["ZJKX"].ToString());
                dic.Add("ZJMS",dr["ZJMS"].ToString());
                dic.Add("QKAmount",dr["QKAmount"].ToString());
                dic.Add("QKCurrencyName", dr["QKCurrencyName"].ToString());
                dic.Add("QKConvertAmount", dr["QKConvertAmount"].ToString());
                dic.Add("DKType",dr["DKType"].ToString());
                dic.Add("CurDKAmount", dr["CurDKAmount"].ToString());
                dic.Add("CurDKCurrency", dr["CurDKCurrency"].ToString());
                dic.Add("DKDate", dr["DKDate"].ToString());
                dic.Add("QKCurrencyCnt", dr["QKCurrencyCnt"].ToString());
                //dic.Add("SeqCnt", dr["SeqCnt"].ToString());
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                foreach (var item in workItemDic)
                {
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                }
                ls.Add(dic);
                i++;
            }
            setDic(ls,"SeqCnt2",QKCnt.ToString(),DKObjectID,QKObjectID,"");

        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取付款记录（结算模块中）
    public void getFKTblOfJS(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        var fksql = " select t1.ObjectID FKObjectID,t1.ZKMS,convert(varchar(20),convert(decimal(18,2),t1.Amount)) as Amount,e1.EnumValue CurrencyName,  "+
                    " CONVERT(varchar(12),t1.FKDate,111) FKDate,t1.ConvertAmount, " +
                    " t1.BankFee,t1.AgencyFee, "+
                    " convert(varchar(20),convert(decimal(18,2),t2.AmountSum))+e1.EnumValue as AmountSum,t2.Cnt,t1.Receiver,t1.State Status,t1.IcObjectID  "+
                    " from   "+
                    " (  "+
                    " 	SELECT f.ObjectID,ft.ZKMS,ft.Amount,f.Currency,f.FKDate,f.ConvertAmount,f.ModifiedTime ,ft.ParentIndex,f.Receiver," +
                    "   f.BankFee,f.AgencyFee,"+
                    " 	ic.State,ic.ObjectID IcObjectID "+
                    " 	FROM I_FK f  "+
                    " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID  "+
                    " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID  and ic.State = '4' "+
                    " 	and f.ContractNo = '"+ContractNo+"'  "+
                    " ) t1 INNER JOIN   "+
                    " (  "+
                    " 	SELECT f.ObjectID,sum(ft.Amount) AmountSum,count(ft.ObjectID) Cnt  "+
                    " 	FROM I_FK f  "+
                    " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID  "+
                    " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID  and ic.State = '4' "+
                    " 	and f.ContractNo = '"+ContractNo+"'  "+
                    " 	GROUP BY f.ObjectID  "+
                    " ) t2 on t1.ObjectID = t2.ObjectID  "+
                    " LEFT JOIN OT_EnumerableMetadata e1 on t1.Currency = e1.Code and e1.Category = '币种'  "+
                    " order by t1.ModifiedTime ,t1.ObjectID,t1.ParentIndex    ";
        // 获取已经进行结算的付款数据，包含保存和提交和审批过的的数据
        var jfksql = " select dj.FKObjectID FKObjectID,dj.FKAmount from I_JS j  "+
                   " INNER JOIN I_FKTblOfJS dj on dj.ParentObjectID = j.ObjectID  "+
                   " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId "+
                   " and j.ContractNo = '"+ContractNo+"' and dj.IsCheck = '是;' "+
                   " order by dj.ParentIndex ";
        System.Data.DataTable dt_fk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(fksql);
        System.Data.DataTable dt_fkj = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jfksql);
        List<Dictionary<string, string>> ls_fk = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> ls_fkj = new List<Dictionary<string, string>>();
        if (dt_fkj.Rows.Count > 0)
        {
            var i = 0;
            foreach (DataRow dr in dt_fkj.Rows)
            {
                i++;
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("FKObjectID", dr["FKObjectID"].ToString());
                ls_fkj.Add(dic);
            }
        }
        if (dt_fk.Rows.Count > 0)
        {
            var i = 0;
            var TheNo = 0;
            var ObjectIDBak = "";
            foreach (DataRow dr in dt_fk.Rows)
            {
                // 如果已经结算过，那么跳过
                if(Common.Contains(ls_fkj,dr["FKObjectID"].ToString()))
                {
                    continue;
                }
                i++;
                Dictionary<string, string> dic = new Dictionary<string, string>();
                if (!ObjectIDBak.Equals(dr["FKObjectID"].ToString()))
                {
                    TheNo++;
                }
                ObjectIDBak = dr["FKObjectID"].ToString();
                dic.Add("TheNo", TheNo.ToString());

                // 如果是人民币，直接拿人民币合计作为折算金额
                if(dr["CurrencyName"].ToString().Equals("人民币"))
                {
                    dic.Add("ConvertAmount", dr["AmountSum"].ToString());
                } else
                {
                    // 如果有折算金额，则取之，不然就是没有折算金额
                    var ConvertAmount = Convert.ToDouble(dr["ConvertAmount"]);
                    if(ConvertAmount > 0)
                    {
                        dic.Add("ConvertAmount", dr["ConvertAmount"].ToString()+"人民币");
                    }

                }
                dic.Add("ZKMS", dr["ZKMS"].ToString());
                dic.Add("FKAmount", dr["Amount"].ToString());
                dic.Add("FKCurrency", dr["CurrencyName"].ToString());
                dic.Add("Receiver", dr["Receiver"].ToString());
                dic.Add("BankFee", dr["BankFee"].ToString());
                dic.Add("AgencyFee", dr["AgencyFee"].ToString());
                if (dr["Status"].ToString().Equals("4"))
                {
                    dic.Add("FKDate", dr["FKDate"].ToString());
                }

                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                }
                dic.Add("FKObjectID", dr["FKObjectID"].ToString());
                dic.Add("Cnt", dr["Cnt"].ToString());
                ls_fk.Add(dic);
            }

        }

        object JSONObj = JsonConvert.SerializeObject(ls_fk);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    //public void doBGContract (HttpContext context) {
    //    string BizObjcetID = context.Request["BizObjcetID"];

    //    System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
    //        " select * from I_BG where ObjectID = '"+BizObjcetID+"' ");
    //    System.Data.DataTable dt2 = null;

    //    if (dt.Rows.Count > 0)
    //    {

    //        var ContractNo = dt.Rows[0]["ContractNo"].ToString();
    //        var IsChangeAmountRMB = dt.Rows[0]["IsChangeAmountRMB"].ToString();
    //        var IsChangeAmountWB = dt.Rows[0]["IsChangeAmountWB"].ToString();
    //        var IsChangeDHDate = dt.Rows[0]["IsChangeDHDate"].ToString();
    //        var IsChangeAgency = dt.Rows[0]["IsChangeAgency"].ToString();
    //        var IsChangePayCondition = dt.Rows[0]["IsChangePayCondition"].ToString();
    //        string sql_update1 = " update I_ContractMain set ";
    //        string sql_update2 = " where ContractNo = '"+ContractNo+"'";
    //        string sql_t = "";
    //        if (IsChangeAmountRMB == "是")
    //        {
    //            sql_t += " ,ContractTotalPrice=" + dt.Rows[0]["AmountRMBNew"].ToString();
    //        }
    //        if (IsChangeAmountWB == "是")
    //        {
    //            sql_t += " ,JKTotalAmount=" + dt.Rows[0]["AmountWBNew"].ToString();
    //        }
    //        if (IsChangeDHDate == "是")
    //        {
    //            sql_t += " ,ContractDHDate='" + dt.Rows[0]["DHDateNew"].ToString() + "'";
    //        }
    //        if (IsChangeAgency == "是")
    //        {
    //            sql_t += " ,AgencyComputerNum=" + dt.Rows[0]["AgencyNumNew"].ToString();
    //        }
    //        if (IsChangePayCondition == "是")
    //        {
    //            sql_t += " ,PayCondition='" + dt.Rows[0]["PayConditionNew"].ToString() + "'";
    //        }
    //        if(sql_t != "")
    //        {
    //            dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
    //                sql_update1 + sql_t.Substring(2) + sql_update2);

    //        }
    //    }

    //    object JSONObj = JsonConvert.SerializeObject(dt2);
    //    context.Response.ContentType = "application/json";
    //    context.Response.Write(JSONObj);
    //}

    // 获取已申请支付金额
    public void getApplyZJAmount(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        var sql = " select t.Currency,sum(t.Amount) TotalAmount from ( "+
                    " 	select f.ZKType,f.Currency,ft.ZJKX,ft.Amount "+
                    " 	from I_FK f "+
                    " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID "+
                    " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID "+
                    " 	and f.ContractNo = '"+ContractNo+"' and ic.State='4' and f.ZKType = 'ZKType_HT' "+
                    " 	Union "+
                    " 	select f.ZKType,f.Currency,ft.ZJKX,ft.Amount "+
                    " 	from I_FK f "+
                    " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID "+
                    " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID and ic.State='2' "+
                    " 	INNER JOIN OT_WorkItem wi on ic.ObjectID = wi.InstanceId and f.ZKType = 'ZKType_HT' and wi.ActivityCode != 'ActivityOrig' "+
                    " 	and f.ContractNo = '"+ContractNo+"' ) t "+
                    " GROUP BY t.Currency ";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        Dictionary<string, string> dic = new Dictionary<string, string>();
        dic.Add("RMB", "0");
        dic.Add("WB", "0");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                if(dr["Currency"].ToString() == "RMB")
                {
                    if (dic.ContainsKey("RMB"))
                    {
                        dic.Remove("RMB");
                    }
                    dic.Add("RMB", dr["TotalAmount"].ToString());
                } else
                {
                    if (dic.ContainsKey("WB"))
                    {
                        dic.Remove("WB");
                    }
                    dic.Add("WB", dr["TotalAmount"].ToString());
                }

            }

        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取支付管理中的基本数据（资金计划，请款，到款，付款）
    public void getZFGLData(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        var sql_zjjh = " SELECT pt.ObjectID,pt.Content " +
                            " FROM I_ZJPlan p" +
                            " INNER JOIN I_PlanTbl pt on p.ObjectID = pt.ParentObjectID " +
                            " INNER JOIN OT_InstanceContext ic on p.ObjectID = ic.BizObjectId " +
                            " and p.ContractNo = '"+ContractNo+"'" +
                            " order by pt.parentIndex ";
        var sql_qk = " SELECT "+
                            " 	t.QKObjectId, "+
                            " 	t.QKSeq, "+
                            " 	CAST (t.Amount AS VARCHAR) + e.EnumValue Amount "+
                            " FROM "+
                            " 	( "+
                            " 	SELECT "+
                            " 		MAX (qk.ObjectId) QKObjectId, "+
                            " 		qk.QKSeq QKSeq, "+
                            " 		SUM (tbl.Amount) Amount, "+
                            " 		SUM (tbl.ConvertAmount) ConvertAmount, "+
                            " 		MAX (qk.QKTarget) QKTarget, "+
                            " 		tbl.Currency, "+
                            " 		MAX (ic.ObjectID) icObjectId, "+
                            " 		MAX (qk.RejectFlg) RejectFlg "+
                            " 	FROM "+
                            " 		I_QK qk "+
                            " 	INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID "+
                            " 	INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID "+
                            " 	AND qk.ContractNo = '"+ContractNo+"' and ic.State = '4' "+
                            " 	GROUP BY "+
                            " 		qk.QKSeq, "+
                            " 		tbl.Currency "+
                            " 	) t "+
                            " LEFT JOIN OT_EnumerableMetadata e ON t.Currency = e.Code AND e.Category = '币种' "+
                            " ORDER BY "+
                            " 	t.QKSeq ";
        var sql_dk = " select  d.ObjectID DKObjectID, "+
                            " (select top 1 dk.QKSeqHidden from I_DKTbl dk where d.ObjectID = dk.ParentObjectID) QKSeq," +
                            " (select top 1 dk.ZJMS from I_DKTbl dk where d.ObjectID = dk.ParentObjectID) ZJMS," +
                            " CONVERT(varchar,d.DKAmount)+e1.EnumValue DKTotalAmount "+
                            " from I_DK d "+
                            " INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectId "+
                            " INNER JOIN OT_EnumerableMetadata e1 ON d.DKCurrency = e1.Code AND e1.Category = '币种' "+
                            " and d.ContractNo = '"+ContractNo+"'  and d.DKAmount > 0 and ic.State = '4' "+
                            " order by d.ModifiedTime  ";
        var sql_fk = " select t.FKObjectID,min(t.Currency) Currency,min(t.CurrencyName) CurrencyName,  "+
                            "  min(t.FKDate) FKDate,min(t.ConvertAmount) ConvertAmount,  "+
                            "  min(t.AmountSum) AmountSum, min(t.Content) Content,t.ModifiedTime "+
                            " from ( "+
                            "  select t1.ObjectID FKObjectID,cast(t1.Amount as varchar)+e1.EnumValue as Amount,t1.Currency,e1.EnumValue CurrencyName,  "+
                            "  CONVERT(varchar(12),t1.FKDate,111) FKDate,t1.ConvertAmount,  "+
                            "  cast(t2.AmountSum as varchar)+e1.EnumValue as AmountSum, t1.Content,t1.ModifiedTime "+
                            "  from   "+
                            "  (  "+
                            "  	SELECT f.ObjectID,ft.Amount,f.Currency,f.FKDate,f.ConvertAmount,f.ModifiedTime ,ft.ParentIndex,f.Content "+
                            "  	FROM I_FK f  "+
                            "  	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID  "+
                            "  	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID  "+
                            "  	and f.ContractNo = '"+ContractNo+"'  and ic.State = '4' "+
                            "  ) t1 INNER JOIN   "+
                            "  (  "+
                            "  	SELECT f.ObjectID,sum(ft.Amount) AmountSum  "+
                            "  	FROM I_FK f  "+
                            "  	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID  "+
                            "  	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID  "+
                            "  	and f.ContractNo = '"+ContractNo+"'  and ic.State = '4' "+
                            "  	GROUP BY f.ObjectID  "+
                            "  ) t2 on t1.ObjectID = t2.ObjectID  "+
                            "  LEFT JOIN OT_EnumerableMetadata e1 on t1.Currency = e1.Code and e1.Category = '币种'  "+
                            " ) t "+
                            " GROUP BY t.ModifiedTime,t.FKObjectID "+
                            " ORDER BY t.ModifiedTime,t.FKObjectID ";
        System.Data.DataTable dt_zjjh = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_zjjh);
        System.Data.DataTable dt_qk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_qk);
        System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_dk);
        System.Data.DataTable dt_fk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_fk);
        Dictionary<string, List<Dictionary<string, string>>> dic_all = new Dictionary<string, List<Dictionary<string, string>>>();
        List<Dictionary<string, string>> ls_zjjh = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> ls_qk = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> ls_dk = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> ls_fk = new List<Dictionary<string, string>>();
        // 资金计划
        if (dt_zjjh.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_zjjh.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("key", dr["ObjectID"].ToString());
                dic.Add("value", dr["Content"].ToString());
                ls_zjjh.Add(dic);
            }
        }
        // 请款
        if (dt_qk.Rows.Count > 0)
        {
            var QKSeq = "";
            var Amount = "";
            foreach (DataRow dr in dt_qk.Rows)
            {

                if(!QKSeq.Equals("") && !QKSeq.Equals(dr["QKSeq"].ToString()))
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("key", QKSeq);
                    dic.Add("value", "批次:"+QKSeq+"("+Amount+")");
                    ls_qk.Add(dic);
                    Amount = dr["Amount"].ToString()+" ";
                } else
                {
                    Amount += dr["Amount"].ToString()+" ";
                }
                QKSeq = dr["QKSeq"].ToString();
            }
            Dictionary<string, string> dic2 = new Dictionary<string, string>();
            dic2.Add("key", QKSeq);
            dic2.Add("value", "批次:"+QKSeq+"("+Amount+")");
            ls_qk.Add(dic2);
        }
        // 到款
        if (dt_dk.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_dk.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("key", dr["DKObjectID"].ToString());
                dic.Add("value", dr["DKTotalAmount"].ToString() + "(请款批次:"+ dr["QKSeq"].ToString() + " "+dr["ZJMS"].ToString()+")");
                ls_dk.Add(dic);
            }
        }
        // 付款
        if (dt_fk.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_fk.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("key", dr["FKObjectID"].ToString());
                if(dr["Currency"].ToString().Equals("RMB"))
                {
                    dic.Add("value", dr["AmountSum"].ToString() + "("+ dr["FKDate"].ToString() + " "+dr["Content"].ToString()+")");
                } else
                {
                    // 如果有折算金额，则取之，不然就是没有折算金额
                    var ConvertAmount = Convert.ToDouble(dr["ConvertAmount"]);
                    if(ConvertAmount > 0)
                    {
                        dic.Add("value", dr["ConvertAmount"].ToString() + "人民币("+ dr["FKDate"].ToString() + " "+dr["Content"].ToString()+")");
                    }
                    else
                    {
                        dic.Add("value", "无折算金额("+ dr["FKDate"].ToString() + " "+dr["Content"].ToString()+")");
                    }
                }

                ls_fk.Add(dic);
            }
        }
        dic_all.Add("zjjh",ls_zjjh);
        dic_all.Add("qk",ls_qk);
        dic_all.Add("dk",ls_dk);
        dic_all.Add("fk",ls_fk);
        object JSONObj = JsonConvert.SerializeObject(dic_all);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取支付管理表中的数据
    public void getPayManager(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        var sql = " select * from PD_PayManager where ContractNo = '"+ContractNo+"' order by id";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 支付管理
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("id", dr["id"].ToString());
                dic.Add("ZJJH_Keys", dr["ZJJH_Keys"].ToString());
                dic.Add("ZJJH_Values", dr["ZJJH_Values"].ToString().Replace(",","<br>"));
                dic.Add("QK_Keys", dr["QK_Keys"].ToString());
                dic.Add("QK_Values", dr["QK_Values"].ToString().Replace(",","<br>"));
                dic.Add("DK_Keys", dr["DK_Keys"].ToString());
                dic.Add("DK_Values", dr["DK_Values"].ToString().Replace(",","<br>"));
                dic.Add("FK_Keys", dr["FK_Keys"].ToString());
                dic.Add("FK_Values", dr["FK_Values"].ToString().Replace(",","<br>"));
                dic.Add("JSAmount", dr["JSAmount"].ToString());
                ls.Add(dic);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 插入支付管理表
    public void insertOrUpdatePayManager(HttpContext context)
    {
        string Flg = context.Request["Flg"];
        string ContractNo = context.Request["ContractNo"];
        string id = context.Request["id"];
        string zjjh_keys = context.Request["zjjh_keys"];
        string zjjh_values = context.Request["zjjh_values"];
        string qk_keys = context.Request["qk_keys"];
        string qk_values = context.Request["qk_values"];
        string dk_keys = context.Request["dk_keys"];
        string dk_values = context.Request["dk_values"];
        string fk_keys = context.Request["fk_keys"];
        string fk_values = context.Request["fk_values"];
        string djsje = context.Request["djsje"];
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        try
        {
            if(Flg.Equals("insert"))
            {
                var sql = " insert into PD_PayManager ( " +
                " ZJJH_Keys, " +
                " ZJJH_Values, " +
                " QK_Keys, " +
                " QK_Values, " +
                " DK_Keys, " +
                " DK_Values, " +
                " FK_Keys, " +
                " FK_Values, " +
                " JSAmount, " +
                " ContractNo," +
                " modifyTime " +
                " ) " +
                " values ( " +
                " '" + zjjh_keys + "', " +
                " '" + zjjh_values + "', " +
                " '" + qk_keys + "', " +
                " '" + qk_values + "', " +
                " '" + dk_keys + "', " +
                " '" + dk_values + "', " +
                " '" + fk_keys + "', " +
                " '" + fk_values + "', " +
                " '" + djsje + "', " +
                " '" + ContractNo + "'," +
                " CURRENT_TIMESTAMP " +
                " ) ";

                System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
            }
            else if (Flg.Equals("update"))
            {
                var sql = " update PD_PayManager  " +
                " set ZJJH_Keys = '" + zjjh_keys + "', " +
                " ZJJH_Values = '" + zjjh_values + "', " +
                " QK_Keys = '" + qk_keys + "', " +
                " QK_Values = '" + qk_values + "', " +
                " DK_Keys = '" + dk_keys + "', " +
                " DK_Values = '" + dk_values + "', " +
                " FK_Keys = '" + fk_keys + "', " +
                " FK_Values = '" + fk_values + "', " +
                " JSAmount = '" + djsje + "', " +
                " ContractNo = '" + ContractNo + "', " +
                " modifyTime = CURRENT_TIMESTAMP" +
                " where id =  '" + id + "'" ;

                System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
            }
            else if (Flg.Equals("delete"))
            {
                var sql = " delete from PD_PayManager  " +
                " where id =  '" + id + "'" ;

                System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
            }


            var sql2 = " select * from PD_PayManager where ContractNo = '"+ContractNo+"' order by id";

            System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);

            // 支付管理
            if (dt2.Rows.Count > 0)
            {
                foreach (DataRow dr in dt2.Rows)
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("id", dr["id"].ToString());
                    dic.Add("ZJJH_Keys", dr["ZJJH_Keys"].ToString());
                    dic.Add("ZJJH_Values", dr["ZJJH_Values"].ToString().Replace(",","<br>"));
                    dic.Add("QK_Keys", dr["QK_Keys"].ToString());
                    dic.Add("QK_Values", dr["QK_Values"].ToString().Replace(",","<br>"));
                    dic.Add("DK_Keys", dr["DK_Keys"].ToString());
                    dic.Add("DK_Values", dr["DK_Values"].ToString().Replace(",","<br>"));
                    dic.Add("FK_Keys", dr["FK_Keys"].ToString());
                    dic.Add("FK_Values", dr["FK_Values"].ToString().Replace(",","<br>"));
                    dic.Add("JSAmount", dr["JSAmount"].ToString());
                    ls.Add(dic);
                }
            }

        }
        catch (Exception exp)
        {

        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取请款、到款、付款、结算流程数量
    public void getCountByConId(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        var sql = " select Count(qk.ObjectID) qkCnt, "+
                    " Count(dk.ObjectID) dkCnt, "+
                    " Count(fk.ObjectID) fkCnt, "+
                    " Count(js.ObjectID) jsCnt," +
                    " Count(gd.ObjectID) gdCnt"+
                    " from OT_InstanceContext ic "+
                    " LEFT JOIN I_QK qk on ic.BizObjectId = qk.ObjectID and qk.ContractNo = '"+ContractNo+"' "+
                    " LEFT JOIN I_DK dk on ic.BizObjectId = dk.ObjectID and dk.ContractNo = '"+ContractNo+"' "+
                    " LEFT JOIN I_FK fk on ic.BizObjectId = fk.ObjectID and fk.ContractNo = '"+ContractNo+"' "+
                    " LEFT JOIN I_JS js on ic.BizObjectId = js.ObjectID and js.ContractNo = '"+ContractNo+"' " +
                    " LEFT JOIN I_GD gd on ic.BizObjectId = gd.ObjectID and gd.ContractNo = '"+ContractNo+"' ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        Dictionary<string, string> dic = new Dictionary<string, string>();
        // 支付管理
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                dic.Add("qkCnt", dr["qkCnt"].ToString());
                dic.Add("dkCnt", dr["dkCnt"].ToString());
                dic.Add("fkCnt", dr["fkCnt"].ToString());
                dic.Add("jsCnt", dr["jsCnt"].ToString());
                dic.Add("gdCnt", dr["gdCnt"].ToString());
            }
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取执行中的所有相关流程正在申请中的数量
    public void getApplyingCountOfOper(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        var sql = " select Count(qk.ObjectID) qkCnt, "+
                    " Count(dk.ObjectID) dkCnt, "+
                    " Count(fk.ObjectID) fkCnt, "+
                    " Count(js.ObjectID) jsCnt, "+
                    " Count(ps.ObjectID) psCnt, "+
                    " Count(ils.ObjectID) ilsCnt, "+
                    " Count(dh.ObjectID) dhCnt, "+
                    " Count(bg.ObjectID) bgCnt, "+
                    " Count(bh.ObjectID) bhCnt, "+
                    " Count(gd.ObjectID) gdCnt, "+
                    " Count(gdc.ObjectID) gdcCnt "+
                    " from OT_InstanceContext ic "+
                    " LEFT JOIN I_QK qk on ic.BizObjectId = qk.ObjectID and qk.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_DK dk on ic.BizObjectId = dk.ObjectID and dk.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_FK fk on ic.BizObjectId = fk.ObjectID and fk.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_JS js on ic.BizObjectId = js.ObjectID and js.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_PaymentSub ps on ic.BizObjectId = ps.ObjectID and ps.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_ImportLicenseSub ils on ic.BizObjectId = ils.ObjectID and ils.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_DH dh on ic.BizObjectId = dh.ObjectID and dh.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_BG bg on ic.BizObjectId = bg.ObjectID and bg.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_BH bh on ic.BizObjectId = bh.ObjectID and bh.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_GD gd on ic.BizObjectId = gd.ObjectID and gd.ContractNo = '"+ContractNo+"' and ic.State = '2' "+
                    " LEFT JOIN I_GDChange gdc on ic.BizObjectId = gdc.ObjectID and gdc.ContractNo = '"+ContractNo+"' and ic.State = '2' ";
        var sql_js = " select js.ObjectID JSObjectID ,Max(js.JSResult) JSResult,Max(js.QK_FK_Status) QK_FK_Status,Max(qk.ObjectID) QKObjcetID,Max(fk.ObjectID) FKObjectID "+
                    " from I_JS js "+
                    " INNER JOIN OT_InstanceContext ic on ic.BizObjectId = js.ObjectID and js.ContractNo = '"+ContractNo+"' and ic.State = '4' "+
                    " left JOIN I_QK qk on qk.JSObjectID = js.ObjectID  "+
                    " left JOIN I_FK fk on fk.JSObjectID = js.ObjectID  "+
                    " group BY js.ObjectID ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        System.Data.DataTable dt_js = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_js);
        Dictionary<string, string> dic = new Dictionary<string, string>();
        // 支付管理
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                dic.Add("qkCnt", dr["qkCnt"].ToString());
                dic.Add("dkCnt", dr["dkCnt"].ToString());
                dic.Add("fkCnt", dr["fkCnt"].ToString());
                // 如果结算有在申请中的，直接返回count
                if((int)Convert.ToSingle(dr["jsCnt"].ToString()) > 0)
                {
                    dic.Add("jsCnt", dr["jsCnt"].ToString());
                }else
                {
                    // 如果结算申请完了，则需要查看待请款和待付款情况
                    if (dt_js.Rows.Count > 0)
                    {
                        foreach (DataRow dr2 in dt_js.Rows)
                        {
                            // 如果待请款待付款ok
                            if(dr2["JSResult"].ToString().Equals("0")
                                    || (!dr2["JSResult"].ToString().Equals("0") && (!dr2["QKObjcetID"].ToString().Equals("") || !dr2["FKObjectID"].ToString().Equals(""))))
                            {
                                continue;
                                // 如果是批量结算ok
                            } else if(dr2["QK_FK_Status"].ToString().Contains("Batch") && dr2["QK_FK_Status"].ToString().Contains("OK"))
                            {
                                continue;
                            } else
                            {
                                dic.Add("jsCnt", "1");
                                break;
                            }
                        }
                    }
                }

                dic.Add("psCnt", dr["psCnt"].ToString());
                dic.Add("ilsCnt", dr["ilsCnt"].ToString());
                dic.Add("dhCnt", dr["dhCnt"].ToString());
                dic.Add("bgCnt", dr["bgCnt"].ToString());
                dic.Add("bhCnt", dr["bhCnt"].ToString());
                dic.Add("gdCnt", dr["gdCnt"].ToString());
                dic.Add("gdcCnt", dr["gdcCnt"].ToString());
            }
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取执行中的累计请款金额等
    public void getDataOfOper(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        var sql_cuy = " select top 1 con.ContractTotalPrice,con.JKTotalAmount,con.Currency from I_ContractMain con "+
                    " where con.ContractNo = '"+ContractNo+"'  ";

        string sql_cuname = " select enum1.EnumValue CurrencyName from OT_EnumerableMetadata enum1 where enum1.Category = '币种' and enum1.Code = 'CurCode' ";

        var sql_qk = " select qks.QKType,qks.Currency,sum(qks.Amount) LJQKAmount "+
                    " from I_QK qk "+
                    " INNER JOIN I_QKSubTbl qks on qks.ParentObjectID = qk.ObjectID  "+
                    " INNER JOIN OT_InstanceContext ic on ic.BizObjectId = qk.ObjectID  "+
                    " and qk.ContractNo = '"+ContractNo+"' and ic.State = '4' "+
                    " group by qks.QKType,qks.Currency "+
                    " ORDER BY qks.QKType,qks.Currency ";

        var sql_dk = " select dt.DKType,dt.CurDKCurrency,sum(dt.CurDKAmount) LJDKAmount  "+
                    " from I_DK dk " +
                    " INNER JOIN I_DKTbl dt on dk.ObjectID = dt.ParentObjectID and dt.CurDKAmount > 0 "+
                    " INNER JOIN OT_InstanceContext ic on ic.BizObjectId = dk.ObjectID  "+
                    " and dk.ContractNo = '"+ContractNo+"' and ic.State = '4' "+
                    " group by dt.DKType,dt.CurDKCurrency "+
                    " order by dt.DKType,dt.CurDKCurrency ";

        var sql_fk = " select fk.ZKType,fk.Currency,sum(fk.CurZJAmount) LJFKAmount "+
                    " from I_FK fk "+
                    " INNER JOIN OT_InstanceContext ic on ic.BizObjectId = fk.ObjectID  "+
                    " and fk.ContractNo = '"+ContractNo+"' and ic.State = '4'  "+
                    " group by fk.ZKType,fk.Currency "+
                    " order by fk.ZKType,fk.Currency ";

        var sql_bg = " select sum(BGAmount) LJBGAmount "+
                    " from I_DH d "+
                    " INNER JOIN OT_InstanceContext ic on ic.BizObjectId = d.ObjectID and ic.State = '4'   "+
                    " and d.ContractNo = '"+ContractNo+"' ";

        Dictionary<string, string> dic = new Dictionary<string, string>();
        System.Data.DataTable dt_cuy = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_cuy);
        System.Data.DataTable dt_qk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_qk);
        System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_dk);
        System.Data.DataTable dt_fk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_fk);
        System.Data.DataTable dt_bg = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_bg);

        // 币种
        var ContractTotalPrice = 0.0;
        var JKTotalAmount = 0.0;
        if (dt_cuy.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_cuy.Rows)
            {
                dic.Add("ContractTotalPrice", dr["ContractTotalPrice"].ToString());
                dic.Add("JKTotalAmount", dr["JKTotalAmount"].ToString());
                if(dr["Currency"] != null && !dr["Currency"].ToString().Equals(""))
                {
                    sql_cuname = sql_cuname.Replace("CurCode",dr["Currency"].ToString());
                    System.Data.DataTable dt_cuname = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_cuname);
                    if (dt_cuname.Rows.Count > 0)
                    {
                        foreach (DataRow dr2 in dt_cuname.Rows)
                        {
                            dic.Add("CurrencyName", dr2["CurrencyName"].ToString());

                        }
                    }
                }
                ContractTotalPrice = Convert.ToDouble(dr["ContractTotalPrice"].ToString()==""?"0":dr["ContractTotalPrice"].ToString());
                JKTotalAmount = Convert.ToDouble(dr["JKTotalAmount"].ToString()==""?"0":dr["JKTotalAmount"].ToString());
            }
        }
        // 请款
        if (dt_qk.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_qk.Rows)
            {
                if(dr["QKType"].ToString().Equals("HT"))
                {
                    if (dr["Currency"].ToString().Equals("RMB"))
                    {
                        dic.Add("LJQKAmountRMB", dr["LJQKAmount"].ToString());
                    } else
                    {
                        dic.Add("LJQKAmountWB", dr["LJQKAmount"].ToString());
                    }
                } else if (dr["QKType"].ToString().Equals("FY"))
                {
                    if (dr["Currency"].ToString().Equals("RMB"))
                    {
                        dic.Add("LJQKFYAmountRMB", dr["LJQKAmount"].ToString());
                    } else
                    {
                        dic.Add("LJQKFYAmountWB", dr["LJQKAmount"].ToString());
                    }
                }
            }
        }

        // 到款
        if (dt_dk.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_dk.Rows)
            {
                if(dr["DKType"].ToString().Equals("合同到款"))
                {
                    if (dr["CurDKCurrency"].ToString().Equals("RMB"))
                    {
                        dic.Add("LJDKAmountRMB", dr["LJDKAmount"].ToString());
                    } else
                    {
                        dic.Add("LJDKAmountWB", dr["LJDKAmount"].ToString());
                    }
                } else if (dr["DKType"].ToString().Equals("费用到款"))
                {
                    if (dr["CurDKCurrency"].ToString().Equals("RMB"))
                    {
                        dic.Add("LJDKFYAmountRMB", dr["LJDKAmount"].ToString());
                    } else
                    {
                        dic.Add("LJDKFYAmountWB", dr["LJDKAmount"].ToString());
                    }
                }
            }
        }

        // 付款
        var LJFKAmountRMB = 0.0;
        var LJFKAmountWB = 0.0;
        if (dt_fk.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_fk.Rows)
            {
                if(dr["ZKType"].ToString().Equals("ZKType_HT"))
                {
                    if (dr["Currency"].ToString().Equals("RMB"))
                    {
                        dic.Add("LJFKAmountRMB", dr["LJFKAmount"].ToString());
                        LJFKAmountRMB = Convert.ToDouble(dr["LJFKAmount"].ToString());
                    } else
                    {
                        dic.Add("LJFKAmountWB", dr["LJFKAmount"].ToString());
                        LJFKAmountWB = Convert.ToDouble(dr["LJFKAmount"].ToString());
                    }
                } else if (dr["ZKType"].ToString().Equals("ZKType_FY"))
                {
                    if (dr["Currency"].ToString().Equals("RMB"))
                    {
                        dic.Add("LJFKFYAmountRMB", dr["LJFKAmount"].ToString());
                    } else
                    {
                        dic.Add("LJFKFYAmountWB", dr["LJFKAmount"].ToString());
                    }
                }
            }
        }
        if(ContractTotalPrice != 0)
        {
            dic.Add("FKPercentRMB", ((LJFKAmountRMB / ContractTotalPrice) * 100).ToString());
        } else
        {
            dic.Add("FKPercentRMB", "0");
        }
        if(JKTotalAmount != 0)
        {
            dic.Add("FKPercentWB", ((LJFKAmountWB / JKTotalAmount) * 100).ToString());
        } else
        {
            dic.Add("FKPercentWB", "0");
        }

        // 到货中的报关单金额
        if (dt_bg.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_bg.Rows)
            {
                dic.Add("LJBGAmount", dr["LJBGAmount"].ToString());
            }
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 根据流程id获取流程entity
    public void getInstanceById (HttpContext context) {
        string InstanceId = context.Request["InstanceId"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT top 1 * from OT_InstanceContext where ObjectID = '"+InstanceId+"'");
        if (dt.Rows.Count > 0)
        {
            dic.Add("ObjectID",dt.Rows[0]["ObjectID"].ToString());
            dic.Add("InstanceName",dt.Rows[0]["InstanceName"].ToString());
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 批量
    // 获取结算记录选择
    public void getJSLSData(HttpContext context)
    {
        string JS_Target = context.Request["JS_Target"];
        var sql = " select t1.*,t2.Cnt from (  "+
                    " 	 select cm.ContractNo, "+
                    " 	 cm.ContractName, "+
                    " 	 cm.PostA, " +
                    "    case e1.EnumValue when '航空煤油' then '航油合同' else '非航油合同' end ContractProperty,"+
                    " 	 cm.PostB, "+
                    " 	 convert(varchar(20),convert(decimal(18,2),j.LJDKAmountRMB))+j.CurrencyRMB LJDKAmountRMB,   "+
                    " 	 convert(varchar(20),convert(decimal(18,2),j.LJFKAmountRMB))+j.CurrencyRMB LJFKAmountRMB,  "+
                    " 	 convert(varchar(20),convert(decimal(18,2),j.BankFY))+j.CurrencyRMB BankFY,  "+
                    " 	 convert(varchar(20),convert(decimal(18,2),j.AgencyFY))+j.CurrencyRMB + '\n(' + CONVERT(VARCHAR,j.AgencyFYWB)+j.CurrencyWB + ')' AgencyFY,  "+
                    " 	 convert(varchar(20),convert(decimal(18,2),j.OtherFY))+j.CurrencyRMB OtherFY,  "+
                    " 	 j.JSResult JSResultNum,  "+
                    " 	 j.JSStatus+convert(varchar(20),convert(decimal(18,2),j.JSResult))+j.CurrencyRMB JSResult,  "+
                    " 	 j.JSStatus,  "+
                    " 	 j.ObjectID JSObjectID,   "+
                    " 	 ic.ObjectID IcObjectId , "+
                    " 	 j.ModifiedTime , "+
                    " 	 ic.State Status,j.QK_FK_Status QK_FK_Status "+
                    " 	 from I_JS j  "+
                    " 	 INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId and ic.State = '4' and j.QK_FK_Status is null "+
                    " 	 INNER JOIN I_ContractMain cm on cm.ContractNo = j.ContractNo and cm.FinalUser = '"+JS_Target+"'  " +
                    "    INNER JOIN OT_EnumerableMetadata e1 on e1.Category like '合同性质%' and cm.ContractProperty = e1.Code"+
                    " ) t1, "+
                    " ( "+
                    " 	select cm.ContractNo,count(1) cnt "+
                    " 	from I_JS j  "+
                    " 	INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId and ic.State = '4' and j.QK_FK_Status is null "+
                    " 	INNER JOIN I_ContractMain cm on cm.ContractNo = j.ContractNo and cm.FinalUser = '"+JS_Target+"'  "+
                    " 	GROUP BY cm.ContractNo "+
                    " ) t2 "+
                    " where t1.ContractNo = t2.ContractNo "+
                    " ORDER BY t1.ContractNo,t1.ModifiedTime  ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 支付管理
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                // 请付款状态为空，说明结算完了，但还没有进行请付款
                if(dr["QK_FK_Status"].ToString().Equals(""))
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    dic.Add("ContractNo", dr["ContractNo"].ToString());
                    dic.Add("ContractNoHidden", dr["ContractNo"].ToString());
                    dic.Add("ContractName", dr["ContractName"].ToString());
                    dic.Add("ContractProperty", dr["ContractProperty"].ToString());
                    var PostA = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["PostA"].ToString());
                    var PostB = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["PostB"].ToString());
                    dic.Add("PostAB", PostA+","+PostB);
                    dic.Add("DKAmount", dr["LJDKAmountRMB"].ToString());
                    dic.Add("FKAmount", dr["LJFKAmountRMB"].ToString());
                    dic.Add("BankFY", dr["BankFY"].ToString());
                    dic.Add("AgencyFY", dr["AgencyFY"].ToString());
                    dic.Add("OtherFY", dr["OtherFY"].ToString());
                    dic.Add("JSResult", dr["JSResult"].ToString());
                    dic.Add("JSObjectID", dr["JSObjectID"].ToString());
                    dic.Add("Cnt", dr["Cnt"].ToString());
                    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                    foreach (var item in workItemDic)
                    {
                        Console.WriteLine(item.Key + item.Value);
                        if (item.Key.Equals("workItemId"))
                        {
                            dic.Add("WorkItemId", item.Value);
                        }
                    }
                    ls.Add(dic);
                }
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 通过ID获取客户信息
    public void getCustomerById (HttpContext context) {
        string ObjectID = context.Request["ObjectID"];
        Dictionary<string,string> dic = new Dictionary<string,string>();
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT * FROM I_CustomerList WHERE ObjectID = '"+ObjectID+"'");
        if (dt.Rows.Count > 0)
        {
            dic.Add("CompanyName",dt.Rows[0]["CompanyName"].ToString());
            dic.Add("ModelOrDepartment",dt.Rows[0]["ModelOrDepartment"].ToString());
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 设置请付款状态为
    public void setJS_Status (HttpContext context) {
        string JSObjectIDs = context.Request["JSObjectIDs"];
        string Status = context.Request["Status"];
        string[] arr = JSObjectIDs.Split(',');
        Dictionary<string,string> dic = new Dictionary<string,string>();
        foreach(string item in arr)
        {
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " update I_JS set QK_FK_Status = '"+Status+"' where ObjectID = '"+item+"'");
        }
        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取批量结算之批量请款记录
    public void getBatchJS_QKData(HttpContext context)
    {
        string QK_Target = context.Request["QK_Target"];
        string QK_Status = context.Request["QK_Status"];
        var sql = "  SELECT q.QK_Target,q.Content,convert(varchar(20),convert(decimal(18,2),q.Amount))+' 人民币'  Amount, " +
                    "  CONVERT(varchar(12),q.DKDate,111) DKDate,CONVERT(varchar(12),q.SDDate,111) SDDate, " +
                    "  ic.State Status,ic.ObjectID IcObjectID,q.RejectFlg" +
                    "  FROM I_BatchJS_QK q " +
                    "  INNER JOIN OT_InstanceContext ic on q.ObjectID = ic.BizObjectID ";
        var sql2 = QK_Target.Equals("")?"":" and q.QK_Target = '" + QK_Target + "'  ";
        var sql3 = "  order by q.CreatedTime desc ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql + sql2 + sql3);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        var TheNo = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("QK_Target", dr["QK_Target"].ToString());
                dic.Add("Content", dr["Content"].ToString());
                dic.Add("Amount", dr["Amount"].ToString());
                if(dr["SDDate"].ToString() != "1753/01/01")
                {
                    dic.Add("SDDate", dr["SDDate"].ToString());
                }
                if (dr["DKDate"].ToString() != "1753/01/01")
                {
                    dic.Add("DKDate", dr["DKDate"].ToString());
                }

                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                    else if (item.Key.Equals("ActivityCode"))
                    {
                        ActivityCode = item.Value;
                    }
                }
                string st = "";
                if (dr["Status"].ToString().Equals("4"))
                {
                    st = "完成";
                }
                else if (dr["Status"].ToString().Equals("2"))
                {
                    if (dr["RejectFlg"].ToString().Equals("1"))
                    {
                        st = "驳回";
                    }
                    else
                    {
                        if (ActivityCode.Equals("ActivityOrig"))
                        {
                            st = "草稿";
                        }
                        else if (ActivityCode.Equals("ActivityConfirm"))
                        {
                            st = "送达确认中";
                        }
                        else if (ActivityCode.Equals("ActivityDKConfirm"))
                        {
                            st = "到款确认中";
                        }
                        else
                        {
                            st = "审批中";
                        }

                    }
                }
                // 如果状态不等于查询条件的状态，则跳到下一条
                if(!QK_Status.Equals("") && QK_Status.IndexOf(st) == -1)
                {
                    continue;
                }
                dic.Add("DisplayName", st);
                dic.Add("RejectFlg", dr["RejectFlg"].ToString());
                dic.Add("Status", dr["Status"].ToString());
                ls.Add(dic);
                TheNo++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取批量结算之批量付款记录
    public void getBatchJS_FKData(HttpContext context)
    {
        string FK_Target = context.Request["FK_Target"];
        string FK_Status = context.Request["FK_Status"];
        var sql = "  SELECT f.Receiver,e1.EnumValue PayType,f.Content,convert(varchar(20),convert(decimal(18,2),f.Amount))+' 人民币'  Amount,CONVERT(varchar(12),f.FKDate,111) FKDate, " +
                    "  ic.State Status,ic.ObjectID IcObjectID,f.RejectFlg " +
                    "  FROM I_BatchJS_FK f " +
                    "  INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID ";
        var sql2 = FK_Target.Equals("")?"":" and f.Receiver = '" + FK_Target + "'  ";
        var sql3 = "  LEFT JOIN OT_EnumerableMetadata e1 on f.PayType = e1.Code and e1.Category = '支付方式' "+
                    "  order by f.CreatedTime desc ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql + sql2 + sql3);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        var TheNo = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("Receiver", dr["Receiver"].ToString());
                dic.Add("PayType", dr["PayType"].ToString());
                dic.Add("Content", dr["Content"].ToString());
                dic.Add("Amount", dr["Amount"].ToString());
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                    else if (item.Key.Equals("ActivityCode"))
                    {
                        ActivityCode = item.Value;
                    }
                }
                string st = "";
                if (dr["Status"].ToString().Equals("4"))
                {
                    st = "完成";
                    dic.Add("FKDate", dr["FKDate"].ToString());
                }
                else if (dr["Status"].ToString().Equals("2"))
                {
                    if (dr["RejectFlg"].ToString().Equals("1"))
                    {
                        st = "驳回";
                    }
                    else
                    {
                        if (ActivityCode.Equals("ActivityOrig"))
                        {
                            st = "草稿";
                        }
                        else if (ActivityCode.Equals("ActivityConfirm"))
                        {
                            st = "确认中";
                        }
                        else
                        {
                            st = "审批中";
                        }

                    }
                }
                // 如果状态不等于查询条件的状态，则跳到下一条
                if(!FK_Status.Equals("") && FK_Status.IndexOf(st) == -1)
                {
                    continue;
                }
                dic.Add("DisplayName", st);
                dic.Add("RejectFlg", dr["RejectFlg"].ToString());
                dic.Add("Status", dr["Status"].ToString());
                ls.Add(dic);
                TheNo++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取批量结算之批量结清记录
    public void getBatchJS_JQData(HttpContext context)
    {
        string JQ_Target = context.Request["JQ_Target"];
        string JQ_Status = context.Request["JQ_Status"];
        var sql = "  SELECT j.JQ_Target,j.Content, " +
                    "  ic.State Status,ic.ObjectID IcObjectID,j.RejectFlg " +
                    "  FROM I_BatchJS_JQ j " +
                    "  INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectID ";
        var sql2 = JQ_Target.Equals("")?"":" and j.JQ_Target = '" + JQ_Target + "'  ";
        var sql3 = "  order by j.CreatedTime desc ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql + sql2 + sql3);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        var TheNo = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("JQ_Target", dr["JQ_Target"].ToString());
                dic.Add("Content", dr["Content"].ToString());
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                    else if (item.Key.Equals("ActivityCode"))
                    {
                        ActivityCode = item.Value;
                    }
                }
                string st = "";
                if (dr["Status"].ToString().Equals("4"))
                {
                    st = "完成";
                }
                else if (dr["Status"].ToString().Equals("2"))
                {
                    if (dr["RejectFlg"].ToString().Equals("1"))
                    {
                        st = "驳回";
                    }
                    else
                    {
                        if (ActivityCode.Equals("ActivityOrig"))
                        {
                            st = "草稿";
                        }
                        else
                        {
                            st = "审批中";
                        }

                    }
                }
                // 如果状态不等于查询条件的状态，则跳到下一条
                if(!JQ_Status.Equals("") && JQ_Status.IndexOf(st) == -1)
                {
                    continue;
                }
                dic.Add("DisplayName", st);
                dic.Add("RejectFlg", dr["RejectFlg"].ToString());
                dic.Add("Status", dr["Status"].ToString());
                ls.Add(dic);
                TheNo++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取批量到款之批量到款记录
    public void getBatchDK_DKData(HttpContext context)
    {
        string DK_Target = context.Request["DK_Target"];
        string DK_Status = context.Request["DK_Status"];
        var sql = "   SELECT d.DK_Target,convert(varchar(20),convert(decimal(18,2),d.Amount)) Amount,CONVERT(varchar(12),d.DKDate,111) DKDate, " +
                    "  ic.State Status,ic.ObjectID IcObjectID,d.RejectFlg " +
                    "  FROM I_BatchDK_DK d " +
                    "  INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectID ";
        var sql2 = DK_Target.Equals("")?"":" and d.DK_Target = '" + DK_Target + "'  ";
        var sql3 = "  order by d.CreatedTime desc ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql + sql2 + sql3);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 
        var TheNo = 1;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("DK_Target", dr["DK_Target"].ToString());
                dic.Add("Amount", dr["Amount"].ToString().Replace(",","<br>"));
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                foreach (var item in workItemDic)
                {
                    Console.WriteLine(item.Key + item.Value);
                    if (item.Key.Equals("workItemId"))
                    {
                        dic.Add("WorkItemId", item.Value);
                    }
                    else if (item.Key.Equals("ActivityCode"))
                    {
                        ActivityCode = item.Value;
                    }
                }
                string st = "";
                if (dr["Status"].ToString().Equals("4"))
                {
                    st = "完成";
                    dic.Add("DKDate", dr["DKDate"].ToString());
                }
                else if (dr["Status"].ToString().Equals("2"))
                {
                    if (dr["RejectFlg"].ToString().Equals("1"))
                    {
                        st = "驳回";
                    }
                    else
                    {
                        if (ActivityCode.Equals("ActivityOrig"))
                        {
                            st = "草稿";
                        }
                        else if (ActivityCode.Equals("ActivityConfirm"))
                        {
                            st = "确认中";
                        }
                        else
                        {
                            st = "审批中";
                        }

                    }
                }
                // 如果状态不等于查询条件的状态，则跳到下一条
                if(DK_Status.IndexOf(st) == -1)
                {
                    continue;
                }
                dic.Add("DisplayName", st);
                dic.Add("RejectFlg", dr["RejectFlg"].ToString());
                dic.Add("Status", dr["Status"].ToString());
                ls.Add(dic);
                TheNo++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取批量到款中的请款记录选择
    public void getDKLSData(HttpContext context)
    {
        // 所有请款的数据 - 正在到款的数据 - 正在批量到款的数据
        string DK_Target = context.Request["DK_Target"];
        // 批量到款选择页面 到 批量到款流程页面传入参数
        string QKObjectIDs = context.Request["QKObjectIDs"];
        string [] QKObjectIDArr = { };
        string paramSql = "";
        if(QKObjectIDs!=null && QKObjectIDs != "")
        {
            QKObjectIDArr = QKObjectIDs.Split(',');
            foreach (string item in QKObjectIDArr)
            {
                if (item != "")
                {
                    string [] arr = item.Split(':');
                    paramSql += "or (qk.ObjectId = '" + arr[0] + "' and tbl.QKType = '" + arr[1] + "' and tbl.Currency = '" + arr[2] + "') ";
                }
            }
        }
        paramSql = paramSql.Length > 2 ? " and ( "+paramSql.Substring(2) +" ) ": "";
        //var sql = " select t1.*,t2.cnt SeqCnt,t3.ConvertAmountSum QKConvertAmount from (  "+
        //            " SELECT  "+
        //            " 	tbl.ObjectID QKObjectID, "+
        //            "  qk.ContractNo, "+
        //            "   qk.QKSeq QKSeq,  "+
        //            "   tbl.ParentIndex,  "+
        //            " 	tbl.QKType QKTypeCode,  "+
        //            " 	e3.EnumValue QKType,  "+
        //            " 	qk.QKTarget,  "+
        //            " 	CONVERT(varchar(12),qk.ModifiedTime,111) QKDate,  "+
        //            " 	e2.EnumValue ZJKX,  "+
        //            " 	tbl.ZJMS,  "+
        //            " 	tbl.Amount QKAmount,  "+
        //            " 	tbl.Rate QKRate,  "+
        //            " 	tbl.LJDKAmount LJDKAmount,  "+
        //            " 	tbl.LJDKAmountWB LJDKAmountWB,  " +
        //            "   tbl.DKStatus, "+
        //            " 	tbl.Currency QKCurrencyCode,  "+
        //            " 	e1.EnumValue QKCurrency  "+
        //            " FROM  "+
        //            " 	I_QK qk  "+
        //            " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款')  "+
        //            " INNER JOIN I_ContractMain cm on cm.ContractNo = qk.ContractNo and cm.FinalUser = '" + DK_Target + "'  "+
        //            " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4' "+
        //            " LEFT JOIN OT_EnumerableMetadata e1 ON tbl.Currency = e1.Code AND e1.Category = '币种'  "+
        //            " LEFT JOIN OT_EnumerableMetadata e2 ON tbl.ZJKX = e2.Code AND e2.Category = '资金款项'  "+
        //            " LEFT JOIN OT_EnumerableMetadata e3 ON tbl.QKType = e3.Code AND e3.Category = '请款类型'  "+
        //            " ) t1,  "+
        //            " (select qk.ContractNo,QKSeq,count(1) cnt FROM  "+
        //            " 	I_QK qk  "+
        //            " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款')  "+
        //            " INNER JOIN I_ContractMain cm on cm.ContractNo = qk.ContractNo and cm.FinalUser = '" + DK_Target + "'  "+
        //            " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4'  "+
        //            " group by qk.ContractNo,qk.QKSeq  "+
        //            " ) t2,  "+
        //            " (select qk.ContractNo,QKSeq,sum(tbl.ConvertAmount) ConvertAmountSum FROM  "+
        //            " 	I_QK qk  "+
        //            " INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款') "+
        //            " INNER JOIN I_ContractMain cm on cm.ContractNo = qk.ContractNo and cm.FinalUser = '" + DK_Target + "'  "+
        //            " INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4'  "+
        //            " group by qk.ContractNo,qk.QKSeq  "+
        //            " ) t3  "+
        //            " where t1.ContractNo = t2.ContractNo and t1.QKSeq = t2.QKSeq  and t1.ContractNo = t3.ContractNo  "+
        //            " and t1.QKSeq = t3.QKSeq  "+
        //            " order BY t1.ContractNo,t1.QKSeq,t1.ParentIndex  ";
        var sql =
            "   SELECT qk.ObjectId QKObjectID," +
            "   qk.ContractNo," +
            "   tbl.ObjectId QKSubObjectID, "+
            "	qk.QKSeq QKSeq,	 "+
            "	tbl.QKType QKTypeCode, "+
            "	e2.EnumValue QKType, "+
            "	e3.EnumValue ZJKX, "+
            "	tbl.ZJMS ZJMS, "+
            "	tbl.Amount Amount, "+
            "	tbl.Rate QKRate," +
            "   CONVERT(varchar(12),qk.ModifiedTime,111) QKDate, "+
            "	tbl.ConvertAmount ConvertAmount,  "+
            "	tbl.LJDKAmount LJDKAmount, "+
            "	tbl.LJDKAmountWB LJDKAmountWB, "+
            "	qk.QKTarget QKTarget, "+
            "	tbl.Currency QKCurrencyCode, "+
            "	e1.EnumValue QKCurrency  "+
            "   FROM I_QK qk   "+
            "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID   "+
            "   INNER JOIN I_ContractMain cm on cm.ContractNo = qk.ContractNo and cm.FinalUser = '" + DK_Target + "'  " + paramSql +
            "   and ( tbl.DKStatus is null or tbl.DKStatus = '未到款' or tbl.DKStatus = '部分到款') "+
            "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4'  "+
            "   LEFT JOIN OT_EnumerableMetadata e1 on tbl.Currency = e1.Code and e1.Category = '币种'  "+
            "   LEFT JOIN OT_EnumerableMetadata e2 on tbl.QKType = e2.Code and e2.Category = '请款类型'  "+
            "   LEFT JOIN OT_EnumerableMetadata e3 ON tbl.ZJKX = e3.Code AND e3.Category = '资金款项' "+
            "   order by qk.ContractNo,qk.QKSeq,e2.SortKey,tbl.Currency,tbl.ParentIndex  ";
        // 正在审批中的 到款 和 批量到款 的QKObjectID
        var sql_dk2 = " select dt.QKObjectID,dt.QKType,dt.QKCurrency,dt.CurDKAmount "+
                        " from I_DK d "+
                        " INNER JOIN I_DKTbl dt on d.ObjectID = dt.ParentObjectID and dt.CurDKAmount > 0 "+
                        " INNER JOIN OT_InstanceContext ic ON d.ObjectId = ic.BizObjectID and ic.State = '2'  "+
                        " INNER JOIN I_ContractMain cm on cm.ContractNo = d.ContractNo and cm.FinalUser = '" + DK_Target + "'  "+
                        " Union "+
                        " select bdt.QKObjectID,bdt.QKType,bdt.QKCurrency,bdt.CurDKAmount "+
                        " from I_BatchDK_DK bd "+
                        " INNER JOIN I_BatchDKTblOfDK bdt on bd.ObjectID = bdt.ParentObjectID and cast(bdt.CurDKAmount as DECIMAL) > 0  "+
                        " and bd.DK_Target = '" + DK_Target + "'  "+
                        " INNER JOIN OT_InstanceContext ic ON bd.ObjectId = ic.BizObjectID and ic.State = '2'  ";
        System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        System.Data.DataTable dt_dk2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_dk2);
        //List<Dictionary<string, string>> ret = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //List<Dictionary<string, string>> ls_sub = new List<Dictionary<string, string>>();
        // 
        //if (dt.Rows.Count > 0)
        //{
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        //if(!Common.Contains(dt_dk,dr["QKObjectID"].ToString(),dr["QKType"].ToString(),dr["QKCurrency"].ToString()))
        //        //{
        //        Dictionary<string, string> dic = new Dictionary<string, string>();
        //        dic.Add("ContractNo", dr["ContractNo"].ToString());
        //        dic.Add("QKSeq", dr["QKSeq"].ToString());
        //        dic.Add("QKType", dr["QKType"].ToString());
        //        dic.Add("QKTarget", dr["QKTarget"].ToString());
        //        dic.Add("QKDate", dr["QKDate"].ToString());
        //        dic.Add("ZJKX", dr["ZJKX"].ToString());
        //        dic.Add("ZJMS", dr["ZJMS"].ToString());
        //        dic.Add("QKAmount", dr["QKAmount"].ToString());
        //        dic.Add("QKRate", dr["QKRate"].ToString());
        //        dic.Add("QKCurrency", dr["QKCurrency"].ToString());
        //        dic.Add("QKConvertAmount", dr["QKConvertAmount"].ToString()+"人民币");
        //        dic.Add("SeqCnt", dr["SeqCnt"].ToString());
        //        dic.Add("QKCurrencyCode", dr["QKCurrencyCode"].ToString());
        //        dic.Add("LJDKAmount", dr["LJDKAmount"].ToString());
        //        dic.Add("LJDKAmountWB", dr["LJDKAmountWB"].ToString());
        //        dic.Add("QKSeqHidden", dr["ContractNo"].ToString()+dr["QKSeq"].ToString());
        //        dic.Add("QKTypeCode", dr["QKTypeCode"].ToString());
        //        dic.Add("QKObjectID", dr["QKObjectID"].ToString());
        //        dic.Add("DKStatus", dr["DKStatus"].ToString());
        //        ls.Add(dic);
        //        //} else
        //        //    {
        //        //    Dictionary<string, string> dic = new Dictionary<string, string>();
        //        //    dic.Add("ContractNo", dr["ContractNo"].ToString());
        //        //    dic.Add("QKSeq", dr["QKSeq"].ToString());
        //        //    ls_sub.Add(dic);
        //        //}
        //    }
        //}
        //ret = Common.Subs(ls,ls_sub);
        if (dt_dk.Rows.Count > 0)
        {
            var i = 0;
            var ContractNo  = "";
            var QKSeq = "";
            var QKType = "";
            var QKCurrency = "";
            var QKConvertAmount = 0.0;
            var QKObjectID = "";
            int QKCnt = 0;
            int QKCurrencyCnt = 0;
            foreach (DataRow dr in dt_dk.Rows)
            {
                if(!Common.Contains(dt_dk2, dr["QKObjectID"].ToString() , dr["QKType"].ToString() , dr["QKCurrency"].ToString() ))
                {
                    Dictionary<string, string> dic = new Dictionary<string, string>();
                    if (!(ContractNo + QKSeq + QKType + QKCurrency).Equals(dr["ContractNo"].ToString() +dr["QKSeq"].ToString() + dr["QKType"].ToString() + dr["QKCurrency"].ToString()))
                    {
                        // 设置请款单币种数量
                        setDic(ls,"QKCurrencyCnt2",QKCurrencyCnt.ToString(),ContractNo+QKSeq,QKType,QKCurrency);
                        QKCurrencyCnt = 0;
                        // 设置请款折算金额合计
                        setDic(ls,"QKConvertAmount2",QKConvertAmount.ToString(),ContractNo+QKSeq,QKType,QKCurrency);
                        QKConvertAmount = 0.0;
                    }
                    if (QKObjectID!="" && !(QKObjectID).Equals(dr["QKObjectID"].ToString()))
                    {
                        // 设置请款批次数量
                        setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
                        QKCnt = 0;
                    }
                    QKCurrencyCnt++;
                    QKCnt++;
                    ContractNo = dr["ContractNo"].ToString();
                    QKObjectID = dr["QKObjectID"].ToString();
                    QKSeq = dr["QKSeq"].ToString();
                    QKType = dr["QKType"].ToString();
                    QKCurrency = dr["QKCurrency"].ToString();
                    QKConvertAmount += Convert.ToDouble(dr["ConvertAmount"].ToString()==""?"0":dr["ConvertAmount"].ToString());

                    dic.Add("ContractNo", ContractNo);
                    dic.Add("QKObjectID",QKObjectID);
                    dic.Add("QKSubObjectID",dr["QKSubObjectID"].ToString());
                    dic.Add("QKSeq",QKSeq);
                    dic.Add("ZJKX",dr["ZJKX"].ToString());
                    dic.Add("ZJMS",dr["ZJMS"].ToString());
                    dic.Add("QKTarget",dr["QKTarget"].ToString());
                    dic.Add("QKAmount",dr["Amount"].ToString());
                    dic.Add("QKRate", dr["QKRate"].ToString());
                    dic.Add("QKDate", dr["QKDate"].ToString());
                    dic.Add("QKCurrencyCode", dr["QKCurrencyCode"].ToString());
                    dic.Add("QKCurrency",QKCurrency);
                    dic.Add("QKType",QKType);
                    dic.Add("QKTypeCode",dr["QKTypeCode"].ToString());
                    dic.Add("LJDKAmount", dr["LJDKAmount"].ToString());
                    dic.Add("LJDKAmountWB", dr["LJDKAmountWB"].ToString());
                    ls.Add(dic);
                    i++;
                }

            }
            setDic(ls,"QKCurrencyCnt2",QKCurrencyCnt.ToString(),ContractNo+QKSeq,QKType,QKCurrency);
            setDic(ls,"QKConvertAmount2",QKConvertAmount.ToString(),ContractNo+QKSeq,QKType,QKCurrency);
            setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取所有货币
    public void getCurrencys(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        var sql = " select Code,EnumValue Value from OT_EnumerableMetadata where Category = '币种' order by SortKey ";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("Code", dr["Code"].ToString());
                dic.Add("Value", dr["Value"].ToString());
                ls.Add(dic);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 设置请款中的累计到款值
    public void SetQKLJDK(HttpContext context)
    {
        string BatchDKObjectID = context.Request["BatchDKObjectID"];
        System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            "  select dt.QKObjectID QKObjectID,dt.CurDKAmount,dt.CurDKCurrency,dt.QKSeq QKSeq,dt.Status from I_BatchDKTblOfDK dt " +
            "  INNER JOIN I_BatchDK_DK d on dt.ParentObjectID=d.ObjectID  " +
            "  where d.ObjectID = '"+BatchDKObjectID+"' and dt.CurDKAmount > 0  " );
        if (dt2.Rows.Count > 0)
        {
            foreach (DataRow dr2 in dt2.Rows)
            {
                // 修改请款中的累计到款金额
                string sql = " update I_QKSubTbl set ";
                if(dr2["CurDKCurrency"].Equals("RMB"))
                {
                    sql += " LJDKAmount = LJDKAmount + " + dr2["CurDKAmount"];
                } else
                {
                    sql += " LJDKAmountWB = LJDKAmountWB + " + dr2["CurDKAmount"];
                }
                sql += " ,DKStatus = '" + dr2["Status"] +"'";
                sql += " where ObjectID = '" + dr2["QKObjectID"] + "'";
                OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
            }
        }
        return;
    }

    // 航油请款中设置合同金额
    public void setJKTotalAmount(HttpContext context)
    {
        string ContractNo = context.Request["ContractNo"];
        string HKAmount = context.Request["HKAmount"];

        // 修改金额
        string sql = " update I_ContractMain set JKTotalAmount=isnull(JKTotalAmount,0)+"+HKAmount+" where ContractNo = '" + ContractNo + "'";

        OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);

        return;
    }


    // 获取客户信息管理中项目和子项目的树结构的数据
    public void getFinalUserTree(HttpContext context)
    {
        string Type = context.Request["Type"];
        string sql1 = " select * from I_CustomerList where Type = '"+Type+"' ORDER BY CreatedTime";
        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql1);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // I_CustomerList
        if (dt1.Rows.Count > 0)
        {
            foreach (DataRow dr in dt1.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("id", dr["ObjectID"].ToString());
                dic.Add("pId", "");
                dic.Add("name", dr["CompanyName"].ToString()+"（"+dr["ModelOrDepartment"].ToString()+"）");
                dic.Add("sname", "");
                ls.Add(dic);

                string sql2 = " select DISTINCT ProjectCode,ProjectName,ProjectShortName from I_ProjectTbl where ParentObjectID = '"+dr["ObjectID"].ToString()+"' ORDER BY ProjectCode";
                System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);
                // I_ProjectTbl
                if (dt2.Rows.Count > 0)
                {
                    foreach (DataRow dr2 in dt2.Rows)
                    {
                        if(dr2["ProjectCode"] != null && !dr2["ProjectCode"].ToString().Equals(""))
                        {
                            Dictionary<string, string> dic2 = new Dictionary<string, string>();
                            dic2.Add("id", dr2["ProjectCode"].ToString());
                            dic2.Add("pId", dr["ObjectID"].ToString());
                            //dic2.Add("name", dr2["ProjectName"].ToString());
                            dic2.Add("name", dr2["ProjectShortName"].ToString());
                            ls.Add(dic2);

                            string sql3 = " select DISTINCT SubProjectCode,SubProjectName,SubProjectShortName  from I_ProjectTbl where ParentObjectID = '"+dr["ObjectID"].ToString()+"' and ProjectCode = '"+dr2["ProjectCode"].ToString()+"'  ORDER BY SubProjectCode";
                            System.Data.DataTable dt3 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql3);
                            // I_ProjectTbl
                            if (dt3.Rows.Count > 0)
                            {
                                foreach (DataRow dr3 in dt3.Rows)
                                {
                                    if (dr3["SubProjectCode"] != null && !dr3["SubProjectCode"].ToString().Equals(""))
                                    {
                                        Dictionary<string, string> dic3 = new Dictionary<string, string>();
                                        dic3.Add("id", dr3["SubProjectCode"].ToString());
                                        dic3.Add("pId", dr2["ProjectCode"].ToString());
                                        //dic3.Add("name", dr3["SubProjectName"].ToString());
                                        dic3.Add("name", dr3["SubProjectShortName"].ToString());
                                        ls.Add(dic3);
                                    }
                                }
                            }
                        }

                    }
                }
            }
        }


        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取招标项目编号、中标价的树结构的数据
    public void getBidNoTree(HttpContext context)
    {
        string BiddingCode = context.Request["BiddingCode"];
        string ProjectName = context.Request["ProjectName"];
        string wheresql = "";
        if(BiddingCode!=null && !BiddingCode.Equals(""))
        {
            wheresql += " and ib.BiddingCode like '%"+BiddingCode+"%' ";
        }
        if(ProjectName!=null && !ProjectName.Equals(""))
        {
            wheresql += " and ib.ProjectName like '%"+ProjectName+"%' ";
        }
        string sql1 = " SELECT ib.BiddingCode,max(ib.ProjectName) ProjectName "+
                        " FROM I_InviteBids ib  "+
                        " INNER JOIN I_TenderPrice tp on ib.ObjectID = tp.ParentObjectID " +
                        " where 1=1  "+ wheresql +
                        " group by ib.BiddingCode ";
        System.Data.DataTable dt1 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql1);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // I_CustomerList
        if (dt1.Rows.Count > 0)
        {
            foreach (DataRow dr in dt1.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("id", dr["BiddingCode"].ToString());
                dic.Add("pId", "");
                dic.Add("name", dr["BiddingCode"].ToString()+"（"+dr["ProjectName"].ToString()+"）");
                dic.Add("sname", "");
                ls.Add(dic);

                string sql2 = " SELECT tp.PackageName " +
                    " FROM I_InviteBids ib  " +
                    " INNER JOIN I_TenderPrice tp on ib.ObjectID = tp.ParentObjectID where ib.BiddingCode='"+dr["BiddingCode"].ToString()+"' " +
                    " group by ib.BiddingCode,tp.PackageName ";
                System.Data.DataTable dt2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);
                // I_ProjectTbl
                if (dt2.Rows.Count > 0)
                {
                    int i = 0;
                    foreach (DataRow dr2 in dt2.Rows)
                    {
                        if(dr2["PackageName"] != null && !dr2["PackageName"].ToString().Equals(""))
                        {
                            Dictionary<string, string> dic2 = new Dictionary<string, string>();
                            i++;
                            dic2.Add("id", dr["BiddingCode"].ToString()+"_"+i);
                            dic2.Add("pId", dr["BiddingCode"].ToString());
                            dic2.Add("name", dr2["PackageName"].ToString());
                            ls.Add(dic2);

                            string sql3 = " SELECT ib.BiddingCode,max(ib.ProjectName) ProjectName,tp.PackageName,tp.i+1 as TenderPriceNo, " +
                                " sum(tp.TenderPrice1*TenderPrice1ExchangeRate) as TenderPrice  FROM I_InviteBids ib  " +
                                " INNER JOIN I_TenderPrice tp on ib.ObjectID = tp.ParentObjectID where ib.BiddingCode='"+dr["BiddingCode"].ToString()+"' and tp.PackageName='"+dr2["PackageName"].ToString()+"' "  +
                                " group by ib.BiddingCode,tp.PackageName,tp.i ";
                            System.Data.DataTable dt3 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql3);
                            // I_ProjectTbl
                            if (dt3.Rows.Count > 0)
                            {
                                foreach (DataRow dr3 in dt3.Rows)
                                {
                                    if (dr3["TenderPrice"] != null && !dr3["TenderPrice"].ToString().Equals(""))
                                    {
                                        Dictionary<string, string> dic3 = new Dictionary<string, string>();
                                        dic3.Add("id", dr["BiddingCode"].ToString()+"_"+i+"_"+dr3["TenderPriceNo"].ToString());
                                        dic3.Add("pId", dr["BiddingCode"].ToString()+"_"+i);
                                        dic3.Add("name", dr3["TenderPriceNo"].ToString()+"："+dr3["TenderPrice"].ToString()+"元");
                                        ls.Add(dic3);
                                    }
                                }
                            }
                        }

                    }
                }
            }
        }


        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    // 根据InstanceID获取当前活动的节点
    public void getCurActivity(HttpContext context)
    {
        string InstanceID = context.Request["InstanceID"];
        Dictionary<string, string> dic = new Dictionary<string, string>();
        string Status = "";
        System.Data.DataTable dt_ic = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT ic.State FROM OT_InstanceContext ic where ic.ObjectID = '" + InstanceID + "' " );
        if (dt_ic.Rows.Count > 0)
        {
            Status = dt_ic.Rows[0]["State"].ToString();
        }
        //var workItemId = "";
        if ("2".Equals(Status))
        {
            System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select top 1 ObjectID,ActivityCode,DisplayName from OT_WorkItem  " +
                " where InstanceId = '" + InstanceID + "' " +
                " order by FinishTime desc");
            if (dt_wi.Rows.Count > 0)
            {
                dic.Add("ActivityCode", dt_wi.Rows[0]["ActivityCode"].ToString());
                dic.Add("DisplayName", dt_wi.Rows[0]["DisplayName"].ToString());
            }
        }
        else if ("4".Equals(Status))
        {
            //System.Data.DataTable dt_wi = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            //    " select top 1 ObjectID,ActivityCode,DisplayName from OT_WorkItemFinished  " +
            //    " where InstanceId = '" + InstanceID + "' " +
            //    " order by FinishTime desc");
            //if (dt_wi.Rows.Count > 0)
            //{
            dic.Add("ActivityCode", "End");
            dic.Add("DisplayName", "结束");
            //}
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 根据InstanceID获取编号、简称数据
    public void getDataByInstanceId(HttpContext context)
    {
        string InstanceID = context.Request["InstanceID"];
        Dictionary<string, string> dic = new Dictionary<string, string>();
        string WorkflowCode = "";
        System.Data.DataTable dt_ic = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " SELECT ic.WorkflowCode FROM OT_InstanceContext ic where ic.ObjectID = '" + InstanceID + "' " );
        if (dt_ic.Rows.Count > 0)
        {
            WorkflowCode = dt_ic.Rows[0]["WorkflowCode"].ToString();
        }
        string MainTbl = "";
        string sql1 = "select * from PD_Master where [key] = '"+WorkflowCode+"'";
        System.Data.DataTable dt_m = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql1);
        if (dt_m.Rows.Count > 0)
        {
            MainTbl = dt_m.Rows[0]["type"].ToString();
        }
        // 如果该数据是合同的子流程
        if(MainTbl.Equals("ContractMain"))
        {
            string sql2 = "select top 1 mt.ContractNo,mt.ContractShortName ";
            sql2 += " from I_" + WorkflowCode + " t ";
            sql2 += " INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId and ic.ObjectID = '" + InstanceID + "' ";
            if(WorkflowCode.Equals("UpdateContractNo"))
            {
                sql2 += " INNER JOIN I_ContractMain mt on t.ContractNoOld = mt.ContractNo or t.ContractNoNew = mt.ContractNo ";
            } else
            {
                sql2 += " INNER JOIN I_ContractMain mt on t.ContractNo = mt.ContractNo ";
            }

            System.Data.DataTable dt_t = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);
            if (dt_t.Rows.Count > 0)
            {
                dic.Add("OperationNumber", dt_t.Rows[0]["ContractNo"].ToString());
                dic.Add("ProjectAbbreviation", dt_t.Rows[0]["ContractShortName"].ToString());
                dic.Add("OperationType","采购合同");
            }
        } else if(MainTbl.Equals("InviteBids"))
        {
            string sql2 = "select top 1 mt.BiddingCode,mt.ProjectShortName from I_"+WorkflowCode+" t " +
            " INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId and ic.ObjectID = '"+InstanceID+"' " +
            " INNER JOIN I_InviteBids mt on t.BiddingCode = mt.BiddingCode ";
            System.Data.DataTable dt_t = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);
            if (dt_t.Rows.Count > 0)
            {
                dic.Add("OperationNumber", dt_t.Rows[0]["BiddingCode"].ToString());
                dic.Add("ProjectAbbreviation", dt_t.Rows[0]["ProjectShortName"].ToString());
                dic.Add("OperationType","招标项目");
            }
        } else if(MainTbl.Equals("Agreement_mains"))
        {
            string sql2 = "select top 1 mt.AgreeMent_number,mt.AgreeMent_name ";
            sql2 += " from I_" + WorkflowCode + " t ";
            sql2 += " INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId and ic.ObjectID = '" + InstanceID + "' ";
            if(WorkflowCode.Equals("Update_agreement_number"))
            {
                sql2 += " INNER JOIN I_Agreement_mains mt on t.Self_agreeMent_number = mt.AgreeMent_number ";
            } else
            {
                sql2 += " INNER JOIN I_Agreement_mains mt on t.AgreeMent_number = mt.AgreeMent_number ";
            }
            sql2 += " union select top 1 mt.AgreeMent_number,mt.AgreeMent_name " +
                "from I_" + WorkflowCode + " t ";
            sql2 +=" INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId and ic.ObjectID = '" + InstanceID + "' ";
            if(WorkflowCode.Equals("Update_agreement_number"))
            {

            } else
            {
                sql2 += " INNER JOIN I_AircraftOilAgreement mt on t.AgreeMent_number = mt.AgreeMent_number ";
            }
            System.Data.DataTable dt_t = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);
            if (dt_t.Rows.Count > 0)
            {
                dic.Add("OperationNumber", dt_t.Rows[0]["AgreeMent_number"].ToString());
                dic.Add("ProjectAbbreviation", dt_t.Rows[0]["AgreeMent_name"].ToString());
                dic.Add("OperationType","代理协议");
            }
        }


        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取待办任务
    public void getUnfinishedTask(HttpContext context)
    {
        // 从第几条数据开始获取
        string pageNumber = context.Request["pageNumber"];
        // 每一页多少条数据
        string pageSize = context.Request["pageSize"];
        string CurrentUser = context.Request["CurrentUser"];
        string SInstanceName = context.Request["SInstanceName"];
        string sql_in = "";
        if (SInstanceName!=null && !SInstanceName.Equals(""))
        {
            sql_in = " and ic.InstanceName like '%" + SInstanceName + "%'";
        }
        if(pageNumber==null || pageNumber.Equals(""))
        {
            pageNumber = "1";
        }
        if(pageSize==null || pageSize.Equals(""))
        {
            pageSize = "10";
        }
        Dictionary<string,object> ret = new Dictionary<string,object>();
        System.Data.DataTable dt_totalCount = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select count(1) count from (" +
                " SELECT ic.ObjectID ICObjectID,wi.ObjectID WorkItemID,min(ic.InstanceName) InstanceName,min(wi.DisplayName) TaskName,min(wi.ReceiveTime) ReceiveTime, " +
                " min(u.Name) OriginatorName,min(ou.Name) OUName,min(ic.CreatedTime) CreatedTime " +
                " FROM OT_InstanceContext ic " +
                " INNER JOIN OT_WorkItem wi on ic.ObjectID = wi.InstanceId and wi.Participant = '"+CurrentUser+"'" +
                " and ic.InstanceName not like '%主流程%' and ic.InstanceName not like '%资金计划%' " + sql_in +
                " left JOIN OT_User u on ic.Originator = u.ObjectID " +
                " left JOIN OT_OrganizationUnit ou on ic.OrgUnit = ou.ObjectID " +
                " GROUP BY ic.ObjectID,wi.ObjectID " +
                " ) t");
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select top "+pageSize+" * from ( select row_number() over(order by ReceiveTime desc) as rownumber,* from ( " +
                " SELECT ic.ObjectID ICObjectID,wi.ObjectID WorkItemID,min(ic.InstanceName) InstanceName,min(wi.DisplayName) TaskName,min(wi.ReceiveTime) ReceiveTime, " +
                " min(u.Name) OriginatorName,min(ou.Name) OUName,min(ic.CreatedTime) CreatedTime,min(ic.WorkflowCode) WorkflowCode " +
                " FROM OT_InstanceContext ic " +
                " INNER JOIN OT_WorkItem wi on ic.ObjectID = wi.InstanceId and wi.Participant = '"+CurrentUser+"'" +
                " and ic.InstanceName not like '%主流程%' and ic.InstanceName not like '%资金计划%' " +sql_in +
                " left JOIN OT_User u on ic.Originator = u.ObjectID " +
                " left JOIN OT_OrganizationUnit ou on ic.OrgUnit = ou.ObjectID " +
                " GROUP BY ic.ObjectID,wi.ObjectID ) t" +
                " ) A where rownumber >= "+ pageNumber);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //int passCnt = 0;
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("ICObjectID", dr["ICObjectID"].ToString());
                dic.Add("WorkItemID", dr["WorkItemID"].ToString());
                dic.Add("InstanceName", dr["InstanceName"].ToString());
                dic.Add("TaskName", dr["TaskName"].ToString());
                dic.Add("ReceiveTime", dr["ReceiveTime"].ToString());
                dic.Add("OriginatorName", dr["OriginatorName"].ToString());
                dic.Add("OUName", dr["OUName"].ToString());
                dic.Add("CreatedTime", dr["CreatedTime"].ToString());
                // 保函的发起申请节点不要
                //if(dr["InstanceName"].ToString().Contains("保函") && dr["TaskName"].ToString().Equals("发起申请"))
                //{
                //    passCnt++;
                //}

                // 获取编号和项目简称
                Dictionary<string, string> dic2 = getOperationNumbers(dr);
                dic.Add("OperationNumber", dic2.Count>0?dic2["OperationNumber"]!=null?dic2["OperationNumber"]:"":"");
                dic.Add("ProjectAbbreviation", dic2.Count>0?dic2["ProjectAbbreviation"]!=null?dic2["ProjectAbbreviation"]:"":"");
                ls.Add(dic);
            }
        }
        ret.Add("total", dt_totalCount.Rows[0]["count"]);
        ret.Add("rows", ls);
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取待办任务数量
    public void getUnfinishedTaskCount(HttpContext context)
    {
        string CurrentUser = context.Request["CurrentUser"];
        Dictionary<string, string> dic = new Dictionary<string, string>();
        System.Data.DataTable dt_totalUnfinishedCount = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select count(1) count from (" +
                " SELECT ic.ObjectID ICObjectID,wi.ObjectID WorkItemID,min(ic.InstanceName) InstanceName,min(wi.DisplayName) TaskName,min(wi.ReceiveTime) ReceiveTime, " +
                " min(u.Name) OriginatorName,min(ISNULL(ou.Name, '')) OUName,min(ic.CreatedTime) CreatedTime " +
                " FROM OT_InstanceContext ic " +
                " INNER JOIN OT_WorkItem wi on ic.ObjectID = wi.InstanceId and wi.Participant = '"+CurrentUser+"'" +
                " and ic.InstanceName not like '%主流程%' and ic.InstanceName not like '%资金计划%'  " +
                " left JOIN OT_User u on ic.Originator = u.ObjectID " +
                " left JOIN OT_OrganizationUnit ou on ic.OrgUnit = ou.ObjectID " +
                " GROUP BY ic.ObjectID,wi.ObjectID " +
                " ) t");
        System.Data.DataTable dt_totalFinishedCount = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select count(1) count from (" +
                " SELECT ic.ObjectID ICObjectID,wi.ObjectID WorkItemID,min(ic.InstanceName) InstanceName,min(wi.DisplayName) TaskName,min(wi.ReceiveTime) ReceiveTime, " +
                " min(u.Name) OriginatorName,min(ISNULL(ou.Name, '')) OUName,min(ic.CreatedTime) CreatedTime " +
                " FROM OT_InstanceContext ic " +
                " INNER JOIN OT_WorkItemFinished wi on ic.ObjectID = wi.InstanceId and wi.Participant = '"+CurrentUser+"'" +
                " and ic.InstanceName not like '%主流程%' and ic.InstanceName not like '%资金计划%' " +
                " left JOIN OT_User u on ic.Originator = u.ObjectID " +
                " left JOIN OT_OrganizationUnit ou on ic.OrgUnit = ou.ObjectID " +
                " GROUP BY ic.ObjectID,wi.ObjectID " +
                " ) t");
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_totalUnfinishedCount.Rows.Count > 0)
        {
            dic.Add("UnfinishedCount",dt_totalUnfinishedCount.Rows[0]["count"].ToString());
        }
        if (dt_totalFinishedCount.Rows.Count > 0)
        {
            dic.Add("FinishedCount",dt_totalFinishedCount.Rows[0]["count"].ToString());
        }

        object JSONObj = JsonConvert.SerializeObject(dic);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取已办任务
    public void getFinishedTask(HttpContext context)
    {
        // 从第几条数据开始获取
        string pageNumber = context.Request["pageNumber"];
        // 每一页多少条数据
        string pageSize = context.Request["pageSize"];
        string CurrentUser = context.Request["CurrentUser"];
        string SInstanceName = context.Request["SInstanceName"];
        string StartTime = context.Request["StartTime"];
        string EndTime = context.Request["EndTime"];
        string sql_in = "";
        string sql_st = "";
        string sql_et = "";
        if (SInstanceName!=null && !SInstanceName.Equals(""))
        {
            sql_in = " and ic.InstanceName like '%" + SInstanceName + "%'";
        }
        if (StartTime!=null && !StartTime.Equals(""))
        {
            sql_st = " and wi.ReceiveTime >= '"+StartTime+" 00:00:00'";
        }
        if (EndTime!=null && !EndTime.Equals(""))
        {
            sql_et = " and wi.ReceiveTime < '"+EndTime+" 23:59:59'";
        }
        if(pageNumber==null || pageNumber.Equals(""))
        {
            pageNumber = "1";
        }
        if(pageSize==null || pageSize.Equals(""))
        {
            pageSize = "10";
        }
        Dictionary<string,object> ret = new Dictionary<string,object>();
        System.Data.DataTable dt_totalCount = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select count(1) count from (" +
                " SELECT ic.ObjectID ICObjectID,wi.ObjectID WorkItemID,min(ic.InstanceName) InstanceName,min(wi.DisplayName) TaskName,min(wi.ReceiveTime) ReceiveTime, " +
                " min(u.Name) OriginatorName,min(ISNULL(ou.Name, '')) OUName,min(ic.CreatedTime) CreatedTime " +
                " FROM OT_InstanceContext ic " +
                " INNER JOIN OT_WorkItemFinished wi on ic.ObjectID = wi.InstanceId and wi.Participant = '"+CurrentUser+"'" +
                " and ic.InstanceName not like '%主流程%' " +
                sql_in + sql_st + sql_et +
                " left JOIN OT_User u on ic.Originator = u.ObjectID " +
                " left JOIN OT_OrganizationUnit ou on ic.OrgUnit = ou.ObjectID " +
                " GROUP BY ic.ObjectID,wi.ObjectID " +
                " ) t");
        string sql = " select top " + pageSize + " * from ( select row_number() over(order by ReceiveTime desc) as rownumber,* from ( " +
                " SELECT ic.ObjectID ICObjectID,wi.ObjectID WorkItemID,min(ic.InstanceName) InstanceName,min(wi.DisplayName) TaskName,min(wi.ReceiveTime) ReceiveTime, " +
                " min(u.Name) OriginatorName,min(ISNULL(ou.Name, '')) OUName,min(ic.CreatedTime) CreatedTime,min(ic.WorkflowCode) WorkflowCode " +
                " FROM OT_InstanceContext ic " +
                " INNER JOIN OT_WorkItemFinished wi on ic.ObjectID = wi.InstanceId and wi.Participant = '" + CurrentUser + "'" +
                " and ic.InstanceName not like '%主流程%' "
                + sql_in + sql_st + sql_et +
                " left JOIN OT_User u on ic.Originator = u.ObjectID " +
                " left JOIN OT_OrganizationUnit ou on ic.OrgUnit = ou.ObjectID " +
                " GROUP BY ic.ObjectID,wi.ObjectID ) t" +
                " ) A where rownumber >= " + pageNumber;
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("ICObjectID", dr["ICObjectID"].ToString());
                dic.Add("WorkItemID", dr["WorkItemID"].ToString());
                dic.Add("InstanceName", dr["InstanceName"].ToString());
                dic.Add("TaskName", dr["TaskName"].ToString());
                dic.Add("ReceiveTime", dr["ReceiveTime"].ToString());
                dic.Add("OriginatorName", dr["OriginatorName"].ToString());
                dic.Add("OUName", dr["OUName"].ToString());
                dic.Add("CreatedTime", dr["CreatedTime"].ToString());

                // 获取编号和项目简称
                Dictionary<string, string> dic2 = getOperationNumbers(dr);
                dic.Add("OperationNumber", dic2["OperationNumber"]!=null?dic2["OperationNumber"]:"");
                dic.Add("ProjectAbbreviation", dic2["ProjectAbbreviation"]!=null?dic2["ProjectAbbreviation"]:"");
                ls.Add(dic);
            }
        }
        ret.Add("total", dt_totalCount.Rows[0]["count"]);
        ret.Add("rows", ls);
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取全文检索数据
    public void getFullTextSearchData(HttpContext context)
    {
        // 从第几条数据开始获取
        string pageNumber = context.Request["pageNumber"];
        // 每一页多少条数据
        string pageSize = context.Request["pageSize"];
        string CurrentUser = context.Request["CurrentUser"];
        string ModuleName = context.Request["ModuleName"];
        string SubInstanceName = context.Request["SubInstanceName"];
        string FullText = context.Request["FullText"];
        string sql_in = "";
        if (FullText!=null && !FullText.Equals(""))
        {
            sql_in = " and ic.InstanceName like '%" + FullText + "%'";
        }
        List<Dictionary<string, string>> FullTexts = getFullTexts();
        // 全部模块全文检索
        if(ModuleName=="")
        {
            sql_in = getAllModuleSQL(FullText,FullTexts);
            // 单个模块全文检索
        } else if (ModuleName!="" && SubInstanceName =="")
        {
            sql_in = getModuleSQL(ModuleName,FullText,FullTexts);
            // 单个子流程全文检索
        } else if (ModuleName!="" && SubInstanceName !="")
        {
            sql_in = getSubSQL(SubInstanceName,FullText,FullTexts);
        }
        if(pageNumber==null || pageNumber.Equals(""))
        {
            pageNumber = "1";
        }
        if(pageSize==null || pageSize.Equals(""))
        {
            pageSize = "10";
        }
        Dictionary<string,object> ret = new Dictionary<string,object>();
        System.Data.DataTable dt_totalCount = sql_in==""?null:OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select count(1) count from (" +
                sql_in  +
                " ) t");
        string sql = " select top " + pageSize + " * from ( select row_number() over(order by CreatedTime desc) as rownumber,* from ( " +
                 sql_in +
                "  ) t" +
                " ) A where rownumber >= " + pageNumber;
        System.Data.DataTable dt = sql_in==""?null:OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();

        if (dt!=null && dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                Dictionary<string, string> widata = Common.getWorkItemId2(dr["ICObjectID"].ToString(), dr["State"].ToString(), CurrentUser);
                dic.Add("ICObjectID", dr["ICObjectID"].ToString());
                dic.Add("WorkItemID", widata["workItemId"]);
                dic.Add("ModuleName", dr["ModuleName"].ToString());
                int index = dr["InstanceName"].ToString().IndexOf(".");
                var InstanceName = index>0?dr["InstanceName"].ToString().Substring(0,index):dr["InstanceName"].ToString();
                dic.Add("SubInstanceName", InstanceName);


                // 获取编号和项目简称
                Dictionary<string, string> dic2 = getOperationNumbers(dr);
                dic.Add("OperationNumber", dic2["OperationNumber"] != null ? dic2["OperationNumber"] : "");
                dic.Add("ProjectAbbreviation", dic2["ProjectAbbreviation"] != null ? dic2["ProjectAbbreviation"] : "");
                ls.Add(dic);
            }
        }
        ret.Add("total", dt_totalCount!=null?dt_totalCount.Rows[0]["count"]:"0");
        ret.Add("rows", ls);
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    // 业务子系统的几个模块
    public static string[] Modules = { "ContractMain","InviteBids","Agreement_mains"};

    public string getAllModuleSQL(string FullText,List<Dictionary<string, string>> FullTexts)
    {
        var sql = "";
        foreach (string item in Modules)
        {
            List<Dictionary<string, string>> subs = getSubByModuleName(item);
            foreach (Dictionary<string, string> dic in subs)
            {
                sql += getSQL( item, dic["Sub"], FullText,FullTexts) ;
            }
        }
        return sql.Length>=5?sql.Substring(5):"";
    }

    public string getModuleSQL(string ModuleName,string FullText,List<Dictionary<string, string>> FullTexts)
    {
        var sql = "";
        List<Dictionary<string, string>> subs = getSubByModuleName(ModuleName);
        foreach (Dictionary<string, string> dic in subs)
        {
            sql += getSQL( ModuleName, dic["Sub"], FullText,FullTexts) ;
        }
        return sql.Length>=5?sql.Substring(5):"";
    }

    public string getSubSQL(string SubInstanceName,string FullText,List<Dictionary<string, string>> FullTexts)
    {
        var sql = "";
        var ModuleName = getModuleNameBySub(SubInstanceName);
        sql = getSQL( ModuleName, SubInstanceName, FullText,FullTexts) ;
        return sql.Length>=5?sql.Substring(5):"";
    }

    public string getSQL(string ModuleName,string SubInstanceName,string FullText,List<Dictionary<string, string>> FullTexts)
    {

        var sql = "";
        var sql_CONTAINS = "";
        foreach (Dictionary<string, string> item in FullTexts)
        {
            if("FullText_"+SubInstanceName == item["type"])
            {
                sql_CONTAINS += "or CONTAINS(t."+item["key"]+", ' \""+FullText+"\" ') " ;
            }
        }
        if(sql_CONTAINS!="")
        {
            sql = "Union SELECT case '"+ModuleName+"' when 'ContractMain' then '合同' when 'InviteBids' then '招标项目' when 'Agreement_mains' then '协议' end ModuleName," +
                "'"+SubInstanceName+"' WorkflowCode,ic.ObjectID ICObjectID,ic.State,ic.InstanceName,ic.CreatedTime " +
                " FROM I_"+SubInstanceName+" t " +
                " INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId " +
                " and (" + (sql_CONTAINS.Length>=2?sql_CONTAINS.Substring(2):"") +")";
        }
        return sql;
    }
    // 根据模块获取子流程名称
    public List<Dictionary<string, string>> getSubByModuleName(string ModuleName)
    {
        var sql = " select * from PD_Master where type = '"+ModuleName+"'";
        var ret = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 获取Master的数据
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("Sub",dr["key"].ToString());
                ls.Add(dic);
            }
        }
        return ls;
    }
    // 获取全文检索的各个子流程中字段值
    public List<Dictionary<string, string>> getFullTexts()
    {
        var sql = " select * from PD_Master where type like 'FullText_%'";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 获取Master的数据
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("type",dr["type"].ToString());
                dic.Add("key",dr["key"].ToString());
                ls.Add(dic);
            }
        }
        return ls;
    }
    // 根据子流程获取模块名称
    public string getModuleNameBySub(string SubInstanceName)
    {
        var sql = " select top 1 * from PD_Master where [key] = '"+SubInstanceName+"'";
        var ret = "";
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        // 获取Master的数据
        if (dt.Rows.Count > 0)
        {
            ret = dt.Rows[0]["type"].ToString();
        }
        return ret;
    }

    // 根据模块获取子流程
    public void getSubInstanceName(HttpContext context)
    {
        string ModuleName = context.Request["ModuleName"];

        var sql = " select * from PD_Master where type = '"+ModuleName+"' order by attr3";

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        // 获取Master的数据
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("id", dr["id"].ToString());
                dic.Add("type", dr["type"].ToString());
                dic.Add("key", dr["key"].ToString());
                dic.Add("value", dr["value"].ToString());
                dic.Add("attr1", dr["attr1"].ToString());
                dic.Add("attr2", dr["attr2"].ToString());
                dic.Add("attr3", dr["attr3"].ToString());
                dic.Add("attr4", dr["attr4"].ToString());
                dic.Add("attr5", dr["attr5"].ToString());
                ls.Add(dic);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }


    // 获取我的子流程
    public void getMyInstanceSub(HttpContext context)
    {
        // 从第几条数据开始获取
        string pageNumber = context.Request["pageNumber"];
        // 每一页多少条数据
        string pageSize = context.Request["pageSize"];
        string CurrentUser = context.Request["CurrentUser"];
        string SInstanceName = context.Request["SInstanceName"];
        string StartTime = context.Request["StartTime"];
        string EndTime = context.Request["EndTime"];
        string Type = context.Request["Type"];
        string TypeOfMe = context.Request["TypeOfMe"];
        string sql_in = "";
        string sql_st = "";
        string sql_et = "";
        if (SInstanceName!=null && !SInstanceName.Equals(""))
        {
            sql_in = " and ic.InstanceName like '%" + SInstanceName + "%'";
        }
        if (StartTime!=null && !StartTime.Equals(""))
        {
            sql_st = " and wi.ReceiveTime >= '"+StartTime+" 00:00:00'";
        }
        if (EndTime!=null && !EndTime.Equals(""))
        {
            sql_et = " and wi.ReceiveTime < '"+EndTime+" 23:59:59'";
        }
        if(pageNumber==null || pageNumber.Equals(""))
        {
            pageNumber = "1";
        }
        if(pageSize==null || pageSize.Equals(""))
        {
            pageSize = "10";
        }
        Dictionary<string,object> ret = new Dictionary<string,object>();

        string sql = " select ic.ObjectID ICObjectID,min(wi.ObjectID) WorkItemID,min(ic.InstanceName) InstanceName,min(ic.StartTime) StartTime, " ;
        sql += " min(ic.FinishTime) FinishTime,min(wi.DisplayName) DisplayName,min(ic.State) State,MIN (ic.WorkflowCode) WorkflowCode ";
        sql += " FROM OT_InstanceContext ic " ;
        if(Type==null || Type.Equals("") || Type.Equals("进行中"))
        {
            sql += " INNER JOIN OT_WorkItem wi on ic.ObjectID = wi.InstanceId and ic.State = '2'" ;
        } else if (Type.Equals("已完成"))
        {
            sql += " INNER JOIN OT_WorkItemFinished wi on ic.ObjectID = wi.InstanceId and ic.State = '4'" ;
        }
        if(TypeOfMe==null || TypeOfMe.Equals("") || TypeOfMe.Equals("我发起的"))
        {
            sql += " and ic.Originator = '"+CurrentUser+"' " ;
        } else if (TypeOfMe.Equals("我参与的"))
        {
            sql += " and wi.Participant = '"+CurrentUser+"'" ;
        }
        sql += " and ic.InstanceName not like '%主流程%' " ;
        sql += sql_in + sql_st + sql_et ;
        sql += " GROUP BY ic.ObjectID " ;
        string sql_totalCount = " select count(1) count from (";
        sql_totalCount += sql;
        sql_totalCount += " ) t";
        string sql_total = " select top "+pageSize+" * from ( select row_number() over(order by StartTime desc) as rownumber,* from ( ";
        sql_total += sql;
        sql_total += " ) t ) A where rownumber >= "+ pageNumber;
        System.Data.DataTable dt_totalCount = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_totalCount);
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_total);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                Dictionary<string, string> widata = Common.getWorkItemId2(dr["ICObjectID"].ToString(), dr["State"].ToString(), CurrentUser);
                dic.Add("InstanceName", dr["InstanceName"].ToString());
                dic.Add("StartTime", dr["StartTime"].ToString());
                dic.Add("FinishTime", dr["FinishTime"].ToString());
                dic.Add("CurrentActivity", widata["DisplayName"]);
                dic.Add("Approver", widata["ParticipantName"]);
                dic.Add("ICObjectID", dr["ICObjectID"].ToString());
                dic.Add("WorkItemID", widata["workItemId"]);
                dic.Add("Mode", widata["Mode"]);


                // 获取编号和项目简称
                Dictionary<string, string> dic2 = getOperationNumbers(dr);
                dic.Add("OperationNumber", dic2.Count>0&&dic2["OperationNumber"]!=null?dic2["OperationNumber"]:"");
                dic.Add("ProjectAbbreviation", dic2.Count>0&&dic2["ProjectAbbreviation"]!=null?dic2["ProjectAbbreviation"]:"");
                ls.Add(dic);
            }
        }
        ret.Add("total", dt_totalCount.Rows[0]["count"]);
        ret.Add("rows", ls);
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public Dictionary<string, string> getOperationNumbers(DataRow dr)
    {
        Dictionary<string, string> dic = new Dictionary<string, string>();
        string MainTbl = "";
        string sql1 = "select * from PD_Master where [key] = '"+dr["WorkflowCode"].ToString()+"'";
        System.Data.DataTable dt_m = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql1);
        if (dt_m.Rows.Count > 0)
        {
            MainTbl = dt_m.Rows[0]["type"].ToString();
        }
        // 如果该数据是合同的子流程
        if(MainTbl.Equals("ContractMain"))
        {
            string sql2 = "select top 1 mt.ContractNo,mt.ContractShortName ";
            sql2 += " from I_" + dr["WorkflowCode"].ToString() + " t ";
            sql2 += " INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId and ic.ObjectID = '" + dr["ICObjectID"].ToString() + "' ";
            if(dr["WorkflowCode"].ToString().Equals("UpdateContractNo"))
            {
                sql2 += " INNER JOIN I_ContractMain mt on t.ContractObjectID = mt.ObjectID ";
            } else
            {
                sql2 += " INNER JOIN I_ContractMain mt on t.ContractNo = mt.ContractNo ";
            }

            System.Data.DataTable dt_t = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);
            if (dt_t.Rows.Count > 0)
            {
                dic.Add("OperationNumber", dt_t.Rows[0]["ContractNo"].ToString());
                dic.Add("ProjectAbbreviation", dt_t.Rows[0]["ContractShortName"].ToString());
            }
        } else if(MainTbl.Equals("InviteBids"))
        {
            string sql2 = "select top 1 mt.BiddingCode,mt.ProjectShortName from I_"+dr["WorkflowCode"].ToString()+" t " +
            " INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId and ic.ObjectID = '"+dr["ICObjectID"].ToString()+"' " +
            " INNER JOIN I_InviteBids mt on t.IssueObjectId = mt.ObjectID ";
            System.Data.DataTable dt_t = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);
            if (dt_t.Rows.Count > 0)
            {
                dic.Add("OperationNumber", dt_t.Rows[0]["BiddingCode"].ToString());
                dic.Add("ProjectAbbreviation", dt_t.Rows[0]["ProjectShortName"].ToString());
            }
        } else if(MainTbl.Equals("Agreement_mains"))
        {
            string sql2 = "select top 1 mt.AgreeMent_number,mt.AgreeMent_name ";
            sql2 += " from I_" + dr["WorkflowCode"].ToString() + " t ";
            sql2 += " INNER JOIN OT_InstanceContext ic on t.ObjectID = ic.BizObjectId and ic.ObjectID = '" + dr["ICObjectID"].ToString() + "' ";
            if(dr["WorkflowCode"].ToString().Equals("Update_agreement_number"))
            {
                sql2 += " INNER JOIN I_Agreement_mains mt on t.Self_agreeMent_number = mt.AgreeMent_number ";
            } else
            {
                sql2 += " INNER JOIN I_Agreement_mains mt on t.AgreeMent_number = mt.AgreeMent_number ";
            }

            System.Data.DataTable dt_t = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql2);
            if (dt_t.Rows.Count > 0)
            {
                dic.Add("OperationNumber", dt_t.Rows[0]["AgreeMent_number"].ToString());
                dic.Add("ProjectAbbreviation", dt_t.Rows[0]["AgreeMent_name"].ToString());
            }
        } else
        {
            dic.Add("OperationNumber", "");
            dic.Add("ProjectAbbreviation", "");
        }
        return dic;
    }


    // 获取审批记录
    public void getApprovalTblData(HttpContext context)
    {
        // InstanceId
        string InstanceId = context.Request["InstanceId"];

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT BizObjectSchemaCode,Activity,UserID,UserName,Approval,CreatedTime,[Text]"+
                " FROM OT_Comment where InstanceId = '"+InstanceId+"' ORDER BY CreatedTime  ");
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                string ActivityName = Common.getActivityName(dr["BizObjectSchemaCode"].ToString(),dr["Activity"].ToString());
                dic.Add("ActivityName", ActivityName);
                dic.Add("Operator", dr["UserName"].ToString());
                dic.Add("OperateStatus", dr["Approval"].ToString().Equals("0")?"驳回":dr["Approval"].ToString().Equals("1")?"同意":"");
                dic.Add("OperateTime", dr["CreatedTime"].ToString());
                dic.Add("Comment", dr["Text"].ToString());
                ls.Add(dic);
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取保函流水号
    public void getBHNo(HttpContext context)
    {

        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select Max(ISNULL(BHNo,0))+1 BHNo " +
                " from I_BHInput " );
        string ret = "";
        if (dt.Rows.Count > 0)
        {
            ret = dt.Rows[0]["BHNo"].ToString();
        }
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 是否为发起到款角色
    public void IsDKRole(HttpContext context)
    {
        string role = context.Request["role"];
        string UserID = context.Request["UserID"];
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT g.ObjectID" +
                " FROM OT_Group g " +
                " INNER JOIN OT_GroupChild gc on g.ObjectID = gc.ParentObjectID " +
                " INNER JOIN OT_User u on gc.ChildID = u.ObjectID " +
                " and u.ObjectID = '"+UserID+"' and g.Name = '"+role+"'" );
        string ret = "false";
        if (dt.Rows.Count > 0)
        {
            ret = "true";
        }
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取请款币种数据
    public void getQKDetailByCurrency(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string QKSeq = context.Request["QKSeq"];
        string Currency = context.Request["Currency"];

        string ret = getQKDetailByCurrency2(ContractNo, QKSeq, Currency);
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public string getQKDetailByCurrency2(string ContractNo,string QKSeq,string Currency)
    {
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select qs.ZJMS+':'+qs.Currency+convert(varchar(20),convert(decimal(18,2),ISNULL(qs.Amount,0))) QKDetail " +
                " from I_QK q, I_QKSubTbl qs" +
                " where q.ContractNo = '"+ContractNo+"' and q.QKSeq = '"+QKSeq+"' and qs.Currency = '"+Currency+"' " +
                " and q.ObjectID = qs.ParentObjectID ");
        string ret = "";
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                ret += dr["QKDetail"].ToString() + "\n";
            }
        }
        return ret;
    }

    // 获取信用证状态记录
    public void getPaymentStatusData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];

        // 获取信用证付款状态记录
        System.Data.DataTable dt_paymentst = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT p.ObjectID,p.BankName Bank,convert(varchar(20),convert(decimal(18,2),p.PaymentAmount)) as PaymentAmount,ISNULL(p.AfterChangeAmount, 0) AfterChangeAmount,e1.EnumValue Currency " +
                " FROM I_PaymentSub p" +
                " INNER JOIN OT_InstanceContext ic on p.ObjectID = ic.BizObjectId and p.ContractNo = '" + ContractNo + "' and ic.State = '4' " +
                " LEFT JOIN OT_EnumerableMetadata e1 on p.Currency = e1.Code and e1.Category = '币种' " +
                "  ORDER BY p.CreatedTime");
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_paymentst.Rows.Count > 0)
        {
            var i = 0;
            foreach (DataRow dr in dt_paymentst.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("Bank",dr["Bank"].ToString());
                var Amount = "";
                if (Convert.ToDouble(dr["AfterChangeAmount"].ToString()) > 0)
                {
                    Amount = dr["AfterChangeAmount"].ToString();
                } else
                {
                    Amount = dr["PaymentAmount"].ToString();
                }
                System.Data.DataTable dt_paymentfk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select ISNULL(SUM(CurZJAmount), 0) CurZJAmount " +
                " from I_FK f" +
                " INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectId and f.PayType = '" + dr["ObjectID"].ToString() + "' and ic.State = '4' ");
                var PayedAmount = "";
                if (dt_paymentfk.Rows.Count > 0)
                {
                    PayedAmount = dt_paymentfk.Rows[0]["CurZJAmount"].ToString();
                }
                var RemainAmount = (Convert.ToDouble(Amount) - Convert.ToDouble(PayedAmount)).ToString();
                dic.Add("Amount",Amount + dr["Currency"].ToString());
                dic.Add("PayedAmount",PayedAmount + dr["Currency"].ToString());
                dic.Add("RemainAmount",RemainAmount + dr["Currency"].ToString());
                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取信用证记录
    public void getPaymentData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取信用证记录
        System.Data.DataTable dt_payment = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select * from ( " +
                " SELECT p.BankName,convert(varchar(20),convert(decimal(18,2),p.PaymentAmount))+e1.EnumValue PaymentAmount,ic.State Status,p.CreatedTime,ic.ObjectID,p.ObjectID PaymentId, p.changePaymentFlg, p.RejectFlg " +
                " FROM I_PaymentSub p " +
                " INNER JOIN OT_InstanceContext ic on p.ObjectID = ic.BizObjectId and p.ContractNo = '" + ContractNo + "' and ic.State = '4' " +
                " LEFT JOIN OT_EnumerableMetadata e1 on p.Currency = e1.Code and e1.Category = '币种'  " +
                " Union All " +
                " SELECT p.BankName,CONVERT(VARCHAR,p.PaymentAmount)+e1.EnumValue PaymentAmount,ic.State Status,p.CreatedTime,ic.ObjectID,p.ObjectID PaymentId, p.changePaymentFlg, p.RejectFlg " +
                " FROM I_PaymentSub p " +
                " INNER JOIN OT_InstanceContext ic on p.ObjectID = ic.BizObjectId and p.ContractNo = '" + ContractNo + "' and ic.State = '2' " +
                " LEFT JOIN OT_EnumerableMetadata e1 on p.Currency = e1.Code and e1.Category = '币种'  " +
                " ) t ORDER BY t.CreatedTime ");
        List<Dictionary<string, string>> ret = new List<Dictionary<string, string>>();
        if (dt_payment.Rows.Count > 0)
        {
            List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
            var i = 0;
            var TheNo = 0;
            foreach (DataRow dr in dt_payment.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                TheNo++;
                dic.Add("TheNo", TheNo.ToString());
                dic.Add("Bank", dr["BankName"].ToString());
                dic.Add("TotalAmount", dr["PaymentAmount"].ToString());
                var st = dr["Status"].ToString();

                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["ObjectID"].ToString(), st, UserID);
                dic.Add("WorkItemId", workItemDic["workItemId"]);
                dic.Add("Status", st.Equals("4")?"已开证":workItemDic["DisplayName"]);
                dic.Add("PaymentId", dr["PaymentId"].ToString());
                dic.Add("changePaymentFlg", dr["changePaymentFlg"].ToString());
                dic.Add("RejectFlg", dr["RejectFlg"].ToString());
                ls.Add(dic);
                i++;

                System.Data.DataTable dtu = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                    " SELECT p.BankName, " +
                    " convert(varchar(20),convert(decimal(18,2),up.PaymentAmount))+e1.EnumValue as PaymentAmount, " +
                    " ic.State Status, " +
                    " case ic.State  " +
                    " when '4' then '已开证'  " +
                    " when '2' then  " +
                    "  case up.RejectFlg  " +
                    "  WHEN '1' THEN '驳回'  " +
                    "  else '审批中'   " +
                    "  end " +
                    " end DisplayName,   " +
                    " up.CreatedTime, " +
                    " ic.ObjectID, " +
                    " up.ObjectID PaymentId,  " +
                    " up.RejectFlg,  " +
                    " up.changePaymentFlg   " +
                    " FROM I_PaymentUpdateSub up  " +
                    " INNER JOIN OT_InstanceContext ic on up.ObjectID = ic.BizObjectId " +
                    " INNER JOIN I_PaymentSub p on p.paymentNo = up.paymentno and p.ObjectID ='" + dr["PaymentId"].ToString() + "'  " +
                    " LEFT JOIN OT_EnumerableMetadata e1 on p.Currency = e1.Code and e1.Category = '币种'  " +
                    " order by CreatedTime  ");
                if (dtu.Rows.Count > 0)
                {
                    foreach (DataRow dr2 in dtu.Rows)
                    {
                        Dictionary<string, string> dic2 = new Dictionary<string, string>();
                        dic2.Add("TheNo", "");
                        dic2.Add("Bank", dr2["BankName"].ToString());
                        dic2.Add("TotalAmount", dr2["PaymentAmount"].ToString());
                        var st2 = dr2["Status"].ToString();
                        dic2.Add("Status", dr2["DisplayName"].ToString());
                        Dictionary<string, string> workItemDic2 = Common.getWorkItemIdNew(dr2["ObjectID"].ToString(), st2, UserID);
                        foreach (var item in workItemDic2)
                        {
                            Console.WriteLine(item.Key + item.Value);
                            if (item.Key.Equals("workItemId"))
                            {
                                dic2.Add("WorkItemId", item.Value);
                            }
                        }
                        dic2.Add("PaymentId", dr2["PaymentId"].ToString());
                        dic2.Add("changePaymentFlg", dr2["changePaymentFlg"].ToString());
                        dic2.Add("RejectFlg", dr2["RejectFlg"].ToString());
                        ls.Add(dic2);
                        i++;
                    }

                }
            }
            var j = 0;
            foreach (Dictionary<string, string> dic in ls)
            {
                Dictionary<string, string> item = new Dictionary<string, string>();
                item.Add("TheNo",dic["TheNo"].ToString());
                item.Add("Bank",dic["Bank"].ToString());
                item.Add("TotalAmount",dic["TotalAmount"].ToString());
                item.Add("Status",dic["Status"].ToString());
                item.Add("WorkItemId",dic["WorkItemId"].ToString());
                item.Add("PaymentId",dic["PaymentId"].ToString());
                item.Add("changePaymentFlg",dic["changePaymentFlg"].ToString());
                item.Add("RejectFlg",dic["RejectFlg"].ToString());
                ret.Add(item);
                j++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取进口许可证记录
    public void getImportData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取进口许可证记录
        System.Data.DataTable dt_importlicense = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT p.GoodName,p.GoodCode,ic.State Status," +
                " case ic.State  " +
                "	when '2' then  " +
                "		case p.RejectFlg " +
                "			when '1' then '驳回' " +
                "			else " +
                "               case (select DisplayName from OT_WorkItem wi where wi.InstanceId = ic.ObjectID) " +
                "					when '发起申请' then '草稿'" +
                "					else '办理中' " +
                "				end" +
                "		end " +
                "  when '4' then " +
                "		case p.CancelFlg  " +
                "			when '1' then '已废除' " +
                "			else '已办证' " +
                "		end  " +
                "  else '草稿'" +
                " end DisplayName, " +
                " p.CreatedTime," +
                " ic.ObjectID IcObjectId," +
                " p.ObjectID ImportLicenseId, " +
                " p.RejectFlg , " +
                " p.CancelFlg " +
                " FROM I_ImportLicenseSub p, OT_InstanceContext ic " +
                " where p.ObjectID = ic.BizObjectId " +
                " and p.ContractNo = '" + ContractNo + "' " +
                " order by p.CreatedTime  ");
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_importlicense.Rows.Count > 0)
        {
            var i = 0;
            foreach (DataRow dr in dt_importlicense.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                var st = dr["Status"].ToString();
                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, UserID);
                var Mode = workItemDic["Mode"];
                if (Mode.Equals("Work"))
                {
                    st += " ";
                }
                dic.Add("GoodName",dr["GoodName"].ToString());
                dic.Add("GoodCode",dr["GoodCode"].ToString());
                dic.Add("DisplayName",dr["DisplayName"].ToString());
                dic.Add("WorkItemId",workItemDic["workItemId"]);
                dic.Add("Status",st);
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                dic.Add("CancelFlg",dr["CancelFlg"].ToString());
                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取到货记录
    public void getDHData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取到货记录
        System.Data.DataTable dt_dh = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " select ContractNo,e1.EnumValue as DHType,DHSeq,e2.EnumValue as ShippingType,GoodName,Num,Amount,e3.EnumValue as Currency,Supplier,State,RejectFlg,DisplayName,t.ObjectID,t.BizObjectID from (" +
                " 	SELECT d.ContractNo,d.DHType,d.DHSeq,d.ShippingType,g.GoodName,g.Num,g.Amount,g.Currency,d.Supplier,ic.State,d.RejectFlg,ic.ObjectID,d.ObjectID BizObjectID  " +
                "	,case d.RejectFlg " +
                "		when '1' then '驳回' " +
                "		else " +
                "			case wi.DisplayName " +
                "				when '到货申请' then '草稿'" +
                " 				else wi.DisplayName+'中'" +
                "			end " +
                "	end DisplayName " +
                "	FROM I_DH d " +
                "	LEFT JOIN I_DHGoodsTbl g on d.ObjectID = g.ParentObjectID " +
                "	LEFT JOIN OT_InstanceContext ic on d.ObjectId = ic.BizObjectID" +
                "	LEFT JOIN OT_WorkItem wi on ic.ObjectID = wi.instanceId" +
                "	where d.ContractNo = '" + ContractNo + "' and ic.State = '2'" +
                "	UNION" +
                " 	SELECT d.ContractNo,d.DHType,d.DHSeq,d.ShippingType,g.GoodName,g.Num,g.Amount,g.Currency,d.Supplier,ic.State,d.RejectFlg,ic.ObjectID,d.ObjectID BizObjectID " +
                " 	,'已到货' DisplayName " +
                "	FROM I_DH d" +
                "	LEFT JOIN I_DHGoodsTbl g on d.ObjectID = g.ParentObjectID" +
                " 	LEFT JOIN OT_InstanceContext ic on d.ObjectId = ic.BizObjectID" +
                "	where d.ContractNo = '" + ContractNo + "' and ic.State = '4'" +
                " )t " +
                " LEFT JOIN OT_EnumerableMetadata e1 on t.DHType = e1.Code and e1.Category = '到货类别'" +
                " LEFT JOIN OT_EnumerableMetadata e2 on t.ShippingType = e2.Code and e2.Category = '运输方式'" +
                " LEFT JOIN OT_EnumerableMetadata e3 on t.Currency = e3.Code and e3.Category = '币种'" +
                " order by t.DHSeq,t.GoodName");
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_dh.Rows.Count > 0)
        {
            var i = 0;
            var TheNo = 0;
            var SeqCnt = 1;
            string DHSeqBak = "";
            foreach (DataRow dr in dt_dh.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                // 第一行
                if (!DHSeqBak.Equals(dr["DHSeq"].ToString()))
                {
                    TheNo++;
                    if (i > 0)
                    {
                        for (var j = 1; j <= SeqCnt; j++)
                        {
                            ls[i - j]["SeqCnt"] = SeqCnt.ToString();
                        }
                        SeqCnt = 1;
                    }
                }
                else
                {
                    SeqCnt++;
                }
                var st = dr["State"].ToString();
                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["ObjectId"].ToString(), st, UserID);

                var Mode = workItemDic["Mode"];
                if (Mode.Equals("Work"))
                {
                    st += " ";
                }

                dic.Add("TheNo",TheNo.ToString());
                dic.Add("DHType",dr["DHType"].ToString());
                dic.Add("DHSeq",dr["DHSeq"].ToString());
                dic.Add("ShippingType",dr["ShippingType"].ToString());
                dic.Add("GoodName",dr["GoodName"].ToString());
                dic.Add("Num",dr["Num"].ToString());
                dic.Add("Amount",dr["Amount"].ToString());
                dic.Add("Currency",dr["Currency"].ToString());
                dic.Add("Supplier",dr["Supplier"].ToString());
                dic.Add("DisplayName",dr["DisplayName"].ToString());
                dic.Add("WorkItemId",workItemDic["workItemId"]);
                dic.Add("Status",st);
                dic.Add("BizObjectID",dr["BizObjectID"].ToString());
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                DHSeqBak = dr["DHSeq"].ToString();
                ls.Add(dic);
                i++;
            }
            for (var j = 1; j <= SeqCnt; j++)
            {
                ls[dt_dh.Rows.Count - j]["SeqCnt"] = SeqCnt.ToString();
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取变更记录
    public void getBGData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取合同变更记录
        System.Data.DataTable dt_bg = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT convert(varchar(20),convert(decimal(18,2),b.AmountRMBOld))+b.CurrencyRMBOld+' '+convert(varchar(20),convert(decimal(18,2),b.AmountWBOld))+b.CurrencyWBOld as AmountOld, " +
                "  convert(varchar(20),convert(decimal(18,2),ISNULL(b.AmountRMBNew,0)))+b.CurrencyRMBNew as AmountRMBNew, " +
                "  convert(varchar(20),convert(decimal(18,2),ISNULL(b.AmountWBNew,0)))+b.CurrencyWBNew as AmountWBNew, " +
                "  b.IsChangeAmountRMB," +
                "  b.IsChangeAmountWB, " +
                " b.DHDateOld,b.DHDateNew, " +
                " CONVERT(varchar, b.AgencyNumOld)+'('+AgencyTypeOld+')' AgencyOld,  " +
                " CONVERT(varchar, b.AgencyNumNew)+'('+( " +
                " select enum1.EnumValue from OT_EnumerableMetadata enum1 where b.AgencyTypeNew = enum1.Code and enum1.Category = '代理费费率／金额'  " +
                " )+')' AgencyNew, " +
                " b.PayConditionOld,b.PayConditionNew, " +
                " ic.State Status, " +
                " case ic.State   " +
                "	when '2' then   " +
                "		case b.RejectFlg  " +
                "			when '1' then '驳回'  " +
                "			else  " +
                "          case (select top 1 DisplayName from OT_WorkItem wi where wi.InstanceId = ic.ObjectID)  " +
                "					when '变更发起' then '草稿' " +
                "					when '航油部门审批' then '审批中' " +
                "					when '非航油部门审批' then '审批中' " +
                "					when '航油领导审批' then '审批中' " +
                "					when '非航油领导审批' then '审批中' " +
                "					when '确认' then '确认中' " +
                "				end " +
                "		end  " +
                "  when '4' then  " +
                "		'已变更'  " +
                " end DisplayName,  " +
                " b.CreatedTime, " +
                " ic.ObjectID IcObjectId, " +
                " b.ObjectID BizObjectId,  " +
                " b.RejectFlg  " +
                " FROM I_BG b, OT_InstanceContext ic  " +
                " where b.ObjectID = ic.BizObjectId  " +
                " and b.ContractNo = '" + ContractNo + "'  " +
                " order by b.CreatedTime   ");
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_bg.Rows.Count > 0)
        {
            var i = 0;
            foreach (DataRow dr in dt_bg.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                // 第一行
                string AmountNew = "";
                if(dr["IsChangeAmountRMB"].ToString().Equals("是"))
                {
                    AmountNew += dr["AmountRMBNew"].ToString();
                }
                if (dr["IsChangeAmountWB"].ToString().Equals("是"))
                {
                    AmountNew += dr["AmountWBNew"].ToString();
                }
                var st = dr["Status"].ToString();
                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, UserID);
                var Mode = workItemDic["Mode"];
                if (Mode.Equals("Work"))
                {
                    st += " ";
                }
                dic.Add("AmountOld",dr["AmountOld"].ToString());
                dic.Add("AmountNew",dr["AmountNew"].ToString());
                dic.Add("DHDateOld",dr["DHDateOld"].ToString());
                dic.Add("DHDateNew",dr["DHDateNew"].ToString());
                dic.Add("DisplayName",dr["DisplayName"].ToString());
                dic.Add("WorkItemId",workItemDic["workItemId"]);
                dic.Add("Status",st);
                dic.Add("BizObjectId",dr["BizObjectId"].ToString());
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取保函记录
    public void getBHData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

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
        //        "					when '录入' then '录入中'  " +
        //        "					when '发起退保' then '未退'  " +
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
        //List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //if (dt_bh.Rows.Count > 0)
        //{
        //    var i = 0;
        //    foreach (DataRow dr in dt_bh.Rows)
        //    {
        //        Dictionary<string, string> dic = new Dictionary<string, string>();
        //        // 第一行
        //        var st = dr["Status"].ToString();
        //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, UserID);
        //        var Mode = workItemDic["Mode"];
        //        if (Mode.Equals("Work"))
        //        {
        //            st += " ";
        //        }
        //        dic.Add("BHType",dr["BHTypeName"].ToString());
        //        dic.Add("BHProperty",dr["BHPropertyName"].ToString());
        //        dic.Add("BHAmount",dr["BHAmount"].ToString());
        //        dic.Add("ReceiveDate",dr["ReceiveDate"].ToString());
        //        dic.Add("ExpirationDate",dr["ExpirationDate"].ToString());
        //        dic.Add("TBStatus",dr["DisplayName"].ToString());
        //        dic.Add("WorkItemId",workItemDic["workItemId"]);
        //        dic.Add("Status",st);
        //        dic.Add("BizObjectId",dr["BizObjectId"].ToString());
        //        dic.Add("RejectFlg",dr["RejectFlg"].ToString());
        //        ls.Add(dic);
        //        i++;
        //    }
        //}
        // 获取保函数据
        string sql = " SELECT  " +
                        " e1.EnumValue BHTypeName,  " +
                        " e2.EnumValue BHPropertyName,  " +
                        " CONVERT(varchar, bi.BHAmount)+e3.EnumValue as BHAmount,  " +
                        " bi.ReceiveDate,  " +
                        " bi.ExpirationDate,  " +
                        " bi.CreatedTime," +
                        " b.TBType,  " +
                        " b.RejectFlg RejectFlg,   " +
                        " ic.State Status,   " +
                        " ic2.State Status2,   " +
                        " ic.ObjectID IcObjectId,   " +
                        " ic2.ObjectID IcObjectId2,  " +
                        " bi.ObjectID InputBizObjectId, " +
                        " b.ObjectID BizObjectId " +
                        " FROM I_BHInput bi  " +
                        " INNER JOIN OT_InstanceContext ic on bi.ObjectID = ic.BizObjectId and bi.ContractNo = '" + ContractNo + "'  " +
                        " LEFT JOIN I_BH b on bi.ObjectID = b.InputBizObjectID " +
                        " LEFT JOIN OT_InstanceContext ic2 on b.ObjectID = ic2.BizObjectId  " +
                        " LEFT JOIN OT_EnumerableMetadata e1 on bi.BHType = e1.Code and e1.Category = '保函类型'   " +
                        " LEFT JOIN OT_EnumerableMetadata e2 on bi.BHProperty = e2.Code and e2.Category = '保函性质'  " +
                        " LEFT JOIN OT_EnumerableMetadata e3 on bi.Currency = e3.Code and e3.Category = '币种'  " +
                        " order by bi.CreatedTime    ";

        System.Data.DataTable dt_bh = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql );
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_bh.Rows.Count > 0)
        {
            var i = 0;
            foreach (DataRow dr in dt_bh.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                // 第一行
                var st = dr["Status"].ToString();
                var st2 = dr["Status2"].ToString();
                var status = "";
                var TBStatus = "";
                Dictionary<string, string> workItemDic;
                if(st.Equals("2"))
                {
                    TBStatus = "未退";
                    workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), st, UserID);
                    dic.Add("InputWorkitemId",workItemDic["workItemId"]);
                    status = "20";
                } else if(st.Equals("4"))
                {
                    workItemDic = Common.getWorkItemIdNew(dr["IcObjectId2"].ToString(), st2, UserID);
                    dic.Add("WorkItemId",workItemDic["workItemId"]);
                    if (st2.Equals("2"))
                    {
                        status = "42";
                        if (dr["RejectFlg"].ToString().Equals("1"))
                        {
                            TBStatus = "驳回";
                        }
                        else
                        {
                            if (workItemDic["DisplayName"].Equals("财务审批") || workItemDic["DisplayName"].Equals("保函管理人审批"))
                            {
                                TBStatus = "确认中";
                            } else
                            {
                                TBStatus = "审批中";
                            }
                        }
                    } else if (st2.Equals("4"))
                    {
                        status = "44";
                        if(dr["TBType"].ToString().Equals("TB_TB"))
                        {
                            TBStatus = "已退";
                        } else
                        {
                            TBStatus = "没收";
                        }
                    } else
                    {
                        status = "40";
                        TBStatus = "未退";
                    }

                }

                dic.Add("BHType",dr["BHTypeName"].ToString());
                dic.Add("BHProperty",dr["BHPropertyName"].ToString());
                dic.Add("BHAmount",dr["BHAmount"].ToString());
                dic.Add("ReceiveDate",dr["ReceiveDate"].ToString());
                dic.Add("ExpirationDate",dr["ExpirationDate"].ToString());
                dic.Add("TBStatus",TBStatus);

                // 20:录保中、40:录保完成、42:退保发起、44:退保结束
                dic.Add("Status",status);
                dic.Add("InputBizObjectID",dr["InputBizObjectId"].ToString());
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取请款记录
    public void getQKData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];
        //// 获取请款记录
        //var qksql =
        //    "   SELECT max(qk.ObjectId) id,qk.QKSeq QKSeq,sum(tbl.Amount) Amount,sum(tbl.ConvertAmount) ConvertAmount,max(qk.QKTarget) QKTarget,tbl.Currency,max(tbl.ZJMS) ZJMS,MAX (ic.ObjectID) icObjectId,MAX (qk.RejectFlg) RejectFlg " +
        //    "   FROM I_QK qk " +
        //    "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID " +
        //    "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID " +
        //    "   and qk.ContractNo =  '" + ContractNo + "'" +
        //    "   group by qk.QKSeq,tbl.Currency";
        //var qksql2 = " select ic.state Status,t.icObjectId IcObjectId,t.RejectFlg,t.QKSeq,t.ZJMS,t.cnt SeqCnt," +
        //    " convert(varchar(20),convert(decimal(18,2),t.Amount))+e.EnumValue Amount,convert(varchar(20),convert(decimal(18,2),t.ConvertAmount))+'人民币' ConvertAmount,QKTarget " +
        //    " from(" +
        //    "  select t1.id,t1.QKSeq,t1.ZJMS,t1.Amount" +
        //    " ,( " +
        //    "  select sum(t2.ConvertAmount) from (" +
        //        qksql +
        //    "  ) t2 where t2.QKSeq = t1.QKSeq" +
        //    "  ) ConvertAmount" +
        //    " ,( " +
        //    "  select count(t2.QKSeq) from (" +
        //        qksql +
        //    "  ) t2 where t2.QKSeq = t1.QKSeq" +
        //    "  ) cnt" +
        //    " ,t1.Currency " +
        //    " ,t1.QKTarget" +
        //    " ,t1.icObjectId" +
        //    " ,t1.RejectFlg" +
        //    " from (" +
        //        qksql +
        //    "  ) t1" +
        //    " ) t LEFT JOIN OT_EnumerableMetadata e on t.Currency = e.Code and e.Category = '币种' " +
        //    " LEFT JOIN OT_InstanceContext ic on ic.BizObjectId = t.id " +
        //    " order by t.QKSeq";
        //System.Data.DataTable dt_qk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(qksql2);
        //List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //if (dt_qk.Rows.Count > 0)
        //{
        //    var i = 0;
        //    foreach (DataRow dr in dt_qk.Rows)
        //    {
        //        Dictionary<string, string> dic = new Dictionary<string, string>();
        //        // 第一行
        //        var ActivityCode = "";
        //        Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), UserID);
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

        //        dic.Add("QKSeq",dr["QKSeq"].ToString());
        //        dic.Add("ZJMS",dr["ZJMS"].ToString());
        //        dic.Add("QKAmount",dr["Amount"].ToString());
        //        dic.Add("QKTotalAmount",dr["ConvertAmount"].ToString().Replace("人民币","").Equals("0.00")?"": dr["ConvertAmount"].ToString());
        //        dic.Add("QKTarget",dr["QKTarget"].ToString());
        //        dic.Add("SeqCnt",dr["SeqCnt"].ToString());
        //        dic.Add("WorkItemId",workItemDic["workItemId"]);
        //        dic.Add("Status",st);
        //        dic.Add("RejectFlg",dr["RejectFlg"].ToString());
        //        ls.Add(dic);
        //        i++;
        //    }
        //}
        var ContractProperty = "";
        System.Data.DataTable dt_hy = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select top 1 ContractProperty from I_ContractMain where ContractNo = '"+ContractNo+"'");
        if (dt_hy.Rows.Count > 0)
        {
            ContractProperty = dt_hy.Rows[0]["ContractProperty"].ToString();
        }
        // 获取请款记录
        var qksql = "";
        //航油请款的折算金额不按币种分开，非航油的折算金额按币种分开
        //if(ContractProperty != "ContractProperty_HKMY")
        //{
        qksql =
        "   SELECT qk.ObjectId QKObjectID,qk.QKSeq QKSeq,e2.EnumValue QKType,tbl.Amount Amount,tbl.ConvertAmount ConvertAmount, "+
        "   qk.QKTarget QKTarget,tbl.Currency QKCurrency,e.EnumValue QKCurrencyName,tbl.ZJMS ZJMS,ic.ObjectID IcObjectId,ic.state Status,qk.RejectFlg RejectFlg  "+
        "   FROM I_QK qk  "+
        "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID  "+
        "   and qk.ContractNo =  '"+ContractNo+"' "+
        "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID  "+
        "   LEFT JOIN OT_EnumerableMetadata e on tbl.Currency = e.Code and e.Category = '币种' " +
        "   LEFT JOIN OT_EnumerableMetadata e2 on tbl.QKType = e2.Code and e2.Category = '请款类型' "+
        "   order by qk.QKSeq,e2.SortKey,tbl.Currency,tbl.ParentIndex ";
        //} else
        //    {
        //        qksql =
        //        "   SELECT qk.ObjectId QKObjectID,qk.QKSeq QKSeq,tbl.Amount Amount,tbl.ConvertAmount ConvertAmount, "+
        //        "   qk.QKTarget QKTarget,tbl.ZJMS ZJMS,ic.ObjectID IcObjectId,ic.state Status,qk.RejectFlg RejectFlg " +
        //        "   ,'QKType' QKType,'QKCurrency' QKCurrency,e.EnumValue QKCurrencyName"+
        //        "   FROM I_QK qk  "+
        //        "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID  "+
        //        "   and qk.ContractNo =  '"+ContractNo+"' "+
        //        "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID  "+
        //        "   LEFT JOIN OT_EnumerableMetadata e on tbl.Currency = e.Code and e.Category = '币种' " +
        //        "   order by qk.QKSeq,tbl.ParentIndex ";
        //    }


        System.Data.DataTable dt_qk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(qksql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_qk.Rows.Count > 0)
        {
            var i = 0;
            var QKSeq = "";
            var QKType = "";
            var QKCurrency = "";
            var QKTotalAmount = 0.0;
            var QKObjectID = "";
            int QKCnt = 0;
            int QKCurrencyCnt = 0;
            foreach (DataRow dr in dt_qk.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                if(ContractProperty != "ContractProperty_HKMY")
                {
                    if (!(QKSeq + QKType + QKCurrency).Equals(dr["QKSeq"].ToString() + dr["QKType"].ToString() + dr["QKCurrency"].ToString()))
                    {
                        // 设置请款单币种数量
                        setDic(ls,"QKCurrencyCnt",QKCurrencyCnt.ToString(),QKSeq,QKType,QKCurrency);
                        QKCurrencyCnt = 0;
                        // 设置请款折算金额合计
                        setDic(ls,"QKTotalAmount",QKTotalAmount.ToString(),QKSeq,QKType,QKCurrency);
                        QKTotalAmount = 0.0;
                    }
                    if (QKObjectID!="" && !(QKObjectID).Equals(dr["QKObjectID"].ToString()))
                    {
                        // 设置请款批次数量
                        setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
                        QKCnt = 0;
                    }
                } else
                {
                    if (QKObjectID!="" && !(QKObjectID).Equals(dr["QKObjectID"].ToString()))
                    {
                        // 设置请款批次数量
                        setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
                        QKCnt = 0;
                        // 设置请款单币种数量
                        setDic(ls,"QKCurrencyCnt3",QKCurrencyCnt.ToString(),QKObjectID,"","");
                        QKCurrencyCnt = 0;
                        // 设置请款折算金额合计
                        setDic(ls,"QKTotalAmount3",QKTotalAmount.ToString(),QKObjectID,"","");
                        QKTotalAmount = 0.0;
                    }
                }

                QKCurrencyCnt++;
                QKCnt++;
                QKObjectID = dr["QKObjectID"].ToString();
                QKSeq = dr["QKSeq"].ToString();
                QKType = dr["QKType"].ToString();
                QKCurrency = dr["QKCurrency"].ToString();
                QKTotalAmount += Convert.ToDouble(dr["ConvertAmount"].ToString()==""?"0":dr["ConvertAmount"].ToString());
                // 第一行
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), UserID);
                ActivityCode = workItemDic["ActivityCode"];
                var Mode = workItemDic["Mode"];
                string st = "";
                if (dr["Status"].ToString().Equals("4"))
                {
                    st = "审批完成";
                }
                else if (dr["Status"].ToString().Equals("2"))
                {
                    if (dr["RejectFlg"].ToString().Equals("1"))
                    {
                        st = "驳回";
                    }
                    else
                    {
                        if(ActivityCode.Equals("ActivityOrig"))
                        {
                            st = "草稿";
                        } else
                        {
                            st = "申请中";
                        }
                    }
                }
                if(Mode.Equals("Work"))
                {
                    st += " ";
                }
                dic.Add("QKObjectID",QKObjectID);
                dic.Add("QKSeq",QKSeq);
                dic.Add("ZJMS",dr["ZJMS"].ToString());
                dic.Add("QKAmount",dr["Amount"].ToString()+dr["QKCurrencyName"].ToString());
                //dic.Add("QKTotalAmount",SumConvertAmount.ToString()+"人民币");
                dic.Add("QKTarget",dr["QKTarget"].ToString());
                //dic.Add("SeqCnt",QKCnt.ToString());
                dic.Add("QKCurrencyCnt",QKCurrencyCnt.ToString());
                dic.Add("QKCurrency",QKCurrency);
                dic.Add("QKType",QKType);
                dic.Add("WorkItemId",workItemDic["workItemId"]);
                dic.Add("Status",st);
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                ls.Add(dic);
                i++;
            }
            if (ContractProperty != "ContractProperty_HKMY")
            {
                setDic(ls,"QKCurrencyCnt",QKCurrencyCnt.ToString(),QKSeq,QKType,QKCurrency);
                setDic(ls,"QKTotalAmount",QKTotalAmount.ToString(),QKSeq,QKType,QKCurrency);
            } else
            {
                setDic(ls,"QKCurrencyCnt3",QKCurrencyCnt.ToString(),QKObjectID,"","");
                setDic(ls,"QKTotalAmount3",QKTotalAmount.ToString(),QKObjectID,"","");
            }
            setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取到款状态记录
    public void getDKStatusData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];
        string QKSubObjectIDs = context.Request["QKSubObjectIDs"];
        string QKSubsSQL = getQKSubsSQL(QKSubObjectIDs);
        ContractMain con = Common.getContractByBizId(ContractNo);
        // 获取到款状态
        var dkst_sql = " select d.ContractNo,dk.QKSeqHidden,dk.QKType,dk.QKCurrency, " +
            " Min(ic.State) Status" +
            " from I_DK d" +
            " INNER JOIN I_DKTbl dk on dk.ParentObjectID = d.ObjectID " +
            " INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectId" +
            " and d.ContractNo = '" + ContractNo + "' and dk.CurDKAmount > 0 " +
            " group by d.ContractNo,dk.QKSeqHidden,dk.QKType,dk.QKCurrency";
        System.Data.DataTable dt_dkst2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dkst_sql);
        Dictionary<string, string> dkst_dic = new Dictionary<string, string>();
        if (dt_dkst2.Rows.Count > 0)
        {
            var i = 0;
            foreach (DataRow dr in dt_dkst2.Rows)
            {
                dkst_dic.Add(dr["QKSeqHidden"].ToString()+dr["QKType"].ToString()+dr["QKCurrency"].ToString(), dr["Status"].ToString());
                i++;
            }
        }
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
        //                " order BY t1.QKSeq,t1.ParentIndex " ;
        //System.Data.DataTable dt_dk2 = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dkst_sql2);
        //List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //if (dt_dk2.Rows.Count > 0)
        //{
        //    var i = 0;
        //    foreach (DataRow dr in dt_dk2.Rows)
        //    {
        //        Dictionary<string, string> dic = new Dictionary<string, string>();
        //        var LJDKTotalAmount = "";
        //        if (dr["LJDKAmount"].ToString() != "" && Convert.ToDouble(dr["LJDKAmount"].ToString()) != 0) {
        //            LJDKTotalAmount += dr["LJDKAmount"].ToString() + "人民币 " ;
        //        }
        //        if (dr["LJDKAmountWB"].ToString() != "" && Convert.ToDouble(dr["LJDKAmountWB"].ToString()) != 0)
        //        {
        //            LJDKTotalAmount += dr["LJDKAmountWB"].ToString() + Common.getDicValue("币种", con.Currency);
        //        }
        //        var st = dr["Status"].ToString()==""?"未到款": dr["Status"].ToString();
        //        st += Common.getStatus(dkst_dic, dr["QKSeq"].ToString());

        //        dic.Add("QKSeq",dr["QKSeq"].ToString());
        //        dic.Add("SeqCnt",dr["SeqCnt"].ToString());
        //        dic.Add("ZJKX",dr["ZJKX"].ToString());
        //        dic.Add("ZJMS",dr["ZJMS"].ToString());
        //        dic.Add("QKAmount",dr["QKAmount"].ToString());
        //        dic.Add("QKCurrency",dr["QKCurrency"].ToString());
        //        dic.Add("QKConvertAmount",dr["QKConvertAmount"].ToString().Replace("人民币", "").Equals("0.00") ? "" : dr["QKConvertAmount"].ToString());
        //        dic.Add("QKTarget",dr["QKTarget"].ToString());
        //        dic.Add("LJDKTotalAmount",LJDKTotalAmount);
        //        dic.Add("DisplayName",st);
        //        ls.Add(dic);
        //        i++;
        //    }
        //}
        var ContractProperty = "";
        System.Data.DataTable dt_hy = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select top 1 ContractProperty from I_ContractMain where ContractNo = '"+ContractNo+"'");
        if (dt_hy.Rows.Count > 0)
        {
            ContractProperty = dt_hy.Rows[0]["ContractProperty"].ToString();
        }
        // 获取请款记录
        var qksql = "";
        //航油请款的折算金额不按币种分开，非航油的折算金额按币种分开
        //if (ContractProperty != "ContractProperty_HKMY")
        //{
        qksql =
        "   SELECT qk.ObjectId QKObjectID,qk.QKSeq QKSeq,e3.EnumValue QKType,e2.EnumValue ZJKX,tbl.ZJMS,tbl.Amount Amount,tbl.ConvertAmount ConvertAmount, "+
        "   qk.QKTarget QKTarget,tbl.Currency QKCurrency,e1.EnumValue QKCurrencyName,tbl.ZJMS ZJMS,ic.ObjectID IcObjectId," +
        "   tbl.LJDKAmount LJDKAmount,tbl.LJDKAmountWB LJDKAmountWB,tbl.DKStatus DKStatus  "+
        "   FROM I_QK qk  "+
        "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID  "+
        "   and qk.ContractNo =  '"+ContractNo+"' "+ QKSubsSQL +
        "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4'  "+
        "   LEFT JOIN OT_EnumerableMetadata e1 on tbl.Currency = e1.Code and e1.Category = '币种' " +
        "   LEFT JOIN OT_EnumerableMetadata e2 ON tbl.ZJKX = e2.Code AND e2.Category = '资金款项' " +
        "   LEFT JOIN OT_EnumerableMetadata e3 on tbl.QKType = e3.Code and e3.Category = '请款类型' "+
        "   order by qk.QKSeq,e3.SortKey,tbl.Currency,tbl.ParentIndex ";
        //} else
        //{
        //    qksql =
        //    "   SELECT qk.ObjectId QKObjectID,qk.QKSeq QKSeq,e2.EnumValue ZJKX,tbl.ZJMS,tbl.Amount Amount,tbl.ConvertAmount ConvertAmount, "+
        //    "   qk.QKTarget QKTarget,tbl.ZJMS ZJMS,ic.ObjectID IcObjectId," +
        //    "   tbl.LJDKAmount LJDKAmount,tbl.LJDKAmountWB LJDKAmountWB,tbl.DKStatus DKStatus " +
        //    "   ,'QKType' QKType,'QKCurrency' QKCurrency,e1.EnumValue QKCurrencyName "+
        //    "   FROM I_QK qk  "+
        //    "   INNER JOIN I_QKSubTbl tbl ON qk.ObjectID = tbl.ParentObjectID  "+
        //    "   and qk.ContractNo =  '"+ContractNo+"' "+ QKSubsSQL +
        //    "   INNER JOIN OT_InstanceContext ic ON qk.ObjectId = ic.BizObjectID and ic.State = '4'  "+
        //    "   LEFT JOIN OT_EnumerableMetadata e1 on tbl.Currency = e1.Code and e1.Category = '币种' " +
        //    "   LEFT JOIN OT_EnumerableMetadata e2 ON tbl.ZJKX = e2.Code AND e2.Category = '资金款项' " +
        //    "   order by qk.QKSeq,tbl.ParentIndex ";
        //}


        System.Data.DataTable dt_qk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(qksql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_qk.Rows.Count > 0)
        {
            var i = 0;
            var QKSeq = "";
            var QKType = "";
            var QKCurrency = "";
            var QKConvertAmount = 0.0;
            var QKObjectID = "";
            int QKCnt = 0;
            int QKCurrencyCnt = 0;
            foreach (DataRow dr in dt_qk.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                if (ContractProperty != "ContractProperty_HKMY")
                {
                    if (!(QKSeq + QKType + QKCurrency).Equals(dr["QKSeq"].ToString() + dr["QKType"].ToString() + dr["QKCurrency"].ToString()))
                    {
                        // 设置请款单币种数量
                        setDic(ls,"QKCurrencyCnt",QKCurrencyCnt.ToString(),QKSeq,QKType,QKCurrency);
                        QKCurrencyCnt = 0;
                        // 设置请款折算金额合计
                        setDic(ls,"QKConvertAmount",QKConvertAmount.ToString(),QKSeq,QKType,QKCurrency);
                        QKConvertAmount = 0.0;
                    }
                    if (QKObjectID!="" && !(QKObjectID).Equals(dr["QKObjectID"].ToString()))
                    {
                        // 设置请款批次数量
                        setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
                        QKCnt = 0;
                    }
                } else
                {
                    if (QKObjectID!="" && !(QKObjectID).Equals(dr["QKObjectID"].ToString()))
                    {
                        // 设置请款批次数量
                        setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
                        QKCnt = 0;
                        // 设置请款单币种数量
                        setDic(ls,"QKCurrencyCnt3",QKCurrencyCnt.ToString(),QKObjectID,"","");
                        QKCurrencyCnt = 0;
                        // 设置请款折算金额合计
                        setDic(ls,"QKConvertAmount3",QKConvertAmount.ToString(),QKObjectID,"","");
                        QKConvertAmount = 0.0;
                    }
                }

                QKCurrencyCnt++;
                QKCnt++;
                QKObjectID = dr["QKObjectID"].ToString();
                QKSeq = dr["QKSeq"].ToString();
                QKType = dr["QKType"].ToString();
                QKCurrency = dr["QKCurrency"].ToString();
                QKConvertAmount += Convert.ToDouble(dr["ConvertAmount"].ToString()==""?"0":dr["ConvertAmount"].ToString());
                // 设置累计到款
                var LJDKTotalAmount = "";
                if (dr["LJDKAmount"].ToString() != "" && Convert.ToDouble(dr["LJDKAmount"].ToString()) != 0)
                {
                    LJDKTotalAmount += dr["LJDKAmount"].ToString() + "人民币 ";
                }
                if (dr["LJDKAmountWB"].ToString() != "" && Convert.ToDouble(dr["LJDKAmountWB"].ToString()) != 0)
                {
                    LJDKTotalAmount += dr["LJDKAmountWB"].ToString() + Common.getDicValue("币种", con.Currency);
                }
                dic.Add("LJDKTotalAmount",LJDKTotalAmount);
                dic.Add("QKObjectID",QKObjectID);
                dic.Add("QKSeq",QKSeq);
                dic.Add("ZJKX",dr["ZJKX"].ToString());
                dic.Add("ZJMS",dr["ZJMS"].ToString());
                dic.Add("QKAmount",dr["Amount"].ToString()+dr["QKCurrencyName"].ToString());
                dic.Add("QKTarget",dr["QKTarget"].ToString());
                dic.Add("QKCurrencyCnt",QKCurrencyCnt.ToString());
                dic.Add("QKCurrency",QKCurrency);
                dic.Add("QKType",QKType);
                var st = dr["DKStatus"].ToString() == "" ? "未到款" : dr["DKStatus"].ToString();
                st += Common.getStatus(dkst_dic, dr["QKSeq"].ToString()+dr["QKType"].ToString()+dr["QKCurrency"].ToString());
                dic.Add("DisplayName",st);
                ls.Add(dic);
                i++;
            }
            if (ContractProperty != "ContractProperty_HKMY")
            {
                setDic(ls,"QKCurrencyCnt",QKCurrencyCnt.ToString(),QKSeq,QKType,QKCurrency);
                setDic(ls,"QKConvertAmount",QKConvertAmount.ToString(),QKSeq,QKType,QKCurrency);
            } else
            {
                setDic(ls,"QKCurrencyCnt3",QKCurrencyCnt.ToString(),QKObjectID,"","");
                setDic(ls,"QKConvertAmount3",QKConvertAmount.ToString(),QKObjectID,"","");
            }
            setDic(ls,"SeqCnt",QKCnt.ToString(),QKObjectID,"","");
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }
    // 获取请款子表拼接的SQL
    public string  getQKSubsSQL(string QKSubObjectIDs)
    {
        string ret = "";
        if(QKSubObjectIDs==null){
            return ret;
        } else {
            string [] QKSubs = QKSubObjectIDs.Split(',');
            foreach (string item in QKSubs)
            {
                if(item!="")
                {
                    ret += "or tbl.ObjectID = '"+item+"' ";
                }
            }
            return ret!=""?"and ( "+ret.Substring(2)+" )":"";
        }

    }
    // 获取到款记录
    public void getDKData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取到款记录
        var dksql = " select (select top 1 dk.QKTargetCode from I_DKTbl dk where d.ObjectID = dk.ParentObjectID) QKTarget,  " +
            " CONVERT(varchar(12),d.DKDate,111) DKDate," +
            " convert(varchar(20),convert(decimal(18,2),d.DKAmount))+e1.EnumValue DKTotalAmount," +
            " d.RejectFlg," +
            " ic.ObjectID IcObjectID, " +
            " ic.State Status" +
            //" case ic.State " +
            //"	when '2' THEN" +
            //"		case d.RejectFlg " +
            //"			when '1' then '驳回'" +
            //"			else '确认中'" +
            //"		END" +
            //"	when '4' then '已确认'" +
            //" end DisplayName" +
            " from I_DK d" +
            " INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectId" +
            " INNER JOIN OT_EnumerableMetadata e1 ON d.DKCurrency = e1.Code AND e1.Category = '币种'" +
            " and d.ContractNo = '" + ContractNo + "'  " +
            " order by d.ModifiedTime ";
        System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dksql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_dk.Rows.Count > 0)
        {
            var i = 0;
            foreach (DataRow dr in dt_dk.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                // 第一行
                dic.Add("QKTarget",dr["QKTarget"].ToString());
                if(dr["Status"].ToString().Equals("4"))
                {
                    dic.Add("DKDate",dr["DKDate"].ToString());
                }

                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), UserID);
                var st = dr["Status"].ToString();
                if (workItemDic["Mode"].Equals("Work"))
                {
                    st += " ";
                }
                var DisplayName = "";
                if(dr["RejectFlg"].ToString().Equals("1"))
                {
                    DisplayName = "驳回";
                } else
                {
                    if (dr["Status"].ToString().Equals("4"))
                    {
                        DisplayName = "审批完成";
                    }
                    else if (dr["Status"].ToString().Equals("2"))
                    {
                        DisplayName = workItemDic["DisplayName"].ToString();
                    }
                }
                dic.Add("DKTotalAmount",dr["DKTotalAmount"].ToString());
                dic.Add("DisplayName",DisplayName);
                dic.Add("WorkItemId",workItemDic["workItemId"].ToString());
                dic.Add("Status",st);
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取付款记录
    public void getFKData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取付款记录
        var fksql =
            " select t1.ObjectID,t1.ZKMS,convert(varchar(20),convert(decimal(18,2),t1.Amount)) as Amount,convert(varchar(20),convert(decimal(18,2),t1.OutTaxAmount)) as OutTaxAmount," +
            "t1.Currency,e1.EnumValue CurrencyName, " +
            " CONVERT(varchar(12),t1.FKDate,111) FKDate,t1.ConvertAmount, " +
            " convert(varchar(20),convert(decimal(18,2),t2.AmountSum))+e1.EnumValue as AmountSum,t2.Cnt, t1.Content,ISNULL(e2.EnumValue, '信用证') PayType," +
            " t1.Receiver,t1.OtherReceiver,t1.State Status,t1.IcObjectID,t1.RejectFlg,t1.ZFOperate " +
            " from  " +
            " ( " +
            " 	SELECT f.ObjectID,ft.ZKMS,ft.Amount,ft.OutTaxAmount,f.Currency,f.FKDate,f.ConvertAmount,f.ModifiedTime ,ft.ParentIndex,f.Content,f.PayType,f.Receiver,f.OtherReceiver, " +
            " 	ic.State,ic.ObjectID IcObjectID,f.RejectFlg ,f.ZFOperate" +
            " 	FROM I_FK f " +
            " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID " +
            " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID " +
            " 	and f.ContractNo = '" + ContractNo + "' and (f.ZFOperate = '' or f.ZFOperate = 'ZFOperate_ZF')" +
            " ) t1 INNER JOIN  " +
            " ( " +
            " 	SELECT f.ObjectID,sum(ft.Amount) AmountSum,count(ft.ObjectID) Cnt " +
            " 	FROM I_FK f " +
            " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID " +
            " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID " +
            " 	and f.ContractNo = '" + ContractNo + "' and (f.ZFOperate = '' or f.ZFOperate = 'ZFOperate_ZF')" +
            " 	GROUP BY f.ObjectID " +
            " ) t2 on t1.ObjectID = t2.ObjectID " +
            " LEFT JOIN OT_EnumerableMetadata e1 on t1.Currency = e1.Code and e1.Category = '币种' " +
            " LEFT JOIN OT_EnumerableMetadata e2 on t1.PayType = e2.Code and e2.Category = '支付方式' " +
            " order by ModifiedTime ,ObjectID,ParentIndex ";
        System.Data.DataTable dt_fk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(fksql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_fk.Rows.Count > 0)
        {
            var i = 0;
            var TheNo = 0;
            var ObjectIDBak = "";
            foreach (DataRow dr in dt_fk.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                // 第一行
                if (!ObjectIDBak.Equals(dr["ObjectID"].ToString()))
                {
                    TheNo++;
                }
                ObjectIDBak = dr["ObjectID"].ToString();
                string Amount = "";
                if (dr["OutTaxAmount"].ToString().Equals("0.00"))
                {
                    Amount = dr["Amount"].ToString() + dr["CurrencyName"].ToString();
                } else
                {
                    Amount = dr["Amount"].ToString() + dr["CurrencyName"].ToString() + " \n代扣外税：" + dr["OutTaxAmount"].ToString() + dr["CurrencyName"].ToString();
                }
                // 如果是人民币，直接拿人民币合计作为折算金额
                if(dr["Currency"].ToString().Equals("RMB"))
                {
                    dic.Add("ConvertAmount",dr["AmountSum"].ToString());
                } else
                {
                    // 如果有折算金额，则取之，不然就是没有折算金额
                    var ConvertAmount = Convert.ToDouble(dr["ConvertAmount"]);
                    if(ConvertAmount > 0)
                    {
                        dic.Add("ConvertAmount",dr["ConvertAmount"].ToString()+"人民币");
                    }

                }
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), UserID);
                ActivityCode = workItemDic["ActivityCode"];
                var Mode = workItemDic["Mode"];
                string st = "";
                if (dr["Status"].ToString().Equals("4"))
                {
                    st = "已付";
                    dic.Add("FKDate",dr["FKDate"].ToString());
                }
                else if (dr["Status"].ToString().Equals("2"))
                {
                    if (dr["RejectFlg"].ToString().Equals("1"))
                    {
                        st = "驳回";
                    }
                    else
                    {
                        if (ActivityCode.Equals("ActivityOrig"))
                        {
                            st = "草稿";
                        }
                        else if (ActivityCode.Equals("ActivityConfirm"))
                        {
                            st = "确认中";
                        }
                        else
                        {
                            st = "申请中";
                        }

                    }
                }
                if (Mode.Equals("Work"))
                {
                    st += " ";
                }
                dic.Add("TheNo",TheNo.ToString());
                dic.Add("ZKMS",dr["ZKMS"].ToString());
                dic.Add("Amount",Amount);
                dic.Add("Content",dr["Content"].ToString());
                dic.Add("PayType",dr["PayType"].ToString());
                dic.Add("Receiver",dr["Receiver"].ToString().Equals("其他")? dr["OtherReceiver"].ToString(): dr["Receiver"].ToString());
                dic.Add("Cnt",dr["Cnt"].ToString());
                dic.Add("WorkItemId",workItemDic["workItemId"]);
                dic.Add("DisplayName",st);
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取付款拒付记录
    public void getFKJFData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取拒付付款记录
        var fk_jfsql =
            " select t1.ObjectID,t1.ZKMS,convert(varchar(20),convert(decimal(18,2),t1.Amount))+e1.EnumValue as Amount,t1.Currency,e1.EnumValue CurrencyName, " +
            " CONVERT(varchar(12),t1.FKDate,111) FKDate,t1.ConvertAmount, " +
            " cast(t2.AmountSum as varchar)+e1.EnumValue as AmountSum,t2.Cnt, t1.Content,ISNULL(e2.EnumValue, '信用证') PayType," +
            " t1.Receiver,t1.OtherReceiver,t1.State Status,t1.IcObjectID,t1.RejectFlg,t1.ZFOperate " +
            " from  " +
            " ( " +
            " 	SELECT f.ObjectID,ft.ZKMS,ft.Amount,f.Currency,f.FKDate,f.ConvertAmount,f.ModifiedTime ,ft.ParentIndex,f.Content,f.PayType,f.Receiver,f.OtherReceiver, " +
            " 	ic.State,ic.ObjectID IcObjectID,f.RejectFlg ,f.ZFOperate" +
            " 	FROM I_FK f " +
            " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID " +
            " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID " +
            " 	and f.ContractNo = '" + ContractNo + "' and (f.ZFOperate = 'ZFOperate_JF')" +
            " ) t1 INNER JOIN  " +
            " ( " +
            " 	SELECT f.ObjectID,sum(ft.Amount) AmountSum,count(ft.ObjectID) Cnt " +
            " 	FROM I_FK f " +
            " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID " +
            " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID " +
            " 	and f.ContractNo = '" + ContractNo + "' and ( f.ZFOperate = 'ZFOperate_JF')" +
            " 	GROUP BY f.ObjectID " +
            " ) t2 on t1.ObjectID = t2.ObjectID " +
            " LEFT JOIN OT_EnumerableMetadata e1 on t1.Currency = e1.Code and e1.Category = '币种' " +
            " LEFT JOIN OT_EnumerableMetadata e2 on t1.PayType = e2.Code and e2.Category = '支付方式' " +
            " order by ModifiedTime ,ObjectID,ParentIndex ";
        System.Data.DataTable dt_fk_jf = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(fk_jfsql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_fk_jf.Rows.Count > 0)
        {
            var i = 0;
            var TheNo = 0;
            var ObjectIDBak = "";
            foreach (DataRow dr in dt_fk_jf.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                // 第一行
                if (!ObjectIDBak.Equals(dr["ObjectID"].ToString()))
                {
                    TheNo++;
                }
                ObjectIDBak = dr["ObjectID"].ToString();
                // 如果是人民币，直接拿人民币合计作为折算金额
                if (dr["Currency"].ToString().Equals("RMB"))
                {
                    dic.Add("ConvertAmount",dr["AmountSum"].ToString());
                }
                else
                {
                    // 如果有折算金额，则取之，不然就是没有折算金额
                    var ConvertAmount = Convert.ToDouble(dr["ConvertAmount"]);
                    if (ConvertAmount > 0)
                    {
                        dic.Add("ConvertAmount",dr["ConvertAmount"].ToString() + "人民币");
                    }

                }

                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), UserID);
                ActivityCode = workItemDic["ActivityCode"];
                var Mode = workItemDic["Mode"];
                string st = "";
                if (dr["Status"].ToString().Equals("4"))
                {
                    st = "已拒付";
                }
                else if (dr["Status"].ToString().Equals("2"))
                {
                    if (dr["RejectFlg"].ToString().Equals("1"))
                    {
                        st = "驳回";
                    }
                    else
                    {
                        if (ActivityCode.Equals("ActivityOrig"))
                        {
                            st = "草稿";
                        }
                        else
                        {
                            st = "申请中";
                        }

                    }
                }
                if (Mode.Equals("Work"))
                {
                    st += " ";
                }

                dic.Add("TheNo",TheNo.ToString());
                dic.Add("ZKMS",dr["ZKMS"].ToString());
                dic.Add("Amount",dr["Amount"].ToString());
                dic.Add("Content",dr["Content"].ToString());
                dic.Add("PayType",dr["PayType"].ToString());
                dic.Add("Receiver",dr["Receiver"].ToString().Equals("其他")? dr["OtherReceiver"].ToString(): dr["Receiver"].ToString());
                dic.Add("Cnt",dr["Cnt"].ToString());
                dic.Add("WorkItemId",workItemDic["workItemId"]);
                dic.Add("DisplayName",st);
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取到款结算状态记录
    public void getDKRecordTblOfJSData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];


        var ContractProperty = "";
        System.Data.DataTable dt_hy = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
            " select top 1 ContractProperty from I_ContractMain where ContractNo = '"+ContractNo+"'");
        if (dt_hy.Rows.Count > 0)
        {
            ContractProperty = dt_hy.Rows[0]["ContractProperty"].ToString();
        }
        Dictionary<string, string> dic_dkj_ok = new Dictionary<string, string>();
        if(ContractProperty != "航空煤油")
        {
            // 获取结算中的到款记录
            // 获取已经进行过结算处理的数据
            var jdksql_ok = " select dj.DKObjectID,dj.QKObjectID,dj.QKType,dj.QKCurrencyName,Max(ic.State) Status  " +
                        " from I_JS j  " +
                        " INNER JOIN I_DKTblOfJS dj on dj.ParentObjectID = j.ObjectID  " +
                        " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId " +
                        " and j.ContractNo = '" + ContractNo + "'  and dj.IsCheck = '是;'" +
                        " group by dj.DKObjectID,dj.QKObjectID,dj.QKType,dj.QKCurrencyName ";
            System.Data.DataTable dt_dkj_ok = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jdksql_ok);

            if (dt_dkj_ok.Rows.Count > 0)
            {
                foreach (DataRow dr in dt_dkj_ok.Rows)
                {
                    dic_dkj_ok.Add(dr["DKObjectID"].ToString()+dr["QKObjectID"].ToString()+dr["QKType"].ToString()+dr["QKCurrencyName"].ToString(), dr["Status"].ToString());
                }
            }
        } else
        {
            // 获取结算中的到款记录
            // 获取已经进行过结算处理的数据
            var jdksql_ok = " select dj.DKObjectID,dj.QKObjectID,Max(ic.State) Status  " +
                        " from I_JS j  " +
                        " INNER JOIN I_DKTblOfJS dj on dj.ParentObjectID = j.ObjectID  " +
                        " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId " +
                        " and j.ContractNo = '" + ContractNo + "'  and dj.IsCheck = '是;'" +
                        " group by dj.DKObjectID,dj.QKObjectID ";
            System.Data.DataTable dt_dkj_ok = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jdksql_ok);

            if (dt_dkj_ok.Rows.Count > 0)
            {
                foreach (DataRow dr in dt_dkj_ok.Rows)
                {
                    dic_dkj_ok.Add(dr["DKObjectID"].ToString()+dr["QKObjectID"].ToString(), dr["Status"].ToString());
                }
            }
        }

        // 获取到款记录
        var dksql = "";
        //航油请款的折算金额不按币种分开，非航油的折算金额按币种分开
        dksql =
        " select d.ObjectID DKObjectID, "+
        " dt.QKObjectID, " +
        " dt.QKSeqHidden QKSeq, "+
        " dt.QKTarget, "+
        " dt.QKType, "+
        " dt.ZJKX, "+
        " dt.ZJMS, "+
        " dt.QKAmount, "+
        " dt.QKCurrencyName, "+
        " dt.QKConvertAmount, "+
        " dt.DKType, "+
        " dt.CurDKAmount, "+
        " dt.CurDKAmountHidden, " +
        " CONVERT(varchar(12),d.DKDate,111) DKDate," +
        " dt.QKCurrencyCnt, " +
        " dt.SeqCnt, "+
        " e1.EnumValue CurDKCurrency," +
        " ic.ObjectID IcObjectId ,ic.State Status "+
        " from I_DK d "+
        " INNER JOIN I_DKTbl dt on d.ObjectID = dt.ParentObjectID and d.ContractNo = '"+ContractNo+"' and dt.CurDKAmountHidden > 0 "+
        " INNER JOIN OT_InstanceContext ic ON d.ObjectId = ic.BizObjectID and ic.State = '4'  "+
        " Left JOIN OT_EnumerableMetadata e1 ON dt.CurDKCurrency = e1.Code AND e1.Category = '币种' "+
        " order by d.DKDate,d.ObjectID,dt.ParentIndex ";
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
        System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dksql);
        //List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        //if (dt_jdk.Rows.Count > 0)
        //{
        //    var i = 0;
        //    foreach (DataRow dr in dt_jdk.Rows)
        //    {
        //        Dictionary<string, string> dic = new Dictionary<string, string>();
        //        // 第一行
        //        // 根据到款ID获取对应的到款结算状态
        //        if (dr["DKType"].ToString().Equals("结算到款"))
        //        {
        //            dic.Add("Status","不必结算");
        //        }
        //        else
        //        {
        //            dic.Add("Status",Common.getStatusOfDKJ(dic_dkj_ok, dr["ObjectID"].ToString()));
        //        }
        //        dic.Add("QKTarget",dr["QKTarget"].ToString());
        //        dic.Add("DKType",dr["DKType"].ToString());
        //        dic.Add("DKDate",dr["DKDate"].ToString());
        //        dic.Add("DKTotalAmount",dr["DKTotalAmount"].ToString());
        //        ls.Add(dic);
        //        i++;
        //    }
        //}
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_dk.Rows.Count > 0)
        {
            var i = 0;
            var DKObjectID = "";
            var QKObjectID = "";
            var QKCnt = 0;
            foreach (DataRow dr in dt_dk.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                if (DKObjectID!="" && QKObjectID!="" && !(DKObjectID + QKObjectID).Equals(dr["DKObjectID"].ToString() + dr["QKObjectID"].ToString()))
                {
                    // 设置请款批次数量
                    setDic(ls,"SeqCnt2",QKCnt.ToString(),DKObjectID,QKObjectID,"");
                    QKCnt = 0;
                }
                QKCnt++;
                DKObjectID = dr["DKObjectID"].ToString();
                QKObjectID = dr["QKObjectID"].ToString();
                dic.Add("DKObjectID",DKObjectID);
                dic.Add("QKObjectID",QKObjectID);
                dic.Add("QKSeq",dr["QKSeq"].ToString());
                dic.Add("QKTarget",dr["QKTarget"].ToString());
                dic.Add("QKType",dr["QKType"].ToString());
                dic.Add("ZJKX",dr["ZJKX"].ToString());
                dic.Add("ZJMS",dr["ZJMS"].ToString());
                dic.Add("QKAmount",dr["QKAmount"].ToString());
                dic.Add("QKCurrencyName", dr["QKCurrencyName"].ToString());
                dic.Add("QKConvertAmount", dr["QKConvertAmount"].ToString());
                dic.Add("DKType",dr["DKType"].ToString());
                dic.Add("CurDKAmount", dr["CurDKAmount"].ToString());
                dic.Add("CurDKCurrency", dr["CurDKCurrency"].ToString());
                dic.Add("DKDate", dr["DKDate"].ToString());
                dic.Add("QKCurrencyCnt", dr["QKCurrencyCnt"].ToString());
                // 根据到款ID获取对应的到款结算状态
                if (dr["DKType"].ToString().Equals("结算到款"))
                {
                    dic.Add("Status", "不必结算");
                }
                else
                {
                    string key = "";
                    if(ContractProperty != "航空煤油")
                    {
                        key = dr["DKObjectID"].ToString() + dr["QKObjectID"].ToString()+ dr["QKType"].ToString() + dr["QKCurrencyName"].ToString();
                    } else
                    {
                        key = dr["DKObjectID"].ToString() + dr["QKObjectID"].ToString() ;
                    }
                    dic.Add("Status", Common.getStatusOfDKJ(dic_dkj_ok, key));
                }
                //dic.Add("SeqCnt", dr["SeqCnt"].ToString());
                ls.Add(dic);
                i++;
            }
            setDic(ls,"SeqCnt2",QKCnt.ToString(),DKObjectID,QKObjectID,"");

        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取付款结算状态记录
    public void getFKRecordTblOfJSData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取结算中的付款记录
        // 获取已经进行过结算处理的数据
        var jfksql_ok = " select dj.FKObjectID,Max(ic.State) Status  " +
                    " from I_JS j  " +
                    " INNER JOIN I_FKTblOfJS dj on dj.ParentObjectID = j.ObjectID  " +
                    " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId " +
                    " and j.ContractNo = '" + ContractNo + "'  and dj.IsCheck = '是;'" +
                    " group by dj.FKObjectID ";
        System.Data.DataTable dt_fkj_ok = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jfksql_ok);
        Dictionary<string, string> dic_fkj_ok = new Dictionary<string, string>();
        if (dt_fkj_ok.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_fkj_ok.Rows)
            {
                dic_fkj_ok.Add(dr["FKObjectID"].ToString(), dr["Status"].ToString());
            }
        }
        var jfksql = " select t1.ObjectID,t1.ZKMS,e3.EnumValue ZKType,convert(varchar(20),convert(decimal(18,2),t1.Amount)) as Amount,convert(varchar(20),convert(decimal(18,2),t1.OutTaxAmount)) as OutTaxAmount," +
                        " t1.Currency,e1.EnumValue CurrencyName, " +
                        " CONVERT(varchar(12),t1.FKDate,111) FKDate,t1.ConvertAmount, " +
                        " convert(varchar(20),convert(decimal(18,2),t2.AmountSum))+e1.EnumValue as AmountSum,t2.Cnt, t1.Content,e2.EnumValue PayType,t1.Receiver,t1.State Status,t1.IcObjectID,t1.RejectFlg " +
                        " from  " +
                        " ( " +
                        " 	SELECT f.ObjectID,ft.ZKMS,ft.Amount,ft.OutTaxAmount,f.Currency,f.ZKType,f.FKDate,f.ConvertAmount,f.ModifiedTime ,ft.ParentIndex,f.Content,f.PayType,f.Receiver, " +
                        " 	ic.State,ic.ObjectID IcObjectID,f.RejectFlg " +
                        " 	FROM I_FK f " +
                        " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID and (f.ZFOperate = '' or f.ZFOperate = 'ZFOperate_ZF')" +
                        " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID and ic.State='4' " +
                        " 	and f.ContractNo = '" + ContractNo + "' " +
                        " ) t1 INNER JOIN  " +
                        " ( " +
                        " 	SELECT f.ObjectID,sum(ft.Amount) AmountSum,count(ft.ObjectID) Cnt " +
                        " 	FROM I_FK f " +
                        " 	INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID and (f.ZFOperate = '' or f.ZFOperate = 'ZFOperate_ZF')" +
                        " 	INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectID and ic.State='4' " +
                        " 	and f.ContractNo = '" + ContractNo + "' " +
                        " 	GROUP BY f.ObjectID " +
                        " ) t2 on t1.ObjectID = t2.ObjectID " +
                        " LEFT JOIN OT_EnumerableMetadata e1 on t1.Currency = e1.Code and e1.Category = '币种' " +
                        " LEFT JOIN OT_EnumerableMetadata e2 on t1.PayType = e2.Code and e2.Category = '支付方式' " +
                        " LEFT JOIN OT_EnumerableMetadata e3 on t1.ZKType = e3.Code and e3.Category = '付款类型' " +
                        " order by ModifiedTime ,ObjectID,ParentIndex ";
        System.Data.DataTable dt_jfk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jfksql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_jfk.Rows.Count > 0)
        {
            var i = 0;
            var ObjectIDBak = "";
            var TheNo = 0;
            foreach (DataRow dr in dt_jfk.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                // 第一行
                if (!ObjectIDBak.Equals(dr["ObjectID"].ToString()))
                {
                    TheNo++;
                }
                ObjectIDBak = dr["ObjectID"].ToString();
                string Amount = "";
                if (dr["OutTaxAmount"].ToString() == "" || dr["OutTaxAmount"].ToString().Equals("0.00"))
                {
                    Amount = dr["Amount"].ToString() + dr["CurrencyName"].ToString();
                }
                else
                {
                    Amount = dr["Amount"].ToString() + dr["CurrencyName"].ToString() + " \n代扣外税：" + dr["OutTaxAmount"].ToString() + dr["CurrencyName"].ToString();
                }
                // 如果是人民币，直接拿人民币合计作为折算金额
                if (dr["Currency"].ToString().Equals("RMB"))
                {
                    dic.Add("ConvertAmount", dr["AmountSum"].ToString());
                }
                else
                {
                    // 如果有折算金额，则取之，不然就是没有折算金额
                    var ConvertAmount = Convert.ToDouble(dr["ConvertAmount"]);
                    if (ConvertAmount > 0)
                    {
                        dic.Add("ConvertAmount", dr["ConvertAmount"].ToString() + "人民币");
                    }
                }
                // 根据到款ID获取对应的到款结算状态
                if (dr["ZKType"].ToString().Equals("结算付款"))
                {
                    dic.Add("Status","不必结算");
                }
                else
                {
                    dic.Add("Status",Common.getStatusOfDKJ(dic_fkj_ok, dr["ObjectID"].ToString()));
                }
                dic.Add("TheNo",TheNo.ToString());
                dic.Add("Receiver",dr["Receiver"].ToString());
                dic.Add("ZKMS",dr["ZKMS"].ToString());
                dic.Add("Amount",Amount);
                dic.Add("Content",dr["Content"].ToString());
                dic.Add("Cnt",dr["Cnt"].ToString());

                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取结算记录
    public void getJSData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取结算记录
        // 获取已经进行过结算处理的数据
        var jssql = " select j.ObjectID JSObjectID,  " +
                    " convert(varchar(20),convert(decimal(18,2),j.LJDKAmountRMB))+j.CurrencyRMB LJDKAmountRMB,  " +
                    " convert(varchar(20),convert(decimal(18,2),j.LJFKAmountRMB))+j.CurrencyRMB LJFKAmountRMB, " +
                    " convert(varchar(20),convert(decimal(18,2),isnull(j.BankFY,0)))+j.CurrencyRMB BankFY, " +
                    " convert(varchar(20),convert(decimal(18,2),isnull(j.AgencyFY,0)))+j.CurrencyRMB + '\n(' + convert(varchar(20),convert(decimal(18,2),isnull(j.AgencyFYWB,0)))+j.CurrencyWB + ')' AgencyFY, " +
                    " convert(varchar(20),convert(decimal(18,2),isnull(j.OtherFY,0)))+j.CurrencyRMB OtherFY, " +
                    " j.JSResult JSResultNum, " +
                    " j.JSStatus+convert(varchar(20),convert(decimal(18,2),j.JSResult))+j.CurrencyRMB JSResult, " +
                    " j.JSStatus, " +
                    " j.CurrencyRMB, " +
                    " j.CurrencyWB,  " +
                    " j.ModifiedTime, " +
                    " ic.ObjectID IcObjectId ,ic.State Status ,j.RejectFlg RejectFlg ,j.QK_FK_Status QK_FK_Status  " +
                    " from I_JS j " +
                    " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId  " +
                    " and j.ContractNo = '" + ContractNo + "' " +
                    " order BY j.ModifiedTime ";
        System.Data.DataTable dt_js = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jssql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_js.Rows.Count > 0)
        {
            var i = 0;
            foreach (DataRow dr in dt_js.Rows)
            {
                Dictionary<string, string> dic = new Dictionary<string, string>();
                // 第一行
                var ActivityCode = "";
                Dictionary<string, string> workItemDic = Common.getWorkItemIdNew(dr["IcObjectId"].ToString(), dr["Status"].ToString(), UserID);
                dic.Add("WorkItemId",workItemDic["workItemId"]);
                ActivityCode = workItemDic["ActivityCode"];

                // 根据到款ID获取对应的到款结算状态
                if (dr["Status"].ToString().Equals("2"))
                {
                    if(ActivityCode == "ActivityOrig")
                    {
                        dic.Add("DisplayName","草稿");
                    } else
                    {
                        dic.Add("DisplayName","申请中");
                    }
                }
                else
                {
                    if (dr["RejectFlg"].ToString() == "1")
                    {
                        dic.Add("DisplayName","驳回");
                    }
                    else
                    {
                        var JSResultNum = Convert.ToDouble(dr["JSResultNum"]);
                        if (JSResultNum == 0)
                        {
                            dic.Add("DisplayName","结算完成");
                        }
                        else
                        {
                            // 请付款状态一览：
                            // QK_Start:请款开始、QK_OK:请款成功、QK_DK_OK:请款且到款成功、FK_Start:付款开始、FK_OK:付款成功、
                            // BatchQK_Start:批量请款开始、BatchDK_OK:批量到款成功
                            // BatchFK_Start:批量付款开始、BatchFK_OK:批量付款成功
                            // BatchJQ_Start:批量结清开始、BatchJQ_OK:批量结清成功
                            if (dr["QK_FK_Status"].ToString() == "QK_DK_OK" || dr["QK_FK_Status"].ToString() == "FK_OK")
                            {
                                dic.Add("DisplayName","结算完成");
                            } else if (dr["QK_FK_Status"].ToString() == "BatchQK_Start"
                                    || dr["QK_FK_Status"].ToString() == "BatchFK_Start"
                                    || dr["QK_FK_Status"].ToString() == "BatchJQ_Start")
                            {
                                dic.Add("DisplayName","批量结算中");
                            }
                            else if (dr["QK_FK_Status"].ToString() == "BatchDK_OK"
                                || dr["QK_FK_Status"].ToString() == "BatchFK_OK"
                                || dr["QK_FK_Status"].ToString() == "BatchJQ_OK")
                            {
                                dic.Add("DisplayName","批量结算完成");
                            }
                            else
                            {
                                if (dr["JSStatus"].ToString() == "应收")
                                {
                                    dic.Add("DisplayName","待请款");
                                }
                                else if (dr["JSStatus"].ToString() == "应退")
                                {
                                    dic.Add("DisplayName","待付款");
                                }
                            }
                        }
                    }
                }

                dic.Add("LJDKAmountRMB",dr["LJDKAmountRMB"].ToString());
                dic.Add("LJFKAmountRMB",dr["LJFKAmountRMB"].ToString());
                dic.Add("BankFY",dr["BankFY"].ToString());
                dic.Add("AgencyFY",dr["AgencyFY"].ToString());
                dic.Add("OtherFY",dr["OtherFY"].ToString());
                dic.Add("JSResult",dr["JSResult"].ToString());
                dic.Add("JSResultNum",dr["JSResultNum"].ToString());
                dic.Add("RejectFlg",dr["RejectFlg"].ToString());
                dic.Add("JSObjectID",dr["JSObjectID"].ToString());
                dic.Add("Status",dr["QK_FK_Status"].ToString());
                ls.Add(dic);
                i++;
            }
        }
        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    // 获取支付管理记录
    public void getPayManagerData(HttpContext context)
    {
        // ContractNo
        string ContractNo = context.Request["ContractNo"];
        string UserID = context.Request["UserID"];

        // 获取请款记录
        var qksql = " SELECT q.QKSeq,qs.ParentIndex QKTheNo,qs.ZJMS,qs.Currency+convert(varchar(20),convert(decimal(18,2),ISNULL(qs.Amount,0))) Amount,  " +
            " e2.EnumValue QKType,qs.Currency QKCurrency,CONVERT(varchar(12),q.CreatedTime,111) QKDate,qs.DKStatus,q.ObjectID QKObjectID,qs.ObjectID QKSubObjectID " +
            " FROM I_QK q " +
            " INNER JOIN I_QKSubTbl qs on q.ObjectID = qs.ParentObjectID and q.ContractNo = '" + ContractNo + "' and qs.QKType <> 'JS' " +
            " INNER JOIN OT_InstanceContext ic on q.ObjectID = ic.BizObjectId and ic.State = '4' " +
            " LEFT JOIN OT_EnumerableMetadata e2 on qs.QKType = e2.Code and e2.Category = '请款类型'" +
            " order by q.QKSeq,e2.SortKey,qs.Currency,qs.ParentIndex ";
        System.Data.DataTable dt_qk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(qksql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        Dictionary<string, string> dicDK = new Dictionary<string, string>();
        if (dt_qk.Rows.Count > 0)
        {
            var i = 0;
            var QKSeq = "";
            var QKCurrency = "";
            var QKType = "";
            var QKObjectID = "";
            var changeFlg = false; // 请款批次和币种是否变化了
            int QKCnt = 0;
            int QKCurrencyCnt = 0;
            double AgencyFYTotal = 0.0;
            double BankFYTotal = 0.0;
            double OtherFYTotal = 0.0;
            string JSRecAndRemainFee = "";
            int FKCnt = 0;
            string FKObjectID = "";
            double DKAmountTotal = 0.0; // 到款合计
            double FKAmountTotal = 0.0; // 付款合计
            double TKAmountTotal = 0.0; // 退款合计
            double SKAmountTotal = 0.0; // 收款合计
            double TotalRemainFee = 0.0; // 总余额合计
            foreach (DataRow dr in dt_qk.Rows)
            {

                Dictionary<string, string> dic = new Dictionary<string, string>();
                if (!(QKSeq + QKType + QKCurrency).Equals(dr["QKSeq"].ToString() + dr["QKType"].ToString() + dr["QKCurrency"].ToString()))
                {
                    changeFlg = true;
                    setDic(ls,"QKCurrencyCnt",QKCurrencyCnt.ToString(),QKSeq,QKType,QKCurrency);
                    QKCurrencyCnt = 0;
                } else
                {
                    changeFlg = false;
                }
                if (QKObjectID!="" && !(QKObjectID).Equals(dr["QKObjectID"].ToString()))
                {
                    setDic(ls,"QKCnt",QKCnt.ToString(),QKObjectID,"","");
                    QKCnt = 0;
                }
                QKSeq = dr["QKSeq"].ToString();
                QKCurrency = dr["QKCurrency"].ToString();
                QKType = dr["QKType"].ToString();
                QKObjectID = dr["QKObjectID"].ToString();
                dic.Add("QKSeq", QKSeq);
                dic.Add("QKTheNo", dr["QKTheNo"].ToString());
                dic.Add("QKZJMS", dr["ZJMS"].ToString());
                dic.Add("QKAmount", "<input type='checkbox' name='QKAmount' onclick='QKAmountClick()'>"+dr["Amount"].ToString());
                dic.Add("QKDate", dr["QKDate"].ToString());
                dic.Add("DKStatus", dr["DKStatus"].ToString()!=""?dr["DKStatus"].ToString():"未到款");
                dic.Add("QKObjectID", dr["QKObjectID"].ToString());
                dic.Add("QKSubObjectID", dr["QKSubObjectID"].ToString());
                dic.Add("QKAmountCnt", "1");// 初始化1
                dic.Add("QKCnt", "1"); // 初始化1
                dic.Add("QKCurrencyCnt", "1"); // 初始化1
                dic.Add("QKCurrency", QKCurrency);
                dic.Add("QKType", QKType);
                dic.Add("ZJPlanContent", "");
                dic.Add("ZJPlanAmount", "");
                dic.Add("DKBizObjectID", "");
                dic.Add("DKTotalAmount", "");
                dic.Add("FKCnt", "1"); // 初始化1
                dic.Add("SubsFee", "");
                dic.Add("JSRecAndRemainFee", "");
                int fkcnt = 0;
                if (changeFlg) {
                    // 获取资金计划记录
                    var QKCurrencytmp = "批次" + QKSeq + ":" + QKCurrency;
                    var plansql = " select top 1 pt.Content,'RMB'+convert(varchar(20),convert(decimal(18,2),ISNULL(pt.Amount,0))) Amount  " +
                        " from I_ZJPlan p " +
                        " INNER JOIN I_PlanTbl pt on p.ObjectID = pt.ParentObjectID  " +
                        " and pt.QKCurrency='" + QKCurrencytmp + "' and p.ContractNo='" + ContractNo + "' ";
                    System.Data.DataTable dt_plan = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(plansql);
                    if (dt_plan.Rows.Count > 0)
                    {
                        foreach (DataRow dr_plan in dt_plan.Rows)
                        {
                            dic["ZJPlanContent"] = dr_plan["Content"].ToString();
                            dic["ZJPlanAmount"] = dr_plan["Amount"].ToString();
                        }
                    }

                    // 获取到款记录
                    var QKSubsql = getQKSubsql(ContractNo,QKSeq,QKCurrency);
                    var dksql = " SELECT d.ObjectID DKBizObjectID,min(dt.CurDKCurrency)+convert(varchar(20),convert(decimal(18,2),ISNULL(sum(dt.CurDKAmount),0))) DKTotalAmount, " +
                        " min(dt.CurDKCurrency) DKCurrency, ISNULL(sum(dt.CurDKAmount),0) DKAmountD, max(CONVERT(varchar(12),d.DKDate,111)) DKDate " +
                        " from I_DK d  " +
                        " INNER JOIN I_DKTbl dt on d.ObjectID = dt.ParentObjectID and d.ContractNo = '" + ContractNo + "' and dt.CurDKAmount > 0 " +
                        " INNER JOIN OT_InstanceContext ic on d.ObjectID = ic.BizObjectId and ic.State = '4' " +
                        " and ( "+QKSubsql.Substring(2)+" )  " +
                        " GROUP BY d.ObjectID ";
                    System.Data.DataTable dt_dk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(dksql);
                    var DKBizObjectIDs = "";
                    var DKTotalAmounts = "";
                    if (dt_dk.Rows.Count > 0)
                    {
                        foreach (DataRow dr_dk in dt_dk.Rows)
                        {
                            DKBizObjectIDs += dr_dk["DKBizObjectID"].ToString()+"<br>";
                            DKTotalAmounts += "<input type='checkbox' name='DKTotalAmount' onclick='DKFKAmountClick(this)' data='"+dr_dk["DKBizObjectID"].ToString()+"'>"+dr_dk["DKTotalAmount"].ToString()+"("+dr_dk["DKDate"].ToString()+")<br>";
                            DKAmountTotal += Convert.ToDouble(dr_dk["DKCurrency"].ToString().Equals("RMB")?dr_dk["DKAmountD"].ToString():"0");
                        }
                    }
                    dic["DKBizObjectID"] = DKBizObjectIDs;
                    dic["DKTotalAmount"] = DKTotalAmounts;

                }

                // 获取付款记录
                var fksql = " select f.ObjectID FKObjectID,ft.ObjectID FKTblObjectID,f.Currency+convert(varchar(20),convert(decimal(18,2),ISNULL(ft.Amount,0))) Amount, " +
                    " f.Currency FKCurrency,ISNULL(ft.Amount,0) AmountD,ft.ZKMS,CONVERT(varchar(12),f.FKDate,111) FKDate,f.Currency,f.AgencyFee,f.BankFee  " +
                    " from I_Fk f " +
                    " INNER JOIN I_FKTbl ft on f.ObjectID = ft.ParentObjectID and f.ContractNo = '" + ContractNo + "' " +
                    " INNER JOIN OT_InstanceContext ic on f.ObjectID = ic.BizObjectId and ic.State = '4' " +
                    " and ft.QKDetail = '"+dr["QKSubObjectID"].ToString()+"' " +
                    " order by ft.ObjectID ";
                System.Data.DataTable dt_fk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(fksql);


                if (dt_fk.Rows.Count > 0)
                {
                    QKCnt += dt_fk.Rows.Count;
                    QKCurrencyCnt += dt_fk.Rows.Count;
                    // 一条请款对应付款条数作为请款金额的合并单元格数量
                    dic["QKAmountCnt"] = dt_fk.Rows.Count.ToString();
                    foreach (DataRow dr_fk in dt_fk.Rows)
                    {
                        Dictionary<string, string> item ;
                        item = copy(dic);
                        if(FKObjectID!="" && !FKObjectID.Equals(dr_fk["FKObjectID"].ToString()))
                        {
                            setDic(ls,"FKCnt",FKCnt.ToString(),FKObjectID,"","");
                            FKCnt = 1;
                        } else
                        {
                            FKCnt++;
                        }
                        FKObjectID = dr_fk["FKObjectID"].ToString();
                        item.Add("FKObjectID", dr_fk["FKObjectID"].ToString());
                        item.Add("FKTblObjectID", dr_fk["FKTblObjectID"].ToString());
                        item.Add("FKAmount", "<input type='checkbox' name='FKAmount' onclick='DKFKAmountClick(this)'>"+dr_fk["Amount"].ToString());
                        FKAmountTotal += Convert.ToDouble(dr_fk["FKCurrency"].ToString().Equals("RMB")?dr_fk["AmountD"].ToString():"0");
                        item.Add("FKZKMS", dr_fk["ZKMS"].ToString());
                        item.Add("FKDate", dr_fk["FKDate"].ToString());
                        //AgencyFYTotal += Convert.ToDouble(dr_fk["AgencyFee"].ToString());
                        //BankFYTotal += Convert.ToDouble(dr_fk["BankFee"].ToString());
                        dicDK[dr_fk["FKObjectID"].ToString()+"AgencyFY"] = dr_fk["AgencyFee"].ToString();
                        dicDK[dr_fk["FKObjectID"].ToString()+"BankFY"] = dr_fk["BankFee"].ToString();
                        // 获取结算状态记录
                        var jsStssql = " SELECT top 1 ic.State  " +
                            " FROM I_JS j " +
                            " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId  " +
                            " INNER JOIN I_FKTblOfJS fj on j.ObjectID = fj.ParentObjectID and fj.IsCheck = '是;' " +
                            " and j.ContractNo = '" + ContractNo + "' and fj.FKObjectID = '" + dr_fk["FKObjectID"].ToString() + "' " ;
                        System.Data.DataTable dt_jsSts = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jsStssql);
                        if (dt_jsSts.Rows.Count > 0)
                        {
                            item.Add("JSStatus", dt_jsSts.Rows[0]["State"].ToString().Equals("2")?"结算中":"已结算");
                        } else
                        {
                            item.Add("JSStatus", "未结算");
                        }
                        ls.Add(item);
                        fkcnt++;
                    }
                    setDic(ls,"FKCnt",FKCnt.ToString(),FKObjectID,"","");
                } else
                {
                    QKCnt += 1;
                    QKCurrencyCnt += 1;
                }


                // 没有付款记录时，作为一行数据处理，否则已经在付款逻辑中添加了多行数据
                if (fkcnt == 0)
                {
                    ls.Add(dic);
                }
                i++;
            }

            // 获取结算记录
            var jssql = " select j.JSStatus,j.JSResult,j.QK_FK_Status,j.OtherFY " +
                " from I_JS j " +
                " INNER JOIN OT_InstanceContext ic on j.ObjectID = ic.BizObjectId   " +
                " and j.ContractNo = '" + ContractNo + "' and ic.State = '4'  " +
                " order by j.CreatedTime ";
            System.Data.DataTable dt_js = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(jssql);
            if (dt_js.Rows.Count > 0)
            {
                foreach (DataRow dr_js in dt_js.Rows)
                {
                    // 完成的结算(DK_OK:应收，进行请款-到款；FK_OK：应退，进行付款）
                    if(dr_js["QK_FK_Status"].ToString().Contains("DK_OK") || dr_js["QK_FK_Status"].ToString().Contains("FK_OK"))
                    {
                        if(dr_js["JSStatus"].ToString().Equals("应收"))
                        {
                            JSRecAndRemainFee += "收款RMB " + dr_js["JSResult"].ToString()+"<br>";
                            SKAmountTotal += Convert.ToDouble(dr_js["JSResult"].ToString());
                        } else if (dr_js["JSStatus"].ToString().Equals("应退"))
                        {
                            JSRecAndRemainFee += "退款RMB " + dr_js["JSResult"].ToString()+"<br>";
                            TKAmountTotal += Convert.ToDouble(dr_js["JSResult"].ToString());
                        }
                        OtherFYTotal += Convert.ToDouble(dr_js["OtherFY"].ToString());
                    }
                }
            }
            setDic(ls,"QKCnt",QKCnt.ToString(),QKObjectID,"","");
            setDic(ls,"QKCurrencyCnt",QKCurrencyCnt.ToString(),QKSeq,QKType,QKCurrency);
            string SubsFee = "";
            AgencyFYTotal = getFYTotal(dicDK,"AgencyFY");
            BankFYTotal = getFYTotal(dicDK,"BankFY");
            SubsFee += "代理费合计：RMB " + AgencyFYTotal.ToString() + "<br>银行费合计：RMB " + BankFYTotal.ToString() + "<br>其他费用合计："+OtherFYTotal.ToString()+" RMB ";
            setDic(ls,"SubsFee",SubsFee,"","","");
            TotalRemainFee = DKAmountTotal - FKAmountTotal - AgencyFYTotal - BankFYTotal - OtherFYTotal - TKAmountTotal + SKAmountTotal;
            JSRecAndRemainFee += "<br>余额："+TotalRemainFee;
            setDic(ls,"JSRecAndRemainFee",JSRecAndRemainFee,"","","");
        }

        object JSONObj = JsonConvert.SerializeObject(ls);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
    }

    public string getQKSubsql(string ContractNo, string QKSeq, string Currency)
    {
        string ret = "";
        // 获取请款
        var qksql = " SELECT qs.ObjectID QKSubObjectID  " +
            " FROM I_QK q " +
            " INNER JOIN I_QKSubTbl qs on q.ObjectID = qs.ParentObjectID and q.ContractNo = '" + ContractNo + "' " +
            " INNER JOIN OT_InstanceContext ic on q.ObjectID = ic.BizObjectId and ic.State = '4' " +
            " and q.QKSeq='"+QKSeq+"' and qs.Currency='"+Currency+"' " +
            " order by q.QKSeq,qs.ParentIndex ";
        System.Data.DataTable dt_qk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(qksql);
        List<Dictionary<string, string>> ls = new List<Dictionary<string, string>>();
        if (dt_qk.Rows.Count > 0)
        {
            foreach (DataRow dr in dt_qk.Rows)
            {
                ret += "or dt.QKSubObjectID = '"+dr["QKSubObjectID"].ToString()+"' ";
            }
        }
        return ret;
    }

    public Dictionary<string, string> copy(Dictionary<string, string> dic)
    {

        Dictionary<string, string> item = new Dictionary<string, string>();
        item["QKSeq"] = dic["QKSeq"];
        item["QKTheNo"] = dic["QKTheNo"];
        item["QKZJMS"] = dic["QKZJMS"];
        item["QKAmount"] = dic["QKAmount"];
        item["QKDate"] = dic["QKDate"];
        item["QKObjectID"] = dic["QKObjectID"];
        item["QKSubObjectID"] = dic["QKSubObjectID"];
        item["QKAmountCnt"] = dic["QKAmountCnt"];
        item["QKCnt"] = dic["QKCnt"];
        item["QKCurrencyCnt"] = dic["QKCurrencyCnt"];
        item["QKCurrency"] = dic["QKCurrency"];
        item["QKType"] = dic["QKType"];
        item["DKStatus"] = dic["DKStatus"];
        item["ZJPlanContent"] = dic["ZJPlanContent"];
        item["ZJPlanAmount"] = dic["ZJPlanAmount"];
        item["DKBizObjectID"] = dic["DKBizObjectID"];
        item["DKTotalAmount"] = dic["DKTotalAmount"];
        item["FKCnt"] = dic["FKCnt"];
        item["SubsFee"] = dic["SubsFee"];
        item["JSRecAndRemainFee"] = dic["JSRecAndRemainFee"];
        return item;
    }

    public void setDic(List<Dictionary<string, string>> ls,string key,string value,string comp1,string comp2,string comp3)
    {
        foreach(Dictionary<string, string> item in ls )
        {
            if(key.Equals("QKCnt"))
            {
                if(item.ContainsKey("QKObjectID") && item["QKObjectID"].Equals(comp1))
                {
                    item[key] = value;
                }
            }
            if(key.Equals("SeqCnt"))
            {
                if(item.ContainsKey("QKObjectID") && item["QKObjectID"].Equals(comp1))
                {
                    item[key] = value;
                }
            }
            if(key.Equals("SeqCnt2"))
            {
                if(item.ContainsKey("DKObjectID") && item.ContainsKey("QKObjectID") &&
                        item["DKObjectID"].Equals(comp1) && item["QKObjectID"].Equals(comp2))
                {
                    item["SeqCnt"] = value;
                }
            }
            if(key.Equals("QKCurrencyCnt3"))
            {
                if(item.ContainsKey("QKObjectID") && item["QKObjectID"].Equals(comp1))
                {
                    item["QKCurrencyCnt"] = value;
                }
            }
            if(key.Equals("QKTotalAmount3"))
            {
                if(item.ContainsKey("QKObjectID") && item["QKObjectID"].Equals(comp1))
                {
                    item["QKTotalAmount"] = value;
                }
            }
            if(key.Equals("QKConvertAmount3"))
            {
                if(item.ContainsKey("QKObjectID") && item["QKObjectID"].Equals(comp1))
                {
                    item["QKConvertAmount"] = value;
                }
            }
            if(key.Equals("FKCnt"))
            {
                if(item.ContainsKey("FKObjectID") && item["FKObjectID"].Equals(comp1))
                {
                    item[key] = value;
                }
            }
            if(key.Equals("QKCurrencyCnt"))
            {
                if(item.ContainsKey("QKSeq") && item.ContainsKey("QKType") && item.ContainsKey("QKCurrency")
                        && item["QKSeq"].Equals(comp1) && item["QKType"].Equals(comp2) && item["QKCurrency"].Equals(comp3))
                {
                    item[key] = value;
                }
            }
            if(key.Equals("QKCurrencyCnt2"))
            {
                if(item.ContainsKey("ContractNo") && item.ContainsKey("QKSeq") && item.ContainsKey("QKType") && item.ContainsKey("QKCurrency")
                        && (item["ContractNo"]+item["QKSeq"]).Equals(comp1) && item["QKType"].Equals(comp2) && item["QKCurrency"].Equals(comp3))
                {
                    item[key] = value;
                }
            }
            if(key.Equals("QKTotalAmount") || key.Equals("QKConvertAmount"))
            {
                if(item.ContainsKey("QKSeq") && item.ContainsKey("QKType") && item.ContainsKey("QKCurrency")
                        && item["QKSeq"].Equals(comp1) && item["QKType"].Equals(comp2) && item["QKCurrency"].Equals(comp3))
                {
                    item[key] = value;
                }
            }
            if(key.Equals("QKConvertAmount2"))
            {
                if(item.ContainsKey("ContractNo") && item.ContainsKey("QKSeq") && item.ContainsKey("QKType") && item.ContainsKey("QKCurrency")
                        && (item["ContractNo"]+item["QKSeq"]).Equals(comp1) && item["QKType"].Equals(comp2) && item["QKCurrency"].Equals(comp3))
                {
                    item[key] = value;
                }
            }
            if (key.Equals("SubsFee"))
            {
                item[key] = value;
            }
            if (key.Equals("JSRecAndRemainFee"))
            {
                item[key] = value;
            }
        }
    }

    public double getFYTotal(Dictionary<string, string> dicDK,string flg)
    {
        double sum = 0.0;
        foreach (var item in dicDK)
        {
            if (item.Key.Contains(flg))
            {
                sum += Convert.ToDouble(item.Value==""?"0":item.Value);
            }
        }
        return sum;
    }

    // 获取流程节点数据
    public void PullInstanceNode(HttpContext context)
    {
        //string Uri = "http://localhost:8010/Portal/InstanceDetail/AdjustActivity?ActivityCode=ActivityCreate&InstanceID=b8c166db-828e-4e12-a2a1-baf8cf56043a&Participants=18f923a7-5a5e-426d-94ae-a55ad1a4b239";
        //HttpClient httpClient = new HttpClient();
        //    string res1 = "";
        //// 创建一个异步GET请求，当请求返回时继续处理
        //httpClient.GetAsync(Uri).ContinueWith(
        //    (requestTask) =>
        //    {
        //        HttpResponseMessage response = requestTask.Result;
        //        // 确认响应成功，否则抛出异常
        //        response.EnsureSuccessStatusCode();
        //        // 异步读取响应为字符串

        //        response.Content.ReadAsStringAsync().ContinueWith(
        //            (readTask) => (res1 = readTask.Result));
        //        Console.WriteLine(res1);
        //    });
        //object JSONObj = JsonConvert.SerializeObject("");
        //context.Response.ContentType = "application/json";
        //context.Response.Write(JSONObj);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
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

}