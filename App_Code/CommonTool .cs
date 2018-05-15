using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OThinker.H3.Portal.Entity;
using System.Web.UI.HtmlControls;
using System.Data;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using System.Web.UI;
using System.Web.UI.WebControls;
/// <summary>
/// Class1 的摘要说明
/// </summary>
namespace OThinker.H3.Portal.service
{
    public class CommonTool
    {

        public static void ExportToExcel(string filename, string context)
        {
            //GridView gvw = new GridView();
            //gvw.AutoGenerateColumns = true;
            //gvw.DataSource = dataList;
            //// SetStype(gvw);
            //gvw.DataBind();
            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.ClearHeaders();
            //fileName = string.Format("DataInfo{0:yyyy-MM-dd_HH_mm}.xls", DateTime.Now);
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + DateTime.Now.ToShortDateString() + ".xls");
            HttpContext.Current.Response.Charset = "UTF-8";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");


            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.Write("<html><head><style type='text/css'>h1 {font-family: Arial, sans-serif;font-size: 24px;margin: 5px;color: #369;text-align:center}h3 {text-align:center;color:#0099FF;}table{border-collapse: collapse;font-family: 'Lucida Sans Unicode','Lucida Grande',Sans-Serif;font-size: 12px;margin: 20px;text-align: left;width: 97%}td {padding: 8px;}th{text-align:center;}</style></head><body>");
            HttpContext.Current.Response.Write(context);
            //StringWriter tw = new System.IO.StringWriter();
            //HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            //gvw.RenderControl(hw);

            //HttpContext.Current.Response.Write(tw.ToString());
            HttpContext.Current.Response.Write("</tbody> </table>");
            HttpContext.Current.Response.Write("</body></html>");
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.Close();
            HttpContext.Current.Response.End();
            //gvw.Dispose();
            //tw.Dispose();
            //hw.Dispose();
            //gvw = null;
            //tw = null;
            //hw = null;


            //var res = System.Web.HttpContext.Current.Response;
            //content = String.Format("<style type='text/css'>{0}</style>{1}", cssText, content);

            //res.Clear();
            //res.Buffer = true;
            //res.Charset = "UTF-8";
            //res.AddHeader("Content-Disposition", "attachment; filename=" + filename);
            //res.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
            //res.ContentType = "application/vnd.ms-excel;charset=UTF-8";
            ////res.ContentType = "application/ms-excel;charset=UTF-8";
            //res.Write(content);
            //res.Flush();
            //res.End();

        }
        public static void ExportToExcel(DataTable dataList,string filename,string context)
        {
            GridView gvw = new GridView();
            gvw.AutoGenerateColumns = true;
            gvw.DataSource = dataList;
           // SetStype(gvw);
            gvw.DataBind();
            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.ClearHeaders();
            //fileName = string.Format("DataInfo{0:yyyy-MM-dd_HH_mm}.xls", DateTime.Now);
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + System.Web.HttpUtility.UrlEncode(filename) + DateTime.Now.ToShortDateString() + ".xls");
            HttpContext.Current.Response.Charset = "UTF-8";
            HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");


            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.Write("<html><head><style type='text/css'>h1 {font-family: Arial, sans-serif;font-size: 24px;margin: 5px;color: #369;text-align:center}h3 {text-align:center;color:#0099FF;}table{border-collapse: collapse;font-family: 'Lucida Sans Unicode','Lucida Grande',Sans-Serif;font-size: 12px;margin: 20px;text-align: left;width: 97%}td {padding: 8px;}th{text-align:center;}</style></head><body>");
            HttpContext.Current.Response.Write(context);
            StringWriter tw = new System.IO.StringWriter();
            HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            gvw.RenderControl(hw);
            
            HttpContext.Current.Response.Write(tw.ToString());
            HttpContext.Current.Response.Write("</tbody> </table>");
            HttpContext.Current.Response.Write("</body></html>");
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.Close();
            HttpContext.Current.Response.End();
            gvw.Dispose();
            tw.Dispose();
            hw.Dispose();
            gvw = null;
            tw = null;
            hw = null;


            //var res = System.Web.HttpContext.Current.Response;
            //content = String.Format("<style type='text/css'>{0}</style>{1}", cssText, content);

            //res.Clear();
            //res.Buffer = true;
            //res.Charset = "UTF-8";
            //res.AddHeader("Content-Disposition", "attachment; filename=" + filename);
            //res.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
            //res.ContentType = "application/vnd.ms-excel;charset=UTF-8";
            ////res.ContentType = "application/ms-excel;charset=UTF-8";
            //res.Write(content);
            //res.Flush();
            //res.End();
           
        }
        /// <summary>
        /// 设置样式
        /// </summary>
        /// <param name="gvw"></param>
        private static void SetStype(GridView gvw)
        {
            gvw.Font.Name = "Verdana";
            gvw.BorderStyle = System.Web.UI.WebControls.BorderStyle.Solid;
            gvw.HeaderStyle.BackColor = System.Drawing.Color.LightCyan;
            gvw.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            gvw.HeaderStyle.HorizontalAlign = System.Web.UI.WebControls.HorizontalAlign.Center;
            gvw.HeaderStyle.Wrap = false;
            gvw.HeaderStyle.Font.Bold = true;
            gvw.HeaderStyle.Font.Size = 10;
            gvw.RowStyle.Font.Size = 10;
        }
        /// <summary>  
        /// 由DataSet导出Excel  
        /// </summary>  
        /// <param name="sourceTable">要导出数据的DataTable</param>  
        /// <param name="sheetName">工作表名称</param>  
        /// <returns>Excel工作表</returns>  
        private static Stream ExportDataSetToExcel(DataSet sourceDs, string sheetName)
        {
            //NPOI.SS.UserModel.IWorkbook workbook = new NPOI.SS.UserModel.IWorkbook();
            IWorkbook workbook = new HSSFWorkbook();
            MemoryStream ms = new MemoryStream();
            string[] sheetNames = sheetName.Split(',');
            for (int i = 0; i < sheetNames.Length; i++)
            {
                ISheet sheet = workbook.CreateSheet(sheetNames[i]);
                IRow headerRow = sheet.CreateRow(0);
                // handling header.  
                foreach (DataColumn column in sourceDs.Tables[i].Columns)
                    headerRow.CreateCell(column.Ordinal).SetCellValue(column.ColumnName);


                // handling value.  
                int rowIndex = 1;


                foreach (DataRow row in sourceDs.Tables[i].Rows)
                {
                    IRow dataRow = sheet.CreateRow(rowIndex);


                    foreach (DataColumn column in sourceDs.Tables[i].Columns)
                    {
                        dataRow.CreateCell(column.Ordinal).SetCellValue(row[column].ToString());
                    }


                    rowIndex++;
                }
            }
            workbook.Write(ms);
            ms.Flush();
            ms.Position = 0;


            workbook = null;
            return ms;
        }
        /// <summary>  
        /// 由DataSet导出Excel  
        /// </summary>  
        /// <param name="sourceTable">要导出数据的DataTable</param>  
        /// <param name="fileName">指定Excel工作表名称</param>  
        /// <returns>Excel工作表</returns>  
        public static void ExportDataSetToExcel(DataSet sourceDs, string fileName, string sheetName)
        {
            MemoryStream ms = ExportDataSetToExcel(sourceDs, sheetName) as MemoryStream;
            HttpContext.Current.Response.AppendHeader("Content-Disposition", "attachment;filename=" + System.Web.HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
            HttpContext.Current.Response.BinaryWrite(ms.ToArray());
            HttpContext.Current.Response.End();
            ms.Close();
            ms = null;
        }
//然后在后台直接调用ExportDataSetToExcel(ds, filename,"sheet1");

    }
    
}