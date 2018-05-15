//复选框

(function ($) {
    $.fn.SheetCheckbox = function () {
        return $.MvcSheetUI.Run.call(this, "SheetCheckbox", arguments);

    };

    // 构造函数
    $.MvcSheetUI.Controls.SheetCheckbox = function (element, ptions, sheetInfo) {
        $.MvcSheetUI.Controls.SheetCheckbox.Base.constructor.call(this, element, ptions, sheetInfo);
    };

    // 继承及控件实现
    $.MvcSheetUI.Controls.SheetCheckbox.Inherit($.MvcSheetUI.IControl, {
        Checked: false,
        Render: function () {
            //设置默认值
            if (this.Originate) {
                this.Checked = this.DefaultValue || this.V;
                this.Element.checked = this.DefaultValue || this.V;
            }
            else {
                this.Checked = this.V;
                this.Element.checked = this.Checked;
            }

            if (!this.Visiable) {
                this.Element.style.display = "none";
                return;
            }

            //渲染前端
            $(this.Element).unbind("mouseenter").unbind("mouseover").unbind("mouseup").unbind("mouseout");
            $(this.Element).css("cursor", "pointer");
            var divElement = $("<div class='checkbox'><label>" + this.Text + "</label></div>");// $("<div class='checkbox'><label>" + this.DataField + "</label></div>");
            $(this.Element).before(divElement);
            $(this.Element).appendTo(divElement.children("label"));

            if (!this.Editable) {// 不可编辑
                $(this.Element).prop("disabled", true);
                return;
            }
            //绑定事件
            if (this.OnChange) {
                $(this.Element).unbind("click.SheetCheckbox").bind("click.SheetCheckbox", this, function (e) {
                    e.data.RunScript(e.data.Element, e.data.OnChange);
                });
            }
        },
        GetValue: function () {
            return this.Element.checked;
        },
        SetValue: function (value) {
            //$(this.Element).prop("checked", !!value);

            // true/false  子表导入时是字符串
            if (typeof (value) == "string" && value.toLowerCase() == "true") {
                this.Checked = true;
            } else if (typeof (value) == "boolean" && value == true) {
                this.Checked = true;
            } else {
                this.Checked = false;
            }

            this.Element.checked = this.Checked;
            if (this.IsMobile) {
                //this.Switchery.setPosition();
            }
        },
        RenderMobile: function () {
            //设置默认值
            if (this.Originate) {
                this.Checked = this.DefaultValue||this.V;
                this.Element.checked = this.DefaultValue||this.V;
            }
            else {
                this.Checked = this.V;
                this.Element.checked = this.Checked;
            }

            //不可见返回
            if (!this.Visiable) return;

            var _ID = $(this.Element).attr("id");
            if (!_ID) {
                _ID = $.uuid();
                $(this.Element).attr("id", _ID);
            }
            
            $(this.Element).parent().before(this.Text);
            //显示为开关按钮
            $(this.Element).addClass("toggle");
            //var span = $("<span style='width: 120px!important;'></span>");
            //$(this.Element).after(span);
            //$(this.Element).appendTo(span);
            //$(span).append('<label for="' + _ID + '" data-on="" data-off=""><span></span></label>');
            
        
           

            if (!this.Editable) {// 不可编辑
                $(this.Element).prop("disabled", true);
            }

            if (this.Editable) {
                //this.Switchery = new Switchery(this.Element);
                // 绑定修改事件
                $(this.Element).unbind("click.SheetCheckbox").bind("click.SheetCheckbox", this, function (e) {
                   
                    e.data.RunScript(e.data.Element, e.data.OnChange);
                  
                });
            }
            else {
                // 不可编辑
                $(this.Element).prop("disabled", true);
                //this.Switchery = new Switchery(this.Element, { disabled: true });
                return;
            }
        },
        Validate: function () {
            return true;
        },
        SaveDataField: function () {
            var result = {};
            if (!this.Visiable || !this.Editable) return result;
            result[this.DataField] = $.MvcSheetUI.GetSheetDataItem(this.DataField);// this.SheetInfo.BizObject.DataItems[this.DataField];

            if (!result[this.DataField]) {
                if (this.DataField.indexOf(".") == -1) { alert(SheetLanguages.Current.DataItemNotExists + ":" + this.DataField); }
                return {};
            }
            if (result[this.DataField].V != this.GetValue()) {
                result[this.DataField].V = this.GetValue();
                return result;
            }
            if (this.Originate) {
                return result;
            }
            return {};
        }
    });
})(jQuery);