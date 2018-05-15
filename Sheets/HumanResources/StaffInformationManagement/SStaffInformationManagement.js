function GetPhoto() {
    var ParentID = $.MvcSheetUI.GetControlValue("OrgID");
    var ObjectID = $.MvcSheetUI.GetControlValue("RoleId");
    
    var ImageUrl = "/Portal/TempImages/face/DefaultEngine/" + ParentID + "\\" + ObjectID + ".jpg";
    var ImgObj = new Image(); //判断图片是否存在  

    ImgObj.src = ImageUrl;
    document.getElementById("userFace").src = ImageUrl;
    //    $("#userFace").src = ImageUrl;
    ////没有图片，则返回-1 

    //if (ImgObj.fileSize > 0 || (ImgObj.width > 0 && ImgObj.height > 0)) {
    //    alert(ImageUrl);
    //    $.MvcSheetUI.SetControlValue("PhotoStorageDirectory", ImageUrl);

    //} else {
    //    $.MvcSheetUI.SetControlValue("PhotoStorageDirectory", "/Portal/img/TempImages/usermale.jpg");
        

    //} 
    
   
}
function imgerror(img) {
    img.src = "/Portal/img/TempImages/usermale.jpg";
    img.onerror = null;   //控制不要一直跳动
}