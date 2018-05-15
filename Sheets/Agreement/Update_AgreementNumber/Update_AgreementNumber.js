//数据加载后
$.MvcSheet.Loaded = function () {
    // 协议号码
    var AgreeMent_number = getUrlParam("AgreeMent_number");
    if (AgreeMent_number != null && AgreeMent_number != "") {
        // 根据合同号码获取对应合同相关数据
        $.ajax({
            type: "POST",    //页面请求的类型
            url: "Update_AgreementNumber.ashx?Command=getByAgreeMent_number",   //处理页的相对地址
            data: {
                AgreeMent_number: AgreeMent_number,
            },
            async: false,
            success: function (ret) {    //这是处理后执行的函数，msg是处理页返回的数据
                console.log(ret);
                $.MvcSheetUI.SetControlValue("AgreeMent_name", ret.AgreeMent_name);
                $.MvcSheetUI.SetControlValue("AgreeMent_head", ret.Project_head);
                $.MvcSheetUI.SetControlValue("AgreenMent_client", ret.Agreement_client);
                $.MvcSheetUI.SetControlValue("Self_agreeMent_number", ret.AgreeMent_number);

            }
        });
    }
    $("input[data-datafield='AgreeMent_name']").attr("disabled", "disabled");
    $("input[data-datafield='AgreeMent_head']").attr("disabled", "disabled");
    $("input[data-datafield='AgreenMent_client']").attr("disabled", "disabled");
    $("input[data-datafield='Self_agreeMent_number']").attr("disabled", "disabled");

}

// 表单验证接口
$.MvcSheet.Validate = function () {
    if (this.Action == "Submit") {
        // 当前节点是发起节点
        if ($.MvcSheetUI.SheetInfo.ActivityCode == "ActivityOrig") {
            var NoOld = $.MvcSheetUI.GetControlValue("Self_agreeMent_number");
            var NoNew = $.MvcSheetUI.GetControlValue("Update_agreeMent_number");
            var chkFlg = "true";
            try {
                // 除了流水号可以修改，其他的不能修改
                var oldArr = NoOld.split("-");
                var newArr = NoNew.split("-");
                if (newArr.length != 3) {
                    chkFlg = "false";
                }
                if (chkFlg == "true") {
                    var firstStrO = oldArr[0];
                    var firstStrN = newArr[0];
                    var secondStrO = oldArr[1];
                    var secondStrN = newArr[1];
                    var thirdStrO = oldArr[2];
                    var thirdStrN = newArr[2];
                    if (firstStrO != firstStrN || secondStrO != secondStrN || thirdStrO.substring(0, 2) != thirdStrN.substring(0, 2)) {
                        chkFlg = "false";
                    }
                    if (!/^[0-9]*$/.test(thirdStrN.substring(2))) {
                        chkFlg = "false";
                    }
                }
            } catch (err) {
                chkFlg = "false";
            }
            if (chkFlg == "false") {
                layer.alert('协议编号规则有误，不能提交！', { icon: 2 });
                //layer.confirm('协议编号规则有误，确认提交吗！', function (index) {
                //    $.MvcSheet.Submit2(this);
                //});
                return false;
            } else {
                return true;
            }

        }
    }
}