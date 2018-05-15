<%@ WebService Language="C#" Class="OThinker.ST.Service.BiddingService" %>

using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
// using System.Web.Mvc;
using OThinker.Data;
using OThinker.Data.Database;
// using OThinker.H3.Configs;
// using OThinker.H3.Instance;
using OThinker.H3.Portal.Entity;
using System.Data;
using System.Text;
using Newtonsoft.Json;
using OThinker.H3;


namespace OThinker.ST.Service
{
    [WebService(Namespace = "http://www.service/stzx")]
    [WebServiceBinding(ConformsTo = WsiProfiles.None)]
    // [System.ComponentModel.ToolboxItem(false)]
    // [System.Web.Script.Services.ScriptService]
    public class BiddingService : System.Web.Services.WebService
    {

        public static void log(String loginfo)
        {
            // StreamWriter log = new StreamWriter("C:\\Authine\\H3 BPM\\Portal\\log.txt", true, System.Text.Encoding.UTF8);
            // try
            // {
                // log.WriteLine(System.DateTime.Now.ToString() + ":" + loginfo);
                // log.WriteLine(loginfo);
            // }
            // catch (IOException e)
            // {
                // Console.WriteLine(e.ToString());
            // }
            // finally
            // {
                // log.Close();
            // }
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

        /// 获得招标自动编号
        /// Scope: 1 - 国际
        ///        2 - 国内
        /// BidType: 1 - 公开招标
        ///          2 - 邀请招标
        ///          3 - 竞争性谈判
        ///          4 - 询价
        /// 返回Json数据
        /// {'code': 'SPIAIE－YQJ－17008'}

        // 国际－公开招标
        // 0681-1740ZBJ17008
        // 0681: 固定
        // 17 ：年份
        // 40 ：固定
        // ZBJ ：国际招标
        // 17：年份
        // 008 ： 同一年份流水号
        //     其他
        // SPIAIE－YQJ－17008
        // SPIAIE：进出口公司简称固定
        // YQ ：招标方式字段。（公开招标 ZB ；邀请招标： YQ ；竞争性谈判： JT ；询价： XJ ）
        // J ：招标范围。（J：国际招标 N：国内招标）
        // 17 ：年份
        // 008 ： 同一年份流水号
        [WebMethod(Description = "招标编号")]
        public void GetBiddingCode(int Scope, int BidType)
        {
            int xuhao = 1;
            
              // 从数据库中获得序号
              string sql = "select SERIAL_NUMBER from I_BiddingCustomCodeProcess ";
              DataTable result = Query.QueryTable(sql);
              if (result.Rows.Count == 0)
              {
                  string insert = "INSERT INTO I_BiddingCustomCodeProcess (ObjectID, SERIAL_NUMBER) VALUES ( '1', 1)";
                  Query.QueryTable(insert);
              }
              else
              {
                  string str = result.Rows[0]["SERIAL_NUMBER"].ToString();
                  xuhao = Int16.Parse(str) + 1;
                  string update = "update I_BiddingCustomCodeProcess set SERIAL_NUMBER=" + xuhao;
                  Query.QueryTable(update);
              }

              string xh = "000" + xuhao;
			  if(xuhao >= 1000) {
				xh = "" + xuhao;
				} else {
					xh = xh.Substring(xh.Length - 3);
				}
              xh = xh.Substring(xh.Length - 3);
              string code = "";
              string y = DateTime.Now.ToString("yy");
              string type = "ZB";
              if(BidType == 1) {
                  type = "ZB";
              } else if(BidType == 2) {
                  type = "YQ";
              } else if(BidType == 3) {
                  type = "JT";
              } else if(BidType == 4) {
                  type = "XJ";
              }
              if(Scope == 1) {
                  code = "0681-" + y + "40" + type + "J" + y + xh;
              } else {
                  code = "SPIAIE-" + type + "N-" + y + xh;
              }
          
            // string json = JsonConvert.SerializeObject(code);
            string json="{\"ContractNo\":\"" + code + "\"}";
            //string json="{\"ContractNo\":\"" +"0681-40" + Scope + "J" + BidType  + "\"}";

            Context.Response.Write(json);
            Context.Response.End();
        }
       [WebMethod(Description = "获取招标编号")]
        public void GetListByBiddingCode(String TenderReference) {
            // 国内合同 
            MainProcessOfProject con = new MainProcessOfProject();
            System.Data.DataTable dt = OThinker.H3.Controllers.AppUtility.Engine.EngineConfig.CommandFactory.CreateCommand().ExecuteDataTable(
                " SELECT ProjectName,PostA,PostB"+
                " ,SubProjectName,ReferredProject,ProjectEngineering," +
                "enum1.EnumValue as ScopeOfBid,enum2.EnumValue as TenderingManner,TenderReference "+
                " FROM I_MainProcessOfProject con"+
                " LEFT JOIN OT_EnumerableMetadata enum1 on con.ScopeOfBid = enum1.Code and enum1.Category = '招标范围' "+
                " LEFT JOIN OT_EnumerableMetadata enum2 on con.TenderingManner = enum2.Code and enum2.Category = '招标方式'"+
                " where con.TenderReference = '"+TenderReference+"'");
            if (dt.Rows.Count > 0)
            {
                con.ProjectName = dt.Rows[0]["ProjectName"].ToString();
                con.SubProjectName = dt.Rows[0]["SubProjectName"].ToString();
                //OThinker.Organization.User ua = Common.getUserById(dt.Rows[0]["PostA"].ToString());
                //OThinker.Organization.User ub = Common.getUserById(dt.Rows[0]["PostB"].ToString());
                con.PostA = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["PostA"].ToString());
                con.PostB = OThinker.H3.Controllers.AppUtility.Engine.Organization.GetName(dt.Rows[0]["PostB"].ToString());
                con.ScopeOfBid = dt.Rows[0]["ScopeOfBid"].ToString();
                con.TenderingManner = dt.Rows[0]["TenderingManner"].ToString();
                con.TenderReference = dt.Rows[0]["TenderReference"].ToString();
               
            }

            object JSONObj = JsonConvert.SerializeObject(con);
            Context.Response.ContentType = "application/json";
            Context.Response.Write(JSONObj);
        }
    }


}