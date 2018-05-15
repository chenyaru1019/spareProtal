// SheetTimeSpan控件
;
(function ($) {
    //控件执行
    $.fn.SheetTimeSpan = function () {
        return $.MvcSheetUI.Run.call(this, "SheetTimeSpan", arguments);
    };

    $.MvcSheetUI.Controls.SheetTimeSpan = function (element, options, sheetInfo) {
        $.MvcSheetUI.Controls.SheetTimeSpan.Base.constructor.call(this, element, options, sheetInfo);
    };

    $.MvcSheetUI.Controls.SheetTimeSpan.Inherit($.MvcSheetUI.IControl, {
        Render: function () {
            var that = this;
            $element = $(this.Element);

            //是否可见
            if (!this.Visiable) {
                $element.hide();
                return;

            }
            // 查看痕迹
            if (this.TrackVisiable && !this.Originate && this.DataField.indexOf(".") == -1) { this.RenderDataTrackLink(); }
            var timespan = this._getTimeSpan(this.V);
            if (this.Editable) {
                var height = this.IsMobile ? "35px" : "30px";
                this.$dayElement = $("<input type='number' min='0' style='width:58px;height:" + height + ";padding-left:3px;margin:0px 2px 0px 0px' />").val(timespan.day);
                this.$hourElement = $("<input type='number' min='0' max='23' style='width:39px;height:" + height + ";padding-left:3px;margin:0px 2px 0px 2px;' />").val(timespan.hour);
                this.$minuteElement = $("<input type='number' min='0' max='59' style='width:39px;height:" + height + ";padding-left:3px;margin:0px 2px 0px 2px' />").val(timespan.minute);
                this.$secondElement = $("<input type='number' min='0' max='59' style='width:39px;height:" + height + ";padding-left:3px;margin:0px 2px 0px 2px' />").val(timespan.second);

                $element.append(this.$dayElement, document.createTextNode(SheetLanguages.Current.Day),
                    this.$hourElement, document.createTextNode(SheetLanguages.Current.Hour),
                    this.$minuteElement, document.createTextNode(SheetLanguages.Current.Minute),
                    this.$secondElement, document.createTextNode(SheetLanguages.Current.Second));

                //天
                this.$dayElement.unbind("keyup.SheetTimeSpan").bind("keyup.SheetTimeSpan", function (e) {
                    var val = $(this).val();
                    if (!that._isDay(val)) {
                        $(this).val("0");
                        that._focusText(this);
                    }
                });
                //时
                this.$hourElement.unbind("keyup.SheetTimeSpan").bind("keyup.SheetTimeSpan", function () {
                    var val = $(this).val();
                    if (!that._isHour(val)) {
                        $(this).val("0");
                        that._focusText(this);
                    }
                });
                //分
                this.$minuteElement.unbind("keyup.SheetTimeSpan").bind("keyup.SheetTimeSpan", function () {
                    var val = $(this).val();
                    if (!that._isMinuteOrSecond(val)) {
                        $(this).val("0");
                        that._focusText(this);
                    }
                });
                //秒
                this.$secondElement.unbind("keyup.SheetTimeSpan").bind("keyup.SheetTimeSpan", function () {
                    var val = $(this).val();
                    if (!that._isMinuteOrSecond(val)) {
                        $(this).val("0");
                        that._focusText(this);
                    }
                });

                $element.find("input").unbind("focus.SheetTimeSpan").bind("focus.SheetTimeSpan", function () {
                    that._focusText(this);
                });

                $element.find("input").unbind("change.SheetTimeSpan").bind("change.SheetTimeSpan", function () {
                    that.Validate();
                    if (that.OnChange) {
                        that.Element.value = that.GetValue();
                        that.RunScript(that.Element, that.OnChange);
                    }
                });
            } else {
                $element.after("<label style='width:100%;'>" + this._getLabelText(timespan) + "</label>");
                $element.hide();
            }
        },
        _focusText: function (input) {
            if (this.IsMobile && $.os.ios) {
                input.setSelectionRange(0, 9999);
            } else {
                $(input).select();
            }
        },
        RenderMobile: function () {
            //可编辑
            if (this.Editable) {
                this.constructor.Base.RenderMobile.apply(this);
                var that = this;
                this.ionicInit(that, $.MvcSheetUI.IonicFramework);
            } else {
                this.Render();
            }
        },
        ionicInit: function (that, ionic) {
            var ngmodel = that.DataField + that.Options.RowNum;
            that.Mask.parent().parent().attr("ng-click", "showPopUp('" + ngmodel + "')");
            ionic.$scope[ngmodel + "timespan"] = that;
            ionic.$scope.showPopUp = function (ngmodel) {
                var element = ionic.$scope[ngmodel + "timespan"];
                ionic.$scope.data = {
                    day: element.$dayElement.val() - 0,
                    hour: element.$hourElement.val() - 0,
                    min: element.$minuteElement.val() - 0,
                    second: element.$secondElement.val() - 0,
                    dataField: element.DataField
                };
                ionic.$ionicPopup.show({
                    templateUrl: 'Hybrid/form/templates/timeSpanTemp.html',
                    title: '填写时间段',
                    scope: ionic.$scope,
                    cssClass: 'my-custom-popup',
                    buttons: [{
                        text: '取消',
                        onTap: function (e) { }
                    },
                        {
                            text: '<b>完成</b>',
                            type: 'button-calm',
                            onTap: function (e) {
                                element._SetValue(ionic.$scope.data);
                                ionic.$scope.data = {};
                            }
                        }
                    ]
                });
            }

            ionic.$scope.DateChange = function (type) {
                if (type == "day") {
                    ionic.$scope.data.day = ionic.$scope.data.day || 0;
                } else if (type == "hour") {
                    var hour = ionic.$scope.data.hour || 0;
                    hour = hour < 0 ? 0 : hour > 23 ? 23 : hour;
                    ionic.$scope.data.hour = hour;
                } else if (type == "min") {
                    var min = ionic.$scope.data.min || 0
                    min = min < 0 ? 0 : min > 59 ? 59 : min;
                    ionic.$scope.data.min = min;
                } else if (type == "second") {
                    var second = ionic.$scope.data.second || 0;
                    second = second < 0 ? 0 : second > 59 ? 59 : second;
                    ionic.$scope.data.second = second;
                }
                that.Validate();
                if (that.OnChange) {
                    that.Element.value = that.GetValue();
                    that.RunScript(that.Element, that.OnChange);
                }
            }
            ionic.$compile(that.Mask.parent().parent())(ionic.$scope);
        },
        _getTimeSpan: function (text) {
            var timespan = {};
            if (text) {
                var pointIndex = text.indexOf(".");
                var time = text;
                if (pointIndex > -1) {
                    timespan.day = parseInt(text.substring(0, pointIndex));
                    time = text.substring(pointIndex + 1);
                }
                var timeArray = time.split(":");
                if (timeArray && timeArray.length == 3) {
                    timespan.hour = parseInt(timeArray[0]);
                    timespan.minute = parseInt(timeArray[1]);
                    timespan.second = parseInt(timeArray[2]);
                }
            }
            if (!timespan.day) { timespan.day = 0; }
            if (!timespan.hour) { timespan.hour = 0; }
            if (!timespan.minute) { timespan.minute = 0; }
            if (!timespan.second) { timespan.second = 0; }
            return timespan;
        },
        _isDay: function (val) {
            return /^\d+$/.test(val);
        },
        _isHour: function (val) {
            return /^([0-1]?[0-9]|2[0-3])$/.test(val);
        },
        _isMinuteOrSecond: function (val) {
            return /^[0-5]?[0-9]$/.test(val);
        },
        _getLabelText: function (timespan) {
            var labelText = "";
            if (timespan.day != 0) { labelText = timespan.day + SheetLanguages.Current.Day + timespan.hour + SheetLanguages.Current.Hour + timespan.minute + SheetLanguages.Current.Minute + timespan.second + SheetLanguages.Current.Second; } else if (timespan.hour != 0) { labelText = timespan.hour + SheetLanguages.Current.Hour + timespan.minute + SheetLanguages.Current.Minute + timespan.second + SheetLanguages.Current.Second; } else if (timespan.minute != 0) { labelText = timespan.minute + SheetLanguages.Current.Minute + timespan.second + SheetLanguages.Current.Second; } else { labelText = timespan.second + SheetLanguages.Current.Second; }
            return labelText;
        },
        GetText: function () {
            var text = "";
            var val = this.GetValue();
            if (val) {
                var timespan = this._getTimeSpan(val);
                return this._getLabelText(timespan);
            }
            return text;
        },
        GetValue: function () {
            if (!this.Editable) return this.V;
            var day = this.$dayElement.val();
            var hour = this.$hourElement.val();
            var minute = this.$minuteElement.val();
            var second = this.$secondElement.val();
            if (day || hour || minute || second) {
                return (day ? day : "0") + "." +
                    (hour ? hour : "0") + ":" +
                    (minute ? minute : "0") + ":" +
                    (second ? second : "0");
            } else {
                return null;
            }
        },
        SetValue: function (obj) {
            if (this.Editable) {
                var timespan = this._getTimeSpan(obj);
                if (timespan) {
                    this.$dayElement.val(timespan.day);
                    this.$hourElement.val(timespan.hour);
                    this.$minuteElement.val(timespan.minute);
                    this.$secondElement.val(timespan.second);
                }
                if (this.IsMobile) {
                    this.Mask.html(this.GetText());
                }
            }
        },
        _GetValue: function (obj) {
            var day = obj.day;
            var hour = obj.hour;
            var minute = obj.min;
            var second = obj.second;
            var text = "";
            if (day || hour || minute || second) {
                text = (day ? day : "0") + "." +
                    (hour ? hour : "0") + ":" +
                    (minute ? minute : "0") + ":" +
                    (second ? second : "0");
            } else {
                text = null;
            }
            return text;
        },
        _SetValue: function (obj) {
            this.SetValue(this._GetValue(obj));
            this.Mask.html(this.GetText());
        },
        // 数据验证
        _isNotEmpty: function () {
            var day = parseInt(this.$dayElement.val());
            var hour = parseInt(this.$hourElement.val());
            var minute = parseInt(this.$minuteElement.val());
            var second = parseInt(this.$secondElement.val());
            return day || hour || minute || second;
        },
        Validate: function (effective, initValid) {
            if (!this.Editable) return true;

            if (initValid) {
                // 必填验证
                if (this.Required && !this._isNotEmpty()) {
                    this.AddInvalidText(this.Element, "*", false);
                    return false;
                }
            }

            if (!effective) {
                if (this.Required && !this.DoValidate(this._isNotEmpty, [], "*")) {
                    this.ValidateResult = false;
                    return false;
                }
            }

            this.ValidateResult = true;
            return true;
        },
        SaveDataField: function () {
            var result = {};
            if (!this.Visiable || !this.Editable) return result;

            if (this.DataField) {
                var dataFieldItem = $.MvcSheetUI.GetSheetDataItem(this.DataField);
                if (dataFieldItem) {
                    var value = this.GetValue();
                    if (value && dataFieldItem.V != value) {
                        result[this.DataField] = dataFieldItem;
                        result[this.DataField].V = value;
                    }
                } else {
                    if (this.DataField.indexOf(".") == -1) { alert(SheetLanguages.Current.DataItemNotExists + ":" + this.DataField); }
                }
            }
            return result;
        }
    });
})(jQuery);