
function PullInstanceNode() {
    
    $.ajax({
        type: "POST",    //页面请求的类型
        url: "/Portal/InstanceDetail/GetAdjustActivityInfo",   //处理页的相对地址
        data: {
            InstanceID: $.MvcSheetUI.SheetInfo.InstanceId,
        },
        success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
            var options = "";
            if (ret.SUCCESS == true) {
                console.log("GetAdjustActivityInfo=" + ret);
                for (var i = 0; i < ret.InstanceActivity.length; i++) {
                    if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityApprove") {
                        if (ret.InstanceActivity[i].ActivityName == "创建合同") {
                            options += '<option value="' + ret.InstanceActivity[i].ActivityCode + '">' + ret.InstanceActivity[i].ActivityName + '</option>';
                        }
                    }
                    
                }
            }
            
        }
    });
}