//using System;
//using System.Data;
//using System.Configuration;
//using System.Collections;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Web.UI.HtmlControls;
//using System.IO;
//using OThinker.H3.DataModel;
//using OThinker.H3.WorkSheet;
//using OThinker.H3.Data;

//namespace OThinker.H3.Portal
//{
//    /// <summary>
//    /// 附件读取页面
//    /// </summary>
//    public partial class ReadAttachment : PortalPage
//    {
//        /// <summary>
//        /// 获取可以直接使用浏览器打开的附件类型
//        /// </summary>
//        protected string Browse_Extension = ".pdf,.jpg,.gif,.jpeg,.png";

//        #region 获取 URL 参数 ---------------------
//        private string _AttachmentID = string.Empty;
//        /// <summary>
//        /// 获取附件ID
//        /// </summary>
//        protected string AttachmentID
//        {
//            get
//            {
//                if (_AttachmentID == string.Empty)
//                {
//                    _AttachmentID = this.Request.QueryString[PortalPage.Param_AttachmentID] + string.Empty;
//                }
//                return _AttachmentID;
//            }
//        }

//        private string _BizObjectSchemaCode = string.Empty;
//        /// <summary>
//        /// 获取数据模型编码
//        /// </summary>
//        protected string BizObjectSchemaCode
//        {
//            get
//            {
//                if (_BizObjectSchemaCode == string.Empty)
//                {
//                    _BizObjectSchemaCode = this.Request.QueryString[PortalPage.Param_SchemaCode] + string.Empty;
//                    _BizObjectSchemaCode = HttpUtility.UrlDecode(_BizObjectSchemaCode);
//                }
//                return _BizObjectSchemaCode;
//            }
//        }

//        private string _BizObjectID = string.Empty;
//        /// <summary>
//        /// 获取数据模型编码
//        /// </summary>
//        protected string BizObjectID
//        {
//            get
//            {
//                if (_BizObjectID == string.Empty)
//                {
//                    _BizObjectID = this.Request.QueryString[PortalPage.Param_BizObjectID] + string.Empty;
//                    _BizObjectID = HttpUtility.UrlDecode(_BizObjectID);
//                }
//                return _BizObjectID;
//            }
//        }

//        /// <summary>
//        /// 获取是否移动办公访问
//        /// </summary>
//        protected bool IsMobile
//        {
//            get
//            {
//                return this.Request.QueryString[WorkSheet.SheetEnviroment.Param_IsMobile] + string.Empty != string.Empty;
//            }
//        }

//        /// <summary>
//        /// 是否是安卓设备
//        /// </summary>
//        protected bool IsAndroid
//        {
//            get
//            {
//                return Request.UserAgent.ToLower().IndexOf("android") >= 0;
//            }
//        }

//        private int openMethod = -1;
//        /// <summary>
//        /// 获取附件的打开方式
//        /// </summary>
//        private int OpenMethod
//        {
//            get
//            {
//                if (openMethod == -1)
//                {
//                    string o = this.Request.QueryString["OpenMethod"] + string.Empty;
//                    if (!int.TryParse(o, out openMethod))
//                    {
//                        openMethod = (int)OThinker.H3.WorkSheet.AttachmentOpenMethod.Download;
//                    }
//                }
//                return openMethod;
//            }
//        }
//        #endregion

//        #region 页面自定义属性 --------------------
//        private string portalUri = string.Empty;
//        /// <summary>
//        /// 获取 Portal 访问的URI路径
//        /// </summary>
//        public string PortalUri
//        {
//            get
//            {
//                if (portalUri == string.Empty)
//                {
//                    portalUri = ConfigurationManager.AppSettings["PortalUri"] + string.Empty;
//                }
//                return portalUri;
//            }
//        }

//        /// <summary>
//        /// 获取当前附件的打开方式
//        /// </summary>
//        private AttachmentOpenMethod AttachmentOpenMethod
//        {
//            get
//            {
//                return (AttachmentOpenMethod)OpenMethod;
//            }
//        }
//        #endregion

//        #region PageLoad事件 ----------------------
//        /// <summary>
//        /// 页面加载事件，获取附件内容
//        /// </summary>
//        /// <param name="sender"></param>
//        /// <param name="e"></param>
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            OThinker.H3.Tracking.UserLog log = null;
//            if (!this.IsPostBack)
//            {
//                // 不支持这个模式
//                //if (AttachmentOpenMethod == WorkSheet.AttachmentOpenMethod.NTKO)
//                //{
//                //    // NTKO 方式打开，转向NTKO附件页面
//                //    Response.Redirect("ReadNTKOAttachment.aspx?AttachmentID=" + AttachmentID + "&" + PortalPage.Param_SchemaCode + "=" + BizObjectSchemaCode);
//                //}

//                //安卓微信中打开文件
//                if (this.IsMobile && IsWeChat && IsAndroid)
//                {
//                    // 记录打开日志
//                    log = new Tracking.UserLog(
//                        Tracking.UserLogType.OpenAttachment,
//                        this.UserValidator.UserID,
//                        this.BizObjectSchemaCode,
//                        this.BizObjectID,
//                        this.BizObjectID,
//                        string.Empty,
//                        string.Empty,
//                        null,
//                        SheetUtility.GetClientIP(Request),
//                        SheetUtility.GetClientPlatform(Request),
//                        SheetUtility.GetClientBrowser(Request));
//                    this.Engine.UserLogWriter.Write(log);

//                    string WeChatViewUrl = this.Engine.WeChatAdapter.GetAttachmentWeChatViewUrl(
//                        this.UserValidator.UserID,
//                        this.BizObjectSchemaCode,
//                        this.BizObjectID,
//                        this.AttachmentID);
//                    if (!string.IsNullOrEmpty(WeChatViewUrl))
//                    {
//                        Response.Redirect(WeChatViewUrl);
//                    }
//                    return;
//                }

//                Attachment attachment = this.Engine.BizObjectManager.GetAttachment(
//                    this.UserValidator.UserID,
//                    this.BizObjectSchemaCode,
//                    this.BizObjectID,
//                    this.AttachmentID);
//                if (attachment == null || attachment.Content == null || attachment.Content.Length == 0)
//                {
//                    AlertAndClose(this.PortalResource.GetString("ReadAttachment_AttachmentIsNull"));
//                    return;
//                }

//                // 记录打开日志
//                log = new Tracking.UserLog(
//                    Tracking.UserLogType.OpenAttachment,
//                    this.UserValidator.UserID,
//                    attachment.BizObjectSchemaCode,
//                    attachment.BizObjectId,
//                    attachment.BizObjectId,
//                    string.Empty,
//                    attachment.FileName,
//                    null,
//                    SheetUtility.GetClientIP(Request),
//                    SheetUtility.GetClientPlatform(Request),
//                    SheetUtility.GetClientBrowser(Request));
//                this.Engine.UserLogWriter.Write(log);

//                if (this.IsMobile)
//                {
//                    // 移动办公打开方式，则先下载到临时文件夹，再输出文件地址
//                    string fileName = attachment.ObjectID + Path.GetExtension(attachment.FileName);
//                    string savePath = Path.Combine(Server.MapPath("TempImages"), fileName);
//                    using (FileStream fs = new FileStream(savePath, FileMode.OpenOrCreate, FileAccess.ReadWrite))
//                    {
//                        using (BinaryWriter bw = new BinaryWriter(fs))
//                        {
//                            bw.Write(attachment.Content);
//                            bw.Close();
//                        }
//                    }
//                    Response.Redirect(Path.Combine(PortalUri, "TempImages/" + fileName));
//                }

//                string inLine = string.Empty;
//                if (Browse_Extension.IndexOf(Path.GetExtension(attachment.FileName).ToLower()) != -1)
//                {
//                    inLine = "inline;";
//                }
//                else
//                {
//                    inLine = "attachment;";
//                }

//                // 输出附件
//                Response.Buffer = true;
//                Response.Clear();
//                Response.ClearContent();
//                Response.ClearHeaders();
//                Response.AddHeader("Content-Disposition", inLine + "filename=" + HttpUtility.UrlEncode(attachment.FileName, System.Text.Encoding.UTF8));
//                Response.AddHeader("Content-Type", attachment.ContentType);
//                Response.AddHeader("Content-Length", attachment.Content.LongLength.ToString());
//                Response.BinaryWrite(attachment.Content);
//                Response.Flush();
//                Response.End();
//            }
//        }
//        #endregion


//    }
//}