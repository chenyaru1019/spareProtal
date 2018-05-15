// SheetInstancePrioritySelector控件
(function ($) {
    //控件执行
    $.fn.SheetInstancePrioritySelector = function () {
        return $.MvcSheetUI.Run.call(this, "SheetInstancePrioritySelector", arguments);
    };

    $.MvcSheetUI.Controls.SheetInstancePrioritySelector = function (element, options, sheetInfo) {
        $.MvcSheetUI.Controls.SheetInstancePrioritySelector.Base.constructor.call(this, element, options, sheetInfo);
    };

    $.MvcSheetUI.Controls.SheetInstancePrioritySelector.Inherit($.MvcSheetUI.IControl, {
        Render: function () {
            var $element = $(this.Element);
            var that = this;
            //不可见返回
            if (!this.Visiable) {
                $element.hide();
                return;
            }

            //绑定change事件
            $element.unbind("change.SheetInstancePrioritySelector").bind("change.SheetInstancePrioritySelector", function () {
                if ($.isFunction(that.OnChange)) {
                    that.OnChange.apply(this);
                }
                else {
                    (new Function(that.OnChange)).apply(this);
                }
            });

            var priorities = $.MvcSheetUI.SheetInfo.Priorities;
            if (priorities) {
                $element.empty();
                for (var key in priorities) {
                    $element.append("<option value='" + key + "'>" + priorities[key] + "</option>");
                    if (this.IsMobile) {
                        this.AddMobileItem(key, priorities[key], false);
                    }
                }

                this.V = this.V || this.DefaultValue;
                if (this.V && this.V != "") {
                    $element.val(this.V);
                }
                else {
                    $element.val("Normal");
                }

                //不可编辑
                if (!this.Editable) {
                    $element.after("<label style='width:100%;'>" + $element.children("option:selected").text() + "</label>");
                    $element.hide();
                }

                if (this.IsMobile && this.Editable)
                    this.ionicInit($.MvcSheetUI.IonicFramework);
            }
        },
        RenderMobile: function () {
            //可编辑
            this.MobileOptions = [];
            if (this.Editable) {
                this.constructor.Base.RenderMobile.apply(this);
                this.pupIcon = $("<i class='icon ion-ios-arrow-right'></i>").insertAfter(this.Mask);
                $(this.Element).closest("div.item").addClass("item-icon-right");
                $(this.Element).hide();
            }
            else {
                this.Render();
            }
        },

        ionicInit: function (ionic) {
            var that = this;
            $(this.Element.parentElement.parentElement).unbind('click.showChoice').bind('click.showChoice', function (e) {
                ionic.$ionicModal.fromTemplateUrl('radio_autocomplete.html', {
                    scope: ionic.$scope
                }).then(function (modal) {
                    ionic.$scope.modal = modal;
                    ionic.$scope.RadioListDisplay = that.MobileOptions;
                    ionic.$scope.RadioListValue = that.GetValue();
                    ionic.$scope.modal.show();
                    ionic.$scope.clickRadio = function (value, text) {
                        that.SetValue(value);
                        $(that.Mask).html(text);
                        ionic.$scope.modal.hide();
                    }
                });
                return;
            });

            if (that.IsMobile) {
                var text = that.GetText();
                if (that.Editable) {
                    that.Mask.html(text);
                }
                else {
                    //移动端不可编辑
                    $(that.Element).html(text);
                }
            }
        },
        AddMobileItem: function (value, text, isDefault) {
            var MobileOption = {
                DataField: this.DataField,
                Value: value,
                Text: text
            };
            this.MobileOptions.push(MobileOption);
        },
        GetText: function () {
            return $(this.Element).children("option:selected").text();
        },
        //返回数据值
        SaveDataField: function () {
            var result = {};
            if (!this.Visiable || !this.Editable) return result;
            result[this.DataField] = this.SheetInfo.BizObject.DataItems[this.DataField];
            if (!result[this.DataField]) {
                alert(SheetLanguages.Current.DataItemNotExists + ":" + this.DataField);
                return {};
            }
            if (result[this.DataField].V != $(this.Element).val()) {
                $.MvcSheetUI.Priority = $(this.Element).val();
                result[this.DataField].V = $(this.Element).val();
                return result;
            }
            return {};
        }
    });
})(jQuery);