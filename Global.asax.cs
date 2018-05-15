using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using OThinker.H3.Controllers;

namespace OThinker.H3.Portal
{
    /// <summary>
    /// 应用程序配置
    /// </summary>
    public class MvcApplication : System.Web.HttpApplication
    {
        /// <summary>
        /// 全局启动事件
        /// </summary>
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            // 检查是否要启动回收程序
            AppUtility.StartRecycling(this.Server);
            // BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_BeginRequest(Object sender, EventArgs e)
        {
            //输入Portal转向到Index.html页面
            if (Context.Request.FilePath == AppUtility.PortalRoot || Context.Request.FilePath == AppUtility.PortalRoot + "/")
            {
                AppUtility.Engine.LogWriter.Write("Request Path:" + Context.Request.RawUrl);
                Context.Response.Redirect(AppUtility.PortalRoot + "/index.html");
            }
            HttpRequestBase request = new HttpRequestWrapper(this.Context.Request);
            //ajax请求,取消FormsAuthenticationRedirect.
            if(request.IsAjaxRequest()){
                Context.Response.SuppressFormsAuthenticationRedirect = true;
            }
        }

        protected void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.
            if (this.Context == null) return;
            UserValidator userInSession = this.Session[Sessions.GetUserValidator()] as UserValidator;
            if (userInSession != null)
            {
                AppUtility.OnUserLogout(userInSession, this.Request);
            }
        }
    }
}
