//using System;
//using System.Collections.Generic;
//using System.Web;
//using System.Web.UI;
//using System.Threading;
//using System.Globalization;

//namespace OThinker.H3.Portal
//{
//    /// <summary>
//    /// 所有页面的基类
//    /// </summary>
//    public class PortalPage : System.Web.UI.Page
//    {
//        public PortalPage()
//        {
//            this.MaintainScrollPositionOnPostBack = true;
//        }

//        /// <summary>
//        /// 是否展示左边菜单
//        /// </summary>
//        public virtual bool ShowLeftFunctions
//        {
//            get
//            {
//                return true;
//            }
//        }

//        private IEngine _Engine;
//        /// <summary>
//        /// 流程引擎的接口，该接口会比this.Engine的方式更快，因为其中使用了缓存
//        /// </summary>
//        public IEngine Engine
//        {
//            get
//            {
//                if (this._Engine == null)
//                {
//                    this._Engine = new EngineClient(OThinker.H3.Server.Engine);
//                }
//                return this._Engine;
//            }
//        }

//        protected override void OnInit(EventArgs e)
//        {
//            WorkSheet.SheetUtility.InitLang(this.Page);
//            base.OnInit(e);
//        }

//        protected override void OnLoad(EventArgs e)
//        {
//            base.OnLoad(e);

//            if (this.Header != null)
//            {
//                //this.Header.Controls.Add(new LiteralControl(
//                //    "<link href=\"" +
//                //    this.PortalCssRoot +
//                //    "/MainUI.css\" type=\"text/css\" rel=\"stylesheet\" />"));
//            }
//        }

//        public static Acl.UserValidator GetUserValidator(Page Page)
//        {
//            string message = null;
//            Acl.UserValidator user = Portal.UserValidatorFactory.GetUserValidator(Page, PortalPage.GetPortalRoot(Page), out message);
//            if (user == null)
//            {
//                string url = PortalPage.GetNotifyUrl(Page, message);
//                Page.Response.Redirect(url);
//                return null;
//            }
//            else
//            {
//                return user;
//            }
//        }

//        /// <summary>
//        /// 获得根目录地址
//        /// </summary>
//        /// <param name="Page"></param>
//        /// <returns></returns>
//        public static string GetPortalRoot(System.Web.UI.Page Page)
//        {
//            return WorkSheet.SheetUtility.GetPortalRoot(Page);
//        }

//        public static string GetPortalResRoot(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "WFRes");
//        }

//        public static string GetPortalScriptRoot(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalResRoot(Page), "Scripts");
//        }

//        public static string GetPortalFCKEditorRoot(System.Web.UI.Page Page)
//        {
//            return GetPortalResRoot(Page);
//        }

//        public static string GetPortalImageRoot(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalResRoot(Page), "Images").Replace('\\', '/');
//        }

//        public static string GetPortalCssRoot(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalResRoot(Page), "Css").Replace('\\', '/');
//        }

//        /// <summary>
//        /// 不以'/'结尾的形式，比如"/Portal"，或者""表示"/"
//        /// </summary>
//        public string PortalRoot
//        {
//            get
//            {
//                return PortalPage.GetPortalRoot(this.Page);
//            }
//        }

//        protected string PortalResRoot
//        {
//            get
//            {
//                return GetPortalResRoot(this);
//            }
//        }

//        /// <summary>
//        /// 不以'/'结尾的形式，比如"/Portal"，或者""表示"/"
//        /// </summary>
//        public string PortalFCKEditorRoot
//        {
//            get
//            {
//                return GetPortalFCKEditorRoot(this);
//            }
//        }

//        /// <summary>
//        /// 不以'/'结尾的形式，比如"/Portal"，或者""表示"/"
//        /// </summary>
//        public string PortalImageRoot
//        {
//            get
//            {
//                return GetPortalImageRoot(this);
//            }
//        }

//        /// <summary>
//        /// 不以'/'结尾的形式，比如"/Portal"，或者""表示"/"
//        /// </summary>
//        public string PortalCssRoot
//        {
//            get
//            {
//                return GetPortalCssRoot(this);
//            }
//        }

//        public static System.Resources.ResourceManager GetResource(System.Web.UI.Page Page)
//        {
//            return OThinker.H3.Configs.Config.Current.ResourceManager;
//        }

//        public System.Resources.ResourceManager ResourceManager
//        {
//            get
//            {
//                return GetResource(this);
//            }
//        }

//        public System.Resources.ResourceManager PortalResource
//        {
//            get
//            {
//                return DefaultResource;
//            }
//        }

//        public static System.Resources.ResourceManager DefaultResource
//        {
//            get
//            {
//                return Resources.Resource.ResourceManager;
//            }
//        }

//        public const string LackOfAuth = "Not enough authorization";

//        public static string GetLoginUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Login.aspx").Replace('\\', '/');
//        }
//        public static string GetLogoutUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Logout.aspx").Replace('\\', '/');
//        }
//        public static string GetDownloadMobileClientUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "DownloadMobileClient.aspx").Replace('\\', '/');
//        }
//        public static string GetCancelInstanceUrl(System.Web.UI.Page Page, string InstanceId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "CancelInstance.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId;
//        }

//        public static string GetEditCompanyUrl(System.Web.UI.Page Page, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditCompany.aspx").Replace('\\', '/') + "?" + Param_ExpandPath + "=" + ExpandPath;
//        }

//        private const string PageName_EditSegment = "EditSegment.aspx";
//        public static string GetAddSegmentUrl(System.Web.UI.Page Page, string ParentId, string ExpandPath)
//        {
//            return
//                System.IO.Path.Combine(
//                GetPortalRoot(Page), PageName_EditSegment).Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.Add + "&" +
//                PortalPage.Param_Parent + "=" + ParentId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetViewSegmentUrl(System.Web.UI.Page Page, string EditId, string ExpandPath)
//        {
//            return
//                System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditSegment).Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.View + "&" +
//                PortalPage.Param_ID + "=" + EditId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetEditSegmentUrl(System.Web.UI.Page Page, string EditId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditSegment).Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.Admin + "&" +
//                PortalPage.Param_ID + "=" + EditId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        private const string PageName_EditOrgUnit = "EditOrgUnit.aspx";
//        public static string GetAddOrgUnitUrl(System.Web.UI.Page Page, string ParentId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditOrgUnit).Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.Add + "&" +
//                PortalPage.Param_Parent + "=" + ParentId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetViewOrgUnitUrl(System.Web.UI.Page Page, string EditId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditOrgUnit).Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.View + "&" +
//                PortalPage.Param_ID + "=" + EditId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        private const string PageName_EditGroup = "EditGroup.aspx";
//        public static string GetAddGroupUrl(System.Web.UI.Page Page, string ParentId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditGroup).Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.Add + "&" +
//                PortalPage.Param_Parent + "=" + ParentId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetAddGroupChildGroupUrl(System.Web.UI.Page Page, string ParentGroupId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditGroup).Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.Add + "&" +
//                PortalPage.Param_ParentGroup + "=" + ParentGroupId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetCreateGroupsUrl(System.Web.UI.Page Page, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "CreateGroups.aspx").Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.Add + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }
//        public static string GetAddOrgPostUrl(System.Web.UI.Page Page, string ParentId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditOrgPost.aspx").Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.Add + "&" +
//                PortalPage.Param_Parent + "=" + ParentId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetCopyMemberUrl(System.Web.UI.Page Page, string ID, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_CopyMember).Replace('\\', '/') + "?" +
//                PortalPage.Param_ID + "=" + ID + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetViewGroupUrl(System.Web.UI.Page Page, string EditId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditGroup).Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.View + "&" +
//                PortalPage.Param_ID + "=" + EditId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetEditPostUrl(System.Web.UI.Page Page, string EditId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditOrgPost.aspx").Replace('\\', '/') + "?" +
//                PortalPage.Param_Mode + "=" + EditUserType.View + "&" +
//                PortalPage.Param_ID + "=" + EditId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        private const string PageName_EditUser = "EditUser.aspx";
//        public static string GetUserViewUrl(System.Web.UI.Page Page, string UserID, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditUser).Replace('\\', '/') + "?" + Param_Mode + "=" + EditUserType.View + "&" + Param_ID + "=" + UserID + "&" + Param_ExpandPath + "=" + ExpandPath;
//        }

//        private const string Page_EditSegment = "EditSegment.aspx";
//        private const string Page_EditOrgUnit = "EditOrgUnit.aspx";
//        private const string Page_EditOrgPost = "EditOrgPost.aspx";
//        private const string Page_EditGroup = "EditGroup.aspx";
//        public static string GetOrgViewUrl(Page Page, Organization.UnitType unitType, string ID, string PathObjectID)
//        {
//            string page = string.Empty;
//            switch (unitType)
//            {
//                case OThinker.Organization.UnitType.Group:
//                    page = Page_EditGroup;
//                    break;
//                case OThinker.Organization.UnitType.OrganizationUnit:
//                    page = Page_EditOrgUnit;
//                    break;
//                case OThinker.Organization.UnitType.Post:
//                    page = Page_EditOrgPost;
//                    break;
//                case OThinker.Organization.UnitType.Segment:
//                    page = Page_EditSegment;
//                    break;
//            }
//            return System.IO.Path.Combine(GetPortalRoot(Page), page).Replace('\\', '/') + "?" + Param_Mode + "=" + EditUserType.View + "&" + Param_ID + "=" + ID + "&" + Param_ExpandPath + "=" + PathObjectID;
//        }

//        public static string GetUserViewUrl(System.Web.UI.Page Page, string UserID)
//        {
//            return GetUserViewUrl(Page, UserID, null);
//        }

//        public static string GetUserProfileUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditUser).Replace('\\', '/') + "?" + Param_Mode + "=" + EditUserType.Profile;
//        }

//        public static string GetUserAddUrl(System.Web.UI.Page Page, string ParentID, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditUser).Replace('\\', '/') + "?" + Param_Mode + "=" + EditUserType.Add + "&" + Param_Parent + "=" + ParentID + "&" + Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetUserAddUrl(System.Web.UI.Page Page, string ParentID, string ADPath, string ADUser, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditUser).Replace('\\', '/') + "?" +
//                Param_Mode + "=" + EditUserType.Add + "&" +
//                Param_Parent + "=" + ParentID + "&" +
//                Param_ExpandPath + "=" + ExpandPath + "&" +
//                Param_ADPath + "=" + HttpUtility.UrlEncode(ADPath) + "&" +
//                Param_ADUser + "=" + ADUser;
//        }

//        public static string GetEditPageName(IEngine Engine, System.Web.UI.Page Page, string ID, string ExpandPath)
//        {
//            OThinker.Organization.Unit unit;
//            if (ID == null || ID == "")
//            {
//                unit = null;
//            }
//            else
//            {
//                unit = Engine.Organization.GetUnit(ID);
//            }
//            if (unit == null)
//            {
//                return GetEditCompanyUrl(Page, ExpandPath);
//            }
//            else
//            {
//                return GetEditPageName(Page, unit.UnitType, ID, ExpandPath);
//            }
//        }

//        public static string GetEditPageName(System.Web.UI.Page Page, OThinker.Organization.UnitType UnitType, string ID, string ExpandPath)
//        {
//            switch (UnitType)
//            {
//                case OThinker.Organization.UnitType.Company:
//                    return GetEditCompanyUrl(Page, ExpandPath);
//                case OThinker.Organization.UnitType.Segment:
//                    return GetEditSegmentUrl(Page, ID, ExpandPath);
//                case OThinker.Organization.UnitType.OrganizationUnit:
//                    return GetViewOrgUnitUrl(Page, ID, ExpandPath);
//                case Organization.UnitType.Post:
//                    return GetViewGroupUrl(Page, ID, ExpandPath);
//                case OThinker.Organization.UnitType.Group:
//                    return GetViewGroupUrl(Page, ID, ExpandPath);
//                case OThinker.Organization.UnitType.User:
//                    return GetUserViewUrl(Page, ID, ExpandPath);
//                default:
//                    throw new NotImplementedException();
//            }
//        }

//        public static string GetSetPasswordUrl(System.Web.UI.Page Page, EditUserType EditType, string UserId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "SetPassword.aspx").Replace('\\', '/') + "?" +
//                Param_Mode + "=" + EditType + "&" + Param_ID + "=" + UserId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetEditSignatureUrl(System.Web.UI.Page Page, EditUserType EditType, string UserId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditSignature.aspx").Replace('\\', '/') + "?" +
//                Param_Mode + "=" + EditType + "&" + Param_UserID + "=" + UserId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetFunctionAclByUnitUrl(System.Web.UI.Page Page, string UserId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "FunctionAclByUnit.aspx").Replace('\\', '/') + "?" + Param_ID + "=" + UserId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetTransferUserUrl(System.Web.UI.Page Page, string UserId, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "TransferUser.aspx").Replace('\\', '/') + "?" + Param_ID + "=" + UserId + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        private const string PageName_SyncAD = "SyncAD.aspx";
//        public static string GetSyncADUrl(System.Web.UI.Page Page, string ParentID, string PreviousUrl, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_SyncAD).Replace('\\', '/') + "?" +
//                PortalPage.Param_Parent + "=" + ParentID + "&" +
//                PortalPage.Param_Q + "=" + System.Web.HttpUtility.UrlEncode(PreviousUrl) + "&" +
//                PortalPage.Param_ExpandPath + "=" + ExpandPath;
//        }

//        public static string GetEditTitle(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditTitle.aspx").Replace('\\', '/');
//        }

//        public static string GetEditCategory(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditCategory.aspx").Replace('\\', '/');
//        }

//        public static string GetListOrgJob(System.Web.UI.Page Page, string ExpandPath)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "ListOrgJob.aspx").Replace('\\', '/') + "?" + Param_ExpandPath + "=" + HttpUtility.UrlEncode(ExpandPath);
//        }

//        public static string GetEditOrgJob(System.Web.UI.Page Page, string Code)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditOrgJob.aspx").Replace('\\', '/') + "?" + Param_Code + "=" + HttpUtility.UrlEncode(Code);
//        }

//        public static string GetQueryOriganizationUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryOriganization.aspx").Replace('\\', '/');
//        }

//        public static string GetQueryUserUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryUser.aspx").Replace('\\', '/');
//        }

//        public static string GetQueryMyInstanceUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryMyInstance.aspx").Replace('\\', '/');
//        }

//        public static string GetEnableFullTextIndexUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EnableFullTextIndex.aspx").Replace('\\', '/');
//        }

//        public static string GetInstanceChartUrl(System.Web.UI.Page Page, string InstanceId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "InstanceChart.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId;
//        }

//        public static string GetEditInstanceDataItemUrl(System.Web.UI.Page Page, string InstanceId, string ItemName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditInstanceDataItem.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId + "&" + Param_ItemName + "=" + System.Web.HttpUtility.UrlEncode(ItemName);
//        }

//        public static string GetInstanceUrl(System.Web.UI.Page Page, string InstanceId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "InstanceDetail.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId;
//        }
//        public static string GetExceptionDetailUrl(System.Web.UI.Page Page, string ExceptionID)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "ExceptionDetail.aspx").Replace('\\', '/') + "?" + PortalPage.Param_ExceptionID + "=" + ExceptionID;
//        }
//        public static string GetFunctionAclUrl(System.Web.UI.Page Page, string FunctionCode)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "FunctionAcl.aspx").Replace('\\', '/') + "?" + PortalPage.Param_FunctionCode + "=" + FunctionCode;
//        }

//        // public static string PageName_QueryException = "QueryException.aspx";
//        public static string GetWorkflowSettingUrl(System.Web.UI.Page Page, string WorkflowPackage)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "WorkflowSetting.aspx").Replace('\\', '/') + "?" + Param_WorkflowPackage + "=" + System.Web.HttpUtility.UrlEncode(WorkflowPackage);
//        }
//        public static string GetWorkflowOrgAclUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "WorkflowOrgAcl.aspx").Replace('\\', '/') + "?" + Param_WorkflowPackage + "=" + System.Web.HttpUtility.UrlEncode(WorkflowPackage) + "&" + Param_WorkflowName + "=" + System.Web.HttpUtility.UrlEncode(WorkflowName);
//        }
//        public static string GetUpdateWorkflowAclUrl(System.Web.UI.Page Page, string AclId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UpdateWorkflowAcl.aspx").Replace('\\', '/') + "?" + Param_AclID + "=" + AclId;
//        }

//        public static string GetUpdateWorkflowAclUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UpdateWorkflowAcl.aspx").Replace('\\', '/') + "?" +
//                    PortalPage.Param_WorkflowPackage + "=" + System.Web.HttpUtility.UrlEncode(WorkflowPackage) + "&" +
//                    PortalPage.Param_WorkflowName + "=" + System.Web.HttpUtility.UrlEncode(WorkflowName);
//        }

//        public static string GetUpdateWorkflowOrgAclUrl(System.Web.UI.Page Page, string AclId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UpdateWorkflowOrgAcl.aspx").Replace('\\', '/') + "?" + Param_AclID + "=" + AclId;
//        }

//        public static string GetUpdateWorkflowOrgAclUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UpdateWorkflowOrgAcl.aspx").Replace('\\', '/') + "?" +
//                    PortalPage.Param_WorkflowPackage + "=" + System.Web.HttpUtility.UrlEncode(WorkflowPackage) + "&" +
//                    PortalPage.Param_WorkflowName + "=" + System.Web.HttpUtility.UrlEncode(WorkflowName);
//        }

//        public static string GetUpdateSystemAclUrl(System.Web.UI.Page Page, string AclId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UpdateSystemAcl.aspx").Replace('\\', '/') + "?" + Param_AclID + "=" + AclId;
//        }

//        public static string GetUpdateSystemAclUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UpdateSystemAcl.aspx").Replace('\\', '/');
//        }

//        public static string GetUpdateSystemOrgAclUrl(System.Web.UI.Page Page, string AclId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UpdateSystemOrgAcl.aspx").Replace('\\', '/') + "?" + Param_AclID + "=" + AclId;
//        }

//        public static string GetUpdateSystemOrgAclUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UpdateSystemOrgAcl.aspx").Replace('\\', '/');
//        }

//        public static string GetInstanceDataTrackUrl(System.Web.UI.Page Page, string InstanceId, string ItemName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "InstanceDataTrack.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId + "&" + Param_ItemName + "=" + System.Web.HttpUtility.UrlEncode(ItemName);
//        }
//        public static string GetSettingsUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Settings.aspx").Replace('\\', '/');
//        }
//        public static string GetSettings_OrgUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Settings_Org.aspx").Replace('\\', '/');
//        }
//        public static string GetSettings_DisplayUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Settings_Display.aspx").Replace('\\', '/');
//        }
//        public static string GetSettings_SPUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Settings_SP.aspx").Replace('\\', '/');
//        }
//        public static string GetSettings_NotificationContentUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Settings_NotificationContent.aspx").Replace('\\', '/');
//        }
//        public static string GetSettings_NotificationMethodUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Settings_NotificationMethod.aspx").Replace('\\', '/');
//        }
//        public static string GetSettings_StateNameUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Settings_StateName.aspx").Replace('\\', '/');
//        }
//        public static string GetSettings_MobileNameUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "Settings_Mobile.aspx").Replace('\\', '/');
//        }
//        public static string GetMyWorkflowUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "MyWorkflow.aspx").Replace('\\', '/');
//        }

//        public static string GetStartInstanceByAgent(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "StartInstanceByAgent.aspx").Replace('\\', '/');
//        }

//        public static string GetDesignWorkflowUrl(System.Web.UI.Page Page, string FileName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "DesignWorkflow.aspx").Replace('\\', '/') + "?FileName=" + System.Web.HttpUtility.UrlEncode(FileName);
//        }
//        public static string GetMyInstanceUrl(System.Web.UI.Page Page, OThinker.H3.Instance.InstanceState State)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "MyInstance.aspx").Replace('\\', '/') + "?" + Param_State + "=" + State;
//        }
//        public static string GetMyWorkItemUrl(System.Web.UI.Page Page, OThinker.H3.WorkItem.WorkItemState State)
//        {
//            if (State == WorkItem.WorkItemState.Unfinished)
//            {
//                return System.IO.Path.Combine(GetPortalRoot(Page), "MyUnfinishedWorkItem.aspx").Replace('\\', '/');
//            }
//            else if (State == WorkItem.WorkItemState.Finished)
//            {
//                return System.IO.Path.Combine(GetPortalRoot(Page), "MyFinishedWorkItem.aspx").Replace('\\', '/');
//            }
//            else
//            {
//                return System.IO.Path.Combine(GetPortalRoot(Page), "MyWorkItem.aspx").Replace('\\', '/') + "?" + Param_State + "=" + State;
//            }
//        }
//        public static string GetInstanceData(System.Web.UI.Page Page, string InstanceId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "InstanceData.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId;
//        }
//        public static string GetInstanceUserLog(System.Web.UI.Page Page, string InstanceId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "InstanceUserLog.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId;
//        }
//        public static string GetInstanceSheets(System.Web.UI.Page Page, string InstanceId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "InstanceSheets.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId;
//        }
//        public static string GetEditFunctionCategoryUrl(System.Web.UI.Page Page, string CategoryId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditFunctionCategory.aspx").Replace('\\', '/') + (string.IsNullOrEmpty(CategoryId) ? null : ("?" + Param_ID + "=" + CategoryId));
//        }

//        public static string GetQueryFunctionCategoryUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryFunctionCategory.aspx").Replace('\\', '/');
//        }
//        public const string Param_CategoryCode = "CategoryCode";
//        public static string GetEditFunctionUrl(System.Web.UI.Page Page, string CategoryCode, string FunctionId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditFunction.aspx").Replace('\\', '/') + "?" + Param_CategoryCode + "=" + HttpUtility.UrlEncode(CategoryCode) + (string.IsNullOrEmpty(FunctionId) ? null : ("&" + Param_ID + "=" + FunctionId));
//        }

//        public const string Param_Code = "Code";
//        public static string GetListFileServerUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "ListFileServer.aspx").Replace('\\', '/');
//        }

//        public static string GetEditFileServerUrl(System.Web.UI.Page Page, string FileServerCode)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditFileServer.aspx").Replace('\\', '/') + "?" + Param_Code + "=" + FileServerCode;
//        }

//        public static string GetEditFileStoragePolicyUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditFileStoragePolicy.aspx").Replace('\\', '/') + "?" + Param_WorkflowPackage + "=" + HttpUtility.UrlEncode(WorkflowPackage) + "&" + Param_WorkflowName + "=" + HttpUtility.UrlEncode(WorkflowName);
//        }

//        private const string PageName_EditForm = "EditForm.aspx";
//        public static string GetEditFormUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName, int WorkflowVersion)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditForm).Replace('\\', '/') + "?" +
//                Param_EditMode + "=" + EditModeType.Import + "&" +
//                Param_WorkflowPackage + "=" + System.Web.HttpUtility.UrlEncode(WorkflowPackage) + "&" +
//                Param_WorkflowName + "=" + System.Web.HttpUtility.UrlEncode(WorkflowName) + "&" +
//                Param_WorkflowVersion + "=" + WorkflowVersion;
//        }

//        public static string GetEditFormUrl(System.Web.UI.Page Page, string FormName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditForm).Replace('\\', '/') + "?" +
//                Param_EditMode + "=" + EditModeType.Edit + "&" +
//                Param_FormName + "=" + System.Web.HttpUtility.UrlEncode(FormName);
//        }


//        public static string GetCategoryDetail(System.Web.UI.Page Page, string Code)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "CategoryDetail.aspx").Replace('\\', '/') + "?Id=" + HttpUtility.UrlEncode(Code);
//        }

//        public static string GetEditFormUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), PageName_EditForm).Replace('\\', '/') + "?" + Param_EditMode + "=" + EditModeType.Create;
//        }
//        public static string GetStartInstanceUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName, int WorkflowVersion)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "StartInstance.aspx").Replace('\\', '/') + "?" +
//                                PortalPage.Param_WorkflowPackage + "=" + System.Web.HttpUtility.UrlEncode(WorkflowPackage) + "&" +
//                                PortalPage.Param_WorkflowName + "=" + System.Web.HttpUtility.UrlEncode(WorkflowName) + "&" +
//                                PortalPage.Param_WorkflowVersion + "=" + WorkflowVersion + "&";
//        }

//        public static string GetStartInstanceUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName, Dictionary<string, object> Parameters)
//        {
//            System.Text.StringBuilder builder = new System.Text.StringBuilder();
//            if (Parameters != null)
//            {
//                foreach (string paramName in Parameters.Keys)
//                {
//                    if (builder.Length != 0)
//                    {
//                        builder.Append("&");
//                    }
//                    object paramValue = Parameters[paramName];
//                    if (paramValue != null)
//                    {
//                        builder.Append(paramName + "=" + System.Web.HttpUtility.UrlEncode(paramValue.ToString()));
//                    }
//                }
//            }
//            return System.IO.Path.Combine(GetPortalRoot(Page), "StartInstance.aspx").Replace('\\', '/') +
//                    "?" + PortalPage.Param_WorkflowPackage + "=" + System.Web.HttpUtility.UrlEncode(WorkflowPackage) +
//                    "&" + PortalPage.Param_WorkflowName + "=" + System.Web.HttpUtility.UrlEncode(WorkflowName) +
//                    ((builder.Length == 0) ? null : ("&" + builder.ToString()));
//        }

//        public static string GetStartInstanceSpsAddress(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "StartInstanceSps.aspx").Replace('\\', '/');
//        }
//        public static string GetSystemAclUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "SystemAcl.aspx").Replace('\\', '/');
//        }
//        public static string GetSystemOrgAclUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "SystemOrgAcl.aspx").Replace('\\', '/');
//        }
//        public static string GetWorkflowInfoUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName, int WorkflowVersion)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "WorkflowInfo.aspx").Replace('\\', '/') + "?" +
//                                PortalPage.Param_WorkflowPackage + "=" + System.Web.HttpUtility.UrlEncode(WorkflowPackage) + "&" +
//                                PortalPage.Param_WorkflowName + "=" + System.Web.HttpUtility.UrlEncode(WorkflowName) + "&" +
//                                PortalPage.Param_WorkflowVersion + "=" + WorkflowVersion;
//        }

//        /// <summary>
//        /// 获取附件打开的链接地址
//        /// </summary>
//        /// <param name="Page"></param>
//        /// <param name="workflowPackage"></param>
//        /// <param name="workflowName"></param>
//        /// <param name="AttachmentID"></param>
//        /// <param name="openType"></param>
//        /// <returns></returns>
//        public static string GetReadAttachmentUrl(System.Web.UI.Page Page, string workflowPackage, string workflowName, string AttachmentID, string openType)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "ReadAttachment.aspx").Replace('\\', '/') + "?" + Param_AttachmentID + "=" + AttachmentID + "&WorkflowPackage=" + HttpUtility.UrlEncode(workflowPackage) + "&WorkflowName=" + HttpUtility.UrlEncode(workflowName) + "&OpenMethod=" + openType;
//        }

//        /// <summary>
//        /// 获取附件打开的链接地址
//        /// </summary>
//        /// <param name="Page"></param>
//        /// <param name="workflowPackage"></param>
//        /// <param name="workflowName"></param>
//        /// <param name="AttachmentID"></param>
//        /// <returns></returns>
//        public static string GetReadAttachmentUrl(System.Web.UI.Page Page, string workflowPackage, string workflowName, string AttachmentID)
//        {
//            return GetReadAttachmentUrl(Page, workflowPackage, workflowName, AttachmentID, "1");
//        }

//        public static string GetOrgLogUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryOrgLog.aspx").Replace('\\', '/');
//        }

//        public static string GetListBapiUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "BizBus/" + "ListBapi.aspx").Replace('\\', '/');
//        }

//        public static string GetListTransactionUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "BizBus/" + "ListTransaction.aspx").Replace('\\', '/');
//        }

//        public static string GetEditEnvLib(System.Web.UI.Page Page, string EnvLibId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "BizBus/" + "EditEnvLib.aspx").Replace('\\', '/') + "?" + Param_Code + "=" + EnvLibId;
//        }

//        public static string GetListEnvLib(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "BizBus/" + "ListEnvLib.aspx").Replace('\\', '/');
//        }

//        public static string GetListBizAccountCategoryUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "BizBus/" + "ListBizAccountCategory.aspx").Replace('\\', '/');
//        }

//        public static string GetEditBizAccountCategoryUrl(System.Web.UI.Page Page, string CategoryCode)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "BizBus/" + "EditBizAccountCategory.aspx").Replace('\\', '/') + "?" + Param_Code + "=" + HttpUtility.UrlEncode(CategoryCode);
//        }

//        public static string GetCreateBizAccountMappingUrl(System.Web.UI.Page Page, string CategoryCode)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "BizBus/" + "EditBizAccountMapping.aspx").Replace('\\', '/') + "?" + Param_Code + "=" + HttpUtility.UrlEncode(CategoryCode);
//        }

//        public static string GetEditBizAccountMappingUrl(System.Web.UI.Page Page, string MappingId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "BizBus/" + "EditBizAccountMapping.aspx").Replace('\\', '/') + "?" + Param_ID + "=" + HttpUtility.UrlEncode(MappingId);
//        }

//        public static string GetAdjustActivity(System.Web.UI.Page Page, string InstanceId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "AdjustActivity.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId;
//        }
//        public static string GetQueryFormUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryForm.aspx").Replace('\\', '/');
//        }
//        public static string GetQueryInstanceByData(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryInstanceByData.aspx").Replace('\\', '/');
//        }
//        public static string GetQueryInstanceByProperty(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryInstanceByProperty.aspx").Replace('\\', '/');
//        }
//        public static string GetQueryInstanceByID(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryInstanceByID.aspx").Replace('\\', '/');
//        }
//        public static string GetEditWorkflowMapUrl(System.Web.UI.Page Page, string MapID)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditWorkflowMap.aspx").Replace('\\', '/') + "?" + Param_ID + "=" + MapID;
//        }
//        public static string GetWorkflowTemplateSettingUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "WorkflowTemplateSetting.aspx").Replace('\\', '/') + "?" + Param_WorkflowPackage + "=" + HttpUtility.UrlEncode(WorkflowPackage) + "&" + Param_WorkflowName + "=" + HttpUtility.UrlEncode(WorkflowName);
//        }
//        public static string GetEditClauseDataItemUrl(System.Web.UI.Page Page, string WorkflowPackage, string WorkflowName, string ColumnName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditClauseDataItem.aspx").Replace('\\', '/') + "?" +
//                Param_WorkflowPackage + "=" + HttpUtility.UrlEncode(WorkflowPackage) + "&" +
//                Param_WorkflowName + "=" + HttpUtility.UrlEncode(WorkflowName) + "&" +
//                Param_ItemName + "=" + HttpUtility.UrlEncode(ColumnName);
//        }

//        public static string GetEditWorkflowMapUrl(System.Web.UI.Page Page, string SpsSite, string SpsWebName, string SpsList)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditWorkflowMap.aspx").Replace('\\', '/') + "?" +
//                Instance.InstanceContext.PropertyName_SpsSite + "=" + System.Web.HttpUtility.UrlEncode(SpsSite) + "&" +
//                Instance.InstanceContext.PropertyName_SpsWebName + "=" + System.Web.HttpUtility.UrlEncode(SpsWebName) + "&" +
//                Instance.InstanceContext.PropertyName_SpsList + "=" + System.Web.HttpUtility.UrlEncode(SpsList);
//        }

//        public static string GetConvertWorkflowDocUrl(System.Web.UI.Page Page, string FileName)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "ConvertWorkflowDoc.aspx").Replace('\\', '/') + "?" + Param_FileName + "=" + System.Web.HttpUtility.UrlEncode(FileName);
//        }

//        public static string GetSelectUserImageUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalImageRoot(Page), "p_Add.gif").Replace('\\', '/');
//        }

//        public static string GetRemoveUserImageUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalImageRoot(Page), "p_Del.gif").Replace('\\', '/');
//        }

//        public static string GetPriorityImageUrl(System.Web.UI.Page Page, OThinker.H3.Instance.PriorityType Priority)
//        {
//            return System.IO.Path.Combine(GetPortalImageRoot(Page), "Priority_" + Priority + ".gif").Replace('\\', '/');
//        }

//        public static string GetWorkflowImageUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalImageRoot(Page), "ib_workflow.ico").Replace('\\', '/');
//        }

//        public static string GetQueryUrgencyUrl(System.Web.UI.Page Page, string WorkItemId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryUrgency.aspx").Replace('\\', '/') + "?" + Param_WorkItemID + "=" + WorkItemId;
//        }

//        public static string GetUrgeInstanceUrl(System.Web.UI.Page Page, string InstanceId)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "UrgeInstance.aspx").Replace('\\', '/') + "?" + Param_InstanceId + "=" + InstanceId;
//        }

//        public static string GetUrgencyImageUrl(System.Web.UI.Page Page, bool Urged)
//        {
//            if (Urged)
//            {
//                return System.IO.Path.Combine(GetPortalImageRoot(Page), "cui_a.jpg").Replace('\\', '/');
//            }
//            else
//            {
//                return System.IO.Path.Combine(GetPortalImageRoot(Page), "cui_b.jpg").Replace('\\', '/');
//            }
//        }
//        public static string GetApprovalImageUrl(System.Web.UI.Page Page, OThinker.Data.BoolMatchValue Approval)
//        {
//            if (Approval == OThinker.Data.BoolMatchValue.True)
//            {
//                return System.IO.Path.Combine(GetPortalImageRoot(Page), "yes.gif").Replace('\\', '/');
//            }
//            else if (Approval == OThinker.Data.BoolMatchValue.False)
//            {
//                return System.IO.Path.Combine(GetPortalImageRoot(Page), "no.gif").Replace('\\', '/');
//            }
//            else
//            {
//                return null;
//            }
//        }
//        public static string GetSetColumnPropertyUrl(System.Web.UI.WebControls.WebControl Control)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Control.Page), "SetColumnProperty.aspx").Replace('\\', '/') + "?" +
//                Param_LocalPath + "=" + System.Web.HttpUtility.UrlEncode(Control.Page.Request.Url.LocalPath) + "&" +
//                Param_ControlID + "=" + System.Web.HttpUtility.UrlEncode(Control.ID);
//        }
//        public static string GetRemoveImageUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalImageRoot(Page), "remove.gif").Replace('\\', '/');
//        }
//        public static string GetNotifyMessageUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "NotifyMessage.aspx").Replace('\\', '/');
//        }

//        public static string GetNotifyUrl(System.Web.UI.Page Page, string Message)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "NotifyMessage.aspx").Replace('\\', '/') + "?" + Param_Message + "=" + System.Web.HttpUtility.UrlEncode(Message);
//        }

//        /// <summary>
//        /// 
//        /// </summary>
//        /// <param name="Page"></param>
//        /// <param name="AgencyID"></param>
//        /// <param name="Mode">1: 表示编辑自己的委托；2: 表示编辑整个系统内的委托</param>
//        /// <returns></returns>
//        public static string GetEditAgencyUrl(System.Web.UI.Page Page, string AgencyID, int Mode)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "EditAgency.aspx").Replace('\\', '/') + "?" +
//                Param_Mode + "=" + Mode +
//                (AgencyID == null ? null : ("&" + Param_AgencyID + "=" + AgencyID));
//        }

//        public static string GetMyAgencyUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "MyAgents.aspx").Replace('\\', '/');
//        }

//        public static string GetQueryAgentUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "QueryAgent.aspx").Replace('\\', '/');
//        }

//        public static string GetSelectUserUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "SelectUser.aspx").Replace('\\', '/');
//        }

//        public const string Param_ExpandPath = "ExpandPath";
//        public const string Param_Q = "q";
//        public const string Param_LocalPath = "LocalPath";
//        public const string Param_PageAction = "PageAction";
//        public const string Param_PageActionParam = "PageActionParam";
//        public enum PageActionType
//        {
//            None,
//            Redirect,
//            Close,
//            RunScript
//        }

//        /// <summary>
//        /// 创建一个链接。这个链接会更具链接的类型而自动生成一段脚本，在用户提交后，自动执行该脚本
//        /// </summary>
//        /// <param name="Type"></param>
//        /// <param name="Text"></param>
//        /// <param name="Url"></param>
//        /// <returns></returns>
//        public static System.Web.UI.WebControls.HyperLink CreateHyperLink(System.Web.UI.Page Page, Settings.LinkType Type, string Text, string Url)
//        {
//            System.Web.UI.WebControls.HyperLink link = new System.Web.UI.WebControls.HyperLink();
//            FormatHyperLink(link, Page, Type, Text, Url);
//            return link;
//        }

//        public static void FormatHyperLink(System.Web.UI.WebControls.HyperLink link, System.Web.UI.Page Page, Settings.LinkType Type, string Text, string Url)
//        {
//            link.Text = Text;
//            // link.Font.Underline = true;

//            string baseUrl = null;
//            if (Url == null)
//            {
//                return;
//            }
//            if (Url.LastIndexOf("?") == -1)
//            {
//                // url的形式应该是http://.../page1.aspx
//                baseUrl = Url + "?";
//            }
//            else if (Url.LastIndexOf("?") == Url.Length - 1 ||
//                Url.LastIndexOf("&") == Url.Length - 1)
//            {
//                // url的形式应该是http://.../page1.aspx?
//                // url的形式应该是http://.../page1.aspx?param1=value1&
//                baseUrl = Url;
//            }
//            else
//            {
//                // url的形式应该是http://.../page1.aspx?param1=value1
//                baseUrl = Url + "&";
//            }

//            switch (Type)
//            {
//                case Settings.LinkType.Popup:
//                    link.Target = "_blank";
//                    link.NavigateUrl = baseUrl;
//                    break;
//                case Settings.LinkType.PopupCloseRefreshParent:
//                    link.Target = "_blank"; // HuangJie 2010-11-1 修改 JS 防止刷新父窗体时弹出 “不重新发送信息，则无法刷新网页” 对话框
//                    link.NavigateUrl =
//                        baseUrl + "&" +
//                        PortalPage.Param_PageAction + "=" + PortalPage.PageActionType.RunScript + "&" +
//                        PortalPage.Param_PageActionParam + "=" + HttpUtility.UrlEncode("window.opener.location.href=window.opener.location.href;window.opener=null;window.open(\"\",\"_self\");window.close();");
//                    break;
//                case Settings.LinkType.Return:
//                    link.NavigateUrl =
//                        baseUrl + "&" +
//                        PortalPage.Param_PageAction + "=" + PortalPage.PageActionType.RunScript + "&" +
//                        PortalPage.Param_PageActionParam + "=" + HttpUtility.UrlEncode("window.location='" + Page.Request.Url.ToString() + "';");
//                    break;
//                case Settings.LinkType.PopupClose:
//                case Settings.LinkType.None:
//                case Settings.LinkType.Unspecified:
//                default:
//                    link.Target = "_blank";
//                    link.NavigateUrl = baseUrl + "&" + PortalPage.Param_PageAction + "=" + PortalPage.PageActionType.Close;
//                    break;
//            }
//            link.CssClass = "linkItem";
//        }

//        public const string Param_Keyword = "Keyword";
//        public const string PageName_CopyMember = "CopyMember.aspx";
//        public const string Param_HighlightDirItemId = "HighlightDirItemId";
//        public const string Param_AttachmentID = "AttachmentID";
//        public const string Param_UnitType = "UnitType";
//        public const string Param_StartSelectableLevel = "StartSelectableLevel";
//        public const string Param_EndSelectableLevel = "EndSelectableLevel";
//        public const string Param_ExpandToLevel = "ExpandToLevel";
//        public const string Param_VisibleUnitType = "VisibleUnitType";
//        public const string Param_VisibleType = "VisibleType";
//        public const string Param_VisibleUnits = "VisibleUnits";
//        public const string Param_BaseUnits = "BaseUnits";
//        public const string Param_RoleName = "RoleName";
//        public const string Param_VisibleCategories = "VisibleCategories";
//        public const string Param_CategoryCodes = "CategoryCodes";
//        public const string Param_ActionName = "ActionName";
//        public const string Param_ActionEventType = "ActionEventType";
//        public const string Param_ActionButtonType = "ActionButtonType";
//        public const string Param_Priority = "Priority";
//        public const string Param_LeastRecurrences = "LeastRecurrences";
//        public const string Param_OptionalRecipients = "OptionalRecipients";
//        public const string Param_TrackID = "TrackID";
//        public const string Param_TextBoxID = "TextBoxID";
//        public const string Param_ControlID = "ControlID";
//        public const string Param_SelectMode = "Mode";
//        // 委托人
//        public const string Param_Delegant = "Delegant";
//        public const string Param_AgencyID = "AgencyID";
//        // 被委托人
//        public const string Param_Delegatee = "Delegatee";
//        public const string Param_Message = "Message";
//        public const string Param_Mode = "Mode";
//        public const string Param_State = "State";
//        public const string Param_ItemName = "ItemName";
//        public const string Param_InstanceId = "InstanceId";
//        public const string Param_InstanceName = "InstanceName";
//        public const string Param_WorkflowPackage = "WorkflowPackage";
//        public const string Param_WorkflowName = "WorkflowName";
//        public const string Param_WorkflowVersion = "WorkflowVersion";
//        public const string Param_ExceptionID = "ExceptionID";
//        public const string Param_AclID = "AclID";
//        public const string Param_FunctionCode = "FunctionCode";
//        public const string Param_Alias = "Alias";
//        public const string Param_From = "From";
//        public const string Param_To = "To";
//        public const string Param_Elapsed = "Elapsed";
//        public const string Param_EstimatedElapsed = "EstimatedElapsed";
//        // 工作项ID
//        public const string Param_WorkItemID = "WorkItemID";
//        public const string Param_WorkItemType = "WorkItemType";
//        // 目的活动
//        public const string Param_DestActivityName = "DestActivityName";
//        // 是否同意
//        public const string Param_Approval = "Approval";
//        public const string Param_Comment = "Comment";
//        public const string Param_ParticipateGroup = "ParticipateGroup";
//        public const string Param_ParticipatePost = "ParticipatePost";
//        public const string Param_DestParticipantType = "DestParticipantType";

//        // 是否是创建
//        public const string Param_EditMode = "EditMode";
//        public enum EditModeType
//        {
//            Create,
//            Edit,
//            Import
//        }
//        // 编辑的表单的名称
//        public const string Param_FormName = "FormName";
//        public const string Param_FileName = "FileName";
//        // 用户名
//        public const string Param_UserID = "UserID";
//        public const string Param_ID = "ID";
//        public const string Param_ADUser = "ADUser";
//        public const string Param_ADPath = "ADPath";
//        public const string Param_Parent = "Parent";
//        public const string Param_ParentGroup = "ParentGroup";
//        public const string Param_OriginateRole = "OriginateRole";

//        /// <summary>
//        /// 获得某一个表单的某一种操作对应的URL
//        /// </summary>
//        /// <param name="Page"></param>
//        /// <param name="Sheet"></param>
//        /// <param name="InstanceId"></param>
//        /// <param name="SheetMode">必须是View或者Print模式之一</param>
//        /// <param name="LoginName"></param>
//        /// <param name="LoginPassword"></param>
//        /// <returns></returns>
//        public static string GetViewSheetUrl(System.Web.UI.Page Page, WorkflowTemplate.WorkflowSheet Sheet, string InstanceId, OThinker.H3.WorkSheet.SheetMode SheetMode, string LoginName, string LoginPassword)
//        {
//            if (Sheet == null)
//            {
//                return null;
//            }
//            else
//            {
//                string baseUrl = GetSheetBaseUrl(Page, Sheet.SheetType, Sheet.SheetAddress);
//                string url = baseUrl +
//                    OThinker.H3.WorkSheet.SheetEnviroment.Param_Mode + "=" + SheetMode.ToString() + "&" +
//                    OThinker.H3.WorkSheet.SheetEnviroment.Param_InstanceId + "=" + InstanceId + "&" +
//                    OThinker.H3.WorkSheet.SheetEnviroment.Param_LoginName + "=" + System.Web.HttpUtility.UrlEncode(LoginName) + "&" +
//                    OThinker.H3.WorkSheet.SheetEnviroment.Param_LoginPassword + "=" + System.Web.HttpUtility.UrlEncode(LoginPassword);
//                // 检查Url是否是绝对路径
//                if (url.IndexOf("/") == 0)
//                {
//                    // 是绝对路径
//                }
//                else
//                {
//                    // 获得绝对路径
//                    string localPath = Page.Request.Url.LocalPath;
//                    int lastIndex = localPath.LastIndexOf("/");
//                    string folder = null;
//                    if (lastIndex == -1)
//                    {
//                        folder = null;
//                    }
//                    else if (lastIndex == 0)
//                    {
//                        folder = "/";
//                    }
//                    else
//                    {
//                        folder = localPath.Substring(0, lastIndex) + "/";
//                    }
//                    url = folder + url;
//                }

//                return url;
//            }
//        }

//        /// <summary>
//        /// 获得表单URL
//        /// </summary>
//        /// <param name="Page"></param>
//        /// <param name="WorkItem"></param>
//        /// <param name="SheetMode">必须是View或者Print模式之一</param>
//        /// <param name="LoginName"></param>
//        /// <param name="LoginPassword"></param>
//        /// <returns></returns>
//        public static string GetViewSheetUrl(System.Web.UI.Page Page, WorkItem.WorkItem WorkItem, OThinker.H3.WorkSheet.SheetMode SheetMode, PageActionType Action, string ActionParam, string LoginName, string LoginPassword)
//        {
//            string baseUrl = GetSheetBaseUrl(Page, WorkItem.SheetType, WorkItem.SheetAddress);
//            baseUrl += OThinker.H3.WorkSheet.SheetEnviroment.Param_Mode + "=" + SheetMode + "&";
//            baseUrl += OThinker.H3.WorkSheet.SheetEnviroment.Param_WorkItemID + "=" + WorkItem.WorkItemID + "&";
//            baseUrl += PortalPage.Param_PageAction + "=" + Action + "&";
//            baseUrl += PortalPage.Param_PageActionParam + "=" + System.Web.HttpUtility.UrlEncode(ActionParam);// +"&" +
//            if (!string.IsNullOrEmpty(LoginName))
//            {
//                baseUrl += "&" + OThinker.H3.WorkSheet.SheetEnviroment.Param_LoginName + "=" + System.Web.HttpUtility.UrlEncode(LoginName);
//            }
//            if (!string.IsNullOrEmpty(LoginPassword))
//            {
//                baseUrl += "&" + OThinker.H3.WorkSheet.SheetEnviroment.Param_LoginPassword + "=" + System.Web.HttpUtility.UrlEncode(LoginPassword);
//            }
//            return baseUrl;
//        }

//        public static string GetWorkSheetUrl(System.Web.UI.Page Page, WorkItem.WorkItem WorkItem, PortalPage.PageActionType Action, string ActionParam, string LoginName, string LoginPassword)
//        {
//            if (WorkItem == null)
//            {
//                return null;
//            }
//            else
//            {
//                string baseUrl = GetSheetBaseUrl(Page, WorkItem.SheetType, WorkItem.SheetAddress);
//                baseUrl += OThinker.H3.WorkSheet.SheetEnviroment.Param_Mode + "=" + WorkSheet.SheetMode.Work + "&";
//                baseUrl += OThinker.H3.WorkSheet.SheetEnviroment.Param_WorkItemID + "=" + WorkItem.WorkItemID + "&";
//                baseUrl += PortalPage.Param_PageAction + "=" + Action + "&";
//                baseUrl += PortalPage.Param_PageActionParam + "=" + System.Web.HttpUtility.UrlEncode(ActionParam) + "&";
//                if (!string.IsNullOrEmpty(LoginName))
//                {
//                    baseUrl += "&" + OThinker.H3.WorkSheet.SheetEnviroment.Param_LoginName + "=" + System.Web.HttpUtility.UrlEncode(LoginName);
//                }
//                if (!string.IsNullOrEmpty(LoginPassword))
//                {
//                    baseUrl += "&" + OThinker.H3.WorkSheet.SheetEnviroment.Param_LoginPassword + "=" + System.Web.HttpUtility.UrlEncode(LoginPassword);
//                }
//                return baseUrl;
//            }
//        }

//        private static string GetDefaultSheetUrl(System.Web.UI.Page Page)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "DefaultSheet.aspx").Replace('\\', '/');
//        }

//        public static string GetSheetBaseUrl(System.Web.UI.Page Page, OThinker.H3.WorkflowTemplate.SheetType SheetType, string SheetAddress)
//        {
//            string baseUrl = null;
//            switch (SheetType)
//            {
//                case OThinker.H3.WorkflowTemplate.SheetType.None:
//                    baseUrl = null;
//                    break;
//                case OThinker.H3.WorkflowTemplate.SheetType.DefaultSheet:
//                    baseUrl = GetDefaultSheetUrl(Page) + "?";
//                    break;
//                case OThinker.H3.WorkflowTemplate.SheetType.CustomSheet:
//                    if (SheetAddress.LastIndexOf("?") == -1)
//                    {
//                        // url的形式应该是http://.../page1.aspx
//                        baseUrl = SheetAddress + "?";
//                    }
//                    else if (SheetAddress.LastIndexOf("?") == SheetAddress.Length - 1 ||
//                        SheetAddress.LastIndexOf("&") == SheetAddress.Length - 1)
//                    {
//                        // url的形式应该是http://.../page1.aspx?
//                        // url的形式应该是http://.../page1.aspx?param1=value1&
//                        baseUrl = SheetAddress;
//                    }
//                    else
//                    {
//                        // url的形式应该是http://.../page1.aspx?param1=value1
//                        baseUrl = SheetAddress + "&";
//                    }
//                    break;
//                default:
//                    throw new NotImplementedException();
//            }
//            return baseUrl;
//        }

//        public static string AddParamToUrl(string Url, string ParamName, string ParamValue)
//        {
//            if (Url == null)
//            {
//                return null;
//            }
//            else if (Url.LastIndexOf('?') == -1)
//            {
//                // 不包括?
//                return Url + "?" + ParamName + "=" + System.Web.HttpUtility.UrlEncode(ParamValue);
//            }
//            else if (Url.LastIndexOf('?') == Url.Length - 1)
//            {
//                // 以?结尾
//                return Url + ParamName + "=" + System.Web.HttpUtility.UrlEncode(ParamValue);
//            }
//            else if (Url.LastIndexOf('&') == Url.Length - 1)
//            {
//                // 以&结尾
//                return Url + ParamName + "=" + System.Web.HttpUtility.UrlEncode(ParamValue);
//            }
//            else
//            {
//                return Url + "&" + ParamName + "=" + System.Web.HttpUtility.UrlEncode(ParamValue);
//            }
//        }

//        public static string GetWorkItemUrl(System.Web.UI.Page Page, string WorkItemID, WorkSheet.SheetMode Mode)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "WorkItemDetail.aspx").Replace('\\', '/') + "?" +
//                "WorkItemID=" + WorkItemID + "&" +
//                "Mode=" + Mode.ToString() + "&" +
//                PortalPage.Param_PageAction + "=" + Page.Request.QueryString[Param_PageAction] + "&" +
//                PortalPage.Param_PageActionParam + "=" + Page.Request.QueryString[Param_PageActionParam];
//        }

//        public static string GetWorkItemUrl(System.Web.UI.Page Page, string WorkItemID)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "WorkItemDetail.aspx").Replace('\\', '/') + "?" + "WorkItemID=" + WorkItemID;
//        }

//        public static string GetWorkItemUrl(System.Web.UI.Page Page, string WorkItemID, WorkSheet.SheetMode Mode, PageActionType ActionType, string ActionParam)
//        {
//            return System.IO.Path.Combine(GetPortalRoot(Page), "WorkItemDetail.aspx").Replace('\\', '/') + "?" +
//                "WorkItemID=" + WorkItemID + "&" +
//                "Mode=" + Mode.ToString() + "&" +
//                "PageAction=" + ActionType + "&" +
//                "PageActionParam=" + ActionParam;
//        }

//        /// <summary>
//        /// 获得当前登陆用户的权限对象
//        /// </summary>
//        public Acl.UserValidator UserValidator
//        {
//            get
//            {
//                return PortalPage.GetUserValidator(this.Page);
//            }
//        }

//        #region 弹出窗口相关方法 ------------

//        /// <summary>
//        /// 弹出消息框
//        /// </summary>
//        /// <param name="message">消息</param>
//        protected virtual void Alert(string message)
//        {
//            Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "Alert", "<script language=\"javascript\">alert(\"" + message + "\");</script>");
//        }

//        public static void Alert(string message, UpdatePanel updatePanel)
//        {
//            ScriptManager.RegisterStartupScript(updatePanel, updatePanel.Page.GetType(), "message", "alert('" + message.ToString() + "');", true);
//        }

//        /// <summary>
//        /// 弹出消息框，并且关闭窗口
//        /// </summary>
//        /// <param name="message"></param>
//        protected virtual void AlertAndClose(string message)
//        {
//            Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "Alert", "<script language=\"javascript\">alert(\"" + message + "\");window.close();</script>");
//        }


//        /// <summary>
//        /// 弹出消息框，并且关闭窗口
//        /// 注：窗口是 ModalDialog
//        /// </summary>
//        /// <param name="message"></param>
//        protected virtual void RefreshModalParent(string message)
//        {
//            Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "Alert", "<script language=\"javascript\">alert(\"" + message + "\");window.dialogArguments.location.reload();window.close();</script>");
//        }

//        /// <summary>
//        /// 弹出消息框，并且关闭窗口
//        /// 注：窗口是 Open 方式打开
//        /// </summary>
//        /// <param name="message"></param>
//        protected virtual void RefreshOpenerParent(string message)
//        {
//            Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "Alert", "<script language=\"javascript\">alert(\"" + message + "\");window.opener.location.reload();window.close();</script>");
//        }
//        #endregion

//    }
//}
