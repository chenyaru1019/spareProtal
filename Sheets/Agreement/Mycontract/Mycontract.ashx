<%@ WebHandler Language="C#" Class="Mycontract" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using OThinker.H3;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Runtime.Serialization;
using OThinker.H3.Portal.service;

public class Mycontract : IHttpHandler {
    JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public void ProcessRequest (HttpContext context) {

        string command = context.Request["Command"];
        switch (command)
        {
            case "getcontractList":getcontractList(context);break;


        }
    }
    //获合同列表
    public void getcontractList(HttpContext context) {
        // 从第几条数据开始获取
        string pageNumber = context.Request["pageNumber"];
        // 每一页多少条数据
        string pageSize = context.Request["pageSize"];

        string contract_sele = context.Request["contract_sele"];//合同选择
        string contract_states = context.Request["contract_states"];//合同状态
        string my_role = context.Request["my_role"];//我的角色
        string user = context.Request["user"];
        string contract_name = context.Request["contract_name"];//合同名称
        //合同查询
        string contract_number = context.Request["contract_number"];//合同编号
        string qy_time = context.Request["qy_time"];//合同签约时间
        string qy_time2 = context.Request["qy_time2"];
        string Project_head = context.Request["Project_head"];//项目负责人
        string my_way = context.Request["my_way"];//贸易方式
        string contract_creatime = context.Request["contract_creatime"];//合同创建时间
        string contract_creatime2 = context.Request["contract_creatime2"];//合同创建时间2
        string end_user = context.Request["end_user"];//最终用户
        string contract_xz = context.Request["contract_xz"];//合同性质
        string contract_bgtime = context.Request["contract_bgtime"];//合同变更时间
        string contract_bgtime2 = context.Request["contract_bgtime2"];//合同变更时间2
        string contract_mf = context.Request["contract_mf"];//合同卖方
        string contract_type = context.Request["contract_type"];//合同类型
        String sqls =
            "SELECT ContractNo,ContractName,CONVERT(varchar(12),t.CreatedTime,111) CreatedTime,em1.EnumValue ContractTypeName,ContractProperty,PostA,PostB,FinalUser,Salers,em.EnumValue ContractPropertyName,TradeMethod," +
            " ContractTotalPrice,JKTotalAmount,em2.EnumValue CurrencyName,CONVERT(varchar(12),t.SignDate,111) SignDate,CONVERT(varchar(12),t.ModifiedTime,111) ModifiedTime," +
            " (select top 1 ic.FinishTime from I_BG b inner join OT_InstanceContext ic on b.ObjectID = ic.BizObjectID and b.ContractNo = t.ContractNo order by b.CreatedTime desc) BGFinishTime," +
            //"(SELECT wi.DisplayName FROM OT_InstanceContext ic INNER JOIN OT_WorkItem wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = t.ObjectID " +
            //"AND ic.state = '2'  UNION SELECT  wi.DisplayName FROM OT_InstanceContext ic" +
            //" INNER JOIN OT_WorkItemFinished wi ON ic.ObjectID = wi.InstanceId AND ic.BizObjectId = t.ObjectID AND ic.state = '4' ) as con_state," +
            " ics.ObjectID IcObjectID, ics.State Status" +
            //", wit.ObjectID" +
            " FROM  I_ContractMain t " +
            " LEFT JOIN OT_EnumerableMetadata em ON t.ContractProperty=em.Code and em.Category like '合同性质%'  " +
            " LEFT JOIN OT_EnumerableMetadata em1 ON t.ContractType=em1.Code and em1.Category='合同类型'  " +
            " LEFT JOIN OT_EnumerableMetadata em2 ON t.Currency=em2.Code and em2.Category='币种'  " +
            " LEFT JOIN OT_InstanceContext ics ON ics.BizObjectid=t.ObjectID " +
            //" LEFT JOIN OT_WorkItem wit ON wit.InstanceId=ics.ObjectID " +
            "where 1=1 ";

        if (contract_number != "" && contract_number !=null)
        {
            sqls += " and ContractNo like '%" + contract_number + "%'";
        }
        //合同签约时间
        if (qy_time != "" && qy_time != null)
        {
            sqls += " and SignDate >= '" + qy_time + "'";
        }
        if (qy_time2 != "" && qy_time2 != null)
        {
            sqls += " and SignDate <= '" + qy_time2 + "'";
        }
        if (Project_head != "" &&  Project_head !=null)
        {
            sqls += " and  (PostA = '" + Project_head + "' OR  PostB = '" + Project_head + "')";
        }
        if (my_way != "" &&  my_way !=null)
        {
            sqls += " and TradeMethod = '" + my_way + "'";
        }
        //合同创建时间
        if (contract_creatime != "" && contract_creatime != null)
        {
            sqls += " and CreatedTime >= '" + contract_creatime + "'";
        }
        if (contract_creatime2 != "" && contract_creatime2 != null)
        {
            sqls += " and CreatedTime <= '" + contract_creatime2 + "'";
        }
        if (end_user != "" && end_user !=null)
        {
            sqls += " and FinalUser = '" + end_user + "'";
        }
        if (contract_xz != "" && contract_xz !=null)
        {
            sqls += " and ContractProperty = '" + contract_xz + "'";

        }
        //合同变更时间
        //if (contract_bgtime != "" && contract_bgtime != null)
        //{
        //    sqls += " and ModifiedTime = '" + contract_bgtime + "'";

        //}
        //if (contract_bgtime2 != "" && contract_bgtime2 != null)
        //{
        //    sqls += " and ModifiedTime = '" + contract_bgtime2 + "'";

        //}
        if (contract_mf != "" && contract_mf !=null)
        {
            sqls += " and Salers = '" + contract_mf + "'";

        }
        if (contract_type != "" && contract_type !=null)
        {
            sqls += " and ContractType = '" + contract_type + "'";

        }
        //合同名称
        if (contract_name != "" && contract_name != null)
        {
            sqls+= " and  ContractName  like '%" + contract_name + "%'";
        }


        //if (agreement != "") {
        //    switch (agreement) {
        //        case "w1":sqls += "我的协议";break;
        //        case "w2":sqls += "代职协议";break;
        //        case "w3":sqls += "全部";break;
        //    }
        //}
        if (my_role != "" && my_role !=null)
        {
            if (my_role == "我是A角") {
                sqls += " and PostA='"+user+"'";
            }else if (my_role == "我是B角") {
                sqls += " and PostB='"+user+"'";
            } else
            {
                sqls += " and (PostA='"+user+"' or PostB='"+user+"') ";
            }
        }
        //sqls += " order by CreatedTime desc ";
        string sqlsC =
                " select count(1) count from ("
                + sqls
                + " ) t";
        string sqlsD =
                " select top " + pageSize + " * from ( select row_number() over(order by CreatedTime desc) as rownumber,* from ( "
                + sqls
                + " ) t ) A where rownumber >= " + pageNumber;
        //获取协议执行的版本号
        //int versionAgreen_performNo = OThinker.H3.Controllers.AppUtility.Engine.WorkflowManager.GetWorkflowDefaultVersion("Agreen_perform");
        System.Data.DataTable dt_totalCount = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqlsC);
        System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sqlsD);
        Dictionary<string,object> ret = new Dictionary<string,object>();
        List<Dictionary<string,string>> ls = new List<Dictionary<string,string>>();
        var TheNo = 1;

        if (dt.Rows.Count > 0) {
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string,string> dic = new Dictionary<string,string>();
                //创建、审签、执行、完成合同
                //if (contract_states != "" && contract_states != null)
                //{
                //if ( contract_states.Contains(dr["con_state"].ToString()))
                //{
                DateTime  dt1 = Convert.ToDateTime(contract_bgtime+" 00:00:00");
                DateTime  dt2 = Convert.ToDateTime(contract_bgtime2+" 23:59:59");
                DateTime  dtMax = Convert.ToDateTime("9999-12-31 23:59:59.000");
                DateTime  BGFinishTime = dr["BGFinishTime"].ToString().Equals("")?Convert.ToDateTime("9999-12-31 23:59:59.000"):Convert.ToDateTime(dr["BGFinishTime"].ToString());
                if (contract_bgtime != "" && contract_bgtime != null && BGFinishTime.CompareTo(dtMax)!=0 && BGFinishTime.CompareTo(dt1)<0)
                {
                    continue;
                }
                if (contract_bgtime2 != "" && contract_bgtime2 != null && BGFinishTime.CompareTo(dtMax)!=0 && dt2.CompareTo(BGFinishTime)<0)
                {
                    continue;
                }
                dic.Add("TheNo",TheNo.ToString());
                dic.Add("ContractNO", dr["ContractNO"].ToString());
                dic.Add("ContractName", dr["ContractName"].ToString());
                dic.Add("CreatedTime", dr["CreatedTime"].ToString());
                dic.Add("ContractType", dr["ContractTypeName"].ToString());
                dic.Add("ContractProperty", dr["ContractPropertyName"].ToString());
                //dic.Add("Projecthead", dr["ContractName"].ToString());
                dic.Add("Projecthead", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["PostA"].ToString()) + '/' + OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["PostB"].ToString()));
                dic.Add("FinalUser", dr["FinalUser"].ToString());
                dic.Add("Salers", dr["Salers"].ToString());
                var ContractTotalPrice = "";
                if(dr["ContractTotalPrice"]!=null && dr["ContractTotalPrice"].ToString() != "" && dr["ContractTotalPrice"].ToString() != "0")
                {
                    ContractTotalPrice += dr["ContractTotalPrice"].ToString() + "人民币 ";
                }
                if(dr["JKTotalAmount"]!=null && dr["JKTotalAmount"].ToString() != "" && dr["JKTotalAmount"].ToString() != "0")
                {
                    ContractTotalPrice += dr["JKTotalAmount"].ToString() + dr["CurrencyName"].ToString();
                }
                dic.Add("ContractTotalPrice", ContractTotalPrice);
                dic.Add("SignDate", dr["SignDate"].ToString());
                dic.Add("ModifiedTime", dr["BGFinishTime"].ToString());
                Dictionary<string, string> workItemDic = Common.getWorkItemId2(dr["IcObjectId"].ToString(), dr["Status"].ToString(),user);
                var DisplayName = dr["Status"].ToString().Equals("4")?"合同完成":workItemDic["DisplayName"];
                var workItemId = workItemDic["workItemId"];
                dic.Add("contract_state", DisplayName);
                if(contract_states != null && contract_states != "" && !contract_states.Contains(DisplayName))
                {
                    continue;
                }
                var sql_fk = " select fk.ZKType,fk.Currency,sum(fk.CurZJAmount) LJFKAmount " +
                   " from I_FK fk " +
                   " INNER JOIN OT_InstanceContext ic on ic.BizObjectId = fk.ObjectID  " +
                   " and fk.ContractNo = '" + dr["ContractNO"].ToString() + "' and ic.State = '4'  " +
                   " group by fk.ZKType,fk.Currency "+
                    " order by fk.ZKType,fk.Currency ";
                System.Data.DataTable dt_fk = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(sql_fk);
                // 付款
                var LJFKAmountRMB = 0.0;
                var LJFKAmountWB = 0.0;
                if (dt_fk.Rows.Count > 0)
                {
                    foreach (DataRow dr_f in dt_fk.Rows)
                    {
                        if(dr_f["ZKType"].ToString().Equals("ZKType_HT"))
                        {
                            if (dr_f["Currency"].ToString().Equals("RMB"))
                            {
                                LJFKAmountRMB = Convert.ToDouble(dr_f["LJFKAmount"].ToString());
                            } else
                            {
                                LJFKAmountWB = Convert.ToDouble(dr_f["LJFKAmount"].ToString());
                            }
                        }
                    }
                }
                var FKPercentRMB = "";
                var FKPercentWB = "";
                if(dr["ContractTotalPrice"]!=null && dr["ContractTotalPrice"].ToString() != "" && dr["ContractTotalPrice"].ToString() != "0")
                {
                    FKPercentRMB = "人民币:"+string.Format("{0:0.00}",((LJFKAmountRMB / Convert.ToDouble(dr["ContractTotalPrice"].ToString()))) * 100).ToString()+"%<br>";
                }
                if(dr["JKTotalAmount"]!=null && dr["JKTotalAmount"].ToString() != "" && dr["JKTotalAmount"].ToString() != "0")
                {
                    FKPercentWB = dr["CurrencyName"]+":"+string.Format("{0:0.00}",((LJFKAmountWB / Convert.ToDouble(dr["JKTotalAmount"].ToString()))) * 100).ToString()+"%";
                }
                dic.Add("FKPercent", FKPercentRMB + FKPercentWB);
                dic.Add("ObjectID", workItemId);
                dic.Add("PostA", dr["PostA"].ToString());
                dic.Add("PostB", dr["PostB"].ToString());
                ls.Add(dic);
                TheNo++;
                //}
                //}
                //else {
                //    dic.Add("TheNo",TheNo.ToString());
                //    dic.Add("ContractNO", dr["ContractNO"].ToString());
                //    dic.Add("ContractName", dr["ContractName"].ToString());
                //    dic.Add("CreatedTime", dr["CreatedTime"].ToString());
                //    dic.Add("ContractType", dr["ContractType"].ToString());
                //    dic.Add("ContractProperty", dr["EnumValue"].ToString());
                //    //dic.Add("Projecthead", dr["ContractName"].ToString());
                //    dic.Add("Projecthead", OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["PostA"].ToString()) + '/' + OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dr["PostB"].ToString()));
                //    dic.Add("FinalUser", dr["FinalUser"].ToString());
                //    dic.Add("Salers", dr["Salers"].ToString());
                //    dic.Add("ContractTotalPrice", dr["ContractTotalPrice"].ToString());
                //    dic.Add("SignDate", dr["SignDate"].ToString());
                //    dic.Add("ModifiedTime", dr["ModifiedTime"].ToString());
                //    Dictionary<string, string> workItemDic = Common.getWorkItemId(dr["IcObjectId"].ToString(), dr["Status"].ToString());
                //    var DisplayName = workItemDic["DisplayName"];
                //    dic.Add("contract_state", DisplayName);
                //    dic.Add("ObjectID", dr["ObjectID"].ToString());
                //    ls.Add(dic);
                //    TheNo++;
                //}
            }
        }
        ret.Add("total", dt_totalCount.Rows[0]["count"]);
        ret.Add("rows", ls);
        object JSONObj = JsonConvert.SerializeObject(ret);
        context.Response.ContentType = "application/json";
        context.Response.Write(JSONObj);
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