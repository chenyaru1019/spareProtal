// SheetInstancePrioritySelector控件
(function ($) {
    //控件执行
    $.fn.SheetOriginatorUnit = function () {
        return $.MvcSheetUI.Run.call(this, "SheetOriginatorUnit", arguments);
    };

    $.MvcSheetUI.Controls.SheetOriginatorUnit = function (element, options, sheetInfo) {
        $.MvcSheetUI.Controls.SheetOriginatorUnit.Base.constructor.call(this, element, options, sheetInfo);
    };

    $.MvcSheetUI.Controls.SheetOriginatorUnit.Inherit($.MvcSheetUI.IControl, {
        Render: function () {
            var $element = $(this.Element);
            var that = this;

            // 绑定change事件
            $element.unbind("change.SheetOriginatorUnit").bind("change.SheetOriginatorUnit", function () {
                if ($.isFunction(that.OnChange)) {
                    that.OnChange.apply(this);
                }
                else {
                    (new Function(that.OnChange)).apply(this);
                }
            });
            var parentUnits = $.MvcSheetUI.SheetInfo.DirectParentUnits;
            if (parentUnits) {
                $element.empty();
                for (var key in parentUnits) {
                    $element.append("<option value='" + key + "'>" + parentUnits[key] + "</option>");
                }
                this.V = $.MvcSheetUI.SheetInfo.OriginatorOU; //当前流程发起人OU
                if (this.V && this.V != "") {
                    $element.val(this.V);
                }

                var length = 0;
                for (var key in $.MvcSheetUI.SheetInfo.DirectParentUnits) {
                    length++;
                }

                // 非发起模式或者不存在兼职情况，则不可编辑
                //if (!this.Originate || length == 1) {
                //非发起环节或者不存在兼职情况，则不可编辑                
                if ($.MvcSheetUI.SheetInfo.ActivityCode != $.MvcSheetUI.SheetInfo.StartActivityCode || length == 1 || $.MvcSheetUI.QueryString("Mode").toLowerCase() == "view") {
                    $element.after("<label style='width:100%;'>" + $element.children("option:selected").text() + "</label>");
                    $element.hide();
                }

            }
        },
        RenderMobile: function () {
            // 可编辑
            var length = 0;
            for (var key in $.MvcSheetUI.SheetInfo.DirectParentUnits) {
                length++;
            }
            if ((this.Originate || $.MvcSheetUI.SheetInfo.ActivityCode == $.MvcSheetUI.SheetInfo.StartActivityCode) && length > 1) {
                this.constructor.Base.RenderMobile.apply(this);
                $(this.Element).closest("div.item").addClass("item-select");
                
            }
            else {
                this.Render();
            }
        },
        GetText: function () {
            return $(this.Element).children("option:selected").text();
        },
        // 返回数据值
        SaveDataField: function () {
            $.MvcSheetUI.ParentUnitID = $(this.Element).val();
        }
    });
})(jQuery);